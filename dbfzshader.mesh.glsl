#include "Pipelines/NPR_Pipeline.glsl"

uniform sampler2D base_texture;
uniform sampler2D sss_texture;
uniform sampler2D ilm_texture;
uniform sampler2D detail_texture;
uniform float shadow1_threshold = 0.5;
uniform float shadow2_threshold = 0.1;
uniform float permanent_shadow_threshold = 0.2;
uniform vec3 light_dir;
uniform vec3 highlight_rimlight_color;
uniform float highlight_rimlight_size = 1;
uniform vec3 shadow_rimlight_color;
uniform float shadow_rimlight_size = 1;
uniform float specular_size = 0.2;
uniform vec4 light_color = vec4(0.5,0.5,0.5,1);
uniform vec4 ambient_color = vec4(0.5,0.5,0.5,1);

float LightCalculations(Surface S)
{
   	float intensity;
	intensity = dot(normalize(light_dir),normalize(S.normal));
  
    vec4 ilm_color = texture(ilm_texture, S.uv[0]);
    float ilm_shading = ilm_color.g;

    if (ilm_shading < 0.25)
        ilm_shading = 0;
    
    ilm_shading = abs(ilm_shading * 2);

    float shading = ilm_shading * S.color[0].r;

    intensity = intensity * shading;

    return intensity;
}

vec3 HiglightRimlight(Surface S, float base_alpha)
{
    float intensity;

    intensity = get_rim_light(360, highlight_rimlight_size, 0.4, 0.1);

    intensity = intensity * (1 - base_alpha);

    if (intensity > 0.1)
        return vec3(1,1,1);
    else
        return vec3(0,0,0);
}

vec3 ShadowRimlight(Surface S, float base_alpha)
{
    float intensity;

    intensity = get_rim_light(360, shadow_rimlight_size, 0.4, 0.1);

    intensity = intensity * (1 - base_alpha);

    if (intensity > 0.1)
        return vec3(1,1,1);
    else
        return vec3(0,0,0);
}

vec3 SpecularCalculation(Surface S, float ilm_blue)
{
    vec3 view_space_normal = transform_normal(CAMERA, S.normal);
    vec3 product = normalize(normalize(light_dir) + normalize(view_space_normal));
    float intensity = dot(product, S.normal);
    intensity += dot(normalize(S.normal), normalize(view_space_normal));
    intensity = intensity / 2;
    intensity = intensity * ilm_blue;

    if (intensity > specular_size)
        return vec3(1,1,1);
    else
        return vec3(0,0,0);
}

vec3 SoftLight(vec3 base, vec3 blend)
{
    return (1 - 2 * blend) * base * base + 2 * base * blend;
}

vec3 Lerp(vec3 a, vec3 b, float fac)
{
    return a + (b - a) * fac;
}

float HardLight(float base, float blend)
{
    if (blend > 0.5)
    {
        return 1 - 2 * (1 - base) * (1 - blend);
    }
    else
    {
        return (base * 2 * blend);
    }
}

vec3 HardLight(vec3 base, vec3 blend)
{
    return vec3(HardLight(base.r, blend.r),HardLight(base.g, blend.g),HardLight(base.b, blend.b));
}

void COMMON_PIXEL_SHADER(Surface S, inout PixelOutput PO)
{
	float intensity = LightCalculations(S);

    vec4 base_color = texture(base_texture, S.uv[0]);
    vec4 sss_color = texture(sss_texture, S.uv[0]);
    vec4 ilm_color = texture(ilm_texture, S.uv[0]);
    vec4 detail_color = texture(detail_texture, S.uv[1]);

    base_color = base_color * base_color;
    sss_color = sss_color * sss_color;
    base_color.rgb = HardLight(base_color.rgb, light_color.rgb);
    sss_color.rgb = SoftLight(sss_color.rgb, ambient_color.rgb);

    vec3 cel_shading;

    vec3 highlight_rimlight = HiglightRimlight(S, texture(sss_texture, S.uv[0]).a - texture(base_texture, S.uv[0]).a);
    highlight_rimlight = highlight_rimlight * highlight_rimlight_color * (sss_color.rgb + base_color.rgb * 0.1) * texture(base_texture, S.uv[0]).a;

    vec3 shadow_rimlight = ShadowRimlight(S, texture(sss_texture, S.uv[0]).a - texture(base_texture, S.uv[0]).a);
    shadow_rimlight = shadow_rimlight * shadow_rimlight_color * (Lerp(sss_color.rgb * base_color.rgb, SoftLight(sss_color.rgb * base_color.rgb, vec3(0,0,0)), 0.5) + vec3(0.046665, 0.046665, 0.242281)) * ilm_color.r;

    vec3 specular = SpecularCalculation(S, ilm_color.b);
    if ((specular.r + specular.g + specular.b) / 3 > (base_color.r + base_color.g + base_color.b) / 3)
        specular = Lerp(specular, base_color.rgb, 0.9);
    specular = specular * texture(base_texture, S.uv[0]).a;

    sss_color = texture(base_texture, S.uv[0]) * texture(base_texture, S.uv[0]) * sss_color;

    if(intensity >= shadow1_threshold)
        cel_shading = base_color.rgb + highlight_rimlight + specular;
    else if (ilm_color.g > permanent_shadow_threshold && intensity > shadow2_threshold)
        cel_shading = sss_color.rgb;
    else
        cel_shading = sss_color.rgb * sss_color.rgb + shadow_rimlight;

    vec3 final = cel_shading * ilm_color.a * detail_color.rgb;

    PO.color.rgb = final;
}