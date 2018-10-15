#version 150

in vec2 fs_UV;

out vec3 color;

uniform sampler2D u_RenderedTexture;
uniform int u_Time;
uniform ivec2 u_Dimensions;

void main()
{
    // TODO Homework 5
    //color = vec3(0, 0, 0);

    float PI = 3.1415926;
    float sigma = 9.0f;

    int N = 11;

    float kernel;

    float sum;

    for(int i = 0; i < N; i++)
    {
        for(int j = 0; j < N; j++)
        {

            vec2 new_UV = fs_UV + vec2(1.0f * (j - N / 2 + 1)/ u_Dimensions.x, 1.0f * (i - N / 2 + 1)/ u_Dimensions.y);
            kernel = exp(-(i * i + j * j) / (2 * sigma * sigma));
            color += texture(u_RenderedTexture, new_UV).xyz * kernel;
            sum += kernel;
        }
    }


    color = color / sum;




}
