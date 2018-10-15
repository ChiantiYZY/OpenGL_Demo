#version 150

uniform mat4 u_Model;
uniform mat3 u_ModelInvTr;
uniform mat4 u_View;
uniform mat4 u_Proj;

in vec4 vs_Pos;
in vec4 vs_Nor;
in vec2 vs_UV;

out vec2 fs_Nor;

void main()
{
    // TODO Homework 4
    vec3 fs_Nor_before = normalize(u_ModelInvTr * vs_Nor.xyz);

    //normal should be in the camera space such that the light will move with the camera.
    vec4 fs_Nor_camera = u_View * vec4(fs_Nor_before.xyz, 0);

    fs_Nor = vec2((fs_Nor_camera.x + 1) / 2, (fs_Nor_camera.y + 1) / 2);

    vec4 modelposition = u_Model * vs_Pos;
    gl_Position = u_Proj * u_View * modelposition;
}
