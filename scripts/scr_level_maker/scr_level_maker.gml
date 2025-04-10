enum LEVEL_EDITOR_MODE { OBJECTS, BACKGROUND }
enum LEVEL_CURSOR_TYPE { NOTHING, CURSOR, FINGER, ERASER }
enum LEVEL_STYLE { GRASS, CLOUDS, FLOWERS, SPACE, DUNGEON, LENGTH }
enum SPRITE_ORIGIN { TOP_LEFT, CENTER, BOTTOM, OFFSET5 }

/// @description A "Level Maker Object" constructor. Use this as base to create
/// an object for the level editor.
/// @param {Asset.GMObject} _object_index The matching object index of the level object.
/// @param {real} _object_size_x The horizontal size this object will occupy on the level grid.
/// @param {real} _object_size_y The vertical size this object will occupy on the level grid.
/// @param {real} _origin_type The origin type to position the object sprite on level grid.
/// Use one of the SPRITE_ORIGIN enumerator values to set it.
function LMObject(_object_index, _object_size_x, _object_size_y, _origin_type = SPRITE_ORIGIN.TOP_LEFT) constructor {
	label = "";
	index = _object_index;
	size_x = _object_size_x;
	size_y = _object_size_y;
	origin_type = _origin_type;
	tags = [];
	object_config = undefined;
	
	preview_image_index_vertical = undefined;
	
	sprite_button_sprite_index = undefined;
	sprite_button_image_index = 0;
	sprite_button_x_offset = 0;
	sprite_button_y_offset = 0;
	sprite_button_part_left = 0;
	sprite_button_part_top = 0;
	sprite_button_part_width = 16;
	sprite_button_part_height = 16;
	
	set_preview_index_vertical = function(_image_index_flipped = 0) {
		preview_image_index_vertical = _image_index_flipped;
		return self;
	}
	
	set_sprite_button_part = function(
		new_sprite_index,
		new_image_index,
		left_position,
		top_position,
		x_offset, 
		y_offset,
		width = undefined,
		height = undefined
	) {
		sprite_button_sprite_index = new_sprite_index;
		sprite_button_image_index = new_image_index;
		sprite_button_part_left = left_position;
		sprite_button_part_top = top_position;
		sprite_button_x_offset = x_offset;
		sprite_button_y_offset = y_offset;
		sprite_button_part_width = is_undefined(width) ? sprite_button_part_width : width;
		sprite_button_part_height = is_undefined(height) ? sprite_button_part_height : height;
		return self;
	}
	
	set_object_config = function(_object_config) {
		if not is_struct(_object_config) then
			throw "Object config must be a struct of object variables names as keys.";
		
		object_config = _object_config;
		return self;
	}
	
	draw_sprite_button_part = function(_x, _y) {
		var sprite = sprite_button_sprite_index;
		var sprite_nineslice = sprite_get_nineslice(sprite);
		var prev_nineslice_enabled = sprite_nineslice.enabled;
		
		sprite_nineslice.enabled = false;
		draw_sprite_part(sprite, sprite_button_image_index, sprite_button_part_left, sprite_button_part_top, sprite_button_part_width, sprite_button_part_height, _x + sprite_button_x_offset, _y + sprite_button_y_offset);
		sprite_nineslice.enabled = prev_nineslice_enabled;
	}
	
	add_tag = function() {
		var i = 0;
		
		repeat(argument_count) {
			var _tag = argument[i]
			
			if typeof(_tag) != "string" then throw ("A tag must be a string.");
			array_push(tags, _tag);
			i++;
		}
		
		return self;
	}
	
	has_tag = function(_tag) {
		return array_find_index(tags, _tag) == -1 ? false : true;
	}
	
	/// @desc Gets the x and y position of the object's sprite origin depending of its origin type.
	/// @returns {Array<real>} Array of x and y position of the sprite origin respectively.
	get_sprite_offset_typed = function(_tile_size, _object_tile_width, _object_tile_height) {
		var _sprite = object_get_sprite(index);
		var _offx = sprite_get_xoffset(_sprite);
		var _offy = sprite_get_yoffset(_sprite);
		var _w = sprite_get_width(_sprite);
		var _h = sprite_get_height(_sprite);
		
		switch(origin_type){
			case SPRITE_ORIGIN.OFFSET5:
				return [
					_offx - 8,
					_offy - 8
				];
			case SPRITE_ORIGIN.TOP_LEFT:
				return [
					_offx,
					_offy
				];
			case SPRITE_ORIGIN.BOTTOM:
				return [
					_offx - _w / 2 + _object_tile_width * _tile_size / 2,
					_offy - _h + _object_tile_height * _tile_size,
				];
			case SPRITE_ORIGIN.CENTER:
				return [
					_offx - _w / 2 + _object_tile_width * _tile_size / 2,
					_offy - _h / 2 + _object_tile_height * _tile_size / 2
				];
		}
	}
	
	get_size = function(_tile_size = 8) {
		var _tiled_width = size_x / _tile_size;
		var _tiled_height = size_y / _tile_size;
		
		var _offset = get_sprite_offset_typed(_tile_size, _tiled_width, _tiled_height);
		
		return [_tiled_width, _tiled_height, _offset[0], _offset[1]];
	}
	
	return self;
}

