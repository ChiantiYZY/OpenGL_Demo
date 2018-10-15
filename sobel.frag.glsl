#version 150

in vec2 fs_UV;

out vec3 color;

uniform sampler2D u_RenderedTexture;
uniform int u_Time;
uniform ivec2 u_Dimensions;

void main()
{
    // TODO Homework 5


    mat3 hori = mat3(3, 0, -3,
                     10, 0, -10,
                     3, 0, -3);
    mat3 vert = mat3(3, 10, 3,
                     0, 0, 0,
                     -3, -10, -3);

    vec3 hC = vec3(0.0, 0.0, 0.0);
    vec3 vC = vec3(0.0, 0.0, 0.0);

    for(int i = 0; i < 3; i++)
    {
        for(int j = 0; j < 3; j++)
        {
            vec3 tmpColor = texture(u_RenderedTexture, fs_UV + vec2(1.0f * (i - 1)/u_Dimensions.x, 1.0f * (j - 1)/u_Dimensions.y)).xyz;
            hC += hori[i][j] * tmpColor;
            vC += vert[i][j] * tmpColor;
        }
    }


    color = sqrt(hC * hC + vC * vC);

}
