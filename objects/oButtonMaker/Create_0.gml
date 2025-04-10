/// @description Insert description here
// You can write your code in this editor
xs = x
ys = y
level_name = "";
d_levelName = "";
load_name = "";
d_loadLevel = "";
holding=0
drawy=0
drawx=0
scale=1

start_pos_x = x;
start_pos_y = y;
//if(image_index == 6){
//}

small_size = 20;

drawplus=0
drawtarget=0

animate = function() {
	drawplus = 2;
}

play_trigger_sound = function() {
	audio_play_sfx(trigger_sound, false, -18.3, 1);
}

scr_inputcreate()

