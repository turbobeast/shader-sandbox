#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

vec3 color_dist (vec2 center, vec2 loc) {
  vec2 otherLoc = vec2(loc.x, loc.y - sin(loc.x * 200.0 * (-0.1 * cos(u_time))) * .02);
  vec2 distVec = center - loc;
  vec2 otherDist = center - otherLoc;
  float outer = 0.46;

  if (length(distVec) < (0.37)) {
    return vec3(1.9, 0.5, 0.1);
  }

  return vec3(1.3, 0.7, smoothstep(0.37, 0.38, length(distVec))) - vec3(smoothstep(outer-0.1, outer, length(otherDist)));
}


void main() {
  vec2 bt = gl_FragCoord.st/u_resolution;
  vec3 col = color_dist(vec2(0.5), bt);
  gl_FragColor = vec4(col, 1.0);
}