/// @param {real} _top_left_x
/// @param {real} _top_left_y
/// @param {Asset.GMObject} _object
/// @param {real} _object_width
/// @param {real} _object_height
/// @param {real} _xscale
/// @param {real} _yscale
/// @param {real} _angle
function LMObjectGrid(_top_left_x, _top_left_y, _object, _object_width, _object_height, _xscale, _yscale, _angle) constructor {
	top_left_x = _top_left_x;
	top_left_y = _top_left_y;
	object = _object;
	object_width = _object_width;
	object_height = _object_height;
	xscale = _xscale;
	yscale = _yscale;
	angle = _angle;
}

function get_tiles_list() {
	var tiles = [];
	//var tilemap = undefined;
	var tiles_length = 42;
	var tileset_columns = 3;
	var tileset_rows = 14;
	
	//switch(oLevelMaker.selected_style) {
	//	case LEVEL_STYLE.GRASS:
	//		tilemap = tGrassDay;
	//		break;
	//	case LEVEL_STYLE.CLOUDS:
	//		tilemap = tCloudDay;
	//		break;
	//	case LEVEL_STYLE.FLOWERS:
	//		tilemap = tFlower;
	//		break;
	//	case LEVEL_STYLE.SPACE:
	//		tilemap = tSpace;
	//		break;
	//	case LEVEL_STYLE.DUNGEON:
	//		tilemap = tDungeon;
	//		break;
	//}
	
	var counter = 0;
	for(var r = 0; r < tiles_length / 16; r++) {
		for(var c = 0; c < 16; c++) {
			tiles[r, c] = counter++;
		}
	}
	
	return tiles;
}

