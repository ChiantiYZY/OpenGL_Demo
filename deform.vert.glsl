#version 150

uniform mat4 u_Model;
uniform mat3 u_ModelInvTr;
uniform mat4 u_View;
uniform mat4 u_Proj;
uniform vec4 u_Eye;

uniform int u_Time;

in vec4 vs_Pos;
in vec4 vs_Nor;

out vec3 fs_Pos;
out vec4 fs_Nor;
out vec4 fs_LightVec;

void main()
{
    // TODO Homework 4

    float pi = 3.1415926;

    fs_Nor = normalize(vec4(u_ModelInvTr * vec3(vs_Nor),0));

    vec4 start_pos = vec4( 3 * normalize(vs_Pos.xyz), 1);

    vec4 tmp_pos = mix(vs_Pos, start_pos, abs(cos(u_Time * pi * 0.005)));

    vec4 modelposition = u_Model * tmp_pos ;

    vec4 cameraPos = u_Eye;

    fs_Pos = vs_Pos.xyz;

    fs_LightVec = cameraPos - modelposition;

    gl_Position = u_Proj * u_View * modelposition;
}
