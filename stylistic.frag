#version 330

uniform sampler2D u_Texture; // The texture to be read from by this shader
uniform int u_Time;

in vec3 fs_Pos;
in vec4 fs_Nor;
in vec2 fs_UV;

in vec4 fs_LightVec;

layout(location = 0) out vec3 out_Col;

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
    vec4 diffuseColor = texture(u_Texture, fs_UV);

    float diffuseTerm = dot(normalize(fs_Nor), normalize(fs_LightVec));

    diffuseTerm = clamp(diffuseTerm, 0, 1);

    vec3 a = vec3(0.5f, 0.5f, 0.5f);
    vec3 b = vec3(0.8f, 0.8f, 0.8f);
    vec3 c = vec3(1.0f, 1.0f, 0.5f);
    vec3 d = vec3(0.8f, 0.9f, 0.3f);

    //vec3 col = a + b * cos(6.28318 * (c * cos(u_Time * pi * 0.005) + noise(fs_Nor.xyz) + d));
    //out_Col = col;

    out_Col = diffuseColor.xyz;

}



