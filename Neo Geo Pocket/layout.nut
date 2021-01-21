//
// NeoGeo Pocket
// Theme by Mahuti
// vs. 2.0 // added pos module, flyers, and other minor things
//
local order = 0
class UserConfig {
	</ label="Show Logos", 
        help="Shows wheel images when enabled", 
        order=order++, 
        options="Yes, No" />
        show_logos="Yes";
  
    </ label="Show Boxart", 
        help="Shows boxart when enabled", 
        order=order++, 
        options="Yes, No" />
        show_boxart="Yes";
    
 	</ label="Show Playtime", 
        help="The amount of time this game's been played.", 
        order=order++, 
        options="Yes, No, Include Romname" />
        show_playtime="Yes";
    
    </ label="Show Scanlines", 
        help="Shows scanlines when enabled", 
        order=order++, 
        options="Yes, No" />
        show_scanlines="No"; 
    
    </ label="Scratched Text", 
        help="This is some text scratched in the desk, which may not always be visible. Set it to blank to hide it", 
        order=order++
        />
        desk_text="so underRated";
}

 
local config = fe.get_config()

fe.load_module("preserve-art")
fe.load_module("pos") // positioning & scaling module
fe.load_module("shadow-glow")

// stretched positioning
local posData =  {
    base_width = 1920.0,
    base_height = 1080.0,
    layout_width = fe.layout.width,
    layout_height = fe.layout.height,
    scale= "stretch",
    rotate= 0
    debug = true,
}
local pos = Pos(posData)

// scaled positioning
posData =  {
    base_width = 1920.0,
    base_height = 1080.0,
    layout_width = fe.layout.width,
    layout_height = fe.layout.height,
    scale= "scale",
    rotate=0
    debug = true,
}
local scalepos = Pos(posData)

    
//Wood Background
local bg = fe.add_image("ngp_bg.png", 0, 0, pos.width(1920), pos.height(1080))

//local positioning = fe.add_image("template.png", 0, 0, scalepos.width(1920), scalepos.height(1080))
//positioning.preserve_aspect_ratio = true
    
local scratch_me = null
if (config["desk_text"] != ""){
    
    local scratch_y = 120
    local scratch_x = 200
    local scratch_width = 1100
    local scratch_height = 200
    local scratch_font_height=44 
    local scratch_rotation = -7
        
    scratch_me = fe.add_text(config["desk_text"], pos.x(scratch_x), pos.y(scratch_y), pos.width(scratch_width), pos.height(scratch_height) )
    pos.set_font_height(scratch_font_height,scratch_me, "TopLeft")

    scratch_me.x = scalepos.x(scratch_x, "left")
    scratch_me.y = scalepos.y(scratch_y, "top",scratch_me)
    scratch_me.alpha=140
    scratch_me.rotation=scratch_rotation
    scratch_me.set_rgb(150,112,72)
    scratch_me.font = "sugar-death-2-italic.ttf"
        
    local scratch_me2 = fe.add_text(config["desk_text"], pos.x(scratch_x), pos.y(scratch_y), pos.width(scratch_width), pos.height(scratch_height) )
    scratch_me2.y = scalepos.y( -2, "top", scratch_me2, scratch_me)
    scratch_me2.x = scalepos.x( -2, "left", scratch_me2, scratch_me)
    pos.set_font_height(scratch_font_height,scratch_me2, "TopLeft")
    scratch_me2.alpha=70    
    scratch_me2.rotation=scratch_rotation
    scratch_me2.set_rgb(88,23,41)
    scratch_me2.font = "sugar-death-2-italic.ttf"
    
   scratch_me2.zorder = scratch_me.zorder
}
local notebook = fe.add_image("stuart_hall.png", scalepos.x(1086), scalepos.y(30), scalepos.width(1708), scalepos.height(2004))
notebook.y = scalepos.y(0,"middle",notebook,null,"middle")

local cartcase = fe.add_image("empty_case.png", scalepos.x(1086), scalepos.y(-365), scalepos.width(761), scalepos.height(704))
cartcase.x = scalepos.x(130,"right",cartcase)
cartcase.alpha = 200  
local paper_football = fe.add_image("paper_football.png", scalepos.x(766), scalepos.y(-226), scalepos.width(467), scalepos.height(360))

local playtime = null 
if ( config["show_playtime"] != "No" )
{
    // Playtime   
    if ( config["show_playtime"] == "Yes" )
    {
        playtime = fe.add_text("Playtime: [PlayedTime]", pos.x(14),0, pos.width(800), pos.height(108))
    }
    else
    {
        playtime = fe.add_text("Playtime: [PlayedTime] [Name]", pos.x(14),0, pos.width(800), pos.height(108))
    }
    
    pos.set_font_height(25,playtime, "BottomLeft")
    playtime.y = scalepos.y(-20,"bottom",playtime)
    playtime.x = scalepos.x(20,"left",playtime)
    playtime.set_rgb(10, 10, 10)	
}

    
local boxart = null
if ( config["show_boxart"] == "Yes" )
{
    // Boxart
    boxart = fe.add_artwork("boxart", scalepos.x(-70), scalepos.y(25), scalepos.width(750), scalepos.height(750))
    boxart.preserve_aspect_ratio = true
    boxart.trigger = Transition.EndNavigation
    boxart.rotation = -7.5 
        local ds = DropShadow( boxart, 40, scalepos.x(20), scalepos.y(20), 83 )
    boxart.zorder = boxart.zorder-1
}

local wheel = null
if ( config["show_logos"] == "Yes" )
{
 	// wheel
	wheel = fe.add_artwork("wheel", scalepos.x(52),scalepos.y(830), scalepos.width(400), scalepos.height(216))
    
    if (boxart != null){
        wheel.y=pos.y(10,"top",wheel, boxart,"bottom") 
    }
    else
    {
        wheel.y=pos.y(30,"bottom",wheel)        
    }
    wheel.preserve_aspect_ratio = true
	wheel.trigger = Transition.EndNavigation
    wheel.alpha=220
}


// NeoGeo Pocket Overlay
local ngp_overlay = fe.add_image("ngp_foreground.png", scalepos.x(528), scalepos.y(230), scalepos.width(1357), scalepos.height(867))
ngp_overlay.preserve_aspect_ratio = true
ngp_overlay.x=scalepos.x(180,"middle",ngp_overlay)
        
// Missing Cartridge Underlay
local ngp_underlay = fe.add_image("nogame.png", scalepos.x(958), scalepos.y(290), scalepos.width(615), scalepos.height(510))
ngp_underlay.x=scalepos.x(0,"middle",ngp_underlay,ngp_overlay,"middle")
ngp_underlay.y=scalepos.y(100,"top",ngp_underlay,ngp_overlay,"top")
    
// Snap
local snap = fe.add_artwork("snap", scalepos.x(958), scalepos.y(364), scalepos.width(515), scalepos.height(480))
snap.trigger = Transition.EndNavigation
snap.preserve_aspect_ratio=true
snap.x=scalepos.x(-3,"middle",snap,ngp_overlay,"middle")

    
if (config["show_scanlines"] == "Yes" )
{
    // Scanlines
    local scanlines = fe.add_image("scanlines.png", scalepos.x(958), scalepos.y(355), scalepos.width(622), scalepos.height(480) )
    scanlines.preserve_aspect_ratio = true
    scanlines.x=scalepos.x(0,"middle",scanlines,ngp_overlay,"middle")
    scanlines.alpha=160 
}
ngp_overlay.zorder=snap.zorder+5
