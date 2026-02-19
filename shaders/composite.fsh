#version 330 core
#define COMPOSITE_SHADER
#include "/libs/Uniforms.glsl"
#include "/libs/Settings.glsl"
#include "/libs/Utilities.glsl"

in vec2 texCoord;

/* RENDERTARGETS: 0 */
layout(location = 0) out vec4 fragColor;

vec3 getShadow(vec3 shadowScreenPos, float dotNL) {
    float closestDepth = texture(shadowtex0, shadowScreenPos.xy).r;
    float currentDepth = shadowScreenPos.z;
    const float bias = 0.0005;
    float biasDir = dotNL > 0 ? max(bias * (1.0 - dotNL), bias) : 0.0;
    if(currentDepth >= 1.0 || shadowScreenPos.x < 0.0 || shadowScreenPos.x > 1.0 || shadowScreenPos.y < 0.0 || shadowScreenPos.y > 1.0) {
        return vec3(1.0);
    }
    return vec3(step(currentDepth - biasDir, closestDepth));
}

vec3 getSoftShadow(vec4 shadowClipPos, float dotNL) {
    vec3 sum = vec3(0.0);
    const int side = SHADOW_RANGE * 2 + 1;
    const float totalSamples = float(side * side);

    for(int x = -SHADOW_RANGE; x <= SHADOW_RANGE; x++) {
        for(int y = -SHADOW_RANGE; y <= SHADOW_RANGE; y++) {
            vec2 offset = vec2(x, y) * SHADOW_RADIUS / float(SHADOW_RANGE) / float(shadowMapResolution);
            vec4 offsetShadowClipPos = shadowClipPos + vec4(offset, 0.0, 0.0);
            vec3 shadowNDCPos = offsetShadowClipPos.xyz / offsetShadowClipPos.w;
            vec3 shadowScreenPos = shadowNDCPos * 0.5 + 0.5;
            sum += getShadow(shadowScreenPos, dotNL);
        }
    }

    return sum / (totalSamples);
}

void main() {

    float depth = texture(depthtex0, texCoord).r;
    if(depth >= 1.0) {
        discard;
    }

    vec4 albedo = texture(colortex0, texCoord);
    int geoID = texture(colortex3, texCoord).r;
    if(geoID == 2) { 
        fragColor = albedo;
        return;
    }
    
    albedo.rgb = pow(albedo.rgb, vec3(2.2));

    vec3 normal = texture(colortex1, texCoord).xyz;
    vec2 lmData = texture(colortex2, texCoord).rg;

    vec3 lightDir = normalize(mat3(gbufferModelViewInverse) * shadowLightPosition);
    float dotNL = max(dot(normal, lightDir), 0.0);

    vec3 screenPos = vec3(texCoord, depth);
    vec3 ndcPos = screenPos * 2.0 - 1.0;
    vec3 viewPos = projectAndDivide(gbufferProjectionInverse, ndcPos);
    vec3 feetPlayerPos = (gbufferModelViewInverse * vec4(viewPos, 1.0)).xyz;
    vec3 shadowViewPos = (shadowModelView * vec4(feetPlayerPos, 1.0)).xyz;
    vec4 shadowClipPos = shadowProjection * vec4(shadowViewPos, 1.0);
    vec3 shadow = getSoftShadow(shadowClipPos, dotNL);

    vec3 sunlight = vec3(dotNL) * SUN_INTENSITY * lmData.g * shadow;
    vec3 ambientlight = (vec3(lmData.g) * 0.4 + vec3(lmData.r) * 1.2 + AMBIENT_BRIGHTNESS) * albedo.a;
    vec3 sceneColor = albedo.rgb * (sunlight + ambientlight);

    fragColor.rgb = (sceneColor * (1.0 + sceneColor / (WHITE_POINT * WHITE_POINT))) / (1.0 + sceneColor);
    fragColor.rgb = pow(fragColor.rgb, vec3(1.0 / 2.2));
}