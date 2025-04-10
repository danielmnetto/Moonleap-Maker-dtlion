if oLevelMaker.editor_mode == LEVEL_EDITOR_MODE.OBJECTS {
	draw_sprite(sButtonsMakerObj, 0, xstart, ystart + drawplus);

	if not is_undefined(object.sprite_button_sprite_index) then
		object.draw_sprite_button_part(x, y + drawplus);	
	else if sprite_exists(sprite_index) then
		draw_sprite_ext(sprite_index, 0, x, y + drawplus, scale, scale, image_angle, image_blend, 1);
} else if oLevelMaker.editor_mode == LEVEL_EDITOR_MODE.BACKGROUND {
	
}