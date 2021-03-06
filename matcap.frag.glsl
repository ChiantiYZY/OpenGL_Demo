#version 330

uniform sampler2D u_Texture; // The texture to be read from by this shader

in vec2 fs_Nor;

layout(location = 0) out vec3 out_Col;

void main()
{
    vec4 diffuseColor = texture(u_Texture, fs_Nor);
    out_Col = vec3(diffuseColor.rgb);
}
