#version 150

#moj_import <light.glsl>

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in ivec2 UV1;
in ivec2 UV2;
in vec3 Normal;

uniform sampler2D Sampler1;
uniform sampler2D Sampler2;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;

uniform vec3 Light0_Direction;
uniform vec3 Light1_Direction;

out float vertexDistance;
out vec4 vertexColor;
out vec4 lightMapColor;
out vec4 overlayColor;
out vec2 texCoord0;
out vec4 normal;

uniform float GameTime;



float wobble(vec2 pair) {
     return (sin(dot(pair.xy, vec2(10,100)) * 0.25) - 0.5) * 2;
}

void main() {
    float salt = wobble(vec2(GameTime, GameTime));
    vec3 offset = 0.025 * vec3(wobble(salt * Position.yz), wobble(salt * Position.xz), wobble(salt * Position.xy));
    gl_Position = ProjMat * vec4(Position + offset, 1.0);
    overlayColor = texelFetch(Sampler1, UV1, 0);
    texCoord0 = UV0;
}