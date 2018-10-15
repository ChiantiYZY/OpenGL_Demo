#version 150

in vec2 fs_UV;

out vec3 color;

uniform sampler2D u_RenderedTexture;


void main()
{
    // TODO Homework 5
    //color = vec3(0, 0, 0);
    vec4 diffuseColor = texture(u_RenderedTexture, fs_UV);

    float lightness = clamp(1 - sqrt((0.5 - fs_UV.x) * (0.5 - fs_UV.x) + (0.5 - fs_UV.y) * (0.5 - fs_UV.y)) / 0.5,0,1);

    color = vec3(0.21 * diffuseColor.r + 0.72 * diffuseColor.g + 0.07 * diffuseColor.b);

    color = color * lightness;
}
