#define CUSTOM_VERTEX_SHADER

#include "Pipelines/NPR_Pipeline.glsl"

uniform vec3 outline_color = vec3(0,0,0);
uniform float line_scale = 1.0;

void COMMON_VERTEX_SHADER(inout Surface S)
{
    float outline_scale = line_scale * S.color[0].a * 0.01;

    vec3 view_space_normal = transform_normal(CAMERA, S.normal);
    vec3 view_space_position = transform_point(CAMERA, S.position);

    view_space_position.xy += view_space_normal.xy * (abs(view_space_position.z) + 1) * 0.3 * outline_scale;

    S.position = transform_point(inverse(CAMERA), view_space_position);
}

vec4 depth_offset(vec4 color, float depth_offset)
{
    #if defined(PIXEL_SHADER) && !defined(SHADOW_PASS)
    {
        vec3 offset_position = POSITION - view_direction() * depth_offset;
        float projected_depth = project_point(PROJECTION * CAMERA, offset_position).z;
        float far = gl_DepthRange.far;
        float near = gl_DepthRange.near;
        gl_FragDepth = (((far-near) * projected_depth) + near + far) / 2.0;
    }
    #endif

    return color;
}

void COMMON_PIXEL_SHADER(Surface S, inout PixelOutput PO)
{
    PO.color = depth_offset(vec4(outline_color, 1.0), (1 - S.color[0].b) * 0.1);

    if(get_is_front_facing())
    {
        PO.color.a = 0;
    }
}
