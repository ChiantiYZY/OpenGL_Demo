#version 150

uniform mat4 u_Model;
uniform mat3 u_ModelInvTr;
uniform mat4 u_View;
uniform mat4 u_Proj;
uniform vec4 u_Eye;

uniform int u_Time;

in vec4 vs_Pos;
in vec4 vs_Nor;

in vec2 vs_UV;

out vec3 fs_Pos;
out vec4 fs_Nor;
out vec4 fs_LightVec;

out vec2 fs_UV;

float mod289(float x){return x - floor(x * (1.0 / 289.0)) * 289.0;}
vec4 mod289(vec4 x){return x - floor(x * (1.0 / 289.0)) * 289.0;}
vec4 perm(vec4 x){return mod289(((x * 34.0) + 1.0) * x);}

float noise(vec3 p) {
    vec3 a = floor(p);
    vec3 d = p - a;
    d = d * d * (3.0 - 2.0 * d);

    vec4 b = vec4(a.x, a.x, a.y, a.y) + vec4(0.0, 1.0, 0.0, 1.0);
    vec4 k1 = perm(b.xyxy);
    vec4 k2 = perm(k1.xyxy + b.zzww);

    vec4 c = k2 + vec4(a.z, a.z, a.z, a.z);
    vec4 k3 = perm(c);
    vec4 k4 = perm(c + 1.0);

    vec4 o1 = fract(k3 * (1.0 / 41.0));
    vec4 o2 = fract(k4 * (1.0 / 41.0));

    vec4 o3 = o2 * d.z + o1 * (1.0 - d.z);
    vec2 o4 = o3.yw * d.x + o3.xz * (1.0 - d.x);

    return o4.y * d.y + o4.x * (1.0 - d.y);
}


void main()
{
    // TODO Homework 4

    float pi = 3.1415926;

    float theta = 0.005 * u_Time;

    mat4 rz = mat4(cos(theta), sin(theta),0.0, 0.0,
                     -sin(theta),cos(theta),0.0, 0.0,
                    0.0,0.0,1.0,0.0,
                    0.0, 0.0, 0.0, 1.0);

    mat4 ry = mat4(cos(theta), 0.0, -sin(theta), 0.0,
                           0.0, 1.0, 0.0, 0.0,
                           sin(theta), 0.0, cos(theta), 0.0,
                            0.0, 0.0, 0.0, 1.0);

    mat4 rx = mat4(1.0, 0.0, 0.0, 0.0,
                           0.0, cos(theta),sin(theta), 0.0,
                           0.0, -sin(theta), cos(theta), 0.0,
                            0.0, 0.0, 0.0, 1.0);

    fs_Nor = normalize(vec4(u_ModelInvTr * vec3(vs_Nor),0));

    vec4 modelposition = u_Model * vs_Pos;

    vec4 cameraPos = u_Eye;

    vec3 u = ((length(vec3(0, -12, 0) - vs_Pos.xyz)) / 3) * vs_Pos.xyz;

    vec4 tmp_pos = vs_Pos;

    //tmp_pos.y = mix( -5, vs_Pos.y, clamp(cos(pi * u_Time * 0.002) + noise(u), 0 ,1));

    modelposition = u_Model * tmp_pos;

    modelposition.y = mix( -5, vs_Pos.y, clamp(cos(pi * u_Time * 0.002) + noise(u), 0 ,1));

    fs_LightVec = cameraPos - modelposition;

    fs_UV = vs_UV;
    fs_Pos = vs_Pos.xyz;

    gl_Position = u_Proj * u_View * modelposition;
}
