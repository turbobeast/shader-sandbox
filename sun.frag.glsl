#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float map (float val, float start, float end, float mapStart, float mapEnd) {
  float ratio = val / (end - start);
  return mapStart + (ratio * (mapEnd - mapStart));
}

vec3 color_dist (vec2 center, vec2 loc) {
  float cosTime = (u_time * 10.0);
  float mappedCT = map(cosTime, -1.0, 1.0, 1.0, 2.0);
  float offset = 0.01; // + cos(u_time * 22.0) * 0.2; //tan(utime);
  vec2 otherLoc = vec2(loc.x - sin(loc.x * 200.0 * 0.1) * (cos(u_time * 123.0) * .01), loc.y  -cos(loc.x * 200.0 * 0.1) * (cos(u_time * 20.0) * .017 + offset));
  //vec2 otherLoc = vec2(loc.x, loc.y - cos(loc.x * 200.0 * cos(-0.1 * u_time)) * .02);
  vec2 distVec = center - loc;
  vec2 otherDist = center - otherLoc;
  float outer = 0.46;

  vec2 spot = vec2(0.4, 0.3) - center;
  vec2 spotDist = spot - loc;
  if(length(spotDist) < 0.004) {
    return vec3(0.0);
  }
  //
  // if (loc.x > 0.4 && loc.y < 0.2) {
  //
  // }

  if (length(distVec) < (0.37)) {
    return vec3(1.9, 0.3 + 0.9 * length(distVec), 0.1);
  }

  return vec3(1.0, 0.7, smoothstep(0.37, 1.38, length(distVec))) - vec3(smoothstep(outer-0.16, outer, length(otherDist)));
}

vec3 color_wrap (vec2 bt) {

  float fuzz = 0.08;
  return vec3(1.0 - smoothstep( mod(u_time,  1.0), mod(u_time,  1.0)-fuzz, bt.x), 0.4, 0.4) + vec3(1.0 - smoothstep( mod(u_time,  1.0), mod(u_time, 1.0)+fuzz, bt.x), 0.4, 0.4);
  // float yellow = abs(bt.y - 0.3);
  // return vec3(abs(bt.x - mod(u_time,  2.0)), yellow, yellow);
  // if (abs(bt.x - mod(u_time,  1.0)) > 0.07) {
  //   return vec3(0.0, 0.0, 0.0);
  // }
  // return vec3(1.0, 1.0, 1.0);
  //return vec3(smoothstep(u_time, u_time-0.01, bt.x)) - vec3(smoothstep(u_time-0.01, u_time-0.01, bt.x));
}

vec3 stripe (float actual_pos, float stripe_pos, vec3 col) {
  float fuzz = 0.2;
  return (vec3(smoothstep(stripe_pos - fuzz, stripe_pos - fuzz, actual_pos)) * col) - (smoothstep(stripe_pos -fuzz, stripe_pos + fuzz, actual_pos) * col);
}

vec3 jupiter_stripes (float y) {
  return stripe(y, 0.5, vec3(0.88, 0.58, 0.22));
}


void main() {
  vec2 bt = gl_FragCoord.st/u_resolution;
  vec3 col = color_dist(vec2(0.5 + cos(u_time * 42.0) * 0.007, 0.5 + sin(u_time * 42.0) * 0.007), bt);
  //vec3 col = color_dist(vec2(0.5), bt) * color_wrap(bt) * color_wrap(bt + vec2(0.1)) * color_wrap(bt + vec2(0.2));
  // vec3 col = color_wrap(bt);
  // vec3 col = jupiter_stripes(bt.y);
  gl_FragColor = vec4(col, 1.0);
}
