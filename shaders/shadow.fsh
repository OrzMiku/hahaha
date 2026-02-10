#version 330 core
#define SHADOW_SHADER
#include "/libs/Uniforms.glsl"

in vec2 texCoord;

void main() {
    float alpha = texture(gtexture, texCoord).a;
    if(alpha < alphaTestRef) {
        discard;
    }
}