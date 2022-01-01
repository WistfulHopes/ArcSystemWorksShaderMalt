//Copyright (c) 2020 BlenderNPR and contributors. MIT license.

#include "Pipelines/NPR_Pipeline.glsl"

uniform sampler2D decal_texture;

void COMMON_PIXEL_SHADER(Surface S, inout PixelOutput PO)
{
    vec3 decal_color = texture(decal_texture, S.uv[0]).rgb;

    float decal_alpha = (decal_color.r + decal_color.g + decal_color.b) / 3;
    decal_alpha = abs(decal_alpha - 0.498) * 2;

    decal_color = decal_color * decal_color * 2;

    PO.color.rgb = decal_color;
    PO.color.a = decal_alpha;
}