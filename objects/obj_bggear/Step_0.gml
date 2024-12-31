image_angle += (sign(image_xscale) * rotationSpeed);
image_angle = wrap(image_angle, 0, 360);
rotationSpeed = approach(rotationSpeed, 1, 0.25);
x = xstart + (camera_get_view_x(view_camera[0]) * 0.005);
y = ystart + (camera_get_view_y(view_camera[0]) * 0.005);