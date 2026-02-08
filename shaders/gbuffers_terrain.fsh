#version 330 core
#define GBUFFER_SHADER
#include "/libs/Uniforms.glsl"
#include "/libs/Settings.glsl"
#include "/libs/Utilities.glsl"

in vec2 texCoord;
in vec3 vNormal;
in vec4 vColor;

/* RENDERTARGETS: 0,1,2 */
layout(location = 0) out vec4 fragColor;
layout(location = 1) out vec4 encodedNormal;

void main() {
  fragColor = texture(gtexture, texCoord) * vColor;
  if (fragColor.a < alphaTestRef) {
    discard;
  }
  fragColor.a = vColor.a;
  encodedNormal = vec4(vNormal * 0.5 + 0.5, 1.0);
}