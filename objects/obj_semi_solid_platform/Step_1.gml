dir += rotationSpeed;

var _targetX = xstart + lengthdir_x(radius, dir);
var _targetY = ystart + lengthdir_y(radius, dir);

xSpeed = movesXAxis ? _targetX - x : 0;
ySpeed = movesYAxis ? _targetY - y : 0;

x += xSpeed;
y += ySpeed;