function get_objects_list() {
	var _obj = [];
	
	_obj[0, 00] =	new LMObject(oPlayer,			16, 16, SPRITE_ORIGIN.BOTTOM).add_tag("is_unique");
	_obj[0, 01] =	new LMObject(oSolid,			16, 16).add_tag("grid_16", "is_holdable");
	_obj[0, 02] =	new LMObject(oBrokenStone,		16, 16).add_tag("grid_16", "is_holdable");
	_obj[0, 03] =	new LMObject(oPermaSpike,		16, 16).add_tag("is_holdable");
	_obj[0, 04] =	new LMObject(oStar,				16, 16).add_tag("can_spin");
	_obj[0, 05] =	new LMObject(oStarRunning,		16, 16);
	_obj[0, 06] =	new LMObject(oSolidDay,			16, 16, SPRITE_ORIGIN.OFFSET5).add_tag("grid_16", "is_holdable");
	_obj[0, 07] =	new LMObject(oSolidNight,		16, 16, SPRITE_ORIGIN.OFFSET5).add_tag("grid_16", "is_holdable");
	_obj[0, 08] =	new LMObject(oLadderDay,		16, 16);
	_obj[0, 09] =	new LMObject(oLadderNight,		16, 16);
	_obj[0, 10] =	new LMObject(oSnail,			16, 16, SPRITE_ORIGIN.BOTTOM).add_tag("can_flip").set_sprite_button_part(sSnailWalk, 0, 0, 2, -9, 0);
	_obj[0, 11] =	new LMObject(oSnailNight,		16, 16, SPRITE_ORIGIN.BOTTOM).add_tag("can_flip").set_sprite_button_part(sSnailIdleNight, 0, 0, 2, -11, 0, 18);
	_obj[0, 12] =	new LMObject(oLady,				16, 16, SPRITE_ORIGIN.CENTER).add_tag("can_flip");
	_obj[0, 13] =	new LMObject(oBat,				16, 16, SPRITE_ORIGIN.CENTER).add_tag("can_flip", "grid_16").set_sprite_button_part(sBat, 0, 10, 4, -7, -8);
	_obj[0, 14] =	new LMObject(oPlatGhost,		16, 16).add_tag("can_spin");
	_obj[0, 15] =	new LMObject(oSolidRamp,		32, 16, SPRITE_ORIGIN.CENTER).add_tag("can_flip").set_sprite_button_part(sBlockRampEditor, 0, 16, 0, -8, -8);
	
	_obj[1, 00] =	new LMObject(oPlayerDir,		16, 16, SPRITE_ORIGIN.BOTTOM).add_tag("is_player");
	_obj[1, 01] =	new LMObject(oBigSolid,			32, 32).add_tag("grid_16", "is_holdable").set_sprite_button_part(sBlockGrayGiant, 0, 0, 0, 0, 0);
	_obj[1, 02] =	new LMObject(oBrokenStoneBig,	32, 32).add_tag("grid_16", "is_holdable").set_sprite_button_part(sBrokenStoneBig, 0, 0, 0, 0, 0);
	_obj[1, 03] =	new LMObject(oStarColor,		16, 16);
	_obj[1, 04] =	new LMObject(oStarRunningColor,	16, 16);
	_obj[1, 05] =	new LMObject(oLadderNeutral,	16, 16);
	_obj[1, 06] =	new LMObject(oSnailGray,		16, 16, SPRITE_ORIGIN.BOTTOM).add_tag("can_flip");
	_obj[1, 07] =	new LMObject(oLadyGray,			16, 16, SPRITE_ORIGIN.CENTER).add_tag("can_flip").set_sprite_button_part(sLadyGrayUI, 0, 3, 0, -8, -8);
	_obj[1, 08] =	new LMObject(oBatVer,			16, 16, SPRITE_ORIGIN.CENTER).add_tag("can_flip", "is_vertical").set_preview_index_vertical(1).set_sprite_button_part(sBatDown, 0, 10, 4, -7, -8);
	_obj[1, 09] =	new LMObject(oMush,				16, 16, SPRITE_ORIGIN.BOTTOM).add_tag("can_spin");
	_obj[1, 10] =	new LMObject(oMushGray,			16, 16, SPRITE_ORIGIN.BOTTOM).add_tag("can_spin").set_sprite_button_part(sMushGrayUI, 0, 0, 0, 0, 0);
	_obj[1, 11] =	new LMObject(oLadyVer,			16, 16, SPRITE_ORIGIN.CENTER).add_tag("can_flip", "is_vertical").set_sprite_button_part(sLadyVerUI, 0, 3, 1, -8, -8);
	_obj[1, 12] =	new LMObject(oLadyGiant,		48, 16, SPRITE_ORIGIN.CENTER).add_tag("can_flip").set_sprite_button_part(sLadyGiant, 0, 19, 1, -8, -8);
	_obj[1, 13] =	new LMObject(oLadyGiant4,		64, 16, SPRITE_ORIGIN.CENTER).add_tag("can_flip").set_sprite_button_part(sLadyGiant4, 0, 14, 1, -8, -8);
	_obj[1, 14] =	new LMObject(oBatGiant,			48, 16, SPRITE_ORIGIN.CENTER).add_tag("can_flip").set_sprite_button_part(sBatGiant, 0, 21, 1, -8, -8);
	_obj[1, 15] =	new LMObject(oBatSuperGiant,	64, 16, SPRITE_ORIGIN.CENTER).add_tag("can_flip").set_sprite_button_part(sBatGiant4, 0, 12, 1, -8, -8);
	
	_obj[2, 00] =	new LMObject(oPlayerNeutral,	16, 16, SPRITE_ORIGIN.BOTTOM).add_tag("is_unique");
	_obj[2, 01] =	new LMObject(oMagicOrb,			16, 16, SPRITE_ORIGIN.BOTTOM).add_tag("is_unique");
	_obj[2, 02] =	new LMObject(oStarFly,			16, 16);
	_obj[2, 03] =	new LMObject(oKey,				16, 16);
	_obj[2, 04] =	new LMObject(oKeyDoor,			16, 16);
	_obj[2, 05] =	new LMObject(oKeyTall,			32, 16).set_sprite_button_part(sKeyDoorTallUI, 0, 0, 8, -8, -8);
	_obj[2, 06] =	new LMObject(oKeyDoorTall,		32, 16).set_sprite_button_part(sKeyDoorTall, 0, 0, 8, -8, -8);
	_obj[2, 07] =	new LMObject(oKeyWide,			32, 16).set_sprite_button_part(sKeyDoorWideUI, 0, 8, 0, -8, -8);
	_obj[2, 08] =	new LMObject(oKeyDoorWide,		32, 16).set_sprite_button_part(sKeyDoorWide, 0, 8, 0, -8, -8);
	_obj[2, 09] =	new LMObject(oKeyTallWide,		32, 32).set_sprite_button_part(sKeyDoorTallWideUI, 0, 0, 0, -8, -8);
	_obj[2, 10] =	new LMObject(oKeyDoorTallWide,	32, 32).set_sprite_button_part(sKeyDoorWideTall, 0, 0, 0, -8, -8);
	_obj[2, 11] =	new LMObject(oBird,				16, 16, SPRITE_ORIGIN.BOTTOM).add_tag("can_flip", "is_unique");
	_obj[2, 12] =	new LMObject(oSolidInv,			16, 16).add_tag("grid_16", "is_holdable");
	_obj[2, 13] =	new LMObject(oBlack,			16, 16).add_tag("grid_16", "is_holdable");
	_obj[2, 14] =	undefined;
	_obj[2, 15] =	undefined;
	
	return _obj;
}

