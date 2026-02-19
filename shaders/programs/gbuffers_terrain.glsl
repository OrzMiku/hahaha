#include "/libs/Uniforms.glsl"
#include "/libs/Settings.glsl"
#include "/libs/Utilities.glsl"

#ifdef VERTEX_STAGE
#include "/libs/Attributes.glsl"

out VS_OUT {
  out vec2 texcoord;
  out vec2 lmcoord;
  out vec3 normal;
  out vec4 color;
} vs_out;

void main() {
  gl_Position = projectionMatrix * modelViewMatrix * vec4(vaPosition + chunkOffset, 1.0);
  vs_out.texcoord = (textureMatrix * vec4(vaUV0, 0.0, 1.0)).xy;
  const mat4 TEXTURE_MATRIX_2 = mat4(vec4(0.00390625, 0.0, 0.0, 0.0), vec4(0.0, 0.00390625, 0.0, 0.0), vec4(0.0, 0.0, 0.00390625, 0.0), vec4(0.0, 0.0, 0.0, 1.0));
  vs_out.lmcoord = (TEXTURE_MATRIX_2 * vec4(vaUV2, 0.0, 1.0)).xy;
  vs_out.color = vaColor;
  vs_out.normal = mat3(gbufferModelViewInverse) * normalMatrix * vaNormal;
}
#endif

#ifdef FRAGMENT_STAGE

in VS_OUT {
  in vec2 texcoord;
  in vec2 lmcoord;
  in vec3 normal;
  in vec4 color;
} fs_in;

/* RENDERTARGETS: 0,1,2,3 */
layout(location = 0) out vec4 fragColor;
layout(location = 1) out vec4 normal;
layout(location = 2) out vec2 lmData;
layout(location = 3) out int geoID;

void main() {
  fragColor = texture(gtexture, fs_in.texcoord) * fs_in.color;
  if (fragColor.a < alphaTestRef) {
    discard;
  }
  fragColor.a = fs_in.color.a;
  normal = vec4(fs_in.normal, 1.0);
  lmData = fs_in.lmcoord;
  #ifdef GBUFFERS_ENTITIES
  fragColor.rgb = mix(fragColor.rgb, entityColor.rgb, entityColor.a);
  if(fs_in.color.a < 0.9) {
    geoID = 2;
  } else {
    geoID = 1;
  }
  #endif
}

#endif