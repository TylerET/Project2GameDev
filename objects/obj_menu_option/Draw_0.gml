if (menu_controller != noone) {
    // Use the controller's center coordinates for drawing the slice
    var center_x = menu_controller.center_x;
    var center_y = menu_controller.center_y;

    // Set color based on whether the option is selected
    if (is_selected) {
        draw_set_color(c_yellow); // Highlight color for selected/hovered option
    } else {
        draw_set_color(c_white); // Default color
    }

    // Draw the side perimeters from the center to the outer radius
    var radius_outer = 100; // Outer radius for visual effect (adjust as needed)
    var x_start = center_x + radius_outer * cos(degtorad(angle_start));
    var y_start = center_y + radius_outer * sin(degtorad(angle_start));
    var x_end = center_x + radius_outer * cos(degtorad(angle_end));
    var y_end = center_y + radius_outer * sin(degtorad(angle_end));

    // Draw lines from the center to the start and end points on the outer radius
    draw_line(center_x, center_y, x_start, y_start); // Side perimeter for angle_start
    draw_line(center_x, center_y, x_end, y_end);     // Side perimeter for angle_end

    // Draw the outer arc between the start and end points
    var step = 5; // Angle step for smoothness of the arc
    for (var angle = angle_start; angle < angle_end; angle += step) {
        var x1 = center_x + radius_outer * cos(degtorad(angle));
        var y1 = center_y + radius_outer * sin(degtorad(angle));
        var x2 = center_x + radius_outer * cos(degtorad(angle + step));
        var y2 = center_y + radius_outer * sin(degtorad(angle + step));

        // Draw each segment along the outer arc of the slice
        draw_line(x1, y1, x2, y2);
    }

    // Reset draw color
    draw_set_color(c_white);
}