////x0 mostly neutral	//x1 mostly day				//x2 mostly night			//x3								//x4 unused, i plan to make stars fly with they werent colliding
//obj[0,0]=oPlayer		obj[1,0]=oPlayerDir			obj[2,0]=oPlayerNeutral		obj[3,0]=oUndefined				obj[4,0]=oUndefined
//obj[0,1]=oSolid			obj[1,1]=oSolidDay			obj[2,1]=oSolidNight		obj[3,1]=oBigSolid				obj[4,1]=oUndefined
//obj[0,2]=oPlatGhost		obj[1,2]=oBrokenStone		obj[2,2]=oBrokenStoneBig	obj[3,2]=oSolidRamp/**/			obj[4,2]=oUndefined
//obj[0,3]=oPermaSpike	obj[1,3]=oUndefined			obj[2,3]=oUndefined			obj[3,3]=oUndefined/**/			obj[4,3]=oUndefined
//obj[0,4]=oStar			obj[1,4]=oStarColor			obj[2,4]=oStarRunning		obj[3,4]=oStarRunningColor		obj[4,4]=oStarFly
//obj[0,5]=oLadderNeutral obj[1,5]=oLadderDay			obj[2,5]=oLadderNight		obj[3,5]=oUndefined/**/			obj[4,5]=oPlatGhostL
//obj[0,6]=oSnailGray		obj[1,6]=oSnail				obj[2,6]=oSnailNight		obj[3,6]=oUndefined/**/			obj[4,6]=oPlatGhostR
//obj[0,7]=oLadyGray		obj[1,7]=oLady				obj[2,7]=oLadyGiant			obj[3,7]=oLadyGiant4			obj[4,7]=oPlatGhostInv
//obj[0,8]=oBat			obj[1,8]=oBatGiant			obj[2,8]=oUndefined			obj[3,8]=oUndefined/*baixo*/	obj[4,8]=oNeutralFlag
//obj[0,9]=oMushGray		obj[1,9]=oMush				obj[2,9]=oMushGray			obj[3,9]=oUndefined				obj[4,9]=oUndefined
////obj[0,10]=oUndefined	obj[1,10]=oUndefined		obj[2,10]=oUndefined		obj[3,10]=oUndefined			obj[4,10]=oUndefined
//obj[0,10]=oKey			obj[1,10]=oKeyTall			obj[2,10]=oKeyWide			obj[3,10]=oKeyTallWide			obj[4,10]=oUndefined //make different spr to differentiate the keys
//obj[0,11]=oKeyDoor		obj[1,11]=oKeyDoorTall		obj[2,11]=oKeyDoorWide		obj[3,11]=oKeyDoorTallWide		obj[4,11]=oUndefined
//obj[0,12]=oGrayOrb		obj[1,12]=oMagicOrb			obj[2,12]=oUndefined		obj[3,12]=oUndefined			obj[4,12]=oUndefined
//obj[0,13]=oBird			obj[1,13]=oUndefined		obj[2,13]=oUndefined		obj[3,13]=oUndefined			obj[4,13]=oUndefined
//obj[0,14]=oBlack		obj[1,14]=oUndefined		obj[2,14]=oUndefined		obj[3,14]=oUndefined			obj[4,14]=oUndefined
//obj[0,15]=oUndefined	obj[1,15]=oUndefined		obj[2,15]=oUndefined		obj[3,15]=oUndefined			obj[4,15]=oUndefined

function level_maker_apply_style_on_level() {
	instance_destroy(oGrassDay);
	instance_destroy(oCloudDay) 
	instance_destroy(oFlowerDay);
	instance_destroy(oSpaceDay);
	instance_destroy(oDunDay)

	switch(oLevelMaker.selected_style) {
		case LEVEL_STYLE.GRASS:		instance_create_layer(-64, -64, layer, oGrassDay);		break;
		case LEVEL_STYLE.CLOUDS:	instance_create_layer(-64, -64, layer, oCloudDay);		break;
		case LEVEL_STYLE.FLOWERS:	instance_create_layer(-64, -64, layer, oFlowerDay);		break;
		case LEVEL_STYLE.SPACE:		instance_create_layer(-64, -64, layer, oSpaceDay);		break;
		case LEVEL_STYLE.DUNGEON:	instance_create_layer(-64, -64, layer, oDunDay);		break;
	}
	
	for (var yy = oLevelMaker.object_positions_length - 1; yy>=0; yy-=1) {
		for (var xx = oLevelMaker.object_types_length - 1; xx>=0; xx-=1) {
			var object = oLevelMaker.obj[xx, yy];
			
			if is_undefined(object) then continue;

			with(object.index) {
				palette_index = oLevelMaker.selected_style;
			}
		}
	}
}

function level_maker_toggle_level_style_hover_text() {
	var _text = LANG.maker_change_level_style + "\n";
	switch (oLevelMaker.selected_style) {
		case LEVEL_STYLE.GRASS:		_text += LANG.maker_grassstyle; break;
		case LEVEL_STYLE.CLOUDS:	_text += LANG.maker_cloudstyle; break;
		case LEVEL_STYLE.FLOWERS:	_text += LANG.maker_flowerstyle; break;
		case LEVEL_STYLE.SPACE:		_text += LANG.maker_spacestyle; break;
		case LEVEL_STYLE.DUNGEON:	_text += LANG.maker_dungeonstyle; break;
	}
	return _text;
}

function level_maker_toggle_level_style() {
	if not instance_exists(oLevelMaker) then return;
	
	with(oLevelMaker) {
		selected_style += 1
		if selected_style >= LEVEL_STYLE.LENGTH then selected_style = 0
		
		//switch (selected_style) {
		//	case LEVEL_STYLE.GRASS:		other.hover_text = LANG.maker_grassstyle;	break;
		//	case LEVEL_STYLE.CLOUDS:	other.hover_text = LANG.maker_cloudstyle;	break;
		//	case LEVEL_STYLE.FLOWERS:	other.hover_text = LANG.maker_flowerstyle;	break;
		//	case LEVEL_STYLE.SPACE:		other.hover_text = LANG.maker_spacestyle;	break;
		//	case LEVEL_STYLE.DUNGEON:	other.hover_text = LANG.maker_dungeonstyle;	break;
		//}
	}
	
	level_maker_apply_style_on_level();
}

