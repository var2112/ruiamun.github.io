uniform vec3 u_color_main;
varying float vOpacity;

float circle(vec2 st, float r) {

    vec2 dist = st - vec2(.5);
    return 1. - smoothstep(.99 * r, 1.01 * r, dot(dist, dist) * 4.);
    }

void main() {

    float dot = circle(gl_PointCoord.xy, .7);
    if (dot < 0.5) discard;
    gl_FragColor = vec4(u_color_main, dot * vOpacity);
 }