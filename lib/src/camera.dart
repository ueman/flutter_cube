import 'dart:math' as math;
import 'package:vector_math/vector_math_64.dart';

class Camera {
  Camera({
    Vector3? position,
    Vector3? target,
    Vector3? up,
    this.fov = 60.0,
    this.near = 0.1,
    this.far = 1000,
    this.zoom = 1.0,
    this.viewportWidth = 100.0,
    this.viewportHeight = 100.0,
  }) {
    if (position != null) position.copyInto(this.position);
    if (target != null) target.copyInto(this.target);
    if (up != null) up.copyInto(this.up);
  }

  final Vector3 position = Vector3(0.0, 0.0, -10.0);
  final Vector3 target = Vector3(0.0, 0.0, 0.0);
  final Vector3 up = Vector3(0.0, 1.0, 0.0);
  double fov;
  double near;
  double far;
  double zoom;
  double viewportWidth;
  double viewportHeight;

  double get aspectRatio => viewportWidth / viewportHeight;

  Matrix4 get lookAtMatrix => makeViewMatrix(position, target, up);

  Matrix4 get projectionMatrix {
    final double top = near * math.tan(radians(fov) / 2.0) / zoom;
    final double bottom = -top;
    final double right = top * aspectRatio;
    final double left = -right;
    return makeFrustumMatrix(left, right, bottom, top, near, far);
  }

  void trackBall(Vector2 from, Vector2 to, [double sensitivity = 1.0]) {
    final double x = -(to.x - from.x) * sensitivity / (viewportWidth * 0.5);
    final double y = (to.y - from.y) * sensitivity / (viewportHeight * 0.5);
    final Vector2 delta = Vector2(x, y);
    Vector3 moveDirection = Vector3(delta.x, delta.y, 0);
    final double angle = moveDirection.length;
    if (angle > 0) {
      final Vector3 eye = position - target;
      final Vector3 eyeDirection = eye.normalized();
      final Vector3 upDirection = up.normalized();
      final Vector3 sidewaysDirection =
          upDirection.cross(eyeDirection).normalized();
      upDirection.scale(delta.y);
      sidewaysDirection.scale(delta.x);
      moveDirection = upDirection + sidewaysDirection;
      final Vector3 axis = moveDirection.cross(eye).normalized();
      final Quaternion q = Quaternion.axisAngle(axis, angle);
      q.rotate(position);
      q.rotate(up);
    }
  }
}
