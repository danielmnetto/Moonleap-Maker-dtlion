// Draw every tile on the level maker
if(instance_exists(oPause)) {
	for(var _x = 0; _x < room_tile_width; _x++) {
		for(var _y = 0; _y < room_tile_height; _y++) {
			var _xx = _x * 8;
			var _yy = _y * 8;
			var _object_grid = objects_grid[_x, _y];
			
			if _object_grid == -1 then continue;
			
			var _top_left_x = _object_grid.top_left_x;
			var _top_left_y = _object_grid.top_left_y;
		
			if is_struct(_object_grid)
				and _top_left_x == _x
				and _top_left_y == _y 
			{
				var _object = _object_grid.object;
				var _xscale = _object_grid.xscale;
				var _yscale = _object_grid.yscale;
				var _obj_angle = _object_grid.angle;
			
				var _sprite = object_get_sprite(_object.index);
			
				var _object_width = 1;
				var _object_height = 1;
				var _sprite_offset_x = sprite_get_xoffset(_sprite);
				var _sprite_offset_y = sprite_get_yoffset(_sprite);

				var _size = _object.get_size(tile_size);
			
				_sprite_offset_x = _size[2];
				_sprite_offset_y = _size[3];
				
				_object_width = _size[0];
				_object_height = _size[1];
			
				var _new_offset = rotate_object_offset(_object_width,_object_height,_sprite_offset_x,_sprite_offset_y,_obj_angle);

				_sprite_offset_x = _new_offset[0];
				_sprite_offset_y = _new_offset[1];
				
				var _new_image_index = 0;
				var _new_y_scale = _yscale;
				var _preview_index_vertical = _object.preview_image_index_vertical;
				
				if not is_undefined(_preview_index_vertical) {
					_new_image_index = _yscale == -1 ? _preview_index_vertical : 0;
					_new_y_scale = 1;
				}

				draw_sprite_ext(_sprite, _new_image_index, _xx + _sprite_offset_x,_yy + _sprite_offset_y , _xscale, _new_y_scale, _obj_angle, c_white, 1);
			}
		}	
	}
}


draw_set_color(c_white)
draw_set_font(fntSmall)

// Background
draw_sprite(sPauseMaker,0,0,0)

// Draw item preview on cursor
if cursor != LEVEL_CURSOR_TYPE.ERASER
and is_cursor_inside_level 
and instance_exists(oPause)
and not is_undefined(cursor_object_hovering) //sprite_exists(sprite_index)
and not has_object_below_cursor {
	var _new_image_index = 0;
	var _new_y_scale = image_yscale;
	var sprite = object_get_sprite(cursor_object_hovering.index);
	var _preview_index_vertical = cursor_object_hovering.preview_image_index_vertical
				
	if not is_undefined(_preview_index_vertical) {
		_new_image_index = image_yscale == -1 ? _preview_index_vertical : 0;
		_new_y_scale = 1;
	}
	
	var alpha = 0.6;
	draw_sprite_ext(sprite_index, _new_image_index, x + item_preview_offset_x, y + item_preview_offset_y, image_xscale, _new_y_scale, image_angle, c_white, alpha);
}