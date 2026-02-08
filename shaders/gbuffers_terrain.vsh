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
  vColor = vaColor;
  vNormal = mat3(gbufferModelViewInverse) * normalMatrix * vaNormal;
}