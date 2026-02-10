#version 330 core
#include "/libs/Attributes.glsl"

out vec2 texCoord;

void main() {
  gl_Position = vec4(vaPosition.xy * 2.0 - 1.0, 0.0, 1.0);
  texCoord = vaUV0;
}