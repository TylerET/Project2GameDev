dir += rotationSpeed;

var _targetX = xstart + lengthdir_x(radius, dir);
var _targetY = ystart + lengthdir_y(radius, dir);

xSpeed = _targetX - x;
ySpeed = _targetY - y;

x += xSpeed;
y += ySpeed;