function level_maker_check_mouse_wheel_to_page_group_up() {
	if not mouse_wheel_down() then return;
	audio_play_sfx(snd_morcego_02, false, -18.3, 1);
	level_maker_trigger_page_group_up();
}

function level_maker_check_mouse_wheel_to_page_group_down() {
	if not mouse_wheel_up() then return;
	audio_play_sfx(snd_morcego_02, false, -18.3, 1);
	level_maker_trigger_page_group_down();
}

function level_maker_trigger_page_group_up() {
	with(oLevelMaker) {
		item_preview_offset_y = -4
	    selected_object_type -= 1
		
		repeat(object_types_length) {
			if selected_object_type < 0 then
				selected_object_type = object_types_length - 1;
			if selected_object == noone then
				selected_object_type -= 1;
		}
		
		oButtonMakerObj.drawplus = -1;
		oLevelMaker.image_xscale = 1;
		oLevelMaker.image_yscale = 1;
		oLevelMaker.image_angle = 0;
	}
}

function level_maker_trigger_page_group_down() {
	with(oLevelMaker) {
		item_preview_offset_y = 4
	    selected_object_type += 1
		
		repeat(object_positions_length - 1) {
			if selected_object_type > object_types_length - 1 then 
				selected_object_type = 0;
			if selected_object = noone then
				selected_object_position += 1;
		}
		
		oButtonMakerObj.drawplus = 1;
		oLevelMaker.image_xscale = 1;
		oLevelMaker.image_yscale = 1;
		oLevelMaker.image_angle = 0;
	}
}

function level_maker_trigger_save_level() {
	var level_name = get_save_filename("*.moonlevel", "mylevel");
	
	if (level_name == "") then return;
	
	save_level(d_levelName);
}

function level_maker_trigger_load_level() {
	var level_name = get_open_filename("*.moonlevel","mylevel");
	
	if (level_name == "") then return;
	
	load_level(level_name);
}

function level_maker_trigger_test_level() {
	with(oLevelMaker) {
		if not instance_exists(oPause) {
			oLevelMaker.reset_test_button_cooldown();
			oLevelMaker.end_level_and_return_to_editor();
			break;
		}

		var has_player_in_level =
			object_of_type_exists_in_editor(oPlayer) 
			or object_of_type_exists_in_editor(oPlayerDir) 
			or object_of_type_exists_in_editor(oPlayerNeutral) 
			or object_of_type_exists_in_editor(oPlayerEnding);
			
		var has_star_in_level = 
			object_of_type_exists_in_editor(oStar) 
			or object_of_type_exists_in_editor(oStarColor) 
			or object_of_type_exists_in_editor(oStarRunning) 
			or object_of_type_exists_in_editor(oStarRunningColor) 
			or object_of_type_exists_in_editor(oStarFly) 
			or object_of_type_exists_in_editor(oStarColorNight);
		
		if has_player_in_level and has_star_in_level {
			start_level();
		} else {
			if not has_player_in_level then show_message_async(LANG.maker_noplayer);
			if not has_star_in_level then show_message_async(LANG.maker_noestar);
		}
	}
}

function level_maker_trigger_help() {
	show_message_async(LANG.maker_help_text);
}

function level_maker_trigger_change_style() {
	level_maker_toggle_level_style();
}

function level_maker_trigger_eraser() {
	if not instance_exists(oLevelMakerCursor) then return;
	
	oLevelMakerCursor.style = CURSOR_STYLE.ERASER;
}

function level_maker_trigger_clear_level() {
	if mouse_check_button_released(mb_left) {
		holding = 0;
		return;
	}
	
	holding += 0.05;
	
	if holding == 4 {
		audio_play_sfx(sfx_luano_death_pause_01, false, -8.79, 5);
		room_restart();
	}
}