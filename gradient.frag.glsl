#version 330

uniform sampler2D u_Texture; // The texture to be read from by this shader

in vec4 fs_Nor;
in vec4 fs_LightVec;


layout(location = 0) out vec3 out_Col;

void main()
{
    // TODO Homework 4

    float diffuseTerm = dot(normalize(fs_Nor), normalize(fs_LightVec));
    diffuseTerm = clamp(diffuseTerm, 0, 1);

    vec3 a = vec3(0.5f, 0.5f, 0.5f);
    vec3 b = vec3(0.5f, 0.5f, 0.5f);
    vec3 c = vec3(1.0f, 1.0f, 1.0f);
    vec3 d = vec3(0.3f, 0.2f, 0.2f);

    vec3 col = a + b * cos( 6.28318*(c * diffuseTerm + d));

    out_Col = col;

}
