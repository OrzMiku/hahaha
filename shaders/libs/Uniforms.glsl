#ifndef UNIFORMS_GLSL
#define UNIFORMS_GLSL

#if defined(FINAL_SHADER) || defined(COMPOSITE_SHADER) || defined(DEFFRRED_SHADER)
uniform sampler2D colortex0;
uniform sampler2D colortex1;
uniform sampler2D colortex2;
uniform sampler2D depthtex0;
#endif

#if defined(GBUFFER_SHADER) || defined(SHADOW_SHADER)
#endif
uniform sampler2D gtexture;
uniform sampler2D lightmap;
uniform float alphaTestRef;
uniform vec3 chunkOffset;
uniform vec3 shadowLightPosition;
uniform mat3 normalMatrix;
uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;
uniform mat4 textureMatrix;
uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;
#endif