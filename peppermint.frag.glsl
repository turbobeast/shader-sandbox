uniform vec2 u_resolution;
uniform float u_time;

vec3 peppermint (vec2 p) {
  vec2 q = p - vec2(0.5, 0.5);
  vec3 col = vec3(1.0, 0.0, 0.0);
  float r = 0.7 * cos((atan(q.y, q.x) + cos(u_time * 2.6) * 1.0) * (13.0) +  6.0 * length(q) * 6.0 * sin(u_time * 2.6));
  float fuzz = 0.001;
  col *= smoothstep(r, r + fuzz, length(p - vec2(0.5)) );
  if (col.g < 0.2 && col.b < 0.2 && col.r < 0.2) {
    col = vec3(1.0, 1.0, 1.0);
  }
  return col;
}

void main() {
  vec2 p = gl_FragCoord.st/u_resolution;
  vec3 col = peppermint(p);

  gl_FragColor = vec4(col, 1.0);
}
