//
// NeoGeo Pocket
// Theme by Mahuti
 //

class UserConfig {
	</ label="Enable Logos", help="If wheel images/logos aren't used, game titles will be shown instead.", order=1, options="show logos, show titles" />
	enable_logos="show logos";
 
}

local config = fe.get_config();

local flw = fe.layout.width;
local flh = fe.layout.height;

//Background
local bg = fe.add_image("bg.jpg", 0, 0, flw, flh);

// Snap
local snap = fe.add_artwork("snap", flw*0.327, flh*0.238, flw*0.3437, flh*0.43);
snap.trigger = Transition.EndNavigation;

// Boxart
// local flyer = fe.add_artwork("flyer", flw*0.70, flh*0.487, flw*0.1944, flh*0.3666);
// flyer.preserve_aspect_ratio = false;
// flyer.trigger = Transition.EndNavigation;


if ( config["enable_logos"] == "show logos" )
{
 	// wheel
	local wheel = fe.add_artwork("wheel", flw*0.75, flh*0.88, flw*0.2, flh*0.1);
	wheel.preserve_aspect_ratio = true;
	wheel.trigger = Transition.EndNavigation;
	wheel.zorder=100;
	wheel.alpha = 140; 
	
} else {
	// Title
	local title = fe.add_text("[Title]", flw*0, flh*0.92, flw*1, flh*0.1);
	title.align = Align.Right;
	title.charsize = 24;
	title.set_rgb(247, 35, 0);
	title.font = "Pretendo"; 
}
 
// Cartridge
//local cartridge = fe.add_artwork("marquee", flw*0.327, flh*-0.238, flw*0.3437, flh*0.43);
//cartridge.preserve_aspect_ratio = true;
//cartridge.trigger = Transition.EndNavigation;


// Playtime
local playtime = fe.add_text("Playtime : [PlayedTime]", flw*0.01, flh*0.93, flw*0.4, flh*0.1);
playtime.align = Align.Left;
playtime.charsize = 20;
playtime.set_rgb(255, 255, 255);

// Scanlines
local scanlines = fe.add_image("scanlines.png", flw*0.327, flh*0.238, flw*0.3437, flh*0.43);
scanlines.preserve_aspect_ratio = false;
scanlines.alpha = 130;
