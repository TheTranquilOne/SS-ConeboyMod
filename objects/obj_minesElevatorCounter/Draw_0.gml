pal_swap_set(pal_gnome, colorID, false);
draw_sprite_ext(gnome_sprite[dark], gnome_index, x, y, 1, 1, 0, image_blend, 1);
pal_swap_reset();
draw_player_sprite_ext(pizzelle_sprite[dark], pizzelle_index, x, y, 1, 1, 0, image_blend, 1);
draw_player_sprite_ext(eyes_sprite[dark], eyes_index, x, y, 1, 1, 0, image_blend, 1);