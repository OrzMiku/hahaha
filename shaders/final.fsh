#version 330 core
#define FINAL_SHADER
#include "/libs/Uniforms.glsl"
#include "/libs/Settings.glsl"

in vec2 texCoord;

/* RENDERTARGETS: 0 */
layout(location = 0) out vec4 fragColor;

void main() {
  vec4 albedo = texture(colortex0, texCoord);
  vec3 normal = texture(colortex1, texCoord).xyz * 2.0 - 1.0;
  vec3 lightDir = normalize(mat3(gbufferModelViewInverse) * shadowLightPosition);
  float NdotL = max(dot(normal, lightDir), 0.0);
  fragColor = albedo * mix(NdotL, 1.0, AMBIENT_BRIGHTNESS) * albedo.a;
}