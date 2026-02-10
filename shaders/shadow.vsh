#version 330 core
#define SHADOW_SHADER
#include "/libs/Uniforms.glsl"
#include "/libs/Attributes.glsl"

out vec2 texCoord;

void main() {
    gl_Position = projectionMatrix * modelViewMatrix * vec4(vaPosition + chunkOffset, 1.0);
    texCoord = vaUV0;
}