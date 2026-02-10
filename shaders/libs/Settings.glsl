#ifndef SETTINGS_GLSL
#define SETTINGS_GLSL

const int shadowMapResolution = 2048; // [512 1024 2048 4096]

#define AMBIENT_BRIGHTNESS 0.1 // [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0]
/*
const float sunPathRotation = 30.0; // [0.0 30.0 60.0 90.0 120.0 150.0 180.0 210.0 240.0 270.0 300.0 330.0]
const float shadowDistance = 64; // [16 32 64 128]
*/
#define SUN_INTENSITY 5.0 // [0.0 0.5 1.0 1.5 2.0 2.5 3.0 3.5 4.0 4.5 5.0]
#define WHITE_POINT 2.5 // [1.0 1.5 2.0 2.5 3.0 3.5 4.0 4.5 5.0]
#define SHADOW_RADIUS 4 // [0 1 2 3 4 5 6 7 8 9 10]
#define SHADOW_RANGE 4 // [0 2 4 6 8 10 12 14 16 18 20]

#endif