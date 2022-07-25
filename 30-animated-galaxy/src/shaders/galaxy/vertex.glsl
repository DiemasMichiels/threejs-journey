uniform float uTime;
uniform float uSize;

attribute float aScale;
attribute vec3 aRandomness;

varying vec3 vColor;

void main() {
  // Position
  vec4 modelPosition = modelMatrix * vec4(position, 1.0);

  // Spin
  float angle = atan(modelPosition.x, modelPosition.z);
  float distanceToCenter = length(modelPosition.xz);
  float angleOffset = (1.0 / distanceToCenter) * uTime * 0.2;
  angle += angleOffset;
  modelPosition.x = cos(angle) * distanceToCenter;
  modelPosition.z = sin(angle) * distanceToCenter;
  modelPosition.xyz += aRandomness;

  vec4 mvPosition = viewMatrix * modelPosition;
  gl_Position = projectionMatrix * mvPosition;

  // Size
  gl_PointSize = uSize * aScale;
  gl_PointSize *= (1.0 / -mvPosition.z);

  // Color
  vColor = color;
}