#include "Pipelines/NPR_Pipeline.glsl"

uniform sampler2D base_texture;
uniform float glow_multiplier = 2;

void COMMON_PIXEL_SHADER(Surface S, inout PixelOutput PO)
{
    vec4 base_color = texture(base_texture, S.uv[0]);

    base_color = base_color * base_color * glow_multiplier;

    PO.color.rgb = base_color.rgb;
}