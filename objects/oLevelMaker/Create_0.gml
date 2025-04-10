/* NOTES:

- This repository is based on Moonleap version 2.3.2, but with the SleepScreens removed and some levels missing, specifically Rooms 0 to 49.
- Rooms 60 to 63 were kept only as examples of how the levels in Moonleap were originally built.
- The maker_mode=true setting in the oIntro causes the game go straight to the RoomMaker0

- Some objects just didnt pause when oPause exists, thats a bug
- oSolidDay and oSolidNight were created for this levelmaker, in the game i use oGrassDay, oGrassNight, oCloudDay...
- [DONE!] the UI show plenty of oUndefined, it isn't ideal, need to do a solution for that
- Style stuff isn't done yet but the way enemies check what style of phase they are in is by checking if there is a GrassDay, CloudDay, FlowerDay and so on
based on that they update their colors
- oPlatGhost dont really rotate, in the game i use oPlatGhostL, oPlatGhostR and oPlatGhostInv...
- The plan is to eventually integrate Moonleap Maker into the Steam version of Moonleap, making it available as an option in the game menu

*/

// Input variables
scr_inputcreate()

level_name = "";
level_author_name = "";

use_ranking_system = false;
rank_S_change_max = 0;
rank_A_change_max = 0;
rank_B_change_max = 0;
rank_C_change_max = 0;

// Grid-related
tile_size = 8;
room_tile_width =  room_width div tile_size;
room_tile_height = (room_height div tile_size) + tile_size;
objects_grid = []; // Grid where the objects inserted by player are.

for(var _x = 0; _x < room_tile_width; _x++) {
	for(var _y = 0; _y < room_tile_height; _y++) {
		objects_grid[_x,_y] = -1;
	}	
}

// Cursor-related
cursor = LEVEL_CURSOR_TYPE.NOTHING;
cursor_object_hovering = undefined;
is_cursor_inside_level = false;
item_preview_offset_x = 0;
item_preview_offset_y = 0;
has_object_below_cursor = false;
test_button_cooldown_max = 20;
test_button_cooldown = test_button_cooldown_max;
reset_test_button_cooldown = function() {
	test_button_cooldown = test_button_cooldown_max;
}

instance_create_layer(0, 0, "Instances_2", oLevelMakerCursor);

// Level-related
selected_style = LEVEL_STYLE.GRASS;
//time = 0; //used to release the buttons

// UI-related
editor_mode = LEVEL_EDITOR_MODE.OBJECTS;
hover_text = "";
text_shadow_x = 2;
text_shadow_y = 1;
color = {
	nice_black: make_color_rgb(0,0,72),
	nice_white: make_color_rgb(170,255,255),
	nice_blue: $FFFFAA55,
};

// Objects-related
selected_object = 0;
selected_object_type = 0;
selected_object_position = 0;
default_sprite_origin = SPRITE_ORIGIN.TOP_LEFT;
object_positions_length = 16;
object_grid_hovering = -1; // Object where cursor is above at.

// Objects List
obj = get_objects_list();
tile_list = get_tiles_list();

object_types_length = array_length(obj);

get_lmobject_from_list = function(_object_index) {
	for(var t = 0; t < array_length(obj); t++) {
		var type = obj[t];
		
		for(var p = 0; p < array_length(type); p++) {
			if type[p].index == _object_index then return type[p];
		}
	}
}

get_x_y_from_object_index = function(_object) {
	for (var yy = object_positions_length - 1; yy >= 0; yy--) {
		for (var xx = object_types_length - 1; xx >= 0; xx--) {
			var object_from_list = obj[xx, yy];
			
			if is_undefined(object_from_list) then continue;
			
			if (object_from_list.index == _object.index) {
				return [xx, yy];
			}
		}
	}
}

rotate_object_offset = function(_object_width, _object_height, _sprite_offset_x, _sprite_offset_y, _angle){
	var _half_width_object = (_object_width * tile_size) div 2;
	var _half_height_object = (_object_height * tile_size) div 2;
	
	_sprite_offset_x -= _half_width_object;
	_sprite_offset_y -= _half_height_object;
	
	var _dist = point_distance(0,0,_sprite_offset_x,_sprite_offset_y);
	var _dir = point_direction(0,0,_sprite_offset_x,_sprite_offset_y);
	
	_sprite_offset_x = lengthdir_x(_dist,_dir+_angle);
	_sprite_offset_y = lengthdir_y(_dist,_dir+_angle);
	
	_sprite_offset_x += _half_width_object;
	_sprite_offset_y += _half_height_object;
	
	return [_sprite_offset_x,_sprite_offset_y];
}

get_grid_object_hovering = function(_mouse_x, _mouse_y){
	for(var _x = 0; _x < room_tile_width; _x++){
		for(var _y = 0; _y < room_tile_height; _y++){
			var _object_grid = objects_grid[_x,_y];
			
			if _object_grid == -1 then continue;
			
			var _top_left_x = _object_grid.top_left_x;
			var _top_left_y = _object_grid.top_left_y;
			
			if is_struct(_object_grid) 
				and _top_left_x == _x
				and _top_left_y == _y
			{
				
				var _w = _object_grid.object_width;
				var _h = _object_grid.object_height;
				
				if point_in_rectangle(_mouse_x, _mouse_y, _x*tile_size,_y*tile_size, (_x+_w)*tile_size, (_y+_h)*tile_size) {
					return _object_grid;
				}
			}
		}	
	}
	return -1;
}

count_objects_in_grid = function(_object_index) {
	var counter = 0;
	
	for(var _x = 0; _x < room_tile_width; _x++){
		for(var _y = 0; _y < room_tile_height; _y++){
			var _object_grid = objects_grid[_x,_y];
			
			if _object_grid == -1 then continue;
			
			if _object_grid.object.index == _object_index {
				counter += 1;
			}
		}	
	}
	
	return counter;
}

place_object_in_object_grid = function(_top_left_x, _top_left_y, _object, _xscale = 1, _yscale = 1, _angle = 0){
	var _object_width = 1;
	var _object_height = 1;

	var _tiled_size = _object.get_size(tile_size);

	_object_width = _tiled_size[0];
	_object_height = _tiled_size[1];
	
	// Create object grid struct
	var _object_grid = new LMObjectGrid(
		_top_left_x,
		_top_left_y,
		_object,
		_object_width,
		_object_height,
		_xscale,
		_yscale,
		_angle
	);
	
	//make sure the object stays inside the grid
	_top_left_x = clamp(_top_left_x, 0, room_tile_width - _object_width);
	_top_left_y = clamp(_top_left_y, 0, room_tile_height - _object_height);
	
	for(var _x = _top_left_x; _x < _top_left_x + _object_width; _x++){
		for(var _y = _top_left_y; _y < _top_left_y + _object_height; _y++) {
			objects_grid[_x, _y] = _object_grid;
		}	
	}
}

remove_object_from_grid = function(_object_grid){
	var _top_left_x = _object_grid.top_left_x;
	var _top_left_y = _object_grid.top_left_y;
	
	var _object_width = _object_grid.object_width;
	var _object_height = _object_grid.object_height;
	
	for(var _x = _top_left_x; _x < _top_left_x + _object_width; _x++) {
		for(var _y = _top_left_y; _y < _top_left_y + _object_height; _y++) {
			objects_grid[_x, _y] = -1;
		}	
	}
}

check_for_objects_in_grid_position = function(_top_left_x, _top_left_y, _object) {
	if _object == undefined then return false;
	
	var _object_width = 1;
	var _object_height = 1;
	var _size = _object.get_size(tile_size);

	_object_width = _size[0];
	_object_height = _size[1];
	
	//make sure the object stays inside the grid
	_top_left_x = clamp(_top_left_x,0, room_tile_width - _object_width);
	_top_left_y = clamp(_top_left_y,0, room_tile_height - _object_height);
	
	for(var _x = _top_left_x; _x < _top_left_x+_object_width; _x++){
		for(var _y = _top_left_y; _y < _top_left_y+_object_height; _y++){
			var _object_grid = objects_grid[_x, _y];
			
			if is_struct(_object_grid) then return true;
		}	
	}
	
	return false;
}

remove_all_player_objects_from_grid = function() {
	for(var _x = 0; _x < room_tile_width; _x++) {
		for(var _y = 0; _y < room_tile_height; _y++) {
			var _object_grid = objects_grid[_x, _y];
			
			if _object_grid == -1 then continue;
			
			var _top_left_x = _object_grid.top_left_x;
			var _top_left_y = _object_grid.top_left_y;
			var _object_index = _object_grid.object;
			
			if is_struct(_object_grid)
				and _top_left_x == _x 
				and _top_left_y == _y 
				and _object_index.has_tag("is_player") 
			{
				remove_object_from_grid(_object_grid);
			}
		}
	}
}

remove_all_specific_objects_from_grid = function(_object_index) {
	for(var _x = 0; _x < room_tile_width; _x++) {
		for(var _y = 0; _y < room_tile_height; _y++) {
			var _object_grid = objects_grid[_x, _y];
			
			if _object_grid == -1 then continue;
			
			var _top_left_x = _object_grid.top_left_x;
			var _top_left_y = _object_grid.top_left_y;
			var _object = _object_grid.object;
			
			if is_struct(_object_grid)
				and _top_left_x == _x 
				and _top_left_y == _y 
				and _object.index == _object_index
			{
				remove_object_from_grid(_object_grid);
			}
		}
	}
}

remove_all_bird_objects_from_grid = function() {
	for(var _x = 0; _x < room_tile_width; _x++) {
		for(var _y = 0; _y < room_tile_height; _y++) {
			var _object_grid = objects_grid[_x, _y];
			
			if _object_grid == -1 then continue;
			
			var _top_left_x = _object_grid.top_left_x;
			var _top_left_y = _object_grid.top_left_y;
			var _object_index = _object_grid.object;
			
			if is_struct(_object_grid)
				and _top_left_x == _x 
				and _top_left_y == _y 
				and _object_index.has_tag("is_bird") 
			{
				remove_object_from_grid(_object_grid);
			}
		}
	}
}

remove_orb_from_grid = function() {
	for(var _x = 0; _x < room_tile_width; _x++){
		for(var _y = 0; _y < room_tile_height; _y++){
			var _object_grid = objects_grid[_x,_y];
			
			if _object_grid == -1 then continue;
			
			var _top_left_x = _object_grid.top_left_x;
			var _top_left_y = _object_grid.top_left_y;
			var _object_index = _object_grid.object;
			
			if is_struct(_object_grid)
				and _top_left_x == _x
				and _top_left_y == _y
				and (_object_grid.object.index == oMagicOrb 
					or _object_grid.object.index == oGrayOrb)
			{
				remove_object_from_grid(_object_grid);
			}
		}
	}
}

object_of_type_exists_in_editor = function(_object_index) {
	for(var _x = 0; _x < room_tile_width; _x++) {
		for(var _y = 0; _y < room_tile_height; _y++) {
			var _object_grid = objects_grid[_x,_y];
			
			if _object_grid == -1 then continue;
			
			if is_struct(_object_grid)
				and _object_grid.object.index == _object_index then
				return true;
		}
	}
	
	return false;
}

start_level = function() {
	audio_play_sfx(sndStarGame,false,-18.3,1)
	hover_text = "";
	
	instance_destroy(oPause);
	
	switch (selected_style) {
		case LEVEL_STYLE.GRASS:		instance_create_layer(0, 0,"Instances", o_grass_song);		break;
		case LEVEL_STYLE.CLOUDS:	instance_create_layer(0, 0,"Instances", o_cloud_song);		break;
		case LEVEL_STYLE.FLOWERS:	instance_create_layer(0, 0,"Instances", o_flower_song);		break;
		case LEVEL_STYLE.SPACE:		instance_create_layer(0, 0,"Instances", o_space_song);		break;
		case LEVEL_STYLE.DUNGEON:	instance_create_layer(0, 0,"Instances", o_dungeon_song);	break;
	}
	
	// This will be used to determine which objects will be
	// created first.
	var instance_queue = ds_priority_create();
	
	// Instantiate all objects on the level
	for(var _x = 0; _x < room_tile_width; _x++) {
		for(var _y = 0; _y < room_tile_height; _y++) {
			var _object_grid = objects_grid[_x,_y];
			
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
				var _angle = _object_grid.angle;
				
				var _sprite = object_get_sprite(_object.index);
				var _object_width = 1;
				var _object_height = 1;
				var _sprite_offset_x = sprite_get_xoffset(_sprite);
				var _sprite_offset_y = sprite_get_yoffset(_sprite);
				var _size = _object.get_size(tile_size);

				_object_width = _size[0];
				_object_height = _size[1];
				_sprite_offset_x = _size[2];
				_sprite_offset_y = _size[3];
			
				var _new_offset = rotate_object_offset(_object_width, _object_height, _sprite_offset_x, _sprite_offset_y, _angle);
				
				_sprite_offset_x = _new_offset[0];
				_sprite_offset_y = _new_offset[1];

				var _in_world_x = _x * tile_size + _sprite_offset_x;
				var _in_world_y = _y * tile_size + _sprite_offset_y;
				
				_in_world_x = round(_in_world_x);
				_in_world_y = round(_in_world_y);
				
				var _priority = 0;
				var _layer_name = "";
				
				switch(_object.index) {
					// THEY MUST BE THE LAST TO NOT BREAK THE STAR COUNTING.
					case oPlayer:
					case oPlayerDir:
					case oPlayerNeutral:
						_priority = 0;
						_layer_name = "Player_Instances";
						break;
						
					case oStar:
					case oStarColor:
					case oStarRunning:
					case oStarRunningColor:
					case oMagicOrb:
					case oGrayOrb:
					case oBird:
						_layer_name = "Player_Instances";
						_priority = 1;
						break;
						
					default:
						_layer_name = "Gimmick_Instances";
						_priority = 10;
						break;
				}
				
				var _object_var_struct = {
					image_xscale: _xscale,
					image_yscale: _yscale,
					image_angle: _angle
				};

				ds_priority_add(
					instance_queue, 
					{
						x: _in_world_x,
						y: _in_world_y,
						layer: _layer_name,
						index: _object.index,
						var_struct: _object_var_struct
					},
					_priority
				);
				
				//instance_create_layer(_in_world_x, _in_world_y, "Instances", _object.index, _object_var_struct);
			}
		}
	}
	
	repeat(ds_priority_size(instance_queue)) {
		var instance = ds_priority_delete_max(instance_queue);
		instance_create_layer(instance.x, instance.y, instance.layer, instance.index, instance.var_struct);
	}
	ds_priority_destroy(instance_queue);
	
	with(oLevelMaker) {
		scr_update_style();
	}
	
	with (oBrokenStone)
	{
		brokenright = instance_place(x+1,y,oBrokenStone)
		brokenleft = instance_place(x-1,y,oBrokenStone)
		brokenup = instance_place(x,y-1,oBrokenStone)
		brokendown = instance_place(x,y+1,oBrokenStone)
	}
}

delete_all_objects_from_level = function() {
	for (var yy = object_positions_length - 1; yy>=0; yy-=1) {
		for (var xx = object_types_length - 1; xx>=0; xx-=1) {
			var object = obj[xx, yy];
			
			if is_undefined(obj[xx, yy]) then continue;
			instance_destroy(object.index, false);
		}
	}
}

end_level_and_return_to_editor = function(){
	//destroy the "song"
	instance_destroy(o_grass_song);
	instance_destroy(o_cloud_song);
	instance_destroy(o_flower_song);
	instance_destroy(o_space_song);
	instance_destroy(o_dungeon_song);
	audio_stop_all()
	
	delete_all_objects_from_level();
	instance_create_layer(x,y,layer,oPause);
	
	// Reset day/night state
	if instance_exists(oCamera) then
		oCamera.night = false;
	
	// Destroy gimmicks that would persist on level editor after playtest
	instance_destroy(oNeutralFlag);
	instance_destroy(oKeyFollow);
	instance_destroy(oKeyFollow2);
	instance_destroy(oKeyFollow3);
	
	audio_play_sfx(snd_bump, false, 1, 1);
	just_entered_level_editor = true;
}

//CAMERA CODE

oCamera.fancyeffects = false;

camera_current_interpolation = 0;

global.level_maker_mouse_x = mouse_x;
global.level_maker_mouse_y = mouse_y;

just_entered_level_editor = false;

instance_create_layer(x,y,layer,oPause);

//----------------------
// DEFAULT LEVEL

// floor
var fi = 0;
repeat(6) {
	place_object_in_object_grid(14 + 2 * fi, 14, get_lmobject_from_list(oSolid));
	fi++;
}

// player
place_object_in_object_grid(16, 12, get_lmobject_from_list(oPlayer));

// star
place_object_in_object_grid(22, 12, get_lmobject_from_list(oStar));
