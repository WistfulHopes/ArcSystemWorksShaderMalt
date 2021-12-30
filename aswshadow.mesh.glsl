//Copyright (c) 2020 BlenderNPR and contributors. MIT license.

#include "Pipelines/NPR_Pipeline.glsl"

void COMMON_PIXEL_SHADER(Surface S, inout PixelOutput PO)
{
    vec3 color = vec3(0,0,0);
    float alpha = 0;

    PO.color.rgb = color;
    PO.color.a = alpha;
    PO.shadow_color = vec4(0,0,0,1);
}

