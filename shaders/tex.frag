#version 330 core
out vec4 FragColor;
in vec2 TexCoord;

uniform sampler2D texture1;
uniform vec4 objectColor;

void main()
{
    vec4 texColor = texture(texture1, TexCoord);
    if (texColor.a == 0.0)
        discard;

    FragColor = texColor * objectColor;
}