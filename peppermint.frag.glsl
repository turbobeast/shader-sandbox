uniform vec2 u_resolution;
uniform float u_time;

vec3 peppermint (vec2 p) {
  vec2 q = p - vec2(0.5, 0.5); // + sin(u_time));
  // vec3 col = vec3(0.4, 0.5 + cos(u_time) * 0.5, 0.2);
  vec3 col = vec3(1.0, 0.0, 0.0);
  float r = 0.7 * cos((atan(q.y, q.x) + u_time * 2.0) * (3.0) +  2.0 * length(q) * 16.0);
  float fuzz = 0.001;
  col *= smoothstep(r, r + fuzz, length(p - vec2(0.5)) );
  if (col.r < 0.2) {
    col = vec3(1.0, 1.0, 1.0);
  }
  return col;
}

void main() {
  vec2 p = gl_FragCoord.st/u_resolution;
  vec3 col = peppermint(p);

  gl_FragColor = vec4(col, 1.0);
}
