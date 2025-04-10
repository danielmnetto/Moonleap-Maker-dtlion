scr_inputcreate();

enum CURSOR_STYLE { NOTHING, POINTER, HAND, ERASER, BLOCK }

style = CURSOR_STYLE.POINTER;
cursor_speed = 3;

set_cursor_style = function(_style) {
	style = _style;
}

// UI related
color = {
	nice_black: make_color_rgb(0,0,72),
	nice_white: make_color_rgb(170,255,255),
	nice_blue: $FFFFAA55,
};

update_cursor_style = function() {
	var _style = CURSOR_STYLE.POINTER;
	
	if style == CURSOR_STYLE.ERASER then 
		_style = CURSOR_STYLE.ERASER;
	else if place_meeting(x, y, oButtonMaker)
	or place_meeting(x, y, oButtonMakerObj) {
		_style = CURSOR_STYLE.HAND;
	}
	
	style = _style;
}

move_to_main_cursor = function() {
	//x = round(mouse_x);
	//y = round(mouse_y);

	var _in_level_editor = instance_exists(oPause);

	camera_current_interpolation += _in_level_editor ? -0.07 : 0.07;
	camera_current_interpolation = clamp(camera_current_interpolation, 0, 1);
	
	var _cam_offset_x = camera_get_view_x(view_camera[0]);
	var _cam_offset_y = camera_get_view_y(view_camera[0]);
	
	var _cam_width = camera_get_view_width(view_camera[0]);
	var _cam_height = camera_get_view_height(view_camera[0]);
	
	var _app_surface_x = lerp(0, _cam_offset_x, camera_current_interpolation);
	var _app_surface_y = lerp(0, _cam_offset_y, camera_current_interpolation);
	
	var _gui_scale_x = lerp(1, _cam_width / room_width, camera_current_interpolation);
	var _gui_scale_y = lerp(1, _cam_height / room_height, camera_current_interpolation);

	x = (mouse_x - _app_surface_x) / _gui_scale_x;
	y = (mouse_y - _app_surface_y) / _gui_scale_y;
}

check_editor_button_click = function() {
	var _button = collision_point(x, y, oButtonMaker, true, true);
	
	if _button == noone then
		return;
	
	if _button.hold_to_trigger 
	and not is_undefined(_button.action_on_hold)
	and mouse_check_button(mb_left) {
		_button.action_on_hold();
		return;
	}
	
	if is_undefined(_button.action)
	or not mouse_check_button_pressed(mb_left) then
		return;
		
	//audio_play_sfx(sndUiChange, false, -18.3, 1);
	_button.play_trigger_sound();
	_button.action();
	_button.animate();
}

draw_button_hover_text = function() {
	if not instance_exists(oPause) then return;
	
	var _button = collision_point(x, y, oButtonMaker, true, true);
	
	if _button == noone then return;
	var _hover_text = typeof(_button.hover_text) == "number" ? _button.hover_text() : _button.hover_text;
	var _text_color = make_color_rgb(170,255,255);
	var _shadow_color = make_color_rgb(0, 0, 72);
	
	draw_set_color(_text_color);
	
	if x < room_width / 2 {
		draw_set_halign(fa_left)
		draw_text_shadow(x + 14, y, _hover_text, 2, 1, _shadow_color);
	} else {
		draw_set_halign(fa_right)
		draw_text_shadow(x - 7, y, _hover_text, 2, 1, _shadow_color);
	}
	
	draw_set_color(-1);
	draw_set_halign(-1);
}

camera_current_interpolation = 0;