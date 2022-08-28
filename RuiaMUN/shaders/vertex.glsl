uniform sampler2D u_visibility;
uniform float u_size;
uniform float u_time_since_click;
uniform vec3 u_clicked;
varying float vOpacity;
void main() {
    float visibility = 1. - step(.4, texture2D(u_visibility, uv).x);
    gl_PointSize = visibility * u_size;

                    // add ripple
    float time = u_time_since_click;
    float dist = length(position - u_clicked);
    float damping = pow(1. - sin(min(time, 1.)), 5.);
    float wave = (1. + sin(3. * dist + 13. * time));
    float delta = -.025 * damping * wave;

                    // make backside dots darker
    vec4 mvPosition = modelViewMatrix * vec4( position, 1.0 );
    vOpacity = (1. / length(mvPosition.xyz) - .7);
    vOpacity = clamp(vOpacity, 0., .5) + .01;

    gl_Position = projectionMatrix * modelViewMatrix * vec4(position * (1. + delta), 1.);

                    // mask with world map
                    
}