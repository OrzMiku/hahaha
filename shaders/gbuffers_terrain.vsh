#version 330 core
#define GBUFFER_SHADER
#include "/libs/Uniforms.glsl"
#include "/libs/Attributes.glsl"

out vec2 texCoord;
out vec2 lmCoord;
out vec3 vNormal;
out vec4 vColor;

void main() {
  gl_Position = projectionMatrix * modelViewMatrix * vec4(vaPosition + chunkOffset, 1.0);
  texCoord = (textureMatrix * vec4(vaUV0, 0.0, 1.0)).xy;
  const mat4 TEXTURE_MATRIX_2 = mat4(vec4(0.00390625, 0.0, 0.0, 0.0), vec4(0.0, 0.00390625, 0.0, 0.0), vec4(0.0, 0.0, 0.00390625, 0.0), vec4(0.0, 0.0, 0.0, 1.0));
  lmCoord = (TEXTURE_MATRIX_2 * vec4(vaUV2, 0.0, 1.0)).xy;
  vColor = vaColor;
  vNormal = mat3(gbufferModelViewInverse) * normalMatrix * vaNormal;
}