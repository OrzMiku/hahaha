#ifndef UTILITIES_GLSL
#define UTILITIES_GLSL
#include "/libs/Settings.glsl"

vec3 projectAndDivide(mat4 projectionMatrix, vec3 position) {
    vec4 homogeneousPos = projectionMatrix * vec4(position, 1.0);
    return (homogeneousPos / homogeneousPos.w).xyz;
}

#endif