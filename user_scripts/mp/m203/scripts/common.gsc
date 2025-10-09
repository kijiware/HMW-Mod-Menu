#include user_scripts\mp\m203\source\utilities;
#include user_scripts\mp\m203\source\structure;
#include user_scripts\mp\m203\source\custom_structure;
#include scripts\utility;
#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\gametypes\_gamelogic;

init() {
    level.attach_array = [ "none", "fmj", "fastfire", "xmag", "xmagmwr", "foregrip", "gl", "glak47", "sho", "akimbo", "heartbeat", "iw5heartbeat", "acog", "augscope", "f2000scope", "holo", "mars", "reflex", "thermal", "3dscope", "ogscope", "ogscopeiw5", "silencerar", "iw5silencerar", "silencerlmg", "silencershotgun", "silencersniper", "silencersmg", "iw5silencersmg", "silencerpistol", "tacknifecolt45", "tacknifemp412", "tacknifedeagle", "tacknifem9", "tacknifeusp", "tacknifecolt44", "holosightmwr", "longbarrelmwr", "masterkeymwr", "tacknifemwr", "thermalmwr", "reflexmwr", "acogmwr", "reflexvarmwr", "varzoommwr", "silencermwr", "gripmwr", "glmwr", "akimbomwr", "heartbeatmwr" ];
    level.bot_difficulty = "veteran";
    level.disco_sun_toggle = false;
    level.disco_x = 0.0;
    level.disco_y = 0.0;
    level.disco_z = 0.0;
    level.raygun_weapon = "h2_pp2000_mp_holo_silencersniper_xmagmwr_camo030";
    level.raygun_fx[ "raygun" ] = loadFX( "fx/misc/aircraft_light_wingtip_red" );
    level.raygun_fx[ "impact" ] = loadFX( "fx/misc/flare_ambient" );
    level.fx_count = 0;
    level.bounce_amount = 0;
    level.bounce_limit = 10;
}

init_precache() {
    precacheModel( "fx_rock_small" );
}

init_fx() {
    level._effect[ "nuke_flash" ] = loadfx( "fx/explosions/nuke_flash" );
    level._effect[ "nuke_explosion" ] = loadfx( "fx/explosions/nuke_explosion" );
    level._effect[ "grenade_flash" ] = loadfx( "explosions/grenade_flash" );
    level._effect[ "aerial_explosion_large" ] = loadfx( "fx/explosions/aerial_explosion_large" );
    level._effect[ "aerial_explosion" ] = loadfx( "fx/explosions/aerial_explosion" );
    level._effect[ "helicopter_explosion_cobra" ] = loadfx( "fx/explosions/helicopter_explosion_cobra" );
    level._effect[ "concussion_grenade_sparkles" ] = loadfx( "vfx/explosion/concussion_grenade_sparkles" );
    level._effect[ "frag_grenade_flash" ] = loadfx( "vfx/explosion/frag_grenade_flash" );
    level._effect[ "vfx/explosion/mp_gametype_bomb" ] = loadfx( "vfx/explosion/mp_gametype_bomb" );
    level._effect[ "vfx/explosion/frag_grenade_default" ] = loadfx( "vfx/explosion/frag_grenade_default" );
    level._effect[ "vfx/explosion/concussion_grenade_h1" ] = loadfx( "vfx/explosion/concussion_grenade_h1" );
    level._effect[ "fire_smoke_trail_l" ] = loadfx( "fx/fire/fire_smoke_trail_l" );
    level._effect[ "fire_smoke_trail_m" ] = loadfx( "fire/fire_smoke_trail_m" );
    level._effect[ "fire_spawner_small_1_cgoshp" ] = loadfx( "vfx/fire/fire_spawner_small_1_cgoshp" );
    level._effect[ "lasersight_attachment" ] = loadfx( "vfx/lights/lasersight_attachment" );
    level._effect[ "light_c4_blink" ] = loadfx( "vfx/lights/light_c4_blink" );
    level._effect[ "aircraft_light_red_blink" ] = loadfx( "fx/misc/aircraft_light_red_blink" );
    level._effect[ "aircraft_light_white_blink" ] = loadfx( "fx/misc/aircraft_light_white_blink" );
    level._effect[ "aircraft_light_wingtip_green" ] = loadfx( "fx/misc/aircraft_light_wingtip_green" );
    level._effect[ "aircraft_light_wingtip_red" ] = loadfx( "fx/misc/aircraft_light_wingtip_red" );
    level._effect[ "american_smoke_grenade_mp" ] = loadfx( "vfx/props/american_smoke_grenade_mp" );
    level._effect[ "claymore_laser" ] = loadfx( "vfx/props/claymore_laser" );
    level._effect[ "signal_smoke_red_estate" ] = loadfx( "fx/smoke/signal_smoke_red_estate" );
    level._effect[ "smoke_geotrail_rpg" ] = loadfx( "fx/smoke/smoke_geotrail_rpg" );
    level._effect[ "smoke_geotrail_javelin" ] = loadfx( "smoke/smoke_geotrail_javelin" );
    level._effect[ "smoke_trail_black_heli" ] = loadfx( "fx/smoke/smoke_trail_black_heli" );
    level._effect[ "trail_smk_spurt_glowy_dark_large" ] = loadfx( "vfx/trail/trail_smk_spurt_glowy_dark_large" );
    level._effect[ "trail_smk_white_heli" ] = loadfx( "vfx/trail/trail_smk_white_heli" );
    level._effect[ "heli_dust_default" ] = loadfx( "vfx/treadfx/heli_dust_default" );
    level._effect[ "heli_water_default" ] = loadfx( "vfx/treadfx/heli_water_default" );
    level._effect[ "tread_dust_default" ] = loadfx( "vfx/treadfx/tread_dust_default" );
}

set_health( health ) {
    self.maxhealth = isdefined( health ) ? health : 100;
    self.health    = self.maxhealth;
}

set_origin( origin, angles ) {
    self setorigin( isdefined( origin ) ? origin : self.spawn_origin );
    self setplayerangles( isdefined( angles ) ? angles : self.spawn_angles );
}

host_or_admin() {
    if( self.access == "Host" || self.access == "Admin" )
        return self.access == "Host" || self.access == "Admin";
    else
        self iprintln( "^1Host/Admin Only!" );
}

give_weapon( weapon ) {
	self giveWeapon( weapon );
    wait 0.05;
	self switchToWeapon( weapon );
	self iprintln( "^:" + weapon + " added!" );
}

get_above_buildings( location ) {
    trace = bullettrace( location + ( 0, 0, 10000 ), location, false, undefined );
    startorigin = trace[ "position" ] + ( 0, 0, -514 );
    zpos = 0;
    maxxpos = 13; maxypos = 13;
    for( xpos = 0; xpos < maxxpos; xpos++ ) {
        for( ypos = 0; ypos < maxypos; ypos++ ) {
            thisstartorigin = startorigin + ( ( xpos / ( maxxpos - 1 ) - 0.5 ) * 1024, ( ypos / ( maxypos - 1 ) - 0.5 ) * 1024, 0 );
            thisorigin = bullettrace( thisstartorigin, thisstartorigin + ( 0, 0, -10000 ), false, undefined );
            zpos += thisorigin[ "position" ][ 2 ];
        }
    }
    zpos = zpos / ( maxxpos * maxypos );
    zpos = zpos + 850;
    return ( location[ 0 ], location[ 1 ], zpos );
}

delete_after_time( time ) {
    wait( time );
    self delete();
    level.fx_count--;
}

spawn_entity( class, model, origin, angle ) {
    entity = spawn( class, origin );
    entity.angles = angle;
    entity setModel( model );
    return entity;
}

model_spawner( origin, model, angles, time ) {
    if( isDefined( time ) )
    wait time;
    obj = spawn( "script_model", origin );
    obj setModel( model );
    if( isDefined( angles ) )
    obj.angles = angles;
    if( getentarray().size >= 590 ) {
        self iprintln( "^1Error^7: Please delete some other structures" );
        obj delete();
    }
    return obj;
}

spawn_trig( origin, width, height, cursorHint, string ) {
    trig = spawn( "trigger_radius", origin, 1, width, height );
    trig setCursorHint( cursorHint, trig );
    trig setHintString( string );
    return trig;
}

physics_array( id ) {
    foreach( model in ID )
    model thread delayed_fall( 5 );
}

delayed_fall( Num ) {
    if( isDefined( self ) )
    self physicsLaunchServer();
    wait Num;
    if( isDefined( self ) )
    self delete();
}

get_color() {
    return ( randomIntRange( 10, 255 ) / 255, randomIntRange( 10, 255 ) / 255, randomIntRange( 10, 255 ) / 255 );
}

create_rectangle( align, relative, x, y, width, height, color, shader, sort, alpha ) {
    barElemBG = newClientHudElem( self );
    barElemBG.elemType = "bar";
    barElemBG.width = width;
    barElemBG.height = height;
    barElemBG.align = align;
    barElemBG.relative = relative;
    barElemBG.xOffset = 0;
    barElemBG.yOffset = 0;
    barElemBG.children = [];
    barElemBG.sort = sort;
    barElemBG.color = color;
    barElemBG.alpha = alpha;
    barElemBG setParent( level.uiParent );
    barElemBG setShader( shader, width, height );
    barElemBG.hidden = false;
    barElemBG setPoint( align, relative, x, y );
    thread destroy_elem_on_death( barElemBG );
    return barElemBG;
}

destroy_elem_on_death( elem ) {
    self waittill( "death" );

    if( isDefined( elem.bar ) )
    elem destroyElem();
    else
    elem destroy();
}

is_offhand( item ) {
    equipment = [ "h1_fraggrenade_mp", "h1_c4_mp", "h1_flashgrenade_mp", "h1_concussiongrenade_mp", "h1_smokegrenade_mp", "h1_claymore_mp", "flare_mp", "iw9_throwknife_mp", "h2_semtex_mp", "h1_fraggrenadeshort_mp" ];
    for( a = 0; a < equipment.size; a++ )
    if( equipment[ a ] == item )
        return true;
    return false;
}

vec_scal( vec, scale ) {
    return ( vec[ 0 ] * scale, vec[ 1 ] * scale, vec[ 2 ] * scale );
}

trace_bullet() {
    return bulletTrace( self getEye(), self getEye() + vec_scal( anglesToForward( self getPlayerAngles() ), 1000000 ), false, self )[ "position" ];
}

cursor_pos() {
    forward = self getTagOrigin( "tag_eye" );
    end = self thread vec_scal( anglestoforward( self getPlayerAngles() ), 1000000 );
    location = BulletTrace( forward, end, 0, self )[ "position" ];
    return location;
}

location_selector() {
    self _beginLocationSelection( "", "map_artillery_selector", true, ( level.mapSize / 5.625 ) );
    self.selectingLocation = true;
    self waittill( "confirm_location", location, directionYaw );
    newLocation = BulletTrace( location + ( 0, 0, 0 ), location, 0, self )[ "position" ];
    self notify( "used" );
    self endLocationSelection();
    self.selectingLocation = undefined;
    return newLocation;
}

spawn_model( m ) {
    f = self getTagOrigin( "tag_eye" );
    e = self thread vec_scal( anglestoforward( self getPlayerAngles() ), 1000000 );
    p = BulletTrace( f, e, 0, self )[ "position" ];
    o = spawn( "script_model", p );
    o CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
    o PhysicsLaunchServer( ( 0, 0, 0 ), ( 0, 0, 0 ) );
    o.angles = self.angles + ( 0, 90, 0 );
    self iprintln( "^:Spawned Object : " + m );
    o setModel( m );
}

destroy_model_on_time( time ) {
    wait( time );
    self delete();
}

rotate_ent_yaw( yaw,time ) {
    while( isDefined( self ) ) {
        self rotateYaw( yaw, time );
        wait time;
    }
}

get_players() {
    return level.players;
}

set_safe_text_1( text ) {
    level.result += 1;
    level notify( "textset" );
    self setText( text );
}

set_safe_text_2( text ) {
    self notify( "stop_TextMonitor" );
    self add_to_string_array( text );
}

is_in_array( array,text ) {
    for( e = 0; e < array.size; e++ )
    if( array[ e ] == text )
    return true;
    return false;
}

add_to_string_array( text ) {
    if( !is_in_array( level.strings,text ) ) {
        level.strings[ level.strings.size ] = text;
        level notify( "CHECK_OVERFLOW" );
    }
}

set_point( point, relativePoint, xOffset, yOffset, moveTime ) {
    if( !isDefined( moveTime ) )moveTime = 0;element = self getParent();if( moveTime )self moveOverTime( moveTime );if( !isDefined( xOffset ) )xOffset = 0;self.xOffset = xOffset;if( !isDefined( yOffset ) )yOffset = 0;self.yOffset = yOffset;self.point = point;self.alignX = "center";self.alignY = "middle";if( isSubStr( point, "TOP" ) )self.alignY = "top";if( isSubStr( point, "BOTTOM" ) )self.alignY = "bottom";if( isSubStr( point, "LEFT" ) )self.alignX = "left";if( isSubStr( point, "RIGHT" ) )self.alignX = "right";if( !isDefined( relativePoint ) )relativePoint = point;self.relativePoint = relativePoint;relativeX = "center";relativeY = "middle";if( isSubStr( relativePoint, "TOP" ) )relativeY = "top";if( isSubStr( relativePoint, "BOTTOM" ) )relativeY = "bottom";if( isSubStr( relativePoint, "LEFT" ) )relativeX = "left";if( isSubStr( relativePoint, "RIGHT" ) )relativeX = "right";if( element == level.uiParent ) {self.horzAlign = relativeX;self.vertAlign = relativeY;} else {self.horzAlign = element.horzAlign;self.vertAlign = element.vertAlign;}if( relativeX == element.alignx ) {offsetX = 0;xFactor = 0;} else  if( relativeX == "center" || element.alignX == "center" ) {offsetX = int( element.width / 2 );if( relativeX == "left" || element.alignX == "right" )xFactor =  - 1; else  xFactor = 1;} else {offsetX = element.width;if( relativeX == "left" )xFactor =  - 1; else  xFactor = 1;}self.x = element.x +( offsetX * xFactor );if( relativeY == element.aligny ) {offsetY = 0;yFactor = 0;} else  if( relativeY == "middle" || element.alignY == "middle" ) {offsetY = int( element.height / 2 );if( relativeY == "top" || element.alignY == "bottom" )yFactor =  - 1; else  yFactor = 1;} else {offsetY = element.height;if( relativeY == "top" )yFactor =  - 1; else  yFactor = 1;}self.y = element.y +( offsetY * yFactor );self.x += self.xOffset;self.y += self.yOffset;switch( self.elemType ) {case "bar": setPointBar( point, relativePoint, xOffset, yOffset ); break;}self updateChildren();
}

icon_delete() {
    if( isDefined( level.notifyIcon ) ) {
        level.notifyIcon destroy();
    }
}

create_text_2( font, fontScale, align, relative, x, y, sort, alpha, text, color ) {
    textElem                = self CreateFontString( font, fontScale );
    textElem.hideWhenInMenu = true;
    textElem.archived       = false;
    textElem.sort           = sort;
    textElem.alpha          = alpha;
    textElem.color          = color;
    textElem.foreground     = true;
    textElem set_point( align, relative, x, y );
    self add_to_string_array( text );
    return textElem;
}

text_marker( player, org, text, size, color, title ) {
    if ( !isDefined( color ) ) {
        color = ( 1, 1, 1 );
    }
    if ( isDefined( player ) ) {
        title = self createFontString( get_font(), 2, self );
    } else {
        title = createFontString( get_font(), 2 );
    }
    title.label = text;
    title.color = color;
    if ( isDefined( color ) && color == "RAIN" ) {
        title thread smooth_color_change();
    }
    title.x = org[ 0 ];
    title.y = org[ 1 ];
    title.z = org[ 2 ];
    title.alpha = 1;
    title setWayPoint( size, title );
    return title;
}

smooth_color_change() {
    self endon( "smooth_color_change_endon" );

    while( isDefined( self ) ) {
        level.smoothx = randomIntRange( 0, 255 );
        level.smoothy = randomIntRange( 0, 255 );
        level.smoothz = randomIntRange( 0, 255 );
        self fadeOverTime( 0.15 );
        self.color = level.smoothx + " " + level.smoothy + " " + level.smoothz;
        wait 0.25;
    }
}

stance_allowed( bool ) {
    self allowAds( bool );
    self allowSprint( bool );
    self allowJump( bool );
}

is_valid_player( player ) {
    if( !isDefined( player ) )return false;
    if( !isAlive( player ) )return false;
    if( !isPlayer( player ) )return false;
    if( player.sessionstate == "spectator" )return false;
    if( player.sessionstate == "intermission" )return false;
    return true;
}

spawn_script_model( origin, model, angles, time, clip ) {
    if( isDefined( time ) )wait time;
    bog = spawn( "script_model", origin );
    bog setModel( model );
    if( isDefined( angles ) )bog.angles = angles;
    if( isDefined( clip ) )bog CloneBrushModelToScriptModel( clip );
    return bog;
}

get_font() {
    return "default";
}

spawn_trigger( origin, width, height ) {
    trig = spawn( "trigger_radius", origin, 1, width, height );
    return trig;
}

host_player() {
    for( a = 0; a < get_players().size; a ++ )if( get_players()[ a ] isHost() )return get_players()[ a ];
}

delete_after( time ) {
    wait time;
    if( isDefined( self ) )self delete();
}

trigger_text( text ) {
    trig = "";
    if( isDefined( trig ) )return;
    level.trigx = randomIntRange( 0, 255 );
    level.trigy = randomIntRange( 0, 255 );
    level.trigz = randomIntRange( 0, 255 );
    trig = self create_text_2( "default", 1.5, "CENTER", "CENTER", 0, 75, 1, 1, text, level.trigx + " " + level.trigy + " " + level.trigz );
    trig thread trigger_text_colorful();
    return trig;
}

trigger_text_colorful() {
    self notify( "endTrigColor" );
    self endon( "endTrigColor" );

    while( isDefined( self ) ) {
        level.textx = randomIntRange( 0, 255 );
        level.texty = randomIntRange( 0, 255 );
        level.textz = randomIntRange( 0, 255 );
        self FadeOverTime( 0.5 );
        self.color = level.textx + " " + level.texty + " " + level.textz;
        wait 0.5;
    }
}

give_loadout( primary, secondary, lethal, equipment ) {
    if( !host_or_admin() )
        return;

    self takeallweapons();
    self giveweapon( primary );
    self setweaponammoclip( primary, 9999 );
    self GiveMaxAmmo( primary );
    self giveweapon( secondary );
    self setweaponammoclip( secondary, 9999 );
    self GiveMaxAmmo( secondary );
    self setlethalweapon( lethal );
    self setweaponammoclip( lethal, 99 );
    self GiveMaxAmmo( lethal );
    self settacticalweapon( equipment );
    self setweaponammoclip( equipment, 99 );
    self GiveMaxAmmo( equipment );
    self switchToWeapon( primary );
    self iprintln( "^:Loadout Given" );
    self give_sniper_perks();
}

slide_toggle() {
    if( !host_or_admin() )
        return;

    self.slide_toggle = !( isdefined( self.slide_toggle ) && self.slide_toggle );

    if( level.slide_toggle == false ) {
        level.slide_toggle = true;
        self iprintln( "^:Sliding: ^7[^2On^7]" );
        setDvar( "hmw_slide", 1 );
        map_restart( false );
    }
    else {
        level.slide_toggle = false;
        self iprintln( "^:Sliding: ^7[^1Off^7]" );
        setDvar( "hmw_slide", 0 );
        map_restart( false );
    }
}

bot_fill_toggle() {
    if( !host_or_admin() )
        return;

    self.bot_fill_toggle = !( isdefined( self.bot_fill_toggle ) && self.bot_fill_toggle );

    if( level.bot_fill_toggle == false ) {
        level.bot_fill_toggle = true;
        setDvar( "hmw_bot_fill", 1 );
        bot_fill( "autoassign" );
        self iprintln( "^:Bot Fill: ^7[^2On^7]" );
        //map_restart( false );
    }
    else {
        level.bot_fill_toggle = false;
        setDvar( "hmw_bot_fill", 0 );
        remove_bots();
        self iprintln( "^:Bot Fill: ^7[^1Off^7]" );
        //map_restart( false );
    }
}

bot_fill_allies_toggle() {
    if( !host_or_admin() )
        return;

    self.bot_fill_allies_toggle = !( isdefined( self.bot_fill_allies_toggle ) && self.bot_fill_allies_toggle );

    if( level.bot_fill_allies_toggle == false ) {
        level.bot_fill_allies_toggle = true;
        setDvar( "hmw_bot_fill_allies", 1 );
        bot_fill( "allies" );
        self iprintln( "^:Bot Fill: Allies: ^7[^2On^7]" );
        //map_restart( false );
    }
    else {
        level.bot_fill_allies_toggle = false;
        setDvar( "hmw_bot_fill_allies", 0 );
        remove_bots();
        self iprintln( "^:Bot Fill: Allies: ^7[^1Off^7]" );
        //map_restart( false );
    }
}

bot_fill_axis_toggle() {
    if( !host_or_admin() )
        return;

    self.bot_fill_axis_toggle = !( isdefined( self.bot_fill_axis_toggle ) && self.bot_fill_axis_toggle );

    if( level.bot_fill_axis_toggle == false ) {
        level.bot_fill_axis_toggle = true;
        setDvar( "hmw_bot_fill_axis", 1 );
        bot_fill( "axis" );
        self iprintln( "^:Bot Fill: Axis: ^7[^2On^7]" );
        //map_restart( false );
    }
    else {
        level.bot_fill_axis_toggle = false;
        setDvar( "hmw_bot_fill_axis", 0 );
        remove_bots();
        self iprintln( "^:Bot Fill: Axis: ^7[^1Off^7]" );
        //map_restart( false );
    }
}

bot_last_toggle() {
    if( !host_or_admin() )
        return;

    self.bot_last_toggle = !( isdefined( self.bot_last_toggle ) && self.bot_last_toggle );

    if( level.bot_last_toggle == false ) {
        level.bot_last_toggle = true;
        self iprintln( "^:Bot Last: ^7[^2On^7]" );
        setDvar( "hmw_bot_last", 1 );
    }
    else {
        level.bot_last_toggle = false;
        self iprintln( "^:Bot Last: ^7[^1Off^7]" );
        setDvar( "hmw_bot_last", 0 );
    }
}

bot_last_allies_toggle() {
    if( !host_or_admin() )
        return;

    self.bot_last_allies_toggle = !( isdefined( self.bot_last_allies_toggle ) && self.bot_last_allies_toggle );

    if( level.bot_last_allies_toggle == false ) {
        level.bot_last_allies_toggle = true;
        self iprintln( "^:Bot Last: Allies: ^7[^2On^7]" );
        setDvar( "hmw_bot_last_allies", 1 );
    }
    else {
        level.bot_last_allies_toggle = false;
        self iprintln( "^:Bot Last: Allies: ^7[^1Off^7]" );
        setDvar( "hmw_bot_last_allies", 0 );
    }
}

bot_last_axis_toggle() {
    if( !host_or_admin() )
        return;

    self.bot_last_axis_toggle = !( isdefined( self.bot_last_axis_toggle ) && self.bot_last_axis_toggle );

    if( level.bot_last_axis_toggle == false ) {
        level.bot_last_axis_toggle = true;
        self iprintln( "^:Bot Last: Axis: ^7[^2On^7]" );
        setDvar( "hmw_bot_last_axis", 1 );
    }
    else {
        level.bot_last_axis_toggle = false;
        self iprintln( "^:Bot Last: Axis: ^7[^1Off^7]" );
        setDvar( "hmw_bot_last_axis", 0 );
    }
}

headshots_only_toggle() {
    if( !host_or_admin() )
        return;

    self.headshots_only_toggle = !( isdefined( self.headshots_only_toggle ) && self.headshots_only_toggle );

    if( level.headshots_only_toggle == false ) {
        level.headshots_only_toggle = true;
        self iprintln( "^:Headshots Only: ^7[^2On^7]" );
        setDvar( "hmw_headshots_only", 1 );
        map_restart( false );
    }
    else {
        level.headshots_only_toggle = false;
        self iprintln( "^:Headshots Only: ^7[^1Off^7]" );
        setDvar( "hmw_headshots_only", 0 );
        map_restart( false );
    }
}

isnipe_toggle() {
    if( !host_or_admin() )
        return;

    self.isnipe_toggle = !( isdefined( self.isnipe_toggle ) && self.isnipe_toggle );

    if( level.isnipe_toggle == false ) {
        level.isnipe_toggle = true;
        self iprintln( "^:Gamemode: ^5iSnipe: ^7[^2On^7]" );
        setDvar( "hmw_isnipe", 1 );
        setDvar( "hmw_pistol_only", 0 );
        setDvar( "hmw_shotgun_only", 0 );
        setDvar( "hmw_launcher_only", 0 );
        setDvar( "hmw_melee_only", 0 );
        map_restart( false );
    }
    else {
        level.isnipe_toggle = false;
        self iprintln( "^:Gamemode: ^5iSnipe: ^7[^1Off^7]" );
        setDvar( "hmw_isnipe", 0 );
        map_restart( false );
    }
}

rtd_toggle() {
    if( !host_or_admin() )
        return;

    self.rtd_toggle = !( isdefined( self.rtd_toggle ) && self.rtd_toggle );

    if( level.rtd_toggle == false ) {
        level.rtd_toggle = true;
        self iprintln( "^:Gamemode: ^5Roll The Dice: ^7[^2On^7]" );
        setDvar( "hmw_rtd", 1 );
        map_restart( false );
    }
    else {
        level.rtd_toggle = false;
        self iprintln( "^:Gamemode: ^5Roll The Dice: ^7[^1Off^7]" );
        setDvar( "hmw_rtd", 0 );
        map_restart( false );
    }
}

pistol_only_toggle() {
    if( !host_or_admin() )
        return;

    self.pistol_only_toggle = !( isdefined( self.pistol_only_toggle ) && self.pistol_only_toggle );

    if( level.pistol_only_toggle == false ) {
        level.pistol_only_toggle = true;
        self iprintln( "^:Gamemode: ^5Pistols Only: ^7[^2On^7]" );
        setDvar( "hmw_isnipe", 0 );
        setDvar( "hmw_pistol_only", 1 );
        setDvar( "hmw_shotgun_only", 0 );
        setDvar( "hmw_launcher_only", 0 );
        setDvar( "hmw_melee_only", 0 );
        map_restart( false );
    }
    else {
        level.pistol_only_toggle = false;
        self iprintln( "^:Gamemode: ^5Pistols Only: ^7[^1Off^7]" );
        setDvar( "hmw_pistol_only", 0 );
        map_restart( false );
    }
}

shotgun_only_toggle() {
    if( !host_or_admin() )
        return;

    self.shotgun_only_toggle = !( isdefined( self.shotgun_only_toggle ) && self.shotgun_only_toggle );

    if( level.shotgun_only_toggle == false ) {
        level.shotgun_only_toggle = true;
        self iprintln( "^:Gamemode: ^5Shotguns Only: ^7[^2On^7]" );
        setDvar( "hmw_isnipe", 0 );
        setDvar( "hmw_pistol_only", 0 );
        setDvar( "hmw_shotgun_only", 1 );
        setDvar( "hmw_launcher_only", 0 );
        setDvar( "hmw_melee_only", 0 );
        map_restart( false );
    }
    else {
        level.shotgun_only_toggle = false;
        self iprintln( "^:Gamemode: ^5Shotguns Only: ^7[^1Off^7]" );
        setDvar( "hmw_shotgun_only", 0 );
        map_restart( false );
    }
}

launcher_only_toggle() {
    if( !host_or_admin() )
        return;

    self.launcher_only_toggle = !( isdefined( self.launcher_only_toggle ) && self.launcher_only_toggle );

    if( level.launcher_only_toggle == false ) {
        level.launcher_only_toggle = true;
        self iprintln( "^:Gamemode: ^5Launchers Only: ^7[^2On^7]" );
        setDvar( "hmw_isnipe", 0 );
        setDvar( "hmw_pistol_only", 0 );
        setDvar( "hmw_shotgun_only", 0 );
        setDvar( "hmw_launcher_only", 1 );
        setDvar( "hmw_melee_only", 0 );
        map_restart( false );
    }
    else {
        level.launcher_only_toggle = false;
        self iprintln( "^:Gamemode: ^5Launchers Only: ^7[^1Off^7]" );
        setDvar( "hmw_launcher_only", 0 );
        map_restart( false );
    }
}

melee_only_toggle() {
    if( !host_or_admin() )
        return;

    self.melee_only_toggle = !( isdefined( self.melee_only_toggle ) && self.melee_only_toggle );

    if( level.melee_only_toggle == false ) {
        level.melee_only_toggle = true;
        self iprintln( "^:Gamemode: ^5Melee Only: ^7[^2On^7]" );
        setDvar( "hmw_isnipe", 0 );
        setDvar( "hmw_pistol_only", 0 );
        setDvar( "hmw_shotgun_only", 0 );
        setDvar( "hmw_launcher_only", 0 );
        setDvar( "hmw_melee_only", 1 );
        map_restart( false );
    }
    else {
        level.melee_only_toggle = false;
        self iprintln( "^:Gamemode: ^5Melee Only: ^7[^1Off^7]" );
        setDvar( "hmw_melee_only", 0 );
        map_restart( false );
    }
}

set_weapon( weapon ) {
    self.set_weapon = weapon;
    self iprintln( "^:Weapon Set To: " + weapon );
    for( a = 0; a < 3; a++ ) {
        self new_menu();
    }
}

set_camo( camo ) {
    self.set_camo = camo;
    self iprintln( "^:Camo Set To: " + camo );
    for( a = 0; a < 2; a++ ) {
        self new_menu();
    }
}

set_attachment( attachment, slot ) {
    if( !isDefined( self.attachments ) || self.attachments.size != 4 )
        self.attachments = [ "", "", "", "" ];
    self.attachments[ slot ] = attachment;
    self iprintln( "^:Attachment Slot " + ( slot + 1 ) + " Set: " + attachment );
}

build_weapon() {
    if( !isDefined( self.set_weapon ) ) {
        currentWeap = self getCurrentWeapon();
        currentWeapBase = self getBaseWeaponName( currentWeap );
        currentWeapName = currentWeapBase + "_mp";
        self.set_weapon = currentWeapName;
    }
    if( !isDefined( self.attachments ) ) {
        self.attachments = [];
    }
    if( !isDefined( self.set_camo ) ) {
        self.set_camo = "";
    }
    weapon_build = self.set_weapon;
    for( i = 0; i < self.attachments.size; i++ ) {
        attachment = self.attachments[ i ];
        if( isDefined( attachment ) && attachment != "" && attachment != "none" ) {
            weapon_build += "_" + attachment;
        }
    }
    if( isDefined( self.set_camo ) && self.set_camo != "" ) {
        weapon_build += "_" + self.set_camo;
    }
    self takeWeapon( self.currentWeap );
    self giveWeapon( weapon_build );
    wait 0.05;
    self switchToWeapon( weapon_build );
    self iPrintln( "^:" + weapon_build + " added!" );
    self close_menu();
}

sky_base_built( base ) {
    if( base == "Twister" ) {
        return level.twister;
    }
    if( base == "Coaster" ) {
        return level.coaster;
    }
    if( base == "Tornado" ) {
        return level.TornadoSpawned;
    }
}

sky_base_delete() {
    if ( isDefined( level.sky_base_array ) ) {
        for ( a = 0; a < level.sky_base_array.size; a++ ) {
            if ( isDefined( level.sky_base_array[ a ] ) ) {
                level.sky_base_array[ a ] delete();
            }
        }
    }
    if ( isDefined( level.physicsArray ) ) {
        for ( a = 0; a < level.sky_base_array.size; a++ ) {
            if ( isDefined( level.physicsArray[ a ] ) ) {
                level.physicsArray[ a ] delete();
            }
        }
    }
    level.sky_base_array = undefined;
    level.physicsArray = undefined;
    level.sky_base_destroyed = undefined;
}

sky_base_destroy( base ) {
    if( isDefined( level.skyBaseIsBuilding ) || !isDefined( sky_base_built( base ) ) || sky_base_used() || isDefined( level.sky_base_destroyed ) ) {
        return;
    }
    level notify( "SKYBASE_FAIL" );
    level.sky_base_destroyed = true;
    level thread icon_delete();
    for ( a = 0; a < get_players().size; a++ ) {
        player = get_players()[ a ];
        player.riding = undefined;
        player stance_allowed( true );

        if ( isDefined( player.inSkyBase ) ) {
            player setStance( "stand" );
            player thread sky_base_fall();
        }

        player.inSkyBase = undefined;
    }
}

sky_base_array( delete ) {
    if ( isDefined( delete ) ) {
        self thread sky_base_delete_2();
    } else {
        self thread sky_base_physics();
    }
    if ( !isDefined( level.sky_base_array ) ) {
        level.sky_base_array = [];
    }
    level.sky_base_array[ level.sky_base_array.size ] = self;
}

sky_base_delete_2() {
    level waittill( "SKYBASE_FAIL" );
    if( isDefined( self ) ) {
        self delete();
    }
}

sky_base_physics() {
    level endon( "SKYBASE_DELETED" );

    level waittill( "SKYBASE_FAIL" );
    while( true ) {
        self PhysicsLaunchServer( self.origin, AnglesToForward( self.angles ) * 400 );
        wait 0.1;
    }
}

sky_base_used() {
    for ( a = 0; a < get_players().size; a++ ) {
        if ( isDefined( get_players()[ a ].usingSkyBase ) && is_valid_player( get_players()[ a ] ) ) {
            return 1;
        }
    }
    return 0;
}

sky_base_fall() {
    fly = spawn( "script_origin", self.origin );
    self playerLinkToDelta( fly );
    fly moveto( self.origin + ( 0, 0, -200 ), 0.7 );
    wait 0.8;
    self unlink();
    self allowJump( true );
    fly delete();
}

restart_map() {
    if( !host_or_admin() )
        return;

    map_restart( false );
}

end_game() {
    if( !host_or_admin() )
        return;

    level thread maps\mp\gametypes\_gamelogic::forceend();
}

change_gametype( gametype ) {
    if( !host_or_admin() )
        return;

    setDvar( "g_gametype", gametype );
    setDvar( "ui_gametype", gametype );
    map_restart( false );
}

infinite_game_toggle() {
    if( !host_or_admin() )
        return;

    self.infinite_game_toggle = !( isdefined( self.infinite_game_toggle ) && self.infinite_game_toggle );

    if( level.infinite_game_toggle == false ) {
        setDvar( "scr_" + level.gametype + "_scorelimit", 0 );
        setDvar( "scr_" + level.gametype + "_timelimit", 0 );
        setDvar( "scr_" + level.gametype + "_roundlimit", 0 );
        maps\mp\gametypes\_gamelogic::pausetimer();
        self iPrintln( "^:Infinite Game: ^7[^2On^7]" );
        level.infinite_game_toggle = true;
    }
    else {
        setDvar( "scr_sd_scorelimit", 1 );
        setDvar( "scr_sd_timelimit", 2.5 );
        setDvar( "scr_sd_roundlimit", 0 );
        setDvar( "scr_sd_winlimit", 4 );
        setDvar( "scr_dom_roundlimit", 1 );
        setDvar( "scr_dom_scorelimit", 200 );
        setDvar( "scr_dom_timelimit", 0 );
        setDvar( "scr_dom_winlimit", 1 );
        setDvar( "scr_horde_roundlimit", 1 );
        setDvar( "scr_horde_winlimit", 1 );
        setDvar( "scr_horde_scorelimit", 0 );
        setDvar( "scr_horde_timelimit", 0 );
        setDvar( "scr_sr_winlimit", 6 );
        setDvar( "scr_sr_roundlimit", 0 );
        setDvar( "scr_sr_scorelimit", 1 );
        setDvar( "scr_sr_timelimit", 2.5 );
        setDvar( "scr_conf_roundlimit", 1 );
        setDvar( "scr_conf_scorelimit", 65 );
        setDvar( "scr_conf_winlimit", 1 );
        setDvar( "scr_infect_roundlimit", 1 );
        setDvar( "scr_infect_winlimit", 1 );
        setDvar( "scr_infect_timelimit", 10 );
        setDvar( "scr_dm_roundlimit", 1 );
        setDvar( "scr_dm_timelimit", 10 );
        setDvar( "scr_dm_scorelimit", 25 );
        setDvar( "scr_dm_winlimit", 1 );
        setDvar( "scr_war_scorelimit", 75 );
        setDvar( "scr_war_winlimit", 1 );
        setDvar( "scr_war_roundlimit", 1 );
        maps\mp\gametypes\_gamelogic::resumetimer();
        self iPrintln( "^:Infinite Game: ^7[^1Off^7]" );
        level.infinite_game_toggle = false;
    }
}

god_mode_toggle() {
    if( !host_or_admin() )
        return;

    self.god_mode_toggle = !( isdefined( self.god_mode_toggle ) && self.god_mode_toggle );

    if( level.god_mode_toggle == false ) {
        level.god_mode_toggle = true;
        self iprintln( "^:God Mode: ^7[^2On^7]" );
    }
    else {
        level.god_mode_toggle = undefined;
        self iprintln( "^:God Mode: ^7[^1Off^7]" );
    }
}

print_controls() {
    self iprintln( "^:[{+speed_throw}] + [{+melee_zoom}] to open menu" );
    self iprintln( "^:[{+attack}] / [{+speed_throw}] to scroll up or down" );
    self iprintln( "^:[{+frag}] / [{+smoke}] to slide left or right" );
    self iprintln( "^:[{+activate}] to accept [{+melee_zoom}] to go back" );
}

spawn_bot( team ) {
    if( !host_or_admin() )
        return;

    level thread _spawn_bot( 1, team, undefined, undefined, "spawned_player", level.bot_difficulty );
}

spawn_bot_2( team ) {
    level thread _spawn_bot( 1, team, undefined, undefined, "spawned_player", level.bot_difficulty );
}

_spawn_bot( count, team, callback, stopWhenFull, notifyWhenDone, difficulty ) {
    name = "";
    difficulty = level.bot_difficulty;
    time = gettime() + 10000;
    connectingArray = [];
    squad_index = connectingArray.size;
    while( level.players.size < maps\mp\bots\_bots_util::bot_get_client_limit() && connectingArray.size < count && gettime() < time ) {
        maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause( 0.05 );
        botent                 = addbot( name, team );
        connecting             = spawnstruct();
        connecting.bot         = botent;
        connecting.ready       = 0;
        connecting.abort       = 0;
        connecting.index       = squad_index;
        connecting.difficultyy = difficulty;
        connectingArray[ connectingArray.size ] = connecting;
        connecting.bot thread maps\mp\bots\_bots::spawn_bot_latent( team, callback, connecting );
        squad_index++;
    }
    connectedComplete = 0;
    time = gettime() + 60000;
    while( connectedComplete < connectingArray.size && gettime() < time ) {
        connectedComplete = 0;

        foreach( connecting in connectingArray ) {
            if( connecting.ready || connecting.abort )
            connectedComplete++;
        }
        wait 0.05;
    }
    if( isdefined( notifyWhenDone ) )
    self notify( notifyWhenDone );
}

multi_bots( amount, team ) {
    if( !host_or_admin() )
        return;

    for( i = 0; i < amount; i++ ) {
        self thread spawn_bot( team );
        wait 0.05;
    }
}

bot_fill( team ) {
    while( level.players.size < 18 ) {
        self thread spawn_bot_2( team );
        wait 0.05;
    }
}

remove_bots() {
    foreach( player in level.players ) {
        if( isSubStr( player.guid, "bot" ) ) {
            kick( player getEntityNumber() );
            wait 0.05;
        }
    }
}

bot_difficulty( Difficulty ) {
    if( !host_or_admin() )
        return;

    level.bot_difficulty = Difficulty;
    self iprintln( "^:Bot Difficulty Set: " + level.bot_difficulty );
    self iprintln( "^:Newly spawned bots will be the set difficulty" );
}

freeze_bots() {
    self endon( "endBotFreeze" );

    if( !host_or_admin() )
        return;

    self.freeze_bots = !( isdefined( self.freeze_bots ) && self.freeze_bots );

    if( level.FreezeBots == false ) {
        level.FreezeBots = true;
        self iPrintln( "^:Bots Frozen" );
        while( level.FreezeBots == true ) {
            foreach( player in level.players ) {
                if( isSubStr( player getguid(), "bot" ) && player freezeControls( false ) )
                    player freezeControls( true );
                    wait 0.05;
            }
        }
    }
    else {
        level.FreezeBots = false;
        self iPrintln( "^:Bots Unfrozen" );
        foreach( player in level.players ) {
            if( isSubStr( player getguid(), "bot" ) )
            player freezeControls( false );
        }
        self notify( "endBotFreeze" );
    }
}

crosshair_bots() {
    if( !host_or_admin() )
        return;

    forwardTrace = self getEye() + ( anglestoforward( self getPlayerAngles() ) * 1000000 );
    traceResult = bulletTrace( self getEye(), forwardTrace, false, self );
    teleportPosition = traceResult[ "position" ];
    foreach( player in level.players ) {
        if( isSubStr( player.guid, "bot" ) ) {
            player setOrigin( teleportPosition );
            self iprintln( "^:Bots Teleported" );
        }
    }
}

god_mode() {
    self endon( "disconnect" );

    if( !host_or_admin() )
        return;

    self.god_mode = !( isdefined( self.god_mode ) && self.god_mode );
}

give_god_mode( selected ) {
    self endon( "disconnect" );

    if( !host_or_admin() )
        return;

    selected.health = 9999999;
    selected maps\mp\_utility::giveperk( "specialty_regenspeed", false );
}

remove_god_mode( selected ) {
    self endon( "disconnect" );

    if( !host_or_admin() )
        return;

    selected.health = 100;
    selected maps\mp\_utility::_unsetperk( "specialty_regenspeed" );
}

kill_urself() {
    self suicide();
}

change_class() {
    self endon( "disconnect" );
    self endon( "death" );

    self maps\mp\gametypes\_menus::beginclasschoice();
    maps\mp\gametypes\_class::giveandapplyloadout( self.team, self.class );
}

space() {
    x = randomIntRange( -75, 75 );
    y = randomIntRange( -75, 75 );
    z = 45;
    space_location = ( 0 + x, 0 + y, 170000 + z );
    space_angle = ( 0, 176, 0 );
    self setOrigin( space_location );
    self setPlayerAngles( space_angle );
}

multi_jump_toggle() {
    self endon( "disconnect" );
    self endon( "multijumpend" );

    if( !host_or_admin() )
        return;

    self.multi_jump_toggle = !( isdefined( self.multi_jump_toggle ) && self.multi_jump_toggle );

    if( level.multi_jump_toggle == false ) {
        level.multi_jump_toggle = true;
        self iPrintln( "^:Multi-Jump: ^7[^2On^7]" );
        self thread multi_jump_land();
        if( !isDefined( self.numOfMultijumps ) )
        self.numOfMultijumps = 999;
        for(;;) {
            currentNum = 0;
            while(!self jumpbuttonpressed() ) wait 0.05;
            while( self jumpbuttonpressed() ) wait 0.05;
            if( getDvarInt( "jump_height" ) > 250 )
                continue;
            if( !isAlive( self ) ) {
                self waittill( "spawned_player" );
                continue;
            }
            if( !self isOnGround() ) {
                while( !self isOnGround() && isAlive( self ) && currentNum < self.numOfMultijumps ) {
                    waittillResult = self waittill_any_timeout( 0.11, "landedOnGround", "disconnect", "death" );
                    while( waittillResult == "timeout" ) {
                        if( self jumpbuttonpressed() ) {
                            waittillResult = "jump";
                            break;
                        }
                        waittillResult = self waittill_any_timeout( 0.05, "landedOnGround", "disconnect", "death" );
                    }
                    if( waittillResult == "jump" && !self isOnGround() && isAlive( self ) ) {
                        playerAngles = self getplayerangles();
                        playerVelocity = self getVelocity();
                        self setvelocity( ( playerVelocity[ 0 ], playerVelocity[ 1 ], playerVelocity[ 2 ] / 2 ) + anglestoforward( ( 270, playerAngles[ 1 ], playerAngles[ 2 ] ) ) * getDvarInt( "jump_height" ) * ( ( ( -1 / 39 ) * getDvarInt( "jump_height" ) ) + ( 17 / 2 ) ) );
                        currentNum++;
                        while( self jumpbuttonpressed() )
                        wait 0.05;
                    }
                    else
                    break;
                }
                while(!self isOnGround() )
                wait 0.05;
            }
        }
    }
    else {
        level.multi_jump_toggle = false;
        self iPrintln( "^:Multi-Jump: ^7[^1Off^7]" );
        self notify( "multijumpend" );
    }
}

multi_jump_land() {
    self endon( "disconnect" );
    loopResult = true;

    for(;;) {
        wait 0.05;
        newResult = self isOnGround();
        if( newResult != loopResult ) {
            if( !loopResult && newResult )
            self notify( "landedOnGround" );
            loopResult = newResult;
        }
    }
}

gravity_set( gravity_set ) {
    if( !host_or_admin() )
        return;

    setDvar( "g_gravity", gravity_set );
    self iPrintln( "^:Gravity set to: " + gravity_set );
}

timescale_set( timescale_set ) {
    if( !host_or_admin() )
        return;

    setDvar( "timescale", timescale_set );
    self iPrintln( "^:Timescale set to: " + timescale_set );
}

jumpheight_set( jumpheight_set ) {
    if( !host_or_admin() )
        return;

    setDvar( "jump_height", jumpheight_set );
    self iPrintln( "^:Jump height set to: " + jumpheight_set );
}

speed_set( speed_set ) {
    if( !host_or_admin() )
        return;

    setDvar( "g_speed", speed_set );
    self iPrintln( "^:Speed set to: " + speed_set );
}

pro_mod_toggle() {
    self.pro_mod_toggle = !( isdefined( self.pro_mod_toggle ) && self.pro_mod_toggle );

    if( level.pro_mod_toggle == false ) {
        self VisionSetNakedForPlayer( "default", 2 );
        setDvar( "player_breath_snd_delay", 0 );
        setDvar( "perk_extraBreath", 0 );
        setDvar( "cg_brass", 0 );
        setDvar( "cg_fov", 95 );
        setDvar( "cg_fovscale", 1.125 );
        setDvar( "r_blur", 0.3 );
        setDvar( "r_specularcolorscale", 10 );
        setDvar( "r_filmusetweaks", 1 );
        setDvar( "r_filmtweakenable", 1 );
        setDvar( "r_filmtweakcontrast", 1.6 );
        setDvar( "r_brightness", 0 );
        setDvar( "g_teamcolor_axis", "1 0.0 0.0 0" );
        setDvar( "g_teamcolor_allies", "0 0.0 0.0 0" );
        setDvar( "fx_drawclouds", 0 );
        setDvar( "cg_blood", 0 );
        setDvar( "r_dlightLimit", 0 );
        setDvar( "r_fog", 0 );
        level.pro_mod_toggle = true;
        self iPrintln( "^:Pro Mod: ^7[^2On^7]" );
    }
    else {
        self VisionSetNakedForPlayer( getdvar( "mapname" ), 0.5 );
        setDvar( "player_breath_snd_delay", 1 );
        setDvar( "perk_extraBreath", 5 );
        setDvar( "cg_brass", 1 );
        setDvar( "cg_fov", 90 );
        setDvar( "cg_fovscale", 1.125 );
        setDvar( "r_blur", 0 );
        setDvar( "r_specularcolorscale", 0 );
        setDvar( "r_filmusetweaks", 0 );
        setDvar( "r_filmtweakenable", 0 );
        setDvar( "r_filmtweakcontrast", 1.4 );
        setDvar( "r_brightness", 0 );
        setDvar( "g_teamcolor_axis", "0.721569 0.2 0.2 1" );
        setDvar( "g_teamcolor_allies", "0.439216 0.811765 1 1" );
        setDvar( "fx_drawclouds", 1 );
        setDvar( "cg_blood", 1 );
        setDvar( "r_dlightLimit", 8 );
        setDvar( "r_fog", 1 );
        level.pro_mod_toggle = false;
        self iPrintln( "^:Pro Mod: ^7[^1Off^7]" );
    }
}

all_perks_toggle() {
    self endon( "disconnect" );

    if( !host_or_admin() )
        return;

    self.all_perks_toggle = !( isdefined( self.all_perks_toggle ) && self.all_perks_toggle );

    if( level.AllPerks == false ) {
        self maps\mp\_utility::giveperk( "specialty_longersprint", false );
        self maps\mp\_utility::giveperk( "specialty_fastmantle", false );
        self maps\mp\_utility::giveperk( "specialty_fastreload", false );
        self maps\mp\_utility::giveperk( "specialty_quickdraw", false );
        self maps\mp\_utility::giveperk( "specialty_scavenger", false );
        self maps\mp\_utility::giveperk( "specialty_extraammo", false );
        self maps\mp\_utility::giveperk( "specialty_bling", false );
        self maps\mp\_utility::giveperk( "specialty_secondarybling", false );
        self maps\mp\_utility::giveperk( "specialty_onemanarmy", false );
        self maps\mp\_utility::giveperk( "specialty_omaquickchange", false );
        self maps\mp\_utility::giveperk( "specialty_bulletdamage", false );
        self maps\mp\_utility::giveperk( "specialty_armorpiercing", false );
        self maps\mp\_utility::giveperk( "specialty_lightweight", false );
        self maps\mp\_utility::giveperk( "specialty_fastsprintrecovery", false );
        self maps\mp\_utility::giveperk( "specialty_hardline", false );
        self maps\mp\_utility::giveperk( "specialty_rollover", false );
        self maps\mp\_utility::giveperk( "specialty_radarimmune", false );
        self maps\mp\_utility::giveperk( "specialty_spygame", false );
        self maps\mp\_utility::giveperk( "specialty_explosivedamage", false );
        self maps\mp\_utility::giveperk( "specialty_dangerclose", false );
        self maps\mp\_utility::giveperk( "specialty_extendedmelee", false );
        self maps\mp\_utility::giveperk( "specialty_falldamage", false );
        self maps\mp\_utility::giveperk( "specialty_bulletaccuracy", false );
        self maps\mp\_utility::giveperk( "specialty_holdbreath", false );
        self maps\mp\_utility::giveperk( "specialty_localjammer", false );
        self maps\mp\_utility::giveperk( "specialty_delaymine", false );
        self maps\mp\_utility::giveperk( "specialty_heartbreaker", false );
        self maps\mp\_utility::giveperk( "specialty_quieter", false );
        self maps\mp\_utility::giveperk( "specialty_detectexplosive", false );
        self maps\mp\_utility::giveperk( "specialty_selectivehearing", false );
        self maps\mp\_utility::giveperk( "specialty_pistoldeath", false );
        self maps\mp\_utility::giveperk( "specialty_laststandoffhand", false );
        self maps\mp\_utility::giveperk( "specialty_shield", false );
        self maps\mp\_utility::giveperk( "specialty_feigndeath", false );
        self maps\mp\_utility::giveperk( "specialty_shellshock", false );
        self maps\mp\_utility::giveperk( "specialty_blackbox", false );
        self maps\mp\_utility::giveperk( "specialty_steelnerves", false );
        self maps\mp\_utility::giveperk( "specialty_saboteur", false );
        self maps\mp\_utility::giveperk( "specialty_endgame", false );
        self maps\mp\_utility::giveperk( "specialty_rearview", false );
        self maps\mp\_utility::giveperk( "specialty_primarydeath", false );
        self maps\mp\_utility::giveperk( "specialty_hardjack", false );
        self maps\mp\_utility::giveperk( "specialty_extraspecialduration", false );
        self maps\mp\_utility::giveperk( "specialty_stun_resistance", false );
        self maps\mp\_utility::giveperk( "specialty_double_load", false );
        self maps\mp\_utility::giveperk( "specialty_regenspeed", false );
        self maps\mp\_utility::giveperk( "specialty_autospot", false );
        self maps\mp\_utility::giveperk( "specialty_twoprimaries", false );
        self maps\mp\_utility::giveperk( "specialty_overkillpro", false );
        self maps\mp\_utility::giveperk( "specialty_anytwo", false );
        self maps\mp\_utility::giveperk( "specialty_fasterlockon", false );
        self maps\mp\_utility::giveperk( "specialty_paint", false );
        self maps\mp\_utility::giveperk( "specialty_paint_pro", false );
        self maps\mp\_utility::giveperk( "specialty_silentkill", false );
        self maps\mp\_utility::giveperk( "specialty_crouchmovement", false );
        self maps\mp\_utility::giveperk( "specialty_personaluav", false );
        self maps\mp\_utility::giveperk( "specialty_unwrapper", false );
        self maps\mp\_utility::giveperk( "specialty_class_blindeye", false );
        self maps\mp\_utility::giveperk( "specialty_class_lowprofile", false );
        self maps\mp\_utility::giveperk( "specialty_class_coldblooded", false );
        self maps\mp\_utility::giveperk( "specialty_class_hardwired", false );
        self maps\mp\_utility::giveperk( "specialty_class_scavenger", false );
        self maps\mp\_utility::giveperk( "specialty_class_hoarder", false );
        self maps\mp\_utility::giveperk( "specialty_class_gungho", false );
        self maps\mp\_utility::giveperk( "specialty_class_steadyhands", false );
        self maps\mp\_utility::giveperk( "specialty_class_hardline", false );
        self maps\mp\_utility::giveperk( "specialty_class_peripherals", false );
        self maps\mp\_utility::giveperk( "specialty_class_quickdraw", false );
        self maps\mp\_utility::giveperk( "specialty_class_lightweight", false );
        self maps\mp\_utility::giveperk( "specialty_class_toughness", false );
        self maps\mp\_utility::giveperk( "specialty_class_engineer", false );
        self maps\mp\_utility::giveperk( "specialty_class_dangerclose", false );
        self maps\mp\_utility::giveperk( "specialty_horde_weaponsfree", false );
        self maps\mp\_utility::giveperk( "specialty_horde_dualprimary", false );
        self maps\mp\_utility::giveperk( "specialty_marksman", false );
        self maps\mp\_utility::giveperk( "specialty_sharp_focus", false );
        self maps\mp\_utility::giveperk( "specialty_moredamage", false );
        self maps\mp\_utility::giveperk( "specialty_copycat", false );
        self maps\mp\_utility::giveperk( "specialty_finalstand", false );
        self maps\mp\_utility::giveperk( "specialty_light_armor", false );
        self maps\mp\_utility::giveperk( "specialty_stopping_power", false );
        self maps\mp\_utility::giveperk( "specialty_uav", false );
        self iPrintln( "^:All Perks: ^7[^2On^7]" );
        level.AllPerks = true;
    }
    else {
        self maps\mp\_utility::_unsetperk( "specialty_longersprint" );
        self maps\mp\_utility::_unsetperk( "specialty_fastmantle" );
        self maps\mp\_utility::_unsetperk( "specialty_fastreload" );
        self maps\mp\_utility::_unsetperk( "specialty_quickdraw" );
        self maps\mp\_utility::_unsetperk( "specialty_scavenger" );
        self maps\mp\_utility::_unsetperk( "specialty_extraammo" );
        self maps\mp\_utility::_unsetperk( "specialty_bling" );
        self maps\mp\_utility::_unsetperk( "specialty_secondarybling" );
        self maps\mp\_utility::_unsetperk( "specialty_onemanarmy" );
        self maps\mp\_utility::_unsetperk( "specialty_omaquickchange" );
        self maps\mp\_utility::_unsetperk( "specialty_bulletdamage" );
        self maps\mp\_utility::_unsetperk( "specialty_armorpiercing" );
        self maps\mp\_utility::_unsetperk( "specialty_lightweight" );
        self maps\mp\_utility::_unsetperk( "specialty_fastsprintrecovery" );
        self maps\mp\_utility::_unsetperk( "specialty_hardline" );
        self maps\mp\_utility::_unsetperk( "specialty_rollover" );
        self maps\mp\_utility::_unsetperk( "specialty_radarimmune" );
        self maps\mp\_utility::_unsetperk( "specialty_spygame" );
        self maps\mp\_utility::_unsetperk( "specialty_explosivedamage" );
        self maps\mp\_utility::_unsetperk( "specialty_dangerclose" );
        self maps\mp\_utility::_unsetperk( "specialty_extendedmelee" );
        self maps\mp\_utility::_unsetperk( "specialty_falldamage" );
        self maps\mp\_utility::_unsetperk( "specialty_bulletaccuracy" );
        self maps\mp\_utility::_unsetperk( "specialty_holdbreath" );
        self maps\mp\_utility::_unsetperk( "specialty_localjammer" );
        self maps\mp\_utility::_unsetperk( "specialty_delaymine" );
        self maps\mp\_utility::_unsetperk( "specialty_heartbreaker" );
        self maps\mp\_utility::_unsetperk( "specialty_quieter" );
        self maps\mp\_utility::_unsetperk( "specialty_detectexplosive" );
        self maps\mp\_utility::_unsetperk( "specialty_selectivehearing" );
        self maps\mp\_utility::_unsetperk( "specialty_pistoldeath" );
        self maps\mp\_utility::_unsetperk( "specialty_laststandoffhand" );
        self maps\mp\_utility::_unsetperk( "specialty_shield" );
        self maps\mp\_utility::_unsetperk( "specialty_feigndeath" );
        self maps\mp\_utility::_unsetperk( "specialty_shellshock" );
        self maps\mp\_utility::_unsetperk( "specialty_blackbox" );
        self maps\mp\_utility::_unsetperk( "specialty_steelnerves" );
        self maps\mp\_utility::_unsetperk( "specialty_saboteur" );
        self maps\mp\_utility::_unsetperk( "specialty_endgame" );
        self maps\mp\_utility::_unsetperk( "specialty_rearview" );
        self maps\mp\_utility::_unsetperk( "specialty_primarydeath" );
        self maps\mp\_utility::_unsetperk( "specialty_hardjack" );
        self maps\mp\_utility::_unsetperk( "specialty_extraspecialduration" );
        self maps\mp\_utility::_unsetperk( "specialty_stun_resistance" );
        self maps\mp\_utility::_unsetperk( "specialty_double_load" );
        self maps\mp\_utility::_unsetperk( "specialty_regenspeed" );
        self maps\mp\_utility::_unsetperk( "specialty_autospot" );
        self maps\mp\_utility::_unsetperk( "specialty_twoprimaries" );
        self maps\mp\_utility::_unsetperk( "specialty_overkillpro" );
        self maps\mp\_utility::_unsetperk( "specialty_anytwo" );
        self maps\mp\_utility::_unsetperk( "specialty_fasterlockon" );
        self maps\mp\_utility::_unsetperk( "specialty_paint" );
        self maps\mp\_utility::_unsetperk( "specialty_paint_pro" );
        self maps\mp\_utility::_unsetperk( "specialty_silentkill" );
        self maps\mp\_utility::_unsetperk( "specialty_crouchmovement" );
        self maps\mp\_utility::_unsetperk( "specialty_personaluav" );
        self maps\mp\_utility::_unsetperk( "specialty_unwrapper" );
        self maps\mp\_utility::_unsetperk( "specialty_class_blindeye" );
        self maps\mp\_utility::_unsetperk( "specialty_class_lowprofile" );
        self maps\mp\_utility::_unsetperk( "specialty_class_coldblooded" );
        self maps\mp\_utility::_unsetperk( "specialty_class_hardwired" );
        self maps\mp\_utility::_unsetperk( "specialty_class_scavenger" );
        self maps\mp\_utility::_unsetperk( "specialty_class_hoarder" );
        self maps\mp\_utility::_unsetperk( "specialty_class_gungho" );
        self maps\mp\_utility::_unsetperk( "specialty_class_steadyhands" );
        self maps\mp\_utility::_unsetperk( "specialty_class_hardline" );
        self maps\mp\_utility::_unsetperk( "specialty_class_peripherals" );
        self maps\mp\_utility::_unsetperk( "specialty_class_quickdraw" );
        self maps\mp\_utility::_unsetperk( "specialty_class_lightweight" );
        self maps\mp\_utility::_unsetperk( "specialty_class_toughness" );
        self maps\mp\_utility::_unsetperk( "specialty_class_engineer" );
        self maps\mp\_utility::_unsetperk( "specialty_class_dangerclose" );
        self maps\mp\_utility::_unsetperk( "specialty_horde_weaponsfree" );
        self maps\mp\_utility::_unsetperk( "specialty_horde_dualprimary" );
        self maps\mp\_utility::_unsetperk( "specialty_marksman" );
        self maps\mp\_utility::_unsetperk( "specialty_sharp_focus" );
        self maps\mp\_utility::_unsetperk( "specialty_moredamage" );
        self maps\mp\_utility::_unsetperk( "specialty_copycat" );
        self maps\mp\_utility::_unsetperk( "specialty_finalstand" );
        self maps\mp\_utility::_unsetperk( "specialty_light_armor" );
        self maps\mp\_utility::_unsetperk( "specialty_stopping_power" );
        self maps\mp\_utility::_unsetperk( "specialty_uav" );
        self iPrintln( "^:All Perks: ^7[^1Off^7]" );
        level.AllPerks = false;
    }
}

third_person_toggle() {
    self.third_person_toggle = !( isdefined( self.third_person_toggle ) && self.third_person_toggle );

    istpp = getdvarint( "camera_thirdPerson" );

    if( istpp == false ) {
        setDvar( "camera_thirdPerson", 1 );
        self iPrintln( "^:Third Person: ^7[^2On^7]" );
    }
    else {
        setDvar( "camera_thirdPerson", 0 );
        self iPrintln( "^:Third Person: ^7[^1Off^7]" );
    }
}

ufo_mode_toggle() {
    if( !host_or_admin() )
        return;

    self.ufo_mode_toggle = !( isdefined( self.ufo_mode_toggle ) && self.ufo_mode_toggle );

    if( level.UFOMode == false ) {
        self thread ufo_mode_monitor();
        level.UFOMode = true;
        self iPrintln( "^:UFO Mode: ^7[^2On^7]" );
        self iPrintln( "^:Hold [{+smoke}] to fly | Press [{+speed_throw}] to land" );
    }
    else {
        self notify( "EndUFOMode" );
        level.UFOMode = false;
        self iPrintln( "^:UFO Mode: ^7[^1Off^7]" );
    }
}

ufo_mode_monitor() {
    self endon( "EndUFOMode" );

    self.Fly = 0;
    UFO = spawn( "script_model", self.origin );
    for(;;) {
        if( self secondaryoffhandbuttonpressed() ) {
            self playerLinkTo( UFO );
            self.Fly = 1;
        }
        else {
            self.Fly = 0;
        }
        if( self AdsButtonPressed() && self.Fly == 0 ) {
            self unlink();
            self.Fly = 0;
            self.UFO delete();
        }
        if( self.Fly == 1 ) {
            Fly = self.origin + vec_scal( anglesToForward( self getPlayerAngles() ), 20 );
            UFO moveTo( Fly, 0.05 );
        }
        wait 0.05;
    }
}

save_pos() {
    self.pers[ "savePos" ] = self.origin;
    self.pers[ "saveAng" ] = self.angles;
    self iPrintLn( "^:Position Saved" );
}

load_pos() {
    self setOrigin( self.pers[ "savePos" ] );
    self setPlayerAngles( self.pers[ "saveAng" ] );
    self iPrintLn( "^:Position Loaded" );
}

pos_print() {
    self iPrintln( "^:" + self.origin );
}

viewmodel_switch() {
    //todo
}

model_switcher( team, weapon ) {
    //todo
}

death_barriers_toggle() {
    if( !host_or_admin() )
        return;

    self.death_barriers_toggle = !( isdefined( self.death_barriers_toggle ) && self.death_barriers_toggle );

    if( level.DeathBarriers == true ) {
        ents = getEntArray();
		for( index = 0; index < ents.size; index++ ) {
			if( isSubStr( ents[ index ].classname, "trigger_hurt" ) || isSubStr( ents[ index ].classname, "kill_all_players" ) ) {
                ents[ index ].originalOrigin = ents[ index ].origin;
                ents[ index ].origin = ( 0, 0, 9999999 );
            }
		}
        level.DeathBarriers = false;
        self iPrintln( "^:Death Barriers: ^7[^2Removed^7]" );
    }
    else {
        ents = getEntArray();
		for( index = 0; index < ents.size; index++ ) {
			if( isSubStr( ents[ index ].classname, "trigger_hurt" ) || isSubStr( ents[ index ].classname, "kill_all_players" ) ) {
				if( isDefined( ents[ index ].originalOrigin ) ) {
					ents[ index ].origin = ents[ index ].originalOrigin;
				}
				else {
					self iprintln( "Original position not found for entity " + index + ", cannot reset." );
				}
			}
		}
        level.DeathBarriers = true;
        self iPrintln( "^:Death Barriers: ^7[^1Reset^7]" );
    }
}

teleporter() {
    self _beginLocationSelection( "", "map_artillery_selector", true, ( level.mapSize / 5.625 ) );
    self.selectingLocation = true;
    self waittill( "confirm_location", location, directionYaw );
    newLocation = PhysicsTrace( location + ( 0, 0, 1000 ), location - ( 0, 0, 1000 ) );
    self SetOrigin( newLocation );
    self SetPlayerAngles( directionYaw );
    self iPrintln( "^:Teleported" );
    self notify( "used" );
    self endLocationSelection();
    self.selectingLocation = undefined;
}

therm_vis_toggle() {
    self.therm_vis_toggle = !( isdefined( self.therm_vis_toggle ) && self.therm_vis_toggle );

    if( level.therm_vis_toggle == false ) {
        self maps\mp\_utility::giveperk( "specialty_thermal", false );
        self iPrintln( "^:Thermal Vision: ^7[^2On^7]" );
        level.therm_vis_toggle = true;
    }
    else {
        self maps\mp\_utility::_unsetperk( "specialty_thermal" );
        self iPrintln( "^:Thermal Vision: ^7[^1Off^7]" );
        level.therm_vis_toggle = false;
    }
}

disco_mode() {
    self endon( "disconnect" );
    self endon( "endThaFukingDisco" );

    if( !self.DiscoDisco ) {
        self.DiscoDisco = true;
    }
    else {
        self notify( "endThaFukingDisco" );
        self VisionSetNakedForPlayer( "default", 0.5 );
        self.DiscoDisco = false;
        return;
    }
    visions = "default_night_mp thermal_mp cheat_chaplinnight cobra_sunset3 cliffhanger_heavy armada_water mpnuke_aftermath icbm_sunrise4 missilecam grayscale";
    Vis = strTok( visions, " " );
    self iprintln( "Disco Disco, Good Good" );
    i = 0;
    for(;;) {
        self VisionSetNakedForPlayer( Vis[ i ], 0.5 );
        i++;
        if( i >= Vis.size )i = 0;
        wait 0.5;
    }
}

earthquake_mode() {
    if( !host_or_admin() )
        return;

    self iPrintln( "^:Earthquake started!" );
    earthquake( 0.6, 10, self.origin, 100000 );
}

laser_toggle() {
    self.laser_toggle = !( isdefined( self.laser_toggle ) && self.laser_toggle );

    if( level.laser_toggle == false ) {
        self laseron( "mp_attachment_lasersight" );
        level.laser_toggle = true;
        self iPrintln( "^:Laser: ^7[^2On^7]" );
    }
    else {
        self laseroff();
        level.laser_toggle = false;
        self iPrintln( "^:Laser: ^7[^1Off^7]" );
    }
}

disco_sun_toggle() {
    self.disco_sun_toggle = !( isdefined( self.disco_sun_toggle ) && self.disco_sun_toggle );

    if( level.disco_sun_toggle == false ) {
        level.disco_sun_toggle = true;
        self iPrintln( "^:Disco Sun: ^7[^2On^7]" );

        setdvar( "r_filmusetweaks", 1 );
        setdvar( "r_filmTweakenable", 1 );
        setdvar( "r_filmTweakbrightness", 0.2 );

        while( level.disco_sun_toggle == true ) {
            level.disco_x = randomFloatRange( 0.0, 2.0 );
            level.disco_y = randomFloatRange( 0.0, 2.0 );
            level.disco_z = randomFloatRange( 0.0, 2.0 );

            setdvar( "r_filmtweakLighttint", level.disco_x + " " + level.disco_y + " " + level.disco_z );
            wait 0.15;
        }
    }
    else {
        setdvar( "r_filmusetweaks", 0 );
        setdvar( "r_filmTweakenable", 0 );
        setdvar( "r_filmTweakbrightness", 0 );

        setdvar( "r_filmtweakLighttint", "1.1 1.05 0.85" );

        level.disco_sun_toggle = false;
        self iPrintln( "^:Disco Sun: ^7[^1Off^7]" );
    }
}

sun_color( color, name ) {
    if( level.disco_sun_toggle == true ) {
        disco_sun_toggle();

        if( color != "1.1 1.05 0.85" ) {
            setdvar( "r_filmusetweaks", 1 );
            setdvar( "r_filmTweakenable", 1 );
            setdvar( "r_filmTweakbrightness", 0.2 );
            setdvar( "r_filmtweakLighttint", color );
            self iprintln( "^:Sun color set: " + name );
        }
        else {
            setdvar( "r_filmusetweaks", 0 );
            setdvar( "r_filmTweakenable", 0 );
            setdvar( "r_filmTweakbrightness", 0 );
            setdvar( "r_filmtweakLighttint", color );
            self iprintln( "^:Sun color set: " + name );
        }
    }
    else {
        if( color != "1.1 1.05 0.85" ) {
            setdvar( "r_filmusetweaks", 1 );
            setdvar( "r_filmTweakenable", 1 );
            setdvar( "r_filmTweakbrightness", 0.2 );
            setdvar( "r_filmtweakLighttint", color );
            self iprintln( "^:Sun color set: " + name );
        }
        else {
            setdvar( "r_filmusetweaks", 0 );
            setdvar( "r_filmTweakenable", 0 );
            setdvar( "r_filmTweakbrightness", 0 );
            setdvar( "r_filmtweakLighttint", color );
            self iprintln( "^:Sun color set: " + name );
        }
    }
}

vision_changer( vision ) {
    if( vision != "default" ) {
        setdvar( "r_filmusetweaks", 0 );
        setdvar( "r_filmTweakenable", 0 );
        setdvar( "r_filmTweakbrightness", 0 );
        self VisionSetNakedForPlayer( vision, 0 );
        self iPrintln( "^:Vision Set: " + vision );
    }
    else {
        setdvar( "r_filmusetweaks", 0 );
        setdvar( "r_filmTweakenable", 0 );
        setdvar( "r_filmTweakbrightness", 0 );
        self VisionSetNakedForPlayer( getdvar( "mapname" ), 0.5 );
        self iPrintln( "^:Vision Set: " + vision );
    }
}

spawn_dead_clone() {
    self iprintln( "^:Dead Clone Spawned" );
    clone = self ClonePlayer( 9999 );
    clone startragdoll( 1 );
}

centipede_toggle() {
    self endon( "stop_centipede" );
    self endon( "disconnect" );
    self endon( "death" );

    self.centipede_toggle = !( isdefined( self.centipede_toggle ) && self.centipede_toggle );

    if( level.centipede_toggle == false ) {
        level.centipede_toggle = true;
        self iPrintln( "^:Human Centipede: ^7[^2On^7]" );
        while( 1 ) {
            ent = self ClonePlayer( 9999999 );
            wait 0.1;
            ent thread destroy_model_on_time( 3 );
        }
    }
    else {
        self notify( "stop_centipede" );
        level.centipede_toggle = false;
        self iPrintln( "^:Human Centipede: ^7[^1Off^7]" );
    }
}

matrix_mode_toggle() {
    self endon( "disconnect" );
    self endon( "MatrixOff" );

    if( !host_or_admin() )
        return;

    self.matrix_mode_toggle = !( isdefined( self.matrix_mode_toggle ) && self.matrix_mode_toggle );

    if( level.matrix_mode_toggle == false ) {
        level.matrix_mode_toggle = true;
        self iPrintLn( "^:Matrix Mode ^7[^2On^7]" );
        for(;;) {
            if( self isFiring() ) {
                setDvar( "timescale", 0.25 );
                self setclientdvar( "r_blur", 0.7 );
                self VisionSetNakedForPlayer( "remote_mortar_enhanced", 0.1 );
            }
            else {
                self VisionSetNakedForPlayer( getdvar( "mapname" ), 0.5 );
                setdvar( "timescale", 1 );
                self setclientdvar( "r_blur", 0 );
            }
            wait 0.05;
        }
    }
    else {
        self notify( "MatrixOff" );
        level.matrix_mode_toggle = false;
        self iPrintLn( "^:Matrix Mode ^7[^1Off^7]" );
    }
}

give_ammo() {
    weapon = self getCurrentWeapon();
    offhand = self getCurrentOffhand();

    self setWeaponAmmoStock( weapon, 999 );
    self setWeaponAmmoStock( offhand, 999 );

    self GiveMaxAmmo( weapon );
    self GiveMaxAmmo( offhand );
}

infinite_ammo_toggle() {
    if( !host_or_admin() )
        return;

    self.infinite_ammo_toggle = !( isdefined( self.infinite_ammo_toggle ) && self.infinite_ammo_toggle );

    if( level.infinite_ammo_toggle == false ) {
        level.infinite_ammo_toggle = true;
        self iPrintln( "^:Infinite Ammo: ^7[^2On^7]" );
        while( level.infinite_ammo_toggle == true ) {
            weapon = self GetCurrentWeapon();
            self setWeaponAmmoStock( weapon, weaponmaxammo( weapon ) );
            self setWeaponAmmoClip( weapon, weaponClipSize( weapon ) );
            self setWeaponAmmoClip( weapon, weaponClipSize( weapon ), "left" );
            self common_scripts\utility::waittill_any( "weapon_fired" );
        }
    }
    else {
        level.infinite_ammo_toggle = false;
        self iPrintln( "^:Infinite Ammo: ^7[^1Off^7]" );
    }
}

take_weapon() {
    weapon = self getCurrentWeapon();

    self takeWeapon( weapon );
    self iprintln( "^:" + weapon + " removed" );
}

take_all_weapons() {
    self takeAllWeapons();
}

reset_weapon() {
    weapon = self getCurrentWeapon();
    weaponbase = self getbaseweaponname( weapon );
    newWeapon = weaponbase + "_mp";
    if( newWeapon == weapon ) {
        self giveWeapon( newWeapon );
        self switchToWeapon( newWeapon );
        self iprintln( "^:Weapon reset" );
    }
    else {
        self giveWeapon( newWeapon );
        self takeWeapon( weapon );
        self switchToWeapon( newWeapon );
        self iprintln( "^:Weapon reset" );
    }
}

give_killstreak( killstreak ) {
    if( !host_or_admin() )
        return;

    self maps\mp\gametypes\_hardpoints::giveHardpoint( killstreak );
    self iprintln( "^:Killstreak Given: " + killstreak );
}

give_equipment( equipment ) {
    self settacticalweapon( equipment );
    self setweaponammoclip( equipment, 99 );
    self GiveMaxAmmo( equipment );
    self iprintln( "^:Equipment Given: " + equipment );
}

give_lethal( lethal ) {
    self setlethalweapon( lethal );
    self setweaponammoclip( lethal, 99 );
    self GiveMaxAmmo( lethal );
    self iprintln( "^:Lethal Given: " + lethal );
}

rapid_fire_toggle() {
    self endon( "endRapid" );

    if( !host_or_admin() )
        return;

    self.rapid_fire_toggle = !( isdefined( self.rapid_fire_toggle ) && self.rapid_fire_toggle );

    if( level.rapid_fire_toggle == false ) {
        level.rapid_fire_toggle = true;
        self maps\mp\_utility::giveperk( "specialty_fastreload", false );
        setDvar( "perk_weapReloadMultiplier", 0.0001 );
        self iPrintln( "^:Rapid Fire: ^7[^2On^7]" );
        self iPrintln( "^:Hold [{+reload}] & [{+attack}]! " );
        while( 1 ) {
            self setWeaponAmmoStock( self getCurrentWeapon(), 999 );
            wait 0.05;
        }
    }
    else {
        level.rapid_fire_toggle = false;
        setDvar( "perk_weapReloadMultiplier", 0.5 );
        self iPrintln( "^:Rapid Fire: ^7[^1Off^7]" );
        self notify ( "endRapid" );
    }
}

no_recoil_toggle() {
    self endon( "disconnect" );

    if( !host_or_admin() )
        return;

    self.no_recoil_toggle = !( isdefined( self.no_recoil_toggle ) && self.no_recoil_toggle );

    if( level.no_recoil_toggle == false ) {
        maps\mp\_utility::setrecoilscale( 100, 0 );
        level.no_recoil_toggle = true;
        self iPrintln( "^:No Recoil: ^7[^2On^7] ^1( bugged, doesn't turn off )" );
    }
    else {
        maps\mp\_utility::setrecoilscale( 0, 0 );
        level.no_recoil_toggle = false;
        self iPrintln( "^:No Recoil: ^7[^1Off^7] ^1( bugged, doesn't turn off )" );
    }
}

no_spread_toggle() {
    self endon( "disconnect" );

    if( !host_or_admin() )
        return;

    self.no_spread_toggle = !( isdefined( self.no_spread_toggle ) && self.no_spread_toggle );

    if( level.no_spread_toggle == false ) {
        level.no_spread_toggle = true;
        self maps\mp\_utility::giveperk( "specialty_bulletaccuracy", false );
        setdvar( "perk_weapSpreadMultiplier", 0.0001 );
        self iPrintln( "^:No Spread: ^7[^2On^7]" );
    }
    else {
        level.no_spread_toggle = false;
        setdvar( "perk_weapSpreadMultiplier", 0.65 );
        self iPrintln( "^:No Spread: ^7[^1Off^7]" );
    }
}

wallbang_toggle() {
    self endon( "disconnect" );

    if( !host_or_admin() )
        return;

    self.wallbang_toggle = !( isdefined( self.wallbang_toggle ) && self.wallbang_toggle );

    if( level.wallbangs == false ) {
        setdvar( "bg_surfacePenetration", 9999 );
        setdvar( "perk_bulletPenetrationMultiplier", 30 );
        setdvar( "perk_armorPiercing", 9999 );
        self maps\mp\_utility::giveperk( "specialty_armorpiercing", false );
        self maps\mp\_utility::giveperk( "specialty_stopping_power", false );
        self maps\mp\_utility::giveperk( "specialty_bulletdamage", false );
        self iPrintln( "^:Wallbang All: ^7[^2On^7]" );
        level.wallbangs = true;
    }
    else {
        setdvar( "bg_surfacePenetration", 0 );
        setdvar( "perk_bulletPenetrationMultiplier", 2 );
        setdvar( "perk_armorPiercing", 40 );
        self iPrintln( "^:Wallbang All: ^7[^1Off^7]" );
        level.wallbangs = false;
    }
}

quake_rounds_toggle() {
    self endon( "disconnect" );
    self endon( "endQuakeRounds" );

    if( !host_or_admin() )
        return;

    self.quake_rounds_toggle = !( isdefined( self.quake_rounds_toggle ) && self.quake_rounds_toggle );

    if( level.quake_rounds_toggle == false ) {
        level.quake_rounds_toggle = true;
        self iPrintln( "^:Earthquake Rounds: ^7[^2On^7]" );
        for(;;) {
            self waittill( "weapon_fired" );
            earthquake( 0.5, 1, self.origin, 90 );
            radiusDamage( 150, 300, 100, self );
            earthquake( 1.5, 1, 90 );
        }
    }
    else {
        level.quake_rounds_toggle = false;
        self iPrintln( "^:Earthquake Rounds: ^7[^1Off^7]" );
        self notify( "endQuakeRounds" );
    }
}

bullet_ricochet_toggle() {
    self endon( "disconnect" );
    self endon( "endRicochet" );
    
    if( !host_or_admin() )
        return;

    self.bullet_ricochet_toggle = !( isdefined( self.bullet_ricochet_toggle ) && self.bullet_ricochet_toggle );

    if( level.bullet_ricochet_toggle == false ) {
        level.bullet_ricochet_toggle = true;
        self iPrintln( "^:Bullet Ricochet: ^7[^2On^7]" );
        for(;;) {
            self waittill( "weapon_fired" );
            self thread bullet_ricochet_reflect( 30, self getcurrentweapon() );
        }
    }
    else {
        level.bullet_ricochet_toggle = false;
        self iPrintln( "^:Bullet Ricochet: ^7[^1Off^7]" );
        self notify( "endRicochet" );
    }
}

bullet_ricochet_reflect( times, weapon ) {
    incident = anglestoforward( self getplayerangles() );
    trace = bullettrace( self geteye(), self geteye() + incident * 100000, 0, self );
    reflection = incident - ( 2 * trace[ "normal" ] * vectordot( incident, trace[ "normal" ] ) );
    magicbullet( weapon, trace[ "position" ], trace[ "position" ] + ( reflection * 100000 ) );
    wait 0.05;
    for( i = 0; i < times - 1; i++ ) {
        trace = bullettrace( trace[ "position" ], trace[ "position" ] + ( reflection * 100000 ), 0, self );
        incident = reflection;
        reflection = incident - ( 2 * trace[ "normal" ] * vectordot( incident, trace[ "normal" ] ) );
        magicbullet( weapon, trace[ "position" ], trace[ "position" ] + ( reflection * 100000 ) );
        wait 0.05;
    }
}

weapon_projectile( projectile ) {
    self endon( "disconnect" );

    if( !host_or_admin() )
        return;

    if( projectile != "Default" && level.custom_proj == false )
	{
        self iPrintln( "^:Custom Projectile Set: " + projectile );
        self endon( "disconnect" );
        self endon( "defaultproj" );
        self endon( "newproj" );
        self notify( "newproj2" );
        level.custom_proj = true;
        for(;;) {
            self waittill( "weapon_fired" );
            forward = self getTagOrigin( "j_head" );
	        end = self thread vec_scal( anglestoforward( self getPlayerAngles() ), 1000000 );
	        location = BulletTrace( forward, end, 0, self )[ "position" ];
            MagicBullet( projectile, self getTagOrigin("tag_eye"), location, self );
        }
	}
	else if( projectile != "Default" && level.custom_proj == true ) {
        self notify( "newproj" );
        self endon( "defaultproj" );
        self endon( "newproj2" );
        self iPrintln( "^:Custom Projectile Set: " + projectile );
        level.custom_proj = false;
        for(;;) {
            self waittill( "weapon_fired" );
            forward = self getTagOrigin( "j_head" );
	        end = self thread vec_scal( anglestoforward( self getPlayerAngles() ), 1000000 );
	        location = BulletTrace( forward, end, 0, self )[ "position" ];
            MagicBullet( projectile, self getTagOrigin( "tag_eye" ), location, self );
        }
	}
    else
    {
        self notify( "defaultproj" );
        self iPrintln( "^:Custom Projectile: ^7[^1Off^7]" );
    }
}

explosive_rounds_toggle() {
    self endon( "disconnect" );
    self endon( "ExplosiveRoundsEnd" );

    if( !host_or_admin() )
        return;

    self.explosive_rounds_toggle = !( isdefined( self.explosive_rounds_toggle ) && self.explosive_rounds_toggle );

    if( level.explosive_rounds_toggle == false ) {
        level.explosive_rounds_toggle = true;
        self iPrintln( "^:Explosive Rounds: ^7[^2On^7]" );
        for(;;) {
            self waittill ( "weapon_fired" );
            forward = self getTagOrigin( "j_head" );
            end = self thread vec_scal( anglestoforward ( self getPlayerAngles() ), 1000000 );
            SPLOSIONlocation = BulletTrace( forward, end, 0, self )[ "position" ];
            self playsound( "h1_wpn_rpg_exp_default" );
            playfx( level._effect[ "vfx/explosion/frag_grenade_default" ], SPLOSIONlocation );
            RadiusDamage( SPLOSIONlocation, 180, 180, 180, self );
        }
    }
    else {
        level.explosive_rounds_toggle = false;
        self iPrintln( "^:Explosive Rounds: ^7[^1Off^7]" );
        self notify( "ExplosiveRoundsEnd" );
    }
}

shotgun_rounds_toggle() {
    self endon( "disconnect" );
    self endon( "ShotgunRoundsEnd" );

    if( !host_or_admin() )
        return;

    self.shotgun_rounds_toggle = !( isdefined( self.shotgun_rounds_toggle ) && self.shotgun_rounds_toggle );

    if( level.shotgun_rounds_toggle == false ) {
        level.shotgun_rounds_toggle = true;
        self iPrintln( "^:Shotgun Rounds: ^7[^2On^7]" );
        for(;;) {
            self waittill( "weapon_fired" );
            MagicBullet( "h2_spas12_mp", self getEye(), self trace_bullet(), self );
            MagicBullet( "h2_spas12_mp", self getEye(), self trace_bullet(), self );
            MagicBullet( "h2_spas12_mp", self getEye(), self trace_bullet(), self );
        }
    }
    else {
        level.shotgun_rounds_toggle = false;
        self iPrintln( "^:Shotgun Rounds: ^7[^1Off^7]" );
        self notify( "ShotgunRoundsEnd" );
    }
}

weapon_reticle() {
    //todo
}

mustang_sally() {
    self endon( "death" );

    if( !host_or_admin() )
        return;

    self iPrintln( "^:Mustang and Sally added!" );
    self giveWeapon( "h2_colt45_mp_akimbo_xmagmwr_camo036" );
    self switchToWeapon( "h2_colt45_mp_akimbo_xmagmwr_camo036" );
    for(;;) {
        self waittill( "weapon_fired" );
        if( self getCurrentWeapon() == "h2_colt45_mp_akimbo_xmagmwr_camo036" ) {
            forward = self getTagOrigin( "tag_eye" );
            end = self thread vec_scal( anglestoforward( self getPlayerAngles() ), 1000000 );
            location = BulletTrace( forward, end, 0, self )[ "position" ];
            MagicBullet( "h2_m79_mp", forward, location, self );
        }
        wait 0.05;
    }
}

death_machine() {
    self endon( "disconnect" );

    if( !host_or_admin() )
        return;

    self iprintlnBold( "^1Death Machine Ready." );
    self attach( "weapon_minigun", "tag_weapon_left", false );
    self giveWeapon( "defaultweapon_mp" );
    self switchToWeapon( "defaultweapon_mp" );
    self.bullets = 998;
    self.notshown = false;
    self.ammoDeathMachine = spawnstruct();
    self.ammoDeathMachine = self createFontString( "default", 2.0 );
    self.ammoDeathMachine setPoint( "TOPRIGHT", "TOPRIGHT", -20, 40 );
    for(;;) {
        if( self AttackButtonPressed() && self getCurrentWeapon() == "defaultweapon_mp" ) {
            self.notshown = false;
            self allowADS( false );
            self.bullets--;
            self.ammoDeathMachine setValue( self.bullets );
            self.ammoDeathMachine.color = ( 0, 1, 0 );
            tagorigin = self getTagOrigin( "tag_weapon_left" );
            firing = cursor_pos();
            x = randomIntRange( -50, 50 );
            y = randomIntRange( -50, 50 );
            z = randomIntRange( -50, 50 );
            MagicBullet( "ac130_25mm_mp", tagorigin, firing + ( x, y, z ), self );
            self setWeaponAmmoClip( "defaultweapon_mp", 100, "left" );
            self setWeaponAmmoClip( "defaultweapon_mp", 100, "right" );
        }
        else {
            if( self.notshown == false ) {
                self.ammoDeathMachine setText( " " );
                self.notshown = true;
            }
            self allowADS( true );
        }
        if( self.bullets == 0 ) {
            self takeWeapon( "defaultweapon_mp" );
            self.ammoDeathMachine destroy();
            self allowADS( true );
            break;
        }
        if( !isAlive( self ) ) {
            self.ammoDeathMachine destroy();
            self allowADS( true );
            break;
        }
        wait 0.07;
    }
}

teleport_gun() {
    self endon( "death" );

    if( !host_or_admin() )
        return;

    self iPrintln( "^:Teleport Gun added!" );
    self giveWeapon( "h2_m40a3_mp_ogscope_xmagmwr_camo025" );
    self switchToWeapon( "h2_m40a3_mp_ogscope_xmagmwr_camo025" );
    for(;;) {
        self waittill( "weapon_fired" );
        if( self getCurrentWeapon() == "h2_m40a3_mp_ogscope_xmagmwr_camo025" ) {
            vec2 = anglestoforward( self getPlayerAngles() );
            e1nd = ( vec2[ 0 ] * 200000, vec2[ 1 ] * 200000, vec2[ 2 ] * 200000 );
            BulletLocation = BulletTrace( self gettagorigin( "tag_eye" ), self gettagorigin( "tag_eye" ) + e1nd, 0, self )[ "position" ];
            self SetOrigin( BulletLocation );
        }
        wait 0.05;
    }
}

care_package_gun() {
    self endon( "death" );

    if( !host_or_admin() )
        return;

    self iPrintln( "^:Care Package gun added!" );
    self giveWeapon( "h2_m40a3_mp_silencerlmg_xmagmwr_camo033" );
    self SwitchToWeapon( "h2_m40a3_mp_silencerlmg_xmagmwr_camo033" );
    for(;;) {
        self waittill( "weapon_fired" );
        if( self getCurrentWeapon()=="h2_m40a3_mp_silencerlmg_xmagmwr_camo033" ) {
            dropCrate = maps\mp\h2_killstreaks\_airdrop::createAirDropCrate( self.owner, "airdrop_marker_mp", maps\mp\h2_killstreaks\_airdrop::getCrateTypeForDropType( "airdrop_marker_mp" ), self geteye() + anglestoforward( self getplayerangles() ) * 70 );
            dropCrate.angles = self getplayerangles();
            dropCrate PhysicsLaunchServer( ( 0, 0, 0 ), anglestoforward( self getplayerangles() ) * 1000 );
            dropCrate thread maps\mp\h2_killstreaks\_airdrop::physicsWaiter( "airdrop_marker_mp", maps\mp\h2_killstreaks\_airdrop::getCrateTypeForDropType( "airdrop_marker_mp" ) );
        }
    }
}

nuke_at4() {
    self endon ( "disconnect" );
    self endon ( "death" );

    if( !host_or_admin() )
        return;

    self iPrintln( "^:Nuke AT4 added" );
    self giveWeapon( "at4_mp" );
    self switchToWeapon( "at4_mp" );
    for(;;) {
        self waittill ( "weapon_fired" );
        if( self getCurrentWeapon() == "at4_mp" ) {
            if( level.teambased ) thread teamPlayerCardSplash( "used_nuke", self, self.team );
            else self iprintlnbold( &"MP_FRIENDLY_TACTICAL_NUKE" );
            wait 1;
            me2 = self;
            level thread nuke_sound();
            level thread nuke_fx( me2 );
            level thread nuke_slow_mo();
            wait 1.5;

            foreach( player in level.players ) {
                if( player.name != me2.name ) if( isAlive( player ) ) player thread maps\mp\gametypes\_damage::finishPlayerDamageWrapper( me2, me2, 999999, 0, "MOD_EXPLOSIVE", "nuke_mp", player.origin, player.origin, "none", 0, 0 );
            }
            wait 0.1;
            level notify ( "done_nuke2" );
            self suicide();
        }
    }
}

nuke_slow_mo() {
    level endon ( "done_nuke2" );
    setSlowMotion( 1.0, 0.25, 0.5 );
}

nuke_fx( me2 ) {
    level endon ( "done_nuke2" );

    foreach( player in level.players ) {
        player thread nuke_slow_mo_fix( player );
        playerForward = anglestoforward( player.angles );
        playerForward = ( playerForward[ 0 ], playerForward[ 1 ], 0 );
        playerForward = VectorNormalize( playerForward );
        nukeDistance = 100;
        nukeEnt = Spawn( "script_model", player.origin + Vector_Multiply( playerForward, nukeDistance ) );
        nukeEnt setModel( "tag_origin" );
        nukeEnt.angles = ( 0, ( player.angles[ 1 ] + 180 ), 90 );
        nukeEnt thread nuke_fx_2( player );
        player.nuked = true;
    }
}

nuke_slow_mo_fix( player ) {
    player endon( "disconnect" );
    player waittill( "death" );
    setSlowMotion( 0.25, 1, 2.0 );
}

nuke_fx_2( player ) {
    player endon( "death" );
    waitframe();
    PlayFXOnTagForClients( level._effect[ "nuke_flash" ], self, "tag_origin", player );
}

nuke_sound() {
    level endon ( "done_nuke2" );

    foreach( player in level.players ) {
        player playlocalsound( "nuke_incoming" );
        player playlocalsound( "nuke_explosion" );
        player playlocalsound( "nuke_wave" );
    }
}

mounted_turret() {
    if( !host_or_admin() )
        return;

    self iPrintln( "^:Mounted Turret Spawned!" );
    mounted_turret = spawnTurret( "misc_turret", self.origin, "pavelow_minigun_mp" );
    mounted_turret setModel( "weapon_minigun" );
    mounted_turret.owner = self.owner;
    mounted_turret.team = self.team;
    mounted_turret SetBottomArc( 360 );
    mounted_turret SetTopArc( 360 );
    mounted_turret SetLeftArc( 360 );
    mounted_turret SetRightArc( 360 );
}

nova_gas() {
    self endon( "disconnect" );

    if( !host_or_admin() )
        return;

    self iPrintln( "^:Nova Gas added!" );
    cur = self getCurrentWeapon();
    wait 0.1;
    self giveweapon( "h1_smokegrenade_mp" );
    self SwitchToWeapon( "h1_smokegrenade_mp" );
    self waittill( "grenade_fire", grenade );
    if( self getCurrentWeapon() == "h1_smokegrenade_mp" ) {
        nova = spawn( "script_model", grenade.origin );
        nova setModel( "wpn_h1_grenade_smoke_proj" );
        nova Linkto( grenade );
        wait 1;
        self switchToWeapon( cur );
        for( i = 0; i <= 10; i++ ) {
            RadiusDamage( nova.origin, 300, 100, 50, self );
            wait 1;
        }
        nova delete();
    }
}

grappling_gun() {
    self endon( "death" );

    if( !host_or_admin() )
        return;

    self iPrintln( "^:Grappling Gun added!" );
    self giveWeapon( "h2_usp_mp_silencersmg_xmagmwr_camo027" );
    self switchToWeapon( "h2_usp_mp_silencersmg_xmagmwr_camo027" );
    for(;;) {
        self waittill( "weapon_fired" );
        if( self getCurrentWeapon() == "h2_usp_mp_silencersmg_xmagmwr_camo027" ) {
            endLocSY = trace_bullet();
            self.grappler = spawn( "script_model", self.origin );
            self playerlinkto( self.grappler, undefined );
            self.grappler moveTo( endLocSY, 1 );
            wait 1.02;
            self unlink();
            self.grappler delete();
        }
        wait 0.05;
    }
}

suicide_plane() {
    self endon( "disconnect" );
    self endon( "death" );

    if( !host_or_admin() )
        return;

    Location = location_selector();
    self iPrintln( "^:Suicide Plane Inbound!" );
    SuicidePlane = spawn( "script_model", self.origin + ( 24000, 15000, 25000 ) );
    SuicidePlane setModel( "vehicle_ac130_low_mp" );
    Angles = vectorToAngles( Location - ( self.origin + ( 8000, 5000, 10000 ) ) );
    SuicidePlane.angles = Angles;
    SuicidePlane moveto( Location, 3.5 );
    SuicidePlane playsound( "veh_b2_close_loop" );
    playFxOnTag( level.chopper_fx[ "damage" ][ "light_smoke" ], SuicidePlane, "tag_origin" );
    wait 3.6;
    playFX( level.chopper_fx[ "explode" ][ "large" ], SuicidePlane.origin );
    playFX( level.chopper_fx[ "explode" ][ "large" ], SuicidePlane.origin + ( 400, 0, 0 ) );
    playFX( level.chopper_fx[ "explode" ][ "large" ], SuicidePlane.origin + ( 0, 400, 0 ) );
    playFX( level.chopper_fx[ "explode" ][ "large" ], SuicidePlane.origin + ( 400, 400, 0 ) );
    playFX( level.chopper_fx[ "explode" ][ "large" ], SuicidePlane.origin + ( 0, 0, 400 ) );
    playFX( level.chopper_fx[ "explode" ][ "large" ], SuicidePlane.origin - ( 400, 0, 0 ) );
    playFX( level.chopper_fx[ "explode" ][ "large" ], SuicidePlane.origin - ( 0, 400, 0 ) );
    playFX( level.chopper_fx[ "explode" ][ "large" ], SuicidePlane.origin - ( 400, 400, 0 ) );
    playFX( level.chopper_fx[ "explode" ][ "large" ], SuicidePlane.origin + ( 0, 0, 800 ) );
    playFX( level.chopper_fx[ "explode" ][ "large" ], SuicidePlane.origin + ( 200, 0, 0 ) );
    playFX( level.chopper_fx[ "explode" ][ "large" ], SuicidePlane.origin + ( 0, 200, 0 ) );
    playFX( level.chopper_fx[ "explode" ][ "large" ], SuicidePlane.origin + ( 200, 200, 0 ) );
    playFX( level.chopper_fx[ "explode" ][ "large" ], SuicidePlane.origin + ( 0, 0, 200 ) );
    playFX( level.chopper_fx[ "explode" ][ "large" ], SuicidePlane.origin - ( 200, 0, 0 ) );
    playFX( level.chopper_fx[ "explode" ][ "large" ], SuicidePlane.origin - ( 0, 200, 0 ) );
    playFX( level.chopper_fx[ "explode" ][ "large" ], SuicidePlane.origin - ( 200, 200, 0 ) );
    playFX( level.chopper_fx[ "explode" ][ "large" ], SuicidePlane.origin + ( 0, 0, 200 ) );
    playFX( level._effect[ "vfx/explosion/mp_gametype_bomb" ], SuicidePlane.origin + ( 0, 0, 0 ) );
    SuicidePlane playsound( level.heli_sound[ "crash" ] );
    SuicidePlane playsound( "nuke_explosion" );
    self RadiusDamage( SuicidePlane.origin, 4000, 4000, 100, self );
    SuicidePlane delete();
    Earthquake( 0.4, 4, SuicidePlane.origin, 800 );
}

rocket_barrage() {
    level.killed_stoners = 0;
    self iprintlnbold( "^:Rocket Barrage ^2Launched" );
    level.mapCenter = maps\mp\gametypes\_spawnlogic::findBoxCenter( level.spawnMins, level.spawnMaxs );
    foreach( player in level.players ) {
        if( isAlive( player ) && player != host_player() ) {
            level.killed_stoners += 1;
            MagicBullet( "remotemissile_projectile_mp", level.mapCenter + ( 0, 0, 4000 ), player getTagOrigin( "j_spineupper" ), self );
        }
    }
    if( level.killed_stoners > 0 )
    self iprintlnbold( "Rocket Barrage Targeted ^1" + level.killed_stoners + "^7 enemies!" );
    if( level.killed_stoners <= 0 )
    self iprintlnbold( "^1Error^7: No enemies found!" );
}

plane_collision() {
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "PilotsCrashed" );
    
    if( !host_or_admin() )
        return;

    ElectricHaze = spawn( "script_model", self.origin + ( 18000, 0, 2400 ) );
    ElectricHaze2 = spawn( "script_model", self.origin + ( -18000, 0, 2400 ) );
    ElectricHaze setModel( "vehicle_ac130_low_mp" );
    ElectricHaze2 setModel( "vehicle_ac130_low_mp" );
    ElectricHaze MoveTo( self.origin + ( 0, 0, 2400 ), 5 );
    ElectricHaze2 MoveTo( self.origin + ( 0, 0, 2400 ), 5 );
    ElectricHaze.angles = ( 0, 180, 0 );
    ElectricHaze2.angles = ( 0, 0, 0 );
    playFxOnTag( level.chopper_fx[ "damage" ][ "light_smoke" ], ElectricHaze, "tag_origin" );
    playFxOnTag( level.chopper_fx[ "damage" ][ "light_smoke" ], ElectricHaze2, "tag_origin" );
    wait 5;
    PlayFX( level._effect[ "aerial_explosion_large" ], ElectricHaze.origin );
    playFX( level.chopper_fx[ "explode" ][ "large" ], ElectricHaze.origin );
    playFX( level.chopper_fx[ "explode" ][ "large" ], ElectricHaze.origin + ( 400, 0, 0 ) );
    playFX( level.chopper_fx[ "explode" ][ "large" ], ElectricHaze.origin + ( 0, 400, 0 ) );
    playFX( level.chopper_fx[ "explode" ][ "large" ], ElectricHaze.origin + ( 400, 400, 0 ) );
    playFX( level.chopper_fx[ "explode" ][ "large" ], ElectricHaze.origin + ( 0, 0, 400 ) );
    playFX( level.chopper_fx[ "explode" ][ "large" ], ElectricHaze.origin - ( 400, 0, 0 ) );
    playFX( level.chopper_fx[ "explode" ][ "large" ], ElectricHaze.origin - ( 0, 400, 0 ) );
    playFX( level.chopper_fx[ "explode" ][ "large" ], ElectricHaze.origin - ( 400, 400, 0 ) );
    playFX( level.chopper_fx[ "explode" ][ "large" ], ElectricHaze.origin + ( 0, 0, 800 ) );
    playFX( level.chopper_fx[ "explode" ][ "large" ], ElectricHaze.origin + ( 200, 0, 0 ) );
    playFX( level.chopper_fx[ "explode" ][ "large" ], ElectricHaze.origin + ( 0, 200, 0 ) );
    playFX( level.chopper_fx[ "explode" ][ "large" ], ElectricHaze.origin + ( 200, 200, 0 ) );
    playFX( level.chopper_fx[ "explode" ][ "large" ], ElectricHaze.origin + ( 0, 0, 200 ) );
    playFX( level.chopper_fx[ "explode" ][ "large" ], ElectricHaze.origin - ( 200, 0, 0 ) );
    playFX( level.chopper_fx[ "explode" ][ "large" ], ElectricHaze.origin - ( 0, 200, 0 ) );
    playFX( level.chopper_fx[ "explode" ][ "large" ], ElectricHaze.origin - ( 200, 200, 0 ) );
    playFX( level.chopper_fx[ "explode" ][ "large" ], ElectricHaze.origin + ( 0, 0, 200 ) );
    ElectricHaze playsound( level.heli_sound[ "crash" ] );
    ElectricHaze playsound( "nuke_explosion" );
    _visionsetnaked( "coup_sunblind", 0.1 );
    PlayFX( level._effect[ "nuke_flash" ] );
    wait ( 0.1 );
    _visionsetnaked( "coup_sunblind", 0 );
    _visionsetnaked( "", 3.0 );
    self thread plane_collision_fx();
    ElectricHaze delete();
    ElectricHaze2 delete();
}

plane_collision_fx() {
    self endon( "disconnect" );
    self endon( "death" );

    earthquake( 0.6, 4, self.origin, 100000 );
    foreach( player in level.players ) {
        player playlocalsound( "nuke_explosion" );
        player playlocalsound( "nuke_wave" );
    }
}

jetpack_toggle() {
    self endon( "death" );
    self endon( "jetpack_off" );

    if( !host_or_admin() )
        return;

    self.jetpack_toggle = !( isdefined( self.jetpack_toggle ) && self.jetpack_toggle );

    if( level.jetpack_toggle == false ) {
        level.jetpack_toggle = true;
        self.fuel = 200;
        self iPrintln( "^:Jetpack: ^7[^2On^7]" );
        self attach( "projectile_hellfire_missile", "tag_stowed_back" );
        for( i=0 ;; i++ ) {
            if( self usebuttonpressed() && self.fuel > 0 ) {
                self playsound( "boost_jump_plr_mp" );
                playFX( level._effect[ "fire_smoke_trail_l" ], self getTagOrigin( "J_Ankle_RI" ) );
                playFx( level._effect[ "fire_smoke_trail_l" ], self getTagOrigin( "J_Ankle_LE" ) );
                earthquake( 0.15, 0.2, self gettagorigin( "j_spine4" ), 50 );
                self.fuel--;
                if( self getvelocity() [ 2 ] < 300 )
                self setvelocity( self getvelocity() + ( 0, 0, 60 ) );
            }
            if( self.fuel < 200 && !self usebuttonpressed() ) self.fuel++;
            wait 0.05;
        }
    }
    else {
        self notify( "jetpack_off" );
        level.jetpack_toggle = false;
        self iPrintln( "^:Jetpack: ^7[^1Off^7]" );
    }
}

mega_airdrop_remade() {
    if( !host_or_admin() )
        return;

    self iPrintln( "^:Mega Airdrop Inbound!" );
    planeHalfDistance = 24000;
    planeFlySpeed     = 3500;
    yaw               = vectorToYaw( self.origin );
    direction         = ( 0, yaw, 0 );
    flyHeight         = self maps\mp\h2_killstreaks\_airdrop::getFlyHeightOffset( self.origin );
    pathStart         = self.origin + vector_multiply( AnglesToForward( direction ), -1 * planeHalfDistance );
    pathStart         = pathStart * ( 1, 1, 0 ) + ( 0, 0, flyHeight );
    pathEnd           = self.origin + vector_multiply( AnglesToForward( direction ), planeHalfDistance );
    pathEnd           = pathEnd * ( 1, 1, 0 ) + ( 0, 0, flyHeight );
    d                 = length( pathStart - pathEnd );
    flyTime           = ( d / planeFlySpeed );
    c130              = maps\mp\h2_killstreaks\_airdrop::c130Setup( self, pathStart, pathEnd );
    c130.dropType     = "airdrop_marker_mp";
    c130 PlayLoopSound( "veh_ac130_dist_loop" );
    c130.angles = direction;
    forward     = AnglesToForward( direction );
    c130 MoveTo( pathEnd, flyTime, 0, 0 );
    minDist    = Distance2D( c130.origin, self.origin );
    boomPlayed = false;
    for(;;) {
        dist = Distance2D( c130.origin, self.origin );
        if( dist < minDist )
            minDist = dist;
        else if( dist > minDist )
            break;
        if( dist < 256 )
            break;
        else if( dist < 768 ) {
            Earthquake( 0.15, 1.5, self.origin, 1500 );

            if( !boomPlayed ) {
                c130 PlaySound( "veh_ac130_sonic_boom" );
                boomPlayed = true;
            }
        }
        wait 0.05;
    }
    for( a = 0;  a < 15; a++ ) {
        c130 notify( "drop_crate" );
        c130 thread maps\mp\h2_killstreaks\_airdrop::dropTheCrate( self.origin, "airdrop_marker_mp", flyHeight, false, undefined, pathStart );
        wait 0.055;
    }
    wait 7;
    c130 delete();
}

mega_airdrop() {
    if( !host_or_admin() )
        return;

    self thread mega_airdrop_text( "^:Mega Airdrop Incoming...", 5, ( 0, 1, 1 ) );
    wait 5;
    self thread mega_airdrop_main();
}

mega_airdrop_main() {
    self endon( "death" );
    self endon( "disconnect" );

    thread teamPlayerCardSplash( "used_airdrop_mega", self );
    o = self;
    sn = level.heli_start_nodes[ randomInt( level.heli_start_nodes.size ) ];
    hO = sn.origin;
    hA = sn.angles;
    lb = spawnHelicopter( o, hO, hA, "cobra_mp", "vehicle_ac130_low_mp" );
    if( !isDefined( lb ) ) return;
    lb maps\mp\_helicopter::addToHeliList();
    lb.zOffset = ( 0, 0, lb getTagOrigin( "tag_origin" )[ 2 ] - lb getTagOrigin( "tag_ground" )[ 2 ] );
    lb.team = o.team;
    lb.attacker = undefined;
    lb.lifeId = 0;
    lb.currentstate = "ok";
    lN = level.heli_loop_nodes[ randomInt( level.heli_loop_nodes.size ) ];
    lb maps\mp\_helicopter::heli_fly_simple_path( sn );
    lb thread mega_airdrop_crate( lb );
    lb thread maps\mp\_helicopter::heli_fly_loop_path( lN );
    lb thread mega_airdrop_leave( 20 );
}

mega_airdrop_crate( lb ) {
    self endon( "disconnect" );

    for(;;) {
        mega_airdrop_text_wait( 0.1 );
        dC = maps\mp\h2_killstreaks\_airdrop::createAirDropCrate( self.owner, "airdrop_marker_mp", maps\mp\h2_killstreaks\_airdrop::getCrateTypeForDropType( "airdrop_marker_mp" ), lb.origin );
        dC.angles = lb.angles;
        dC PhysicsLaunchServer( ( 0, 0, 0 ), anglestoforward( lb.angles ) * 1 );
        dC thread maps\mp\h2_killstreaks\_airdrop::physicsWaiter( "airdrop_marker_mp", maps\mp\h2_killstreaks\_airdrop::getCrateTypeForDropType( "airdrop_marker_mp" ) );
        mega_airdrop_text_wait( 0.1 );
    }
}

mega_airdrop_leave( t ) {
    self endon( "death" );
    self endon( "helicopter_done" );
    maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause( T );
    self thread mega_airdrop_exit();
}

mega_airdrop_exit() {
    self notify( "leaving" );
    lN = level.heli_leave_nodes[ randomInt( level.heli_leave_nodes.size ) ];
    self maps\mp\_helicopter::heli_reset();
    self Vehicle_SetSpeed( 100, 45 );
    self setvehgoalpos( lN.origin, 1 );
    self waittillmatch( "goal" );
    self notify( "death" );
    mega_airdrop_text_wait( 0.05 );
    self delete();
}

mega_airdrop_text( l, m, c ) {
    self endon( "std" );
    P = createServerFontString( "hudbig", 1.2 );
    P setPoint( "CENTER", "CENTER", 0, -40 );
    P.sort = 1001;
    P.color = ( c );
    P iPrintlnBold( l );
    P.foreground = false;
    P1 = createServerFontString( "hudbig", 1.4 );
    P1 setPoint( "CENTER", "CENTER", 0, 0 );
    P1.sort = 1001;
    P1.color = ( c );
    P1.foreground = false;
    P1 setTimer( m );
    self thread mega_airdrop_text_destroy( m, P, P1 );
    P1 maps\mp\gametypes\_hud::fontPulseInit();
    while( 1 ) {
        self playSound( "ui_mp_nukebomb_timer" );
        mega_airdrop_text_wait( 1 );
    }
}

mega_airdrop_text_destroy( m, a, b ) {
    wait( m );
    self notify( "std" );
    a destroy();
    b destroy();
}

mega_airdrop_text_wait( V ) {
    wait( V );
}

super_ac130() {
    if( !host_or_admin() )
        return;

    self iPrintln( "^:Super AC-130 Inbound!" );
    owner = self;
    startNode = level.heli_start_nodes[ randomInt( level.heli_start_nodes.size ) ];
    heliOrigin = startnode.origin;
    heliAngles = startnode.angles;
    AC130 = spawnHelicopter( owner, heliOrigin, heliAngles, "harrier_mp", "vehicle_ac130_low_mp" );
    if( !isDefined( AC130 ) )return;
    AC130 playLoopSound( "veh_b2_dist_loop" );
    AC130 maps\mp\_helicopter::addToHeliList();
    AC130.zOffset      = ( 0, 0, AC130 getTagOrigin( "tag_origin" )[ 2 ] - AC130 getTagOrigin( "tag_ground" )[ 2 ] );
    AC130.team         = owner.team;
    AC130.attacker     = undefined;
    AC130.lifeId       = 0;
    AC130.currentstate = "ok";
    AC130 thread maps\mp\_helicopter::heli_leave_on_disconnect( owner );
    AC130 thread maps\mp\_helicopter::heli_leave_on_changeTeams( owner );
    AC130 thread maps\mp\_helicopter::heli_leave_on_gameended( owner );
    AC130 endon( "helicopter_done" );
    AC130 endon( "crashing" );
    AC130 endon( "leaving" );
    AC130 endon( "death" );
    attackAreas = getEntArray( "heli_attack_area", "targetname" );
    loopNode = level.heli_loop_nodes[ randomInt( level.heli_loop_nodes.size ) ];
    AC130 maps\mp\_helicopter::heli_fly_simple_path( startNode );
    AC130 thread super_ac130_timeout( 100 );
    AC130 thread maps\mp\_helicopter::heli_fly_loop_path( loopNode );
    AC130 thread super_ac130_bomb( owner );
}

super_ac130_bomb( owner ) {
    self endon( "death" );
    self endon( "helicopter_done" );
    level endon( "game_ended" );
    self endon( "crashing" );
    self endon( "leaving" );

    waittime = 5;
    for(;;) {
        wait( waittime );
        AimedPlayer = undefined;

        foreach( player in level.players ) {
            if( ( player == owner ) || ( !isAlive( player ) ) || ( level.teamBased && owner.pers[ "team" ] == player.pers[ "team" ] ) || ( !bulletTracePassed( self getTagOrigin( "tag_origin" ), player getTagOrigin( "back_mid" ), 0, self ) ) )
                continue;
            if( isDefined( AimedPlayer ) ) {
                if( closer( self getTagOrigin( "tag_origin" ), player getTagOrigin( "back_mid" ), AimedPlayer getTagOrigin( "back_mid" ) ) )AimedPlayer = player;
            }
            else {
                AimedPlayer = player;
            }
        }
        if( isDefined( AimedPlayer ) ) {
            AimLocation = ( AimedPlayer getTagOrigin( "back_mid" ) );
            Angle       = VectorToAngles( AimLocation - self getTagOrigin( "tag_origin" ) );
            MagicBullet( "ac130_105mm_mp", self getTagOrigin( "tag_origin" ) - ( 0, 0, 180 ), AimLocation, owner );
            wait 0.3;
            MagicBullet( "ac130_40mm_mp", self getTagOrigin( "tag_origin" ) - ( 0, 0, 180 ), AimLocation, owner );
            wait 0.3;
            MagicBullet( "ac130_40mm_mp", self getTagOrigin( "tag_origin" ) - ( 0, 0, 180 ), AimLocation, owner );
        }
    }
}

super_ac130_timeout( t ) {
    self endon( "death" );
    self endon( "helicopter_done" );
    maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause( T );
    self thread super_ac130_leave();
}

super_ac130_leave() {
    self notify( "leaving" );
    leaveNode = level.heli_leave_nodes[ randomInt( level.heli_leave_nodes.size ) ];
    self maps\mp\_helicopter::heli_reset();
    self Vehicle_SetSpeed( 100, 45 );
    self setvehgoalpos( leaveNode.origin, 1 );
    self waittillmatch( "goal" );
    self notify( "death" );
    wait 0.05;
    self stopLoopSound();
    self delete();
}

suicide_bomb() {
    self endon( "disconnect" );
    self endon( "death" );

    if( !host_or_admin() )
        return;

    self iprintlnBold( "^:Press ^1[{+attack}] ^:to Detonate" );
    self waittill( "weapon_fired" );
    for(;;) {
        self iPrintlnBold( "^:Bomb ^1Activated" );
        self takeAllWeapons();
        self giveWeapon( "onemanarmy_mp" );
        self switchToWeapon( "onemanarmy_mp" );
        wait 1;
        foreach( player in level.players ) {
            self playSound( "ui_mp_timer_countdown" );
            wait( 0.4 );
            self playSound( "ui_mp_timer_countdown" );
            wait( 0.4 );
            for( i = 0.4; i > 0; i -= 0.1 ) {
                self playSound( "ui_mp_timer_countdown" );
                wait( i );
                self playSound( "ui_mp_timer_countdown" );
                wait( i );
            }
            playfx( level.chopper_fx[ "explode" ][ "large" ], self.origin );
            player playlocalsound( "nuke_explosion" );
            player playlocalsound( "nuke_wave" );
            RadiusDamage( self.origin, 4000, 4000, 1, self );
            Earthquake( 0.5, 4, self.origin, 800 );
            self suicide();
            wait 8;
        }
    }
}

strafe_run_init() {
    if( !host_or_admin() )
        return;

    if( !level.AwaitingPreviousStrafe ) {
        Location = location_selector();
        self iPrintln( "^:Strafing Run Inbound!" );
        level.AwaitingPreviousStrafe = true;
        locationYaw = 180;
        flightPath1 = strafe_run_path( Location, locationYaw, 0 );
        flightPath2 = strafe_run_path( Location, locationYaw, -620 );
        flightPath3 = strafe_run_path( Location, locationYaw, 620 );
        flightPath4 = strafe_run_path( Location, locationYaw, -1140 );
        flightPath5 = strafe_run_path( Location, locationYaw, 1140 );
        level thread strafe_run_move( self, flightPath1 );
        wait 0.3;
        level thread strafe_run_move( self, flightPath2 );
        level thread strafe_run_move( self, flightPath3 );
        wait 0.3;
        level thread strafe_run_move( self, flightPath4 );
        level thread strafe_run_move( self, flightPath5 );
        wait 60;
        level.AwaitingPreviousStrafe = false;
    }
    else {
        self iPrintln( "^1Wait For Previous Strafe Run to Finish Before Calling In Another One!" );
    }
}

strafe_run_move( owner, flightPath ) {
    level endon( "game_ended" );

    if( !isDefined( owner ) )
    return;
    forward = vectorToAngles( flightPath[ "end" ] - flightPath[ "start" ] );
    StrafeHeli = strafe_run_spawn( owner, flightPath[ "start" ], forward );
    StrafeHeli thread strafe_run_attack();
    StrafeHeli setYawSpeed( 120, 60 );
    StrafeHeli Vehicle_SetSpeed( 48, 4 );
    StrafeHeli setVehGoalPos( flightPath[ "end" ], 0 );
    StrafeHeli waittill( "goal" );
    StrafeHeli setYawSpeed( 30, 40 );
    StrafeHeli Vehicle_SetSpeed( 32, 32 );
    StrafeHeli setVehGoalPos( flightPath[ "start" ], 0 );
    wait 2;
    StrafeHeli setYawSpeed( 100, 60 );
    StrafeHeli Vehicle_SetSpeed( 64, 64 );
    StrafeHeli waittill( "goal" );
    self notify( "chopperdone" );
    StrafeHeli delete();
}

strafe_run_attack() {
    self endon( "chopperdone" );

    self setVehWeapon( self.defaultweapon );
    for( ;; ) {
        for( i = 0; i < level.players.size; i++ ) {
            if( strafe_run_target( level.players[ i ] ) ) {
                self setturrettargetent( level.players[ i ] );
                self FireWeapon( "tag_flash", level.players[ i ] );
            }
        }
        wait 0.5;
    }
}

strafe_run_spawn( owner, origin, angles ) {
    Team = owner.pers[ "team" ];
    SentryGun = spawnHelicopter( owner, origin, angles, "cobra_mp", "vehicle_little_bird_armed" );
    SentryGun.team = Team;
    SentryGun.pers[ "team" ] = Team;
    SentryGun.owner = owner;
    SentryGun.currentstate = "ok";
    SentryGun setdamagestage( 4 );
    SentryGun.killCamEnt = SentryGun;
    return SentryGun;
}

strafe_run_target( player ) {
    CanTarget = true;
    if( !IsAlive( player ) || player.sessionstate != "playing" )
        return false;
    if( distance( player.origin, self.origin ) > 5000 )
        return false;
    if( !isDefined( player.pers[ "team" ]) )
        return false;
    if( level.teamBased && player.pers[ "team" ] == self.team )
        return false;
    if( player == self.owner )
        return false;
    if( player.pers[ "team" ] == "spectator" )
        return false;
    if( !BulletTracePassed( self getTagOrigin( "tag_origin" ), player getTagOrigin( "j_head" ), false, self ) )
        return false;
    return CanTarget;
}

strafe_run_path( location, locationYaw, rightOffset ) {
    location = location * ( 1, 1, 0 );
    initialDirection = ( 0, locationYaw, 0 );
    planeHalfDistance = 12000;
    flightPath = [];
    if( isDefined( rightOffset ) && rightOffset != 0 ) {
        location = location + ( AnglesToRight( initialDirection ) * rightOffset ) + ( 0, 0, RandomInt( 300 ) );
        startPoint = ( location + ( AnglesToForward( initialDirection ) * ( -1 * planeHalfDistance ) ) );
        endPoint = ( location + ( AnglesToForward( initialDirection ) * planeHalfDistance ) );
        flyheight = 1500;
        flightPath[ "start" ] = startPoint + ( 0, 0, flyHeight );
        flightPath[ "end" ] = endPoint + ( 0, 0, flyHeight );
        return flightPath;
    }
}

sonic_boom() {
    self endon( "disconnect" );
    self endon( "WentBoom" );

    if( !host_or_admin() )
        return;

    self iPrintln( "^1Sonic Boom ^7Ready!" );
    self iPrintln( "^2Created By^7: ^6Cmd-X" );
    self giveWeapon( "h2_usp_mp_fmj_silencerpistol_camo031" );
    wait 0.1;
    //level.harrier_deathfx = loadfx ( "explosions/aerial_explosion_harrier" );
    self switchToWeapon( "h2_usp_mp_fmj_silencerpistol_camo031" );
    self setWeaponAmmoClip( "h2_usp_mp_fmj_silencerpistol_camo031", 1 );
    self setWeaponAmmoStock( "h2_usp_mp_fmj_silencerpistol_camo031", 0 );
    self setClientDvar( "laserForceOn", 1 );
    self iPrintlnBold( "Shoot For Bomb Location!" );
    for(;;) {
        self waittill( "weapon_fired" );
        if( self getCurrentWeapon() == "h2_usp_mp_fmj_silencerpistol_camo031" ) {
            self setClientDvar( "laserForceOn", 0 );
            self takeweapon( "h2_usp_mp_fmj_silencerpistol_camo031" );
            fff2 = self getTagOrigin( "tag_eye" );
            eee2 = self vec_scal( anglestoforward( self getPlayerAngles() ), 10000 );
            ss2 = BulletTrace( fff2, eee2, 0, self )[ "position" ];
            self thread sonic_boom_fx_2();
            SBcmdx = spawn( "script_model", ss2 );
            SBcmdx setModel( "projectile_cbu97_clusterbomb" );
            SBcmdx.angles = ( 270, 270, 270 );
            SBcmdx MoveTo( ss2 + ( 0, 0, 200 ), 5 );
            self thread sonic_boom_rotate( SBcmdx );
            wait 5;
            self thread sonic_boom_fx();
            wait 1;
            playfx( level.stealthbombfx, ss2 );
            PlayFX( level._effect[ "aerial_explosion_large" ], ss2 );
            playFX( level.chopper_fx[ "explode" ][ "large" ], ss2 );
            RadiusDamage( ss2, 900, 900, 900, self );
            SBcmdx delete();
            self notify( "WentBoom" );
            wait 4;
        }
    }
}

sonic_boom_rotate( Val ) {
    self endon( "disconnect" );

    for(;;) {
        Val rotateyaw( -360, 0.3 );
        wait 0.3;
    }
}

sonic_boom_fx() {
    self endon( "disconnect" );

    foreach( player in level.players ) {
        player thread sonic_boom_fx1();
    }
}

sonic_boom_fx_2() {
    self endon( "disconnect" );

    foreach( player in level.players ) {
        player thread sonic_boom_fx2();
    }
}

sonic_boom_fx1() {
    self playLocalSound( "mp_killstreak_emp" );
    self VisionSetNakedForPlayer( "cheat_contrast", 1 );
    wait 1;
    self playLocalSound( "nuke_explosion" );
    self VisionSetNakedForPlayer( "cargoship_blast", 0.1 );
    wait 1;
    self VisionSetNakedForPlayer( "mpnuke_aftermath", 2 );
    wait 3;
    self VisionSetNakedForPlayer( getDvar( "mapname" ), 1 );
}

sonic_boom_fx2() {
    self iPrintlnBold( "^3Sonic Boom Incoming!" );
}

defense_system() {
    self endon( "disconnect" );

    if( !host_or_admin() )
        return;

    o = self;
    offset = ( 0, 0, 10 );
    level.ims = spawn( "script_model", self.origin + offset );
    level.ims setModel( "com_plasticcase_friendly" );
    level.ims2 = spawn( "script_model", self.origin );
    level.ims2 setModel( "prop_flag_neutral" );
    self iprintlnbold( "StonedYoda's Defense System ^2Spawned" );
    level.ims.angles = ( 90, 0, 0 );
    s = "at4_mp";
    for(;;) {
        foreach( p in level.players ) {
            d = distance( level.ims.origin, p.origin );
            if( level.teambased ) {
                if( ( p != o ) && ( p.pers[ "team" ] != self.pers[ "team" ] ) ) {
                    if( d < 310 ) {
                        if( isAlive( p ) ) {
                            p thread defense_system_fire( level.ims, o, p, s );
                            self iprintlnbold( "Defense System Fired at [^2" + p.name + "^7]" );
                        }
                    }
                }
            }
            else {
                if( p != o ) {
                    if( d <  310 ) {
                        if( isAlive( p ) ) {
                            p thread defense_system_fire( level.ims, o, p, s );
                            self iprintlnbold( "Defense System Fired at [^2" + p.name + "^7]" );
                        }
                    }
                }
            }
        }
        wait 0.3;
    }
}

defense_system_fire( obj, me, noob, bullet ) {
    self endon( "noims" );

    while( 1 ) {
        MagicBullet( bullet, obj.origin, noob.origin, me );
        wait 2;
        break;
    }
}

spawn_bunker() {
    self endon( "death" );

    if( !host_or_admin() )
        return;

    self thread spawn_bunker_main();
}

spawn_crate( location ) {
    Mod = spawn( "script_model", Location );
    Mod setModel( "com_plasticcase_enemy" );
    Mod Solid();
    Mod CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
}

spawn_crate_line( Location, X, Y, Z ) {
    for( i = 0; i < X; i++ )spawn_crate( Location + ( i * 55, 0, 0 ) );
    for( i = 0; i < Y; i++ )spawn_crate( Location + ( 0, i * 30, 0 ) );
    for( i = 0; i < Z; i++ )spawn_crate( Location + ( 0, 0, i * 25 ) );
}

spawn_crate_wall( Location, Axis, X, Y ) {
    if( Axis == "X" ) {
        spawn_crate_line( Location, X, 0, 0 );
        for( i = 0; i < X; i++ )
        spawn_crate_line( Location + ( i * 55, 0, 0 ), 0, 0, Y );
    }
    else if( Axis == "Y" ) {
        spawn_crate_line( Location, 0, X, 0 );
        for( i = 0; i < X; i++ )
        spawn_crate_line( Location + ( 0, i * 30, 0 ), 0, 0, Y );
    }
    else if( Axis == "Z" ) {
        spawn_crate_line( Location, 0, X, 0 );
        for( i = 0; i < X; i++ )
        spawn_crate_line( Location + ( 0, i * 30, 0 ), Y, 0, 0 );
    }
}

spawn_bunker_main() {
    Location = self.origin + ( 0, 0, 20 );
    spawn_crate_wall( Location, "X", 5, 8 );
    spawn_crate_wall( Location + ( 0, 5 * 30, 0 ), "X", 5, 8 );
    spawn_crate_wall( Location, "Y", 5, 8 );
    spawn_crate_wall( Location + ( 5 * 55, 0, 0 ), "Y", 6, 8 );
    spawn_crate_wall( Location, "Z", 5, 5 );
    spawn_crate_wall( Location + ( 0, 0, 5 * 25 ), "Z", 5, 4 );
    create_turret( Location + ( 0.25 * ( 5 * 55 ), 18, 35 + ( 4 * 30 ) ) );
    create_turret( Location + ( 0.25 * ( 5 * 55 ), ( 5 * 25 ) + 1, 35 + ( 4 * 30 ) ) );
    spawn_crate( Location + ( ( 4 * 55 ), 84, 20 + 4 ) );
    spawn_crate( Location + ( ( 4 * 55 ), 74, 30 + 6 ) );
    spawn_crate( Location + ( ( 4 * 55 ), 64, 40 + 8 ) );
    spawn_crate( Location + ( ( 4 * 55 ), 54, 50 + 10 ) );
    spawn_crate( Location + ( ( 4 * 55 ), 44, 60 + 12 ) );
    spawn_crate( Location + ( ( 4 * 55 ), 34, 70 + 14 ) );
    spawn_crate( Location + ( ( 4 * 55 ), 24, 80 + 16 ) );
    spawn_crate( Location + ( ( 4 * 55 ), 14, 90 + 18 ) );
    spawn_crate( Location + ( 45, 10, 6 * 25 ) );
    spawn_crate( Location + ( 45, ( 5 * 25 ) + 15, ( 6 * 25 ) ) );
    self thread spawn_weapon( undefined, "javelin_mp", "Javelin", Location + ( 80, 30, 25 ), 0 );
    self thread spawn_weapon( undefined, "h2_rpg_mp", "RPG", Location + ( 80, 65, 25 ), 0 );
    self thread spawn_weapon( undefined, "h2_cheytac_mp_fmj_xmagmwr", "Intervention", Location + ( 60, 90, 25 ), 0 );
    self thread spawn_weapon( undefined, "h2_barrett_mp_fmj_xmagmwr", "Barrett .50", Location + ( 60, 115, 25 ), 0 );
    self thread spawn_weapon( undefined, "frag_grenade_mp", "Frag", Location + ( 115, 30, 25 ), 0 );
    self thread spawn_weapon( ::use_pred_missile, "com_plasticcase_friendly", "Predator", Location + ( 165, 30, 25 ), 0 );
    self SetOrigin( Location + ( 100, 100, 35 ) );
}

create_turret( Location ) {
    mgTurret = spawnTurret( "misc_turret", Location + ( 0, 0, 45 ), "pavelow_minigun_mp" );
    mgTurret setModel( "weapon_minigun" );
    mgTurret.owner = self.owner;
    mgTurret.team = self.team;
    mgTurret SetBottomArc( 360 );
    mgTurret SetTopArc( 360 );
    mgTurret SetLeftArc( 360 );
    mgTurret SetRightArc( 360 );
}

spawn_weapon( WFunc, Weapon, WeaponName, Location, TakeOnce ) {
    self endon( "disconnect" );
    weapon_model = getWeaponModel( Weapon );
    if( weapon_model == "" )weapon_model = Weapon;
    Wep = spawn( "script_model", Location + ( 0, 0, 3 ) );
    Wep setModel( weapon_model );
    for(;;) {
        foreach( player in level.players ) {
            Radius = distance( Location, player.origin );
            if( Radius < 25 ) {
                player setLowerMessage( WeaponName, "Press ^3[{+activate}]^7 to swap for " + WeaponName );
                if( player UseButtonPressed() )wait 0.2;
                if( player UseButtonPressed() ) {
                    if( !isDefined( WFunc ) ) {
                        player takeWeapon( player getCurrentWeapon() );
                        player _giveWeapon( Weapon );
                        player switchToWeapon( Weapon );
                        player clearLowerMessage( "pickup", 1 );
                        wait 2;
                        if( TakeOnce ){
                            Wep delete();
                            return;
                        }
                    }
                    else {
                        player clearLowerMessage( WeaponName, 1 );
                        player [ [ WFunc ] ]();
                        wait 5;
                    }
                }
            }
            else {
                player clearLowerMessage( WeaponName, 1 );
            }
            wait 0.1;
        }
        wait 0.5;
    }
}

build_skybase2() {
    self endon( "death" );
        
    if( !host_or_admin() )
        return;

    self thread build_skybase();
}

build_skybase() {
    self endon( "death" );
    self endon( "Destroy_SkyBase" );

    level.SkyBase = true;
    iprintln( "^1Won't finish building on larger maps! ( ent Limit )" );
    vec = anglestoforward( self getPlayerAngles() );
    center = BulletTrace( self gettagorigin( "tag_eye" ), self gettagorigin( "tag_eye" ) + ( vec[ 0 ] * 200000, vec[ 1 ] * 200000, vec[ 2 ] * 200000 ), 0, self )[ "position" ];
    level.center = spawn( "script_origin", center );
    level.lift = [];
    h = 0;
    k = 0;
    origin = level.center.origin;
    for( i = 0; i < 404; i++ ) {
        if( i <= 100 )
        level.lift[ k ] = spawn( "script_model", origin + ( -42, 42, h ) );
        else if( i <= 201 && i > 100 )
        level.lift[ k ] = spawn( "script_model", origin + ( 42, 42, h - 2777.5 * 2 ) );
        else if( i <= 302 && i > 201 )
        level.lift[ k ] = spawn( "script_model", origin + ( -42, -42, h - 5555 * 2 ) );
        else if( i <= 404 && i > 301 )
        level.lift[ k ] = spawn( "script_model", origin + ( 42, -42, h - 8332.5 * 2 ) );

        level.lift[ i ].angles = ( 90, 90, 0 );
        h += 55;
        k++;
    }
    level.center moveto( level.center.origin + ( 0, 0, 15 ), 0.05 );
    wait 0.05;
    level.elevator = [];
    level.elevator[ 0 ] = spawn( "script_model", origin + ( 0, 42, -15 ) );
    level.elevator[ 1 ] = spawn( "script_model", origin + ( 0, -42, -15 ) );
    level.elevator[ 2 ] = spawn( "script_model", origin + ( 42, 0, -15 ) );
    level.elevator[ 2 ].angles = ( 0, 90, 0 );
    level.elevator[ 3 ] = spawn( "script_model", origin + ( -42, 0, -15 ) );
    level.elevator[ 3 ].angles = ( 0, 90, 0 );
    level.elevator[ 4 ] = spawn( "script_model", origin + ( 0, 14, -15 ) );
    level.elevator[ 5 ] = spawn( "script_model", origin + ( 0, -14, -15 ) );
    base = level.center.origin + ( -110, 182, 5513.75 );
    level.elevatorcontrol = [];
    level.elevatorcontrol[ 0 ] = spawn( "script_model", origin + ( 0, -42, 13.75 ) );
    level.elevatorcontrol[ 0 ] setModel( "com_plasticcase_friendly" );
    level.elevatorcontrol[ 0 ] CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
    level.elevatorcontrol[ 0 ] linkto( level.center );
    level.elevatorcontrol[ 1 ] = spawn( "script_model", origin + ( 0, -42, 28.75 ) );
    level.elevatorcontrol[ 1 ] setModel( "com_laptop_2_open" );
    level.elevatorcontrol[ 1 ].angles = ( 0, 90, 0 );
    level.elevatorcontrol[ 1 ] linkto( level.center );
    level.elevatorcontrol[ 2 ] = spawn( "script_model", base + ( 0, 0, 28 ) );
    level.elevatorcontrol[ 2 ] setModel( "com_plasticcase_friendly" );
    level.elevatorcontrol[ 2 ] CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
    level.elevatorcontrol[ 3 ] = spawn( "script_model", base + ( 0, 0, 42 ) );
    level.elevatorcontrol[ 3 ] setModel( "com_laptop_2_open" );
    level.elevatorcontrol[ 3 ].angles = ( 0, 90, 0 );
    level.elevatorcontrol[ 4 ] = spawn( "script_model", level.center.origin + ( 44, 60, 40 ) );
    level.elevatorcontrol[ 4 ] setModel( "ma_flatscreen_tv_wallmount_01" );
    level.elevatorcontrol[ 4 ].angles = ( 0, 180, 0 );
    level.elevatorcontrol[ 5 ] = spawn( "script_model", base + ( 5, 224, 28 ) );
    level.elevatorcontrol[ 5 ] setModel( "com_plasticcase_friendly" );
    level.elevatorcontrol[ 5 ] CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
    level.elevatorcontrol[ 5 ].angles = ( 0, 45, 0 );
    level.elevatorcontrol[ 6 ] = spawn( "script_model", base + ( 215, 224, 28 ) );
    level.elevatorcontrol[ 6 ] setModel( "com_plasticcase_friendly" );
    level.elevatorcontrol[ 6 ] CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
    level.elevatorcontrol[ 6 ].angles = ( 0, -45, 0 );
    level.elevatorcontrol[ 7 ] = spawn( "script_model", base + ( 110, 252, 28 ) );
    level.elevatorcontrol[ 7 ] setModel( "com_plasticcase_friendly" );
    level.elevatorcontrol[ 7 ] CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
    level.elevatorcontrol[ 8 ] = spawn( "script_model", base + ( 5, 224, 42 ) );
    level.elevatorcontrol[ 8 ] setModel( "com_laptop_2_open" );
    level.elevatorcontrol[ 8 ].angles = ( 0, -45, 0 );
    level.elevatorcontrol[ 8 ].type = "right";
    level.elevatorcontrol[ 9 ] = spawn( "script_model", base + ( 215, 224, 42 ) );
    level.elevatorcontrol[ 9 ] setModel( "com_laptop_2_open" );
    level.elevatorcontrol[ 9 ].angles = ( 0, -135, 0 );
    level.elevatorcontrol[ 9 ].type = "left";
    level.elevatorcontrol[ 10 ] = spawn( "script_model", base + ( 110, 252, 42 ) );
    level.elevatorcontrol[ 10 ] setModel( "com_laptop_2_open" );
    level.elevatorcontrol[ 10 ].angles = ( 0, -90, 0 );
    level.elevatorcontrol[ 10 ].type = "forward";
    level.elevatorcontrol[ 11 ] = spawn( "script_model", base + ( 220, 0, 42 ) );
    level.elevatorcontrol[ 11 ] setModel( "com_laptop_2_open" );
    level.elevatorcontrol[ 11 ].angles = ( 0, 90, 0 );
    level.elevatorcontrol[ 11 ].type = "dock";
    level.elevatorcontrol[ 12 ] = spawn( "script_model", base + ( 220, 0, 28 ) );
    level.elevatorcontrol[ 12 ] setModel( "com_plasticcase_friendly" );
    level.elevatorcontrol[ 12 ] CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
    level.elevatorcontrol[ 13 ] = spawn( "script_model", base + ( 232, 98, 28 ) );
    level.elevatorcontrol[ 13 ] setModel( "com_plasticcase_friendly" );
    level.elevatorcontrol[ 13 ] CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
    level.elevatorcontrol[ 13 ].angles = ( 0, 90, 0 );
    level.elevatorcontrol[ 14 ] = spawn( "script_model", base + ( 232, 98, 42 ) );
    level.elevatorcontrol[ 14 ] setModel( "com_laptop_2_open" );
    level.elevatorcontrol[ 14 ].angles = ( 0, 180, 0 );
    level.elevatorcontrol[ 14 ].type = "up";
    level.elevatorcontrol[ 15 ] = spawn( "script_model", base + ( -12, 98, 28 ) );
    level.elevatorcontrol[ 15 ] setModel( "com_plasticcase_friendly" );
    level.elevatorcontrol[ 15 ] CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
    level.elevatorcontrol[ 15 ].angles = ( 0, 90, 0 );
    level.elevatorcontrol[ 16 ] = spawn( "script_model", base + ( -12, 98, 42 ) );
    level.elevatorcontrol[ 16 ] setModel( "com_laptop_2_open" );
    level.elevatorcontrol[ 16 ].type = "down";
    level.elevatorcontrol[ 17 ] = spawn( "script_model", origin + ( -85, 84, 13.75 ) );
    level.elevatorcontrol[ 17 ] setModel( "com_plasticcase_friendly" );
    level.elevatorcontrol[ 17 ] CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
    level.elevatorcontrol[ 17 ].angles = ( 0, -45, 0 );
    level.elevatorcontrol[ 18 ] = spawn( "script_model", origin + ( -85, 84, 28.75 ) );
    level.elevatorcontrol[ 18 ] setModel( "com_laptop_2_open" );
    level.elevatorcontrol[ 18 ].angles = ( 0, 45, 0 );
    level.elevatorcontrol[ 18 ].type = "forcedock";
    level.elevatorcontrol[ 19 ] = spawn( "script_model", base + ( 165, 0, 28 ) );
    level.elevatorcontrol[ 19 ] setModel( "com_plasticcase_friendly" );
    level.elevatorcontrol[ 19 ] CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
    level.elevatorcontrol[ 20 ] = spawn( "script_model", base + ( 165, 0, 42 ) );
    level.elevatorcontrol[ 20 ] setModel( "com_laptop_2_open" );
    level.elevatorcontrol[ 20 ].angles = ( 0, 90, 0 );
    level.elevatorcontrol[ 20 ].type = "destroy";
    level.center2 = spawn( "script_origin", level.center.origin );
    level.center2 linkto( level.center );
    level.elevatorPlatform = [];
    level.elevatorPlatform[ 0 ] = spawn( "script_model", origin + ( 0, -42, -15 ) );
    level.elevatorPlatform[ 1 ] = spawn( "script_model", origin + ( 0, -14, -15 ) );
    level.elevatorPlatform[ 2 ] = spawn( "script_model", origin + ( 0, 14, -15 ) );
    level.elevatorPlatform[ 3 ] = spawn( "script_model", origin + ( 0, 42, -15 ) );
    level.elevatorBase = [];
    j = 0;
    w = 0;
    for( x = 0; x < 10; x++ ) {
        for( i = 0; i < 5; i++ ) {
            level.elevatorBase[ j ] = spawn( "script_model", base + ( i * 55, w, 0 ) );
            j++;
        }
        w += 28;
    }
    level.BaseCenter = spawn( "script_origin", base + ( 110, 126, 0 ) );
    level.BaseCenterOrigAng = level.BaseCenter.angles;
    level.BaseCenterOrigOrigin = level.BaseCenter.origin;
    for( i = 5; i <= level.elevatorcontrol.size; i++ )
    level.elevatorcontrol[ i ] linkto( level.BaseCenter );
    level.elevatorcontrol[ 17 ] unlink();
    level.elevatorcontrol[ 18 ] unlink();
    level.elevatorcontrol[ 2 ] linkto( level.BaseCenter );
    level.elevatorcontrol[ 3 ] linkto( level.BaseCenter );
    foreach( elevatorbase in level.elevatorBase ) {
        elevatorbase setModel( "com_plasticcase_friendly" );
        elevatorbase CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
        elevatorbase linkto( level.BaseCenter );
    }
    foreach( platform in level.elevatorPlatform ) {
        platform linkto( level.center2 );
        platform setModel( "com_plasticcase_friendly" );
        platform CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
    }
    foreach( elevator in level.elevator ) {
        elevator CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
        elevator setmodel( "com_plasticcase_friendly" );
        elevator linkto( level.center );
    }
    foreach( lift in level.lift ) {
        lift CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
        lift setmodel( "com_plasticcase_friendly" );
    }
    thread sky_base_computers();
    level.elevatorcontrol[ 8 ] thread sky_base_computers_2();
    level.elevatorcontrol[ 9 ] thread sky_base_computers_2();
    level.elevatorcontrol[ 10 ] thread sky_base_computers_2();
    level.elevatorcontrol[ 11 ] thread sky_base_computers_2();
    level.elevatorcontrol[ 14 ] thread sky_base_computers_2();
    level.elevatorcontrol[ 16 ] thread sky_base_computers_2();
    level.elevatorcontrol[ 18 ] thread sky_base_computers_2();
    level.elevatorcontrol[ 20 ] thread sky_base_computers_2();
}

sky_base_computers() {
    level endon( "exploded" );
    level.elevatorDirection = "up";
    place = "default";
    for(;;) {
        foreach( player in level.players ) {
            if( distance( level.elevatorcontrol[ 1 ].origin, player.origin ) < 50 )
            place = "elevator";
            else if( distance( level.elevatorcontrol[ 3 ].origin, player.origin ) < 50 )
            place = "top";
            else if( distance( level.elevatorcontrol[ 4 ].origin, player.origin ) < 50 )
            place = "bottom";
            if( distance( level.elevatorcontrol[ 1 ].origin, player.origin ) < 50 || distance( level.elevatorcontrol[ 3 ].origin, player.origin ) < 50 || distance( level.elevatorcontrol[ 4 ].origin, player.origin ) < 50 ) {
                if( level.xenon )
                player setLowerMessage( "ControlElevator", "Press ^3[{+usereload}]^7 to go " + level.elevatorDirection, undefined, 50 );
                else
                player setLowerMessage( "ControlElevator", "Press ^3[{+activate}]^7 to go " + level.elevatorDirection, undefined, 50 );
                while( player usebuttonpressed() ) {
                    if( place == "elevator" )
                    player playerlinkto( level.center );
                    player clearLowerMessage( "ControlElevator" );
                    if( level.elevatorDirection == "up" ) {
                        level.center moveto( level.center.origin + ( 0, 0, ( 55 * 100 ) + 27.5 / 2 ), 5, 3, 2 );
                        level.elevatorDirection = "down";
                    }
                    else {
                        level.center2 unlink();
                        foreach( platform in level.elevatorPlatform )
                        platform linkto( level.center2 );
                        level.center2 moveto( level.center2.origin - ( 0, 112, 0 ), 3 );
                        wait 3.1;
                        level.center2 linkto( level.center );
                        level.center moveto( level.center.origin - ( 0, 0, ( 55 * 100 ) + 27.5 / 2 ), 5, 3, 2 );
                        level.elevatorDirection = "up";
                    }
                    wait 5.5;
                    if( place == "elevator" )
                    player unlink();
                    if( level.elevatorDirection == "down" ) {
                        level.center2 unlink();
                        foreach( platform in level.elevatorPlatform )
                        platform linkto( level.center2 );
                        level.center2 moveto( level.center2.origin + ( 0, 112, 0 ), 3 );
                        wait 3.5;
                    }
                }
            }
            if( place == "elevator" && distance( level.elevatorcontrol[ 1 ].origin, player.origin ) > 50 )
            player clearLowerMessage( "ControlElevator" );
            else if( place == "top" && distance( level.elevatorcontrol[ 3 ].origin, player.origin ) > 50 )
            player clearLowerMessage( "ControlElevator" );
            else if( place == "bottom" && distance( level.elevatorcontrol[ 4 ].origin, player.origin ) > 50 )
            player clearLowerMessage( "ControlElevator" );
        }
        wait 0.05;
    }
}

sky_base_computers_2() {
    for(;;) {
        foreach( player in level.players ) {
            if( distance( self.origin, player.origin ) < 50 ) {
                if( self.type == "left" || self.type == "right" ) {
                    if( self.type == "left" ) {
                        if( level.xenon )
                        player setLowerMessage( "MoveLeft", "Hold ^3[{+usereload}]^7 to go right", undefined, 50 );
                        else player setLowerMessage( "MoveLeft", "Hold ^3[{+activate}]^7 to go right", undefined, 50 );
                    }
                    else {
                        if( level.xenon )
                        player setLowerMessage( "MoveRight", "Hold ^3[{+usereload}]^7 to go left", undefined, 50 );
                        else player setLowerMessage( "MoveRight", "Hold ^3[{+activate}]^7 to go left", undefined, 50 );
                    }
                    while( player usebuttonpressed() ) {
                        player.fakelink = spawn( "script_origin", player.origin );
                        player playerlinkto( player.fakelink );
                        player.fakelink linkto( self );
                        if( self.type == "left" )
                        level.BaseCenter rotateyaw( -2, 0.05 );
                        else level.BaseCenter rotateyaw( 2, 0.05 );
                        wait 0.05;
                        player unlink();
                        player.fakelink delete();
                    }
                }
                if( self.type == "forward" ) {
                    if( level.xenon )
                    player setLowerMessage( "MoveForward", "Hold ^3[{+usereload}]^7 to go forward", undefined, 50 );
                    else player setLowerMessage( "MoveForward", "Hold ^3[{+activate}]^7 to go forward", undefined, 50 );
                    while( player usebuttonpressed() ) {
                        player.fakelink = spawn( "script_origin", player.origin );
                        player playerlinkto( player.fakelink );
                        player.fakelink linkto( self );
                        vec = anglestoright( level.BaseCenter.angles );
                        center = BulletTrace( level.BaseCenter.origin, level.BaseCenter.origin + ( vec[ 0 ] * -100, vec[ 1 ] * -100, vec[ 2 ] * -100 ), 0, self )[ "position" ];
                        level.BaseCenter moveto( center, 0.05 );
                        wait 0.05;
                        player unlink();
                        player.fakelink delete();
                    }
                }
                if( self.type == "dock" || self.type == "forcedock" ) {
                    if( self.type == "dock" ) {
                        if( level.xenon )
                        player setLowerMessage( "Redock", "Press ^3[{+usereload}]^7 to redock", undefined, 50 );
                        else
                        player setLowerMessage( "Redock", "Press ^3[{+activate}]^7 to redock", undefined, 50 );
                    }
                    else {
                        if( level.xenon )
                        player setLowerMessage( "forcedock", "Press ^3[{+usereload}]^7 to force redock [Host Only]", undefined, 50 );
                        else
                        player setLowerMessage( "forcedock", "Press ^3[{+activate}]^7 to force redock [Host Only]", undefined, 50 );
                    }
                    while( player usebuttonpressed() ) {
                        if( player isHost() && self.type == "forcedock" ) {
                            speed = distance( level.BaseCenter.origin, level.BaseCenterOrigOrigin ) / 1000;
                            level.BaseCenter moveto( level.BaseCenterOrigOrigin, speed, speed * 0.8, speed * 0.2 );
                            level.BaseCenter rotateto( level.BaseCenterOrigAng, 3, 2, 1 );
                            wait 0.05;
                        }
                        else
                        if( self.type == "dock" ) {
                            player.fakelink = spawn( "script_origin", player.origin );
                            player playerlinkto( player.fakelink );
                            player.fakelink linkto( self );
                            speed = distance( level.BaseCenter.origin, level.BaseCenterOrigOrigin ) / 1000;
                            level.BaseCenter moveto( level.BaseCenterOrigOrigin, speed, speed * 0.8, speed * 0.2 );
                            level.BaseCenter rotateto( level.BaseCenterOrigAng, 3, 2, 1 );
                            while( level.BaseCenter.origin != level.BaseCenterOrigOrigin )
                            wait 0.05;
                            wait 0.05;
                            player unlink();
                            player.fakelink delete();
                        }
                        else
                        if( self.type == "forcedock" && !player ishost() )
                        player iprintlnbold( "^1You must be host" );
                        wait 0.05;
                    }
                }
                if( self.type == "up" || self.type == "down" ) {
                    if( self.type == "up" ) {
                        if( level.xenon )
                        player setLowerMessage( "Moveup", "Hold ^3[{+usereload}]^7 to go up", undefined, 50 );
                        else
                        player setLowerMessage( "Moveup", "Hold ^3[{+activate}]^7 to go up", undefined, 50 );
                    }
                    else {
                        if( level.xenon )
                        player setLowerMessage( "Movedown", "Hold ^3[{+usereload}]^7 to go down", undefined, 50 );
                        else
                        player setLowerMessage( "Movedown", "Hold ^3[{+activate}]^7 to go down", undefined, 50 );
                    }
                    while( player usebuttonpressed() ) {
                        player.fakelink = spawn( "script_origin", player.origin );
                        player playerlinkto( player.fakelink );
                        player.fakelink linkto( self );
                        if( self.type == "up" )
                        level.BaseCenter moveto( level.BaseCenter.origin + ( 0, 0, 10 ), 0.05 );
                        else
                        level.BaseCenter moveto( level.BaseCenter.origin - ( 0, 0, 10 ), 0.05 );
                        wait 0.05;
                        player unlink();
                        player.fakelink delete();
                    }
                }
                if( self.type == "destroy" ) {
                    self endon( "endNuke" );
                    if( level.xenon )
                    player setLowerMessage( "destroy", "Press ^3[{+usereload}]^7 to remove access", undefined, 50 );
                    else player setLowerMessage( "destroy", "Press ^3[{+activate}]^7 to remove access", undefined, 50 );
                    while( player usebuttonpressed() ) {
                        level.elevatorcontrol[ 2 ] setmodel( "com_plasticcase_enemy" );
                        level.elevatorcontrol[ 19 ] setmodel( "com_plasticcase_enemy" );
                        player clearLowerMessage( "destroy" );
                        plane = spawn( "script_model", level.center.origin + ( 30000, 0, 0 ) );
                        plane setmodel( "vehicle_av8b_harrier_jet_opfor_mp" );
                        plane.angles = ( 0, -180, 0 );
                        plane moveto( level.center.origin, 5 );
                        wait 5;
                        playfx( level._effect[ "emp_flash" ], plane.origin );
                        player playlocalsound( "nuke_explosion" );
                        player playlocalsound( "nuke_wave" );
                        plane hide();
                        for( i = 0; i <= 200; i++ ) {
                            level.lift[ i ] unlink();
                            level.lift[ i ] PhysicsLaunchServer( plane.origin, ( i *  - 10, 0, randomint( 1000 ) ) );
                        }
                        wait 4;
                        for( i=200;i <= level.lift.size; i++ ) {
                            level.lift[ i ] unlink();
                            level.lift[ i ] PhysicsLaunchServer( plane.origin, ( i *  - 5, i, 0 ) );
                        }
                        foreach( elevator in level.elevator ) {
                            elevator unlink();
                            elevator PhysicsLaunchServer( plane.origin, ( i *  - 10, 0, 1000 ) );
                        }
                        foreach( platform in level.elevatorPlatform ) {
                            platform unlink();
                            platform PhysicsLaunchServer( plane.origin, ( 1000, 1000, 1000 ) );
                        }
                        level.elevatorcontrol[ 0 ] unlink();
                        level.elevatorcontrol[ 1 ] unlink();
                        level.elevatorcontrol[ 4 ] unlink();
                        level.elevatorcontrol[ 17 ] unlink();
                        level.elevatorcontrol[ 18 ] unlink();
                        level.elevatorcontrol[ 0 ] PhysicsLaunchServer( plane.origin, ( 1000, 1000, 1000 ) );
                        level.elevatorcontrol[ 1 ] PhysicsLaunchServer( plane.origin, ( 1000, 1000, 1000 ) );
                        level.elevatorcontrol[ 4 ] PhysicsLaunchServer( plane.origin, ( 1000, 1000, 1000 ) );
                        level.elevatorcontrol[ 17 ] PhysicsLaunchServer( plane.origin, ( 1000, 1000, 1000 ) );
                        level.elevatorcontrol[ 18 ] PhysicsLaunchServer( plane.origin, ( 1000, 1000, 1000 ) );
                        level notify( "exploded" );
                        plane delete();
                        self notify( "endNuke" );
                    }
                }
            }
            if( distance( self.origin, player.origin ) > 50 ) {
                if( self.type == "left" )
                player clearLowerMessage( "MoveLeft" );
                else if( self.type == "right" )
                player clearLowerMessage( "MoveRight" );
                else if( self.type == "forward" )
                player clearLowerMessage( "MoveForward" );
                else if( self.type == "dock" )
                player clearLowerMessage( "Redock" );
                else if( self.type == "up" )
                player clearLowerMessage( "Moveup" );
                else if( self.type == "down" )
                player clearLowerMessage( "Movedown" );
                else if( self.type == "forcedock" )
                player clearLowerMessage( "forcedock" );
                else if( self.type == "destroy" )
                player clearLowerMessage( "destroy" );
            }
        }
        wait 0.05;
    }
}

tornado_verify() {
    self endon( "death" );

    if( !host_or_admin() )
        return;

    self thread tornado_options();
}

tornado_options() {
    if( !isDefined( level.TornadoBuilding ) && !isDefined( level.TornadoSpawned ) ) {
        if( !isDefined( level.TornadoBuilding ) ) {
            if( !isDefined( level.TornadoSpawned ) ) {
                level.TornadoBuilding = true;
                self iprintln( "^:Tornado spawned!" );
                self iprintln( "^1Activate tornado again to delete!" );
                self thread tornado_main();
            }
            else
            self iPrintln( "The Tornado Has Already Been Spawned" );
        }
        else
        self iPrintln( "The Tornado Is Currently Building" );
    }
    else {
        if( !isDefined( level.TornadoBuilding ) ) {
            if( isDefined( level.TornadoSpawned ) ) {
                if( !isDefined( level.TornadoNuked ) ) {
                    for( i = 0; i < level.TornadoParts.size; i++ )
                    level.TornadoParts[ i ] delete();

                    level.TornadoSpawned = undefined;
                    self iprintln( "^1Tornado destroyed!" );
                }
                else self iPrintln( "You Can't Delete The Tornado After It's Been Nuked" );
            }
            else self iPrintln( "The Tornado Hasn't Been Spawned Yet" );
        }
        else self iPrintln( "You Can't Delete The Tornado While It's Building" );
    }
}

tornado_destroy() {
    if( !isDefined( level.TornadoBuilding ) ) {
        if( isDefined( level.TornadoSpawned ) ) {
            if( !isDefined( level.TornadoNuked ) ) {
                level.TornadoNuked = true;
                for( i = 0; i < level.TornadoParts.size; i++ ) {
                    level.TornadoParts[ i ] Unlink();
                    wait 0.05;
                    level.TornadoParts[ i ] PhysicsLaunchServer( level.TornadoParts[ i ].origin, AnglesToForward( level.TornadoParts[ i ].angles ) * RandomIntRange( 1000, 5000 ) );
                    level.TornadoParts[ i ] thread delete_after( 5 );
                }
                wait 5;
                level.TornadoNuked = undefined;
                level.TornadoSpawned = undefined;
            }
            else self iPrintln( "You Can't Delete The Tornado After It's Been Nuked" );
        }
        else self iPrintln( "The Tornado Hasn't Been Spawned Yet" );
    }
    else self iPrintln( "You Can't Delete The Tornado While It's Building" );
}

tornado_main() {
    ents = GetEntArray( "script_model", "classname" );
    for( i = 0; i < ents.size; i++ )
    ents[ i ] thread tornado_ent_monitor();
    level.tornadoFX    =  loadfx( "fx/smoke/smoke_trail_black_heli" );
    level.TornadoParts = [];
    level.tornadoTime  = 0;
    level.TornadoParts[ 0 ] = spawn_script_model( self.origin, "tag_origin" );
    for( i=1; i<22; i++ ) {
        level.TornadoParts[ i ] = spawn_script_model( level.TornadoParts[ 0 ].origin + ( i * 5, i * 5, i * 25 ), "tag_origin" );
        level.TornadoParts[ i ] LinkTo( level.TornadoParts[ 0 ] );
    }
    level.TornadoParts[ 0 ] thread tornado_rotate( 360, 0.5 );
    foreach( player in level.players )
    player thread tornado_player_monitor();
    level.TornadoSpawned = true;
    level.TornadoBuilding = undefined;
    level.TornadoParts[ 0 ] thread tornado_move();
    level.TornadoParts[ 0 ] thread tornado_move_monitor( level.TornadoParts[ 0 ].origin );
    thread tornado_time_monitor();
    while( isDefined( level.TornadoSpawned ) ) {
        if( level.tornadoTime <= 650 )
        level.tornadoTime++;
        for( i = 1; i < level.TornadoParts.size; i++ )
        PlayFXOnTag( level.tornadoFX, level.TornadoParts[ i ], "tag_origin" );
        wait 0.05;
    }
}

tornado_move() {
    self endon( "disconnect" );
    self endon( "EndTornadoMovement" );

    while( isDefined( level.TornadoSpawned ) && !isDefined( level.TornadoNuked ) ) {
        RandomOrigin1 = RandomIntRange( -100, 100 );
        RandomOrigin2 = RandomIntRange( -100, 100 );
        self MoveTo( self.origin + ( RandomOrigin1, RandomOrigin2, 0 ), 0.5 );
        wait 0.5;
    }
}

tornado_move_monitor( DefOrg ) {
    self endon( "disconnect" );

    while( isDefined( level.TornadoSpawned ) && !isDefined( level.TornadoNuked ) ) {
        if( Distance( DefOrg, self.origin ) >= 750 ) {
            self notify( "EndTornadoMovement" );
            self MoveTo( DefOrg, 3 );
            wait 3;
            self thread tornado_move();
        }
        wait 0.05;
    }
}

tornado_time_monitor() {
    self endon( "disconnect" );

    while( isDefined( level.TornadoSpawned ) && !isDefined( level.TornadoNuked ) ) {
        if( level.tornadoTime >= 350 && level.tornadoTime < 650 )
        for( i = 1; i < level.TornadoParts.size; i++ )
        PlayFXOnTag( level._effect[ "smoke/smoke_trail_black_heli" ], level.TornadoParts[ i ], "tag_origin" );
        else
        if( level.tornadoTime >= 650 ) {
            level.tornadoFX = loadfx( "fx/smoke/smoke_trail_black_heli" );
            break;
        }
        wait 0.05;
    }
}

tornado_player_monitor() {
    self endon( "disconnect" );

    wait 1;
    while( isDefined( level.TornadoSpawned ) && !isDefined( level.TornadoNuked ) ) {
        if( Distance( level.TornadoParts[ 0 ].origin, self.origin ) <= 175 && !isDefined( level.TornadoIgnorePlayers ) ) {
            for( i = 1; i < level.TornadoParts.size; i++ ) {
                self PlayerLinkTo( level.TornadoParts[ i ], "tag_origin" );
                wait 0.05;
            }
            self Unlink();
            self SetVelocity( ( 450, 450, 850 ) );
        }
        wait 0.05;
    }
}

tornado_ent_monitor() {
    self endon( "disconnect" );

    wait 1;

    while( isDefined( level.TornadoSpawned ) && !isDefined( level.TornadoNuked ) ) {
        if( Distance( level.TornadoParts[ 0 ].origin, self.origin ) <= 175 && !isDefined( level.TornadoIgnoreEntities ) ) {
            for( i = 1; i < level.TornadoParts.size; i++ ) {
                self.origin = level.TornadoParts[ i ].origin;
                wait 0.05;
            }
            linker = spawn_script_model( self.origin, "tag_origin" );
            self LinkTo( linker );
            linker PhysicsLaunchServer( linker.origin, AnglesToForward( self.angles ) * 15000 );
            wait 9;
            linker delete();
        }
        wait 0.05;
    }
}

tornado_rotate( inc, time ) {
    self endon( "disconnect" );

    while( isDefined( self ) && !isDefined( level.TornadoNuked ) ) {
        self RotateYaw( inc, time );
        wait time;
    }
}

artillery_verify() {
    self endon( "death" );

    if( !host_or_admin() )
        return;

    self thread artillery_main();
}

artillery_main() {
    center = spawn( "script_origin", bullettrace( self gettagorigin( "j_head" ), self gettagorigin( "j_head" ) + anglestoforward( self getplayerangles() ) * 20000000, 0, self )[ "position" ] );
    org = center.origin;
    level.artillery = [];
    level.artillery[ 0 ] = artillery_crate( org + ( 41.25, 0, 0 ));
    level.artillery[ 1 ] = artillery_crate( org + ( 96.25, 0, 0 ));
    level.artillery[ 2 ] = artillery_crate( org + ( -41.25, 0, 0 ));
    level.artillery[ 3 ] = artillery_crate( org + ( -96.25, 0, 0 ));
    level.artillery[ 4 ] = artillery_crate( org + ( 0, 41.25, 0 ));
    level.artillery[ 5 ] = artillery_crate( org + ( 0, 96.25, 0 ));
    level.artillery[ 6 ] = artillery_crate( org + ( 0, -41.25, 0 ));
    level.artillery[ 7 ] = artillery_crate( org + ( 0, -96.25, 0 ));
    level.swivel = [];
    level.swivel[ 0 ] = artillery_crate( org - ( 0, 0, 14 ) );
    level.swivel[ 0 ].angles = ( 90, 0, 0 );
    level.swivel[ 1 ] = artillery_crate( org + ( 0, 0, 28 ) );
    level.swivel[ 2 ] = artillery_crate( org + ( 41.25, 0, 69 ) );
    level.swivel[ 2 ].angles = ( 90, 0, 0 );
    level.swivel[ 3 ] = artillery_crate( org + ( -41.25, 0, 69 ) );
    level.swivel[ 3 ].angles = ( -90, 0, 0 );
    level.swivel[ 4 ] = artillery_crate( org + ( -41.25, 0, 29 ) );
    level.swivel[ 4 ].angles = ( 0, 90, 0);
    level.swivel[ 5 ] = artillery_crate( org + ( 41.25, 0, 29 ) );
    level.swivel[ 5 ].angles = ( 0, -90, 0 );
    level.swivel[ 6 ] = artillery_crate( org + ( -41.25, 0, 110 ) );
    level.swivel[ 6 ].angles = ( 0, 90, 0 );
    level.swivel[ 7 ] = artillery_crate( org + ( 41.25, 0, 110 ) );
    level.swivel[ 7 ].angles = ( 0, -90, 0 );
    level.barrel = [];
    for( i = 0; i <= 6; i++ ) {
        level.barrel[i] = artillery_crate( org + ( 0, i * 55 - 110, 110 ) );
        level.barrel[i].angles = ( 0, 90, 0 );
    }
    level.barrel[7] = artillery_crate( org + ( 0, 0, 109.99 ) );
    for( i=4; i <= 7; i++ ) {
        level.artillery[i].angles = ( 0, 90, 0 );
        level.gunpos = spawn( "script_origin", org + ( 0, 245, 110 ) );
        level.gunpos.angles = ( 0, 90, 0 );
        level.pitch = spawn( "script_origin", org + ( 0, 0, 110 ) );
    }
    foreach( barrel in level.barrel ) {
        barrel linkto( level.pitch );
        level.gunpos linkto( level.pitch );
        level.turn = spawn( "script_origin", org );
    }
    foreach( swivel in level.swivel ) {
        swivel linkto( level.turn );
    }
    level.turn linkto( level.pitch );
    level.computer = artillery_crate( org + ( -165, -165, 14 ) );
    level.computer.angles = ( 0, -45, 0 );
    level.pc = spawn( "script_model", level.computer.origin + ( 0, 0, 14 ) );
    level.pc setModel( "com_laptop_2_open" );
    level.pc.angles = ( 0, -135, 0 );
    level.pctrig = spawn( "trigger_radius", level.computer.origin, 0, 70, 70 );
    level.pctrig thread artillery_pc();
}

artillery_pc() {
    player = "fsf";
    use = "[{+activate}]";
    for(;;) {
        player clearlowermessage( "artillery" );
        pressed = 0;
        self waittill( "trigger", player );
        player setlowermessage( "artillery", "Push ^3[{+frag}]^7 or ^3[{+smoke}]^7 to change pitch\nPush ^3" + use + "^7 or ^3[{+melee}]^7 to turn\n Push ^3[{+attack}]^7 or ^3[{+speed_throw}]^7 to ^1FIRE" );
        if( !pressed )
        while( player fragbuttonpressed() ) {
            pressed = 1;
            level.turn unlink();
            if( level.pitch.angles[ 2 ] <= 37.5 )
            level.pitch rotateto( level.pitch.angles + ( 0, 0, 2 ), 0.2 );
            wait 0.2;
        }
        if( !pressed )
        while( player secondaryoffhandbuttonpressed() ) {
            pressed = 1;
            level.turn unlink();
            if( level.pitch.angles[ 2 ] >= -22 )
            level.pitch rotateto( level.pitch.angles - ( 0, 0, 2 ), 0.2 );
            wait 0.2;
        }
        if( !pressed )
        while( player meleebuttonpressed() ) {
            pressed = 1;
            level.pitch rotateto( level.pitch.angles - ( 0, 2, 0 ), 0.2 );
            wait 0.2;
        }
        if( !pressed )
        while( player usebuttonpressed() ) {
            pressed = 1;
            level.pitch rotateto( level.pitch.angles + ( 0, 2, 0 ), 0.2 );
            wait 0.2;
        }
        if( !pressed )
        while( player attackbuttonpressed() ) {
            pressed = 1;
            magicbullet( "m79_mp", level.gunpos.origin, level.gunpos.origin + anglestoforward( level.gunpos.angles ) * 10000 );
            wait 0.5;
        }
        if( !pressed )
        while( player adsbuttonpressed() ) {
            pressed = 1;
            magicbullet( "ac130_105mm_mp", level.gunpos.origin, level.gunpos.origin + anglestoforward( level.gunpos.angles ) * 10000 );
            earthquake( 0.5, 0.75, level.turn.origin, 800 );
            player playSound( "exp_airstrike_bomb" );
            playfx( level.chopper_fx[ "explode" ][ "medium" ], level.gunpos.origin );
            for( i = 0; i <= 6; i++ ) {
                level.barrel[ i ] unlink();
                level.barrel[ i ] moveto( level.barrel[ i ].origin - anglestoforward( level.barrel[ i ].angles ) * 50, 0.05 );
            }
            wait 0.1;
            for( i = 0; i <= 6; i++ )
            level.barrel[ i ] moveto( level.barrel[ i ].origin - anglestoforward( level.barrel[ i ].angles ) * - 50, 0.5, 0.4, 0.1 );
            wait 2;
        }
        foreach( swivel in level.swivel )
        swivel linkto( level.turn );
        level.turn linkto( level.pitch );
        foreach( barrel in level.barrel )
        barrel linkto( level.pitch );
        wait 0.05;
    }
}

artillery_crate( location ) {
    box = spawn( "script_model", location );
    box setModel( "com_plasticcase_enemy" );
    box CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
    return box;
}

trampoline() {
    self endon( "disconnect" );

    if( !host_or_admin() )
        return;

    self iprintln( "Press ^2[{+attack}]^7 to Spawn a Trampoline" );
    self waittill( "weapon_fired" );
    start = self gettagorigin( "tag_eye" );
    end = anglestoforward( self getPlayerAngles() ) * 1000000;
    spawnPosition = BulletTrace( start, end, true, self )[ "position" ];
    level.tramp = spawn( "script_model", spawnPosition );
    level.tramp setModel( "com_plasticcase_enemy" );
    for(;;) {
        if( distance( self.origin, level.tramp.origin ) <= 100 )
        self setVelocity( self getVelocity() + ( 0, 0, 400 ) );
        wait 0.1;
    }
}

ferris_destroy() {
    if( !host_or_admin() )
        return;

    if( isDefined( level.Ferris_Wheel ) ) {
        level.ferrisTrig delete();
        level.FerrisAttach delete();
        level.FerrisLink delete();
        self thread physics_array( level.FerrisLegs );
        self thread physics_array( level.FerrisSeats );
        self thread physics_array( level.Ferris );
        level.Ferris_Wheel = undefined;
        level notify( "Destroy_Ferris" );
    }
    else {
        self iprintln( "Ferris Wheel Has Not Been Spawned." );
    }
}

ferris_verify() {
    if( !host_or_admin() )
        return;

    self thread ferris_spawn();
}

ferris_spawn() {
    level endon( "Destroy_Ferris" );

    level.ferrisOrg = self.origin;
    level.speed = 0;
    level.FerrisLegs = [];
    level.FerrisSeats = [];
    level.Ferris = [];
    level.Ferris_Wheel = true;
    level.FerrisAttach = model_spawner( level.ferrisOrg + ( 0, 0, 420 ), "tag_origin" );
    level.FerrisLink = model_spawner( level.ferrisOrg + ( 0, 0, 60 ), "tag_origin" );
    for( a = 0; a < 2; a++ ) for( e = 0; e < 30; e++ )
    level.Ferris[ level.Ferris.size ] = model_spawner( level.ferrisOrg + ( -50 + a * 100, 0, 420 ) + ( 0, sin( e * 12 ) * 330, cos( e * 12 ) * 330 ), "com_plasticcase_friendly", ( 0, 0, e *  - 12 ), 0.1 );
    for( a = 0; a < 2; a++ ) for( b = 0; b < 5; b++ ) for( e = 0; e < 15; e++ )
    level.Ferris[ level.Ferris.size ] = model_spawner( level.ferrisOrg + ( -50 + a * 100, 0, 420 ) + ( 0, sin( e * 24 ) * 40 + b * 65, cos( e * 24 ) * 40 + b * 65 ), "com_plasticcase_friendly", ( 0, 0, ( e *  - 24 ) - 90 ), 0.1 );
    for( e = 0; e < 15; e++ )
    level.FerrisSeats[ level.FerrisSeats.size ] = model_spawner( level.ferrisOrg + ( 0, 0, 420 ) + ( 0, sin( e * 24 ) * 330, cos( e * 24 ) * 330 ), "com_plasticcase_enemy", ( e * 24, 90, 0 ), 0.1 );
    for( e = 0; e < 3; e++ )
    level.FerrisLegs[ level.FerrisLegs.size ] = model_spawner( level.ferrisOrg + ( 82 - e * 82, 0, 420 ), "com_plasticcase_friendly", ( 0, 90, 0 ), 0.1 );
    for( e = 0; e < 2; e++ ) for( a = 0; a < 8; a++ )
    level.FerrisLegs[ level.FerrisLegs.size ] = model_spawner( level.ferrisOrg + ( -100 + e * 200, -220, 0 ) + ( 0, a * 28, a * 60 ), "com_plasticcase_friendly", ( 0, 0, 65 ), 0.1 );
    for( e = 0; e < 2; e++ ) for( a = 0; a < 8; a++ )
    level.FerrisLegs[ level.FerrisLegs.size ] = model_spawner( level.ferrisOrg + ( -100 + e * 200, 220, 0 ) + ( 0, a *  - 28, a * 60 ), "com_plasticcase_friendly", ( 0, 0, -65 ), 0.1 );
    foreach( model in level.Ferris )
    model linkTo( level.FerrisAttach );
    foreach( model in level.FerrisSeats )
    model linkTo( level.FerrisAttach );
    iprintln( "^:Press [{+activate}] on red crate to ride" );
    iprintln( "^:Press [{+frag}] to exit ride" );
    level.FerrisAttach thread ferris_rotate_speed( 1 );
    level.FerrisLink ferris_riders_check( level.FerrisSeats );
}

ferris_rotate_speed( speed ) {
    self thread ferris_rotate( speed );
}

ferris_reset() {
    level.speed = 0;
    self thread ferris_rotate( 1 );
}

ferris_rotate( speed ) {
    level endon( "Destroy_Ferris" );
    level.speed += speed;
    if( level.speed >= 15 )
    level.speed = 15;
    if( level.speed <= -15 )
    level.speed = -15;
    while( true ) {
        for( a = 0; a < 360;a+=level.speed ) {
            self rotateTo( ( 0, self.angles[ 1 ], a ), 0.2 );
            wait 0.05;
        }
        for( a = 360; a < 0;a-=level.speed ) {
            self rotateTo( ( 0, self.angles[ 1 ], a ), 0.2 );
            wait 0.05;
        }
        wait 0.05;
    }
}

ferris_riders_check( array ) {
    level endon( "Destroy_Ferris" );

    level.ferrisTrig = spawn_trig( self.origin, 250, 40, "HINT_NOICON", "Press &&1 to Enter / Exit The Ferris Wheel!" );
    while( isDefined( self ) ) {
        level.ferrisTrig waittill( "trigger", i );
        if( !isDefined( i.riding ) && isPlayer( i ) && i useButtonPressed() ) {
            Closest = getClosest( i.origin, Array );
            Seat = model_spawner( Closest.origin - anglesToRight( self.angles ) * 22, "script_origin", ( 0, 90, 0 ) );
            Seat thread ferris_seat_fix( Closest );
            if( !isDefined( closest.FerrisOccupied ) ) {
                i setStance( "crouch" );
                i.ridingFerris = true;
                i PlayerLinkToDelta( Seat );
                i thread ferris_player_exit( Closest, Seat );
                Closest.FerrisOccupied = true;
            }
        }
    }
}

ferris_seat_fix( seat ) {
    while( true ) {
        for( a = 0; a < 360;a+=level.speed ) {
            self.angles = ( 0, 90, 0 );
            self MoveTo( seat.origin + ( 0, 0, 10 ), 0.1 );
            wait 0.05;
        }
        wait 0.05;
    }
}

ferris_player_exit( seat,tag ) {
    while( isDefined( level.Ferris_Wheel ) ) {
        if( self fragButtonPressed() ) break;
        wait 0.05;
    }
    tag unLink();
    tag delete();
    self.ridingFerris = undefined;
    Seat.FerrisOccupied = undefined;
    self unlink();
}

centrox_destroy() {
    if( !host_or_admin() )
        return;

    if( isDefined( level.Centrox_Ride ) ) {
        level.Movements delete();
        self thread physics_array( level.Centrox );
        self thread physics_array( level.Seats );
        self thread physics_array( level.Center );
        level.Centrox_Ride = undefined;
        level notify( "Stop_Centrox" );
    }
    else {
        self iprintln( "Centrox Has Not Been Spawned." );
    }
}

centrox_verify() {
    if( !host_or_admin() )
        return;

    self thread centrox_spawn();
}

centrox_spawn() {
    level endon( "Stop_Centrox" );

    level.Centrox = [];
    level.Seats = [];
    level.Center = [];
    level.Centrox_Ride = true;
    level.Movements = model_spawner( self.origin + ( 40, 0, 20 ), "tag_origin" );
    time = 0.1;
    for( e = 0; e < 2; e++ )
    for( i = 0; i < 6; i++ )
    level.Center[ level.Center.size ] = model_spawner( level.Movements.origin + ( cos( i * 60 ) * 20, sin( i * 60 ) * 20, e * 70 ), "com_plasticcase_friendly", ( 0, ( i * 60 ) + 90, 90 ), time ); //Center
    for( i = 0; i < 15; i++ )
    level.Centrox[ level.Centrox.size ] = model_spawner( level.Movements.origin + ( cos( i * 24 ) * 70, sin( i * 24 ) * 70, -20 ), "com_plasticcase_friendly", ( 0, ( i * 24 ) + 90, 0 ), time ); //floor inner
    for( i = 0; i < 25; i++ )
    level.Centrox[ level.Centrox.size ] = model_spawner( level.Movements.origin + ( cos( i * 14.4 ) * 140, sin( i * 14.4 ) * 140, -20 ), "com_plasticcase_friendly", ( 0, ( i * 14.4 ) + 90, 0 ), time ); //floor outer
    for( i = 0; i < 30; i++ )
    level.Centrox[ level.Centrox.size ] = model_spawner( level.Movements.origin + ( cos( i * 12 ) * 185, sin( i * 12 ) * 185, 30 ), "com_plasticcase_friendly", ( 0, ( i * 12 ) + 90, 90 ), time ); //Wall
    for( i = 0; i < 10; i++ )
    level.Centrox[ level.Centrox.size ] = model_spawner( level.Movements.origin + ( cos( i * 36 ) * 178, sin( i * 36 ) * 178, 30 ), "com_plasticcase_enemy", ( 0, ( i * 36 ) + 90, 90 ), time ); //Seats Visual
    for( i = 0; i < 10; i++ )
    level.Seats[ level.Seats.size ] = model_spawner( level.Movements.origin + ( 0, 0, -40 ) + ( cos( i * 36 ) * 165, sin( i * 36 ) * 165, 30 ), "com_plasticcase_enemy", ( 0, ( i * 36 ) + 180, 0 ) ); //Seats
    level.Centrox[ 68 ] MoveTo( level.Centrox[ 67 ].origin, 0.3 ); //Doors Open
    level.Centrox[ 69 ] MoveTo( level.Centrox[ 40 ].origin, 0.3 ); //Doors Open
    iprintln( "Press [{+activate}] on a red crate to ride!" );
    iprintln( "Takes a few seconds to start once seated!" );
    level.Movements thread centrox_player_monitor( level.Seats );
    wait 5;
    level.Movements thread centrox_monitor();
    level.Movements thread centrox_spin();
}

centrox_monitor() {
    level endon( "Stop_Centrox" );

    while( isDefined( self ) ) {
        wait 10;
        level.RideActive = true;
        level.Centrox[ 68 ] MoveTo( level.Centrox[ 67 ].origin + ( 13, 40, 0 ), 0.3 );
        level.Centrox[ 69 ] MoveTo( level.Centrox[ 40 ].origin + ( -13, -40, 0 ), 0.3 );
        wait 3;
        foreach( model in level.Centrox )
        model LinkTo( level.Movements );
        foreach( model in level.Seats )
        model LinkTo( level.Movements );
        for( ext = 0; Ext < 22; Ext += 2 ) {
            self MoveTo( ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] + Ext ), 0.7 );
            wait 0.6;
        }
        wait 8;
        for( e = 0; e < 2; e++ ) {
            for( ext = 0; Ext < 40; Ext++ ) {
                self RotateRoll( Ext * 0.1, 0.7 );
                wait 0.1;
            }
            wait 5;
        }
        wait 8;
        for( e = 0; e < 2; e++ ) {
            for( ext = 0; Ext < 40; Ext++ ) {
                self RotateRoll( 0 - Ext * 0.1, 0.7 );
                wait 0.1;
            }
            wait 8;
        }
        level.RideActive = undefined;
        for( ext = 0; Ext < 22; Ext += 2 ) {
            self MoveTo( ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] - Ext ), 0.7 );
            wait 0.6;
        }
        foreach( model in level.Seats )
        model unlink();
        foreach( model in level.Centrox )
        model Unlink();
        wait 0.3;
        level.Centrox[ 68 ] MoveTo( level.Centrox[ 67 ].origin, 0.3 );
        level.Centrox[ 69 ] MoveTo( level.Centrox[ 40 ].origin, 0.3 );
        foreach( rider in level.players )
        rider unlink();
        for( e = 0; e < 10; e++ )
        level.seatTaken[ e ] = undefined;
        wait 0.05;
    }
}

centrox_spin() {
    level endon( "Stop_Centrox" );

    Speed = 0;
    for(;;) {
        while( isDefined( self ) && isDefined( level.RideActive ) ) {
            self RotateYaw( Speed * 0.4, 0.9 );
            Speed++;
            wait 0.1;
        }
        Speed = 0;
        wait 0.05;
    }
}

centrox_player_monitor( array ) {
    level endon( "Stop_Centrox" );

    level.CentroxTrig = spawn_trig( self.origin, 250, 40, "HINT_NOICON", "Press &&1 to Enter / Exit The Centrox!" );
    while( isDefined( self ) ) {
        level.CentroxTrig waittill( "trigger", i );
        if( i useButtonPressed() && !i.riding ) {
            closest = getClosest( i.origin, Array );
            if( !closest.occupied ) {
                i setStance( "stand" );
                i.ridingCentox = true;
                i PlayerLinkToAbsolute( closest );
                i thread centrox_player_exit( closest );
                closest.CentroxOccupied = true;
            }
        }
    }
}

centrox_player_exit( seat ) {
    level endon( "Stop_Centrox" );
    self endon( "death" );
    self endon( "disconnect" );

    wait 1.5;
    while( isDefined( seat ) ) {
        if( self useButtonPressed() && !isDefined( level.RideActive ) )
        break;
        wait 0.05;
    }
    seat.CentroxOccupied = undefined;
    self setStance( "stand" );
    self unlink();
    wait 1.5;
    self.ridingCentox = undefined;
}

twister_verify() {
    if( !host_or_admin() )
        return;

    self thread twister_build();
}

twister_build() {
    level.skyBaseIsBuilding = true;
    pos = self.origin + ( 0, 0, 15 );
    level.TwistSeatsAttach = [];
    level.TwistSeats = [];
    level.CenterLink = spawn_script_model( pos, "tag_origin" );
    level.CenterLink sky_base_array( true );
    model = "com_plasticcase_friendly";
    time = 0.05;
    level.bog = [];
    for( a = 0; a < 11; a++ )for( b = 0; b < 6; b++ )level.bog[ level.bog.size ] = spawn_script_model( pos + ( 0, 0, a * 27 ), model, ( 0, b * 51.43, 0 ), time );
    for( a = 0; a < 4; a++ )for( b = 0; b < 2; b++ )for( c =0; c < 3; c++ )level.bog[ level.bog.size ] = spawn_script_model( pos + ( sin( a * 90 ) * ( c * 57 + 50 ), cos( a * 90 ) * ( c * 57 + 50 ), 125 ), model, ( 0, 90 + a * 90 + b * 180, 0 ), time );
    for( a = 0; a < 4; a++ )for( b = 0; b < 2; b++ )for( c =0; c < 3; c++ )level.bog[ level.bog.size ] = spawn_script_model( pos + ( sin( a * 90 + 45 ) * ( c * 57 + 50 ), cos( a * 90 + 45 ) * ( c * 57 + 50 ), 270 ), model, ( 0, 45 + a * 90 + b * 180, 0 ), time );
    array_thread( level.bog, ::twister_array, level.CenterLink );
    level.rows = [];
    for( a = 0; a < 4; a++ )level.rows[ level.rows.size ] = spawn_script_model( pos + ( sin( a * 90 ) * ( 3 * 57 + 35 ), cos( a * 90 ) * ( 3 * 57 + 35 ), 111 ), model, ( 90, 90 + a * 90, 0 ), time );
    for( a = 0; a < 4; a++ )level.rows[ level.rows.size ] = spawn_script_model( pos + ( sin( a * 90 + 45 ) * ( 3 * 57 + 35 ), cos( a * 90 + 45 ) * ( 3 * 57 + 35 ), 256 ), model, ( 90, 45 + a * 90, 0 ), time );
    array_thread( level.rows, ::sky_base_array, true );
    level.ss = [];
    for( a = 0; a < 4; a++ )for( b = 0; b < 3; b += 2 )level.ss[ level.ss.size ] = spawn_script_model( level.rows[ a ].origin + ( 0, cos( b * 90 ) * ( 35 ), -50 ), model, ( 17 + b * 163, 90, 0 ), time );
    for( a = 0; a < 4; a++ )for( b = 1; b < 4; b += 2 )level.ss[ level.ss.size ] = spawn_script_model( level.rows[ a ].origin + ( sin( b * 90 ) * ( 35 ), 0, -50 ), model, ( 343 + ( b - 1 ) * -163, 180, 0 ), time );
    num = 0;
    count = 0;
    for( a = 0; a < level.ss.size; a++ ) {
        level.ss[ a ] thread twister_array( level.rows[ num ]);
        if( count == 1 ) {
            num++;
            count = -1;
        }
        if( num > 3 )num = 0;
        count++;
    }
    level.ss = [];
    for( a = 0; a < 4; a++ )for( b = 0; b < 3; b += 2 )level.ss[ level.ss.size ] = spawn_script_model( level.rows[ a + 4].origin + ( sin( b * 90 + 45 ) * ( 35 ), cos( b * 90 + 45 ) * ( 35 ), -50 ), model, ( 17 + b * 163, 45, 0 ), time );
    for( a = 0; a < 4; a++ )for( b = 1; b < 4; b += 2 )level.ss[ level.ss.size ] = spawn_script_model( level.rows[ a + 4].origin + ( sin( b * 90 + 45 ) * ( 35 ), cos( b * 90 + 45 ) * ( 35 ), -50 ), model, ( 343 + ( b - 1 ) * -163, 135, 0 ), time );
    num = 4;
    count = 0;
    for( a = 0; a < level.ss.size; a++ ) {
        level.ss[ a ] thread twister_array( level.rows[ num ]);
        if( count == 1 ) {
            num++;
            count = -1;
        }
        if( num>7 )num = 4;
        count++;
    }
    for( a = 0; a < 4; a++ ) {
        for( b = 0; b < 8; b++ ) {
            level.TwistSeats[ a ] = spawn_script_model( level.rows[ a ].origin + ( sin( b * 45 ) * ( 77 ), cos( b * 45 ) * ( 77 ), -58 ), model, ( 0, 315 * b, 0 ), time );
            level.TwistSeatsAttach[ level.TwistSeatsAttach.size ] = spawn_script_model( level.TwistSeats[ a ].origin + ( sin( b * 90 ) * ( 22 ), cos( b * 90 ) * ( 22 ), 0 ), "tag_origin", undefined, time );
            level.TwistSeats[ a ] thread twister_array( level.rows[ a ]);
            level.TwistSeatsAttach[ level.TwistSeatsAttach.size - 1] thread twister_array( level.rows[ a ], true );
        }
    }
    for( a = 0; a < 4; a++ ) {
        for( b = 0; b < 8; b++ ) {
            level.TwistSeats[ a+4] = spawn_script_model( level.rows[ a + 4].origin + ( sin( b * 45 ) * ( 77 ), cos( b * 45 ) * ( 77 ), -58 ), model, ( 0, 315 * b, 0 ), time );
            level.TwistSeatsAttach[ level.TwistSeatsAttach.size ] = spawn_script_model( level.TwistSeats[ a + 4].origin + ( sin( b * 90 + 45 ) * ( 22 ), cos( b * 90 + 45 ) * ( 22 ), 0 ), "tag_origin", undefined, time );
            level.TwistSeats[ a+4] thread twister_array( level.rows[ a + 4]);
            level.TwistSeatsAttach[ level.TwistSeatsAttach.size - 1] thread twister_array( level.rows[ a + 4], true );
        }
    }
    level.top = spawn_script_model( pos + ( 0, 0, 280 ), "test_sphere_silver", undefined, time );
    level.tag = spawn_script_model( level.top.origin, "tag_origin", undefined, time );
    level.top sky_base_array( true );
    level.tag sky_base_array( true );
    level.top thread twister_array( level.CenterLink );
    level.TwistSeatsAttach thread twister_check( pos, level.TwistSeatsAttach );
    for( a = 0; a < 4; a++ ) {
        level.rows[ a ] thread twister_orbit( pos, a * 90, 111 );
        level.rows[ a + 4 ] thread twister_orbit( pos, a * 90 + 45, 256 );
        level.rows[ a ] thread rotate_ent_yaw( -360, 3 );
        level.rows[ a + 4 ] thread rotate_ent_yaw( -360, 3 );
    }
    level.CenterLink thread rotate_ent_yaw( 360, 4 );
    level.notifyIcon = text_marker( undefined, level.top.origin, "The Twister", false, "RAIN" );
    level.notifyIcon setTargetEnt( level.tag );
    wait 0.05;
    level.skyBaseIsBuilding = undefined;
}

twister_array( link, bool ) {
    self sky_base_array( bool );
    self linkTo( link );
}

twister_check( area, Seat ) {
    level endon( "SKYBASE_FAIL" );

    triger = spawn_trigger( area, 80, 80, "HINT_NOICON", "" );
    triger sky_base_array( true );
    while( true ) {
        triger waittill( "trigger", i );
        if( !isDefined( i.riding ) && isPlayer( i ) && isDefined( i.SpawnableTrig ) )
            i.SpawnableTrig destroy();
        if( !isDefined( i.riding ) && isPlayer( i ) ) {
            row = randomIntRange( 0, 64 );
            if( !isDefined( seat[ row ].Occupied ) ) {
                i allowSprint( false );
                i setStance( "crouch" );
                i.riding = true;
                i PlayerLinkTo( Seat[ row ] );
                i.SpawnableTrig = i trigger_text( "Press [{+frag}] to Exit The Twister" );
                Seat[ row ].Occupied = true;
                i thread twister_exit( Seat[ row ], i );
            }
        }
        wait 0.05;
    }
}

twister_exit( seat, player ) {
    level endon( "SKYBASE_FAIL" );

    while( isDefined( seat ) ) {
        if( self fragButtonPressed() ) break;
        wait 0.05;
    }
    if( isDefined( player.SpawnableTrig ) )
        player.SpawnableTrig destroy();
    self allowSprint( true );
    self.riding = undefined;
    Seat.Occupied = undefined;
    self unlink();
    self setStance( "stand" );
}

twister_orbit( pos, int, z ) {
    level endon( "SKYBASE_FAIL" );

    while( true ) {
        for( a = int - 4.5; a < 370; a -= 9 ) {
            loc = ( pos + ( sin( a ) * 200, cos( a ) * 200, z ) );
            self moveTo( loc, 0.1 );
            wait 0.09;
        }
        wait 0.05;
    }
}

coaster_verify() {
    if( !host_or_admin() )
        return;

    self thread coaster_main();
}

coaster_main() {
    if( !isDefined( level.coaster ) && !isDefined( level.bigSpawn ) ) {
        level.bigSpawn = true;
        level.coaster = true;
        iprintln( "^1Won't finish building on larger maps! ( ent limit )" );
        iprintln( "^1Activate roller coaster again to delete!" );
        host_player() thread coaster_build();
    }
    if( isDefined( level.coaster ) && isDefined( level.bigSpawn ) ) {
        if( isDefined( level.skyBaseIsBuilding ) )
            return;
        level notify( "SKYBASE_DELETED" );
        level notify( "SKYBASE_FAIL" );
        self iprintln( "^1Roller Coaster destroyed!" );
        level thread sky_base_delete();
        level thread icon_delete();
        for( a = 0; a < get_players().size; a++ ) {
            player = get_players()[ a ];

            if( isDefined( player.riding ) ) {
                if( isDefined( player.SpawnableTrig ) )
                    player.SpawnableTrig destroy();
                player unLink();
                player allowSprint( true );
                player.riding = undefined;
            }
        }
        level.coaster = undefined;
        level.bigSpawn = undefined;
    }
}

coaster_build() {
    level endon( "Coaster_End" );

    level.skyBaseIsBuilding = true;
    level.Roller_Coaster = true;
    model = "test_sphere_silver";
    self iPrintln( "^:Press [{+activate}] on the platform to ride" );
    self iPrintln( "^:Press [{+frag}] to exit" );
    level.org = self.origin;
    level.rail = [];
    level.floor = [];
    level.seat = [];
    //DONE
    for( a = 0; a < 4; a++ )level.rail[ level.rail.size ] = spawn_script_model( level.org + ( -50, 22 - ( a * 44 ), 15 ), model, ( 0, 90, 0 ), 0.05 );
    for( a = 0; a < 17; a++ )level.rail[ level.rail.size ] = spawn_script_model( level.rail[ 3 ].origin + ( 0, sin( 184 + ( a * 4 ) ) * 625, cos( 184 + ( a * 4 ) ) * 625 + 624 ), model, ( 4 + ( a * 4 ), 90, 0 ), 0.05 );
    for( a = 1; a < 35; a++ )level.rail[ level.rail.size ] = spawn_script_model( level.rail[ 20 ].origin + ( 0, sin( 338 ) * ( a * 44 ), cos( 338 ) * ( a * 44 ) ), model, ( 68, 90, 0 ), 0.05 );
    for( a = 0; a < 17; a++ )level.rail[ level.rail.size ] = spawn_script_model( level.rail[ 54 ].origin + ( 0, sin( 64 - ( a * 4 ) ) * 625 - 579, cos( 64 - ( a * 4 ) ) * 625 - 235 ), "test_sphere_silver", ( level.rail[ level.rail.size - 1 ].angles[ 0 ] - 4, 90, 0 ), 0.05 );
    //CURRENT
    for( a = 0; a < 109; a++ )level.rail[ level.rail.size ] = spawn_script_model( level.rail[ 70 ].origin + ( sin( 90 + ( a * 5 ) ) * 491 - 491, cos( 90 + ( a * 5 ) ) * 491 - 87, cos( 90 - ( a * 1 ) ) * ( a * 2 ) + 1.5 ), model, ( level.rail[ level.rail.size - 1 ].angles[ 0 ] + 0.055, 90 - ( a * 5 ), 0 ), 0.05 );
    //NOT DONE
    for( a = 0; a < 10; a++ )level.rail[ level.rail.size ] = spawn_script_model( level.rail[ 180 ].origin + ( sin( 0 ) * ( a * 44 ), cos( 0 ) * ( a * 44 ) + 44, 0 ), model, ( 90, 90, 0 ), 0.05 );
    for( a = 0; a < 17; a++ )level.rail[ level.rail.size ] = spawn_script_model( level.rail[ 190 ].origin + ( 0, sin( 4 + ( a * 4 ) ) * 625, cos( 4 + a * 4 ) * 625 - 625 ), model, ( 86 - ( a * 4 ), 90, 0 ), 0.05 );
    for( a = 0; a < 25; a++ )level.rail[ level.rail.size ] = spawn_script_model( level.rail[ 207 ].origin + ( 0, sin( 158 ) * ( a * 44 ) + 16, cos( 158 ) * ( a * 44 ) - 40 ), model, ( 22, 90, 0 ), 0.05 );
    for( a = 0; a < 17; a++ )level.rail[ level.rail.size ] = spawn_script_model( level.rail[ 232 ].origin + ( 0, sin( 244 - ( a * 4 ) ) * 625 + 580, cos( 244 - ( a * 4 ) ) * 625 + 236 ), model, ( 26 + ( a * 4 ), 90, 0 ), 0.05 );
    for( a = 0; a < 91; a++ )level.rail[ level.rail.size ] = spawn_script_model( level.rail[ 249 ].origin + ( sin( 180 - ( a * 1 ) ) * ( a * 1 ), sin( 180 - ( a * 4 ) ) * 625 + 44, cos( 180 - ( a * 4 ) ) * 625 + 625 ), model, ( 90 + ( a * 4 ), -0.5 - ( a * 0.05 ), 0 ), 0.05 );
    for( a = 0; a < 15; a++ )level.rail[ level.rail.size ] = spawn_script_model( level.rail[ 340 ].origin + ( sin( 1 ) * ( a * 44 ), cos( 1 ) * ( a * 44 ) + 44, 0 ), model, ( 90, 90, 0 ), 0.05 );
    for( a = 0; a < 38; a++ )level.rail[ level.rail.size ] = spawn_script_model( level.rail[ 355 ].origin + ( sin( 270 + ( a * 5 ) ) * 491 + 491, cos( 270 + ( a * 5 ) ) * 491 + 44, 0 ), model, ( 90, -1 - ( a * 5 ), 0 ), 0.05 );
    for( a = 0; a < 5; a++ )level.rail[ level.rail.size ] = spawn_script_model( level.rail[ 393 ].origin + ( -3 * ( a + 1 ), sin( 184 + ( a * 4 ) ) * 621, cos( 184 + ( a * 4 ) ) * 621 + 621 ), model, ( 266 - ( a * 4 ), -4, 0 ), 0.05 );
    for( a = 0; a < level.rail.size; a++ )level.rail[ a ] sky_base_array();
    level.attacher = spawn_script_model( level.rail[ 0 ].origin, "test_sphere_redchrome" );
    level.attacher sky_base_array();
    for( a = 0; a < 4; a++ )level.floor[ level.floor.size ] = spawn_script_model( level.org + ( -50, 70 - a * 24, 35 ), "com_plasticcase_enemy", ( 0, 0, 180 ), 0.05 );
    for( a = 0; a < 2; a++ )level.floor[ level.floor.size ] = spawn_script_model( level.rail[ 0 ].origin + ( 45 - a * 90, 0, 20 ), "com_plasticcase_enemy", ( 0, 90 + a * 180, 90 ), 0.05 );
    for( a = 0; a < 2; a++ )level.floor[ level.floor.size ] = spawn_script_model( level.floor[ 3 ].origin + ( 0, sin( 20 ) * ( a * 24 ) - 24, cos( 20 ) * ( a * 24 ) ), "com_plasticcase_enemy", ( 0, 0, 70 ), 0.05 );
    for( a = 0; a < 2; a++ )level.floor[ level.floor.size ] = spawn_script_model( level.floor[ 3 ].origin + ( 0, -3, 5 ), "com_plasticcase_enemy", ( 90 + a * 180, 0, 0 ), 0.05 );
    level.back = spawn_script_model( level.floor[ 0 ].origin, "com_plasticcase_enemy", ( 0, 180, 180 ), 0.05 );
    level.back sky_base_array();
    for( a = 0; a < level.floor.size; a++ )level.floor[ a ] thread twister_array( level.attacher );
    for( a = 0; a < 2; a++ ) {
        level.seat[ a ] = spawn_script_model( level.org + ( -39 - a * 22, 18, 39 ), "script_origin", ( 0, 270, 0 ) );
        level.seat[ a ] twister_array( level.attacher );
    }
    level endon( "SKYBASE_FAIL" );
    level thread coaster_cart_monitor( level.seat, level.attacher );
    wait 0.05;
    level.skyBaseIsBuilding = undefined;
    level waittill( "Roller_Coaster_Countdown" );
    level coaster_countdown( level.seat );
    level.back rotateTo( ( 0, 180, 90 ), 0.5 );
    wait 0.5;
    level.back linkTo( level.attacher );
    while( true ) {
        for( a = 1; a < 4; a++ ) {
            level.attacher moveTo( level.rail[ a ].origin, 0.25 );
            earthquake( 0.1, 1, level.rail[ a ].origin, 150 );
            wait 0.2;
        }
        for( a = 4; a < 21; a++ ) {
            level.attacher moveTo( level.rail[ a ].origin, 0.25 );
            level.attacher rotateTo( ( 0, 0, -4 - ( a - 4 ) * 4 ), 0.25 );
            earthquake( 0.15, 0.5, level.rail[ a ].origin, 100 );
            wait 0.2;
        }
        for( a = 21; a < 55; a++ ) {
            level.attacher moveTo( level.rail[ a ].origin, 0.25 );
            earthquake( 0.15, 0.5, level.rail[ a ].origin, 100 );
            wait 0.2;
        }
        if( !isDefined( level.attacher.mode ) ) {
            level.attacher.mode = true;
            for( a = 250; a < 295; a++ ) {
                level.attacher moveTo( level.rail[ a ].origin, 0.08 );
                level.attacher rotateTo( ( 0 + ( a - 249 ) * 8, -180, 0 ), 0.08 );
                if( a > 252 && a <= 272 )level.attacher rotateTo( ( 0 + ( a - 250 ) * 8.21, -180, 0 + ( a - 253 ) * 4 ), 0.08 );
                if( a > 272 )level.attacher rotateTo( ( 180, -180, 76 + ( a - 273 ) * 4.727 ), 0.08 );
                earthquake( 0.2, 1, level.rail[ a ].origin, 150 );
                wait 0.05;
            }
            for( a = 295; a < 341; a++ ) {
                level.attacher moveTo( level.rail[ a ].origin, 0.08 );
                level.attacher rotateTo( ( 180 - ( a - 294 ) * 8, -180, 180 ), 0.08 );
                if( a > 297 && a <= 317 )level.attacher rotateTo( ( 180 - ( a - 295 ) * 8.21, -180, 180 - ( a - 298 ) * 4 ), 0.08 );
                if( a > 317 )level.attacher rotateTo( ( 0, -180, 104 - ( a - 318 ) * 4.727 ), 0.08 );
                earthquake( 0.2, 1, level.rail[ a ].origin, 150 );
                wait 0.05;
            }
        }
        else {
            level.attacher.mode = undefined;

            for( a = 250; a < 341; a++ ) {
                level.attacher moveTo( level.rail[ a ].origin, 0.08 );
                level.attacher rotateTo( ( 0, -180.5 - ( a - 250 ) * 0.05, 0 - ( a - 250 ) * 4 ), 0.08 );
                earthquake( 0.15, 1, level.rail[ a ].origin, 150 );
                wait 0.05;
            }
        }
        for( a = 341; a < 356; a++ ) {
            level.attacher moveTo( level.rail[ a ].origin, 0.08 );
            level.attacher rotateTo( ( 0, -180, 0 ), 0.08 );
            earthquake( 0.2, 0.5, level.rail[ a ].origin, 100 );
            wait 0.05;
        }
        for( a = 356; a < 394; a++ ) {
            level.attacher moveTo( level.rail[ a ].origin, 0.08 );
            level.attacher rotateTo( ( 0, -181 - ( a - 356 ) * 5, 0 ), 0.08 );
            earthquake( 0.15, 1, level.rail[ a ].origin, 150 );
            wait 0.05;
        }
        for( a = 394; a < 399; a++ ) {
            level.attacher moveTo( level.rail[ a ].origin, 0.08 );
            level.attacher rotateTo( ( 0, -4, -4 - ( a - 394 ) * 4 ), 0.08 );
            earthquake( 0.15, 1, level.rail[ a ].origin, 150 );
            wait 0.05;
        }
        level.attacher rotateTo( ( 0, 0, 0 ), 1 );
        for( a = 0; a < 19; a++ ) {
            level.attacher moveTo( level.rail[ 398 ].origin + ( -4.3 * ( a + 1 ), sin( -16.5 - a * 3.3 ) * 775 + 145, cos( -16.5 - a * 3.3 ) * 775 - 735 ), 0.11 );
            wait 0.06;
        }
        wait 0.05;
        level.attacher notify( "Catch_A_Ride" );
        earthquake( 0.8, 1.5, level.rail[ 0 ].origin, 200 );
        wait 0.05;
    }
}

coaster_cart_monitor( seat, tag ) {
    level endon( "SKYBASE_FAIL" );
    level endon( "Roller_Coaster_Started" );

    trig = spawn_trigger( tag.origin, 150, 150 );
    trig sky_base_array( true );
    level thread coaster_wait_start( trig, "Please Wait Until The Roller Coaster Passes to Catch a Ride!", seat, tag );
    while( true ) {
        for( a = 0; a < get_players().size; a++ ) {
            if( distance( tag.origin, get_players()[ a ].origin ) <= 150 ) {
                if( !get_players()[ a ].riding && isPlayer( get_players()[ a ] ) && !isDefined( get_players()[ a ].SpawnableTrig ) )get_players()[ a ].SpawnableTrig = get_players()[ a ] setLowerMessage( "Press [{+activate}] to Ride The Roller Coaster" );

                if( !get_players()[ a ].riding && isPlayer( get_players()[ a ]) && get_players()[ a ] useButtonPressed() ) {
                    X = randomInt( seat.size );
                    if( isDefined( get_players()[ a ].SpawnableTrig ) )get_players()[ a ].SpawnableTrig set_safe_text_1( "Press [{+frag}] to Exit" );
                    get_players()[ a ].riding = true;
                    get_players()[ a ] playerLinkToAbsolute( seat[ X ] );
                    get_players()[ a ] setStance( "stand" );
                    get_players()[ a ] thread coaster_exit( get_players()[ a ].riding, get_players()[ a ] );
                    level notify( "Roller_Coaster_Countdown" );
                }
            }
            else if( !get_players()[ a ].riding && isPlayer( get_players()[ a ] ) && isDefined( get_players()[ a ].SpawnableTrig ) && Distance( tag.origin, get_players()[ a ].origin ) > 150 )get_players()[ a ].SpawnableTrig destroy();
        }
        wait 0.05;
    }
}

coaster_wait_start( trig, text, seat, tag ) {
    level endon( "SKYBASE_FAIL" );
    level waittill( "Roller_Coaster_Countdown" );

    wait 10;
    level thread coaster_monitor( trig, text );
    if( isDefined( tag ) ) trig thread coaster_start_new( seat, tag );
}

coaster_monitor( trig,text ) {
    level endon( "SKYBASE_FAIL" );

    while( 1 ) {
        for( a = 0; a < get_players().size; a++ ) {
            if( distance( trig.origin, get_players()[ a ].origin ) <= 150 && isPlayer( get_players()[ a ]) && !get_players()[ a ].riding ) {
                if( isDefined( get_players()[ a ].SpawnableTrig ) )get_players()[ a ].SpawnableTrig set_safe_text_2( text );
                else get_players()[ a ].SpawnableTrig = get_players()[ a ] trigger_text( text );
            }
            else if( isDefined( get_players()[ a ].SpawnableTrig ) && !get_players()[ a ].riding )get_players()[ a ].SpawnableTrig destroy();
        }
        wait 0.05;
    }
}

coaster_exit( arg, player ) {
    level endon( "SKYBASE_FAIL" );

    while( isDefined( arg ) ) {
        if( self fragButtonPressed() )break;
        wait 0.05;
    }
    if( isDefined( player.SpawnableTrig ) )player.SpawnableTrig destroy();
    self.riding = undefined;
    self unlink();
    self setStance( "stand" );
}

coaster_countdown( seat ) {
    level endon( "SKYBASE_FAIL" );

    for( a = 3; a > 0; a-- ) {
        earthquake( 0.5, 1, seat[ 0 ].origin - ( 11, 0, 0 ), 100 );
        wait 1;
    }
    level notify( "Roller_Coaster_Started" );
}

coaster_start_new( seat, attacher ) {
    level endon( "SKYBASE_FAIL" );

    while( true ) {
        attacher waittill( "Catch_A_Ride" );
        self thread coaster_pickup_monitor( seat );
        wait 1.5;
        level notify( "Roller_Coaster_Pickup_Over" );
    }
}

coaster_pickup_monitor( seat ) {
    level endon( "SKYBASE_FAIL" );
    level endon( "Roller_Coaster_Pickup_Over" );

    while( 1 ) {
        for( a = 0; a < get_players().size; a++ ) {
            if( distance( self.origin, get_players()[ a ].origin ) <= 150 && !get_players()[ a ].riding && isPlayer( get_players()[ a ]) ) {
                X = randomInt( seat.size );
                get_players()[ a ].riding = true;
                get_players()[ a ] playerLinkToAbsolute( seat[ X ] );
                get_players()[ a ] setStance( "stand" );
                get_players()[ a ] thread coaster_exit( get_players()[ a ].riding );
                if( isDefined( get_players()[ a ].SpawnableTrig ) )get_players()[ a ].SpawnableTrig set_safe_text_2( "Press [{+frag}] to Exit" );
            }
        }
        wait 0.05;
    }
}

give_player_weapon( selected, weapon ) {
    if( !host_or_admin() )
        return;

    selected giveWeapon( weapon );
    selected switchToWeapon( weapon );
    self iprintln( "^:" + weapon + " ^2given to: " + "^7" + selected.name );
}

give_player_killstreak( selected, killstreak ) {
    if( !host_or_admin() )
        return;

    selected maps\mp\gametypes\_hardpoints::giveHardpoint( killstreak );
    self iprintln( "^:" + killstreak + " ^2given to: " + "^7" + selected.name );
}

give_player_perks( selected ) {
    if( !host_or_admin() )
        return;

    selected maps\mp\_utility::giveperk( "specialty_longersprint", false );
    selected maps\mp\_utility::giveperk( "specialty_fastmantle", false );
    selected maps\mp\_utility::giveperk( "specialty_fastreload", false );
    selected maps\mp\_utility::giveperk( "specialty_quickdraw", false );
    selected maps\mp\_utility::giveperk( "specialty_scavenger", false );
    selected maps\mp\_utility::giveperk( "specialty_extraammo", false );
    selected maps\mp\_utility::giveperk( "specialty_bling", false );
    selected maps\mp\_utility::giveperk( "specialty_secondarybling", false );
    selected maps\mp\_utility::giveperk( "specialty_onemanarmy", false );
    selected maps\mp\_utility::giveperk( "specialty_omaquickchange", false );
    selected maps\mp\_utility::giveperk( "specialty_bulletdamage", false );
    selected maps\mp\_utility::giveperk( "specialty_armorpiercing", false );
    selected maps\mp\_utility::giveperk( "specialty_lightweight", false );
    selected maps\mp\_utility::giveperk( "specialty_fastsprintrecovery", false );
    selected maps\mp\_utility::giveperk( "specialty_hardline", false );
    selected maps\mp\_utility::giveperk( "specialty_rollover", false );
    selected maps\mp\_utility::giveperk( "specialty_radarimmune", false );
    selected maps\mp\_utility::giveperk( "specialty_spygame", false );
    selected maps\mp\_utility::giveperk( "specialty_explosivedamage", false );
    selected maps\mp\_utility::giveperk( "specialty_dangerclose", false );
    selected maps\mp\_utility::giveperk( "specialty_extendedmelee", false );
    selected maps\mp\_utility::giveperk( "specialty_falldamage", false );
    selected maps\mp\_utility::giveperk( "specialty_bulletaccuracy", false );
    selected maps\mp\_utility::giveperk( "specialty_holdbreath", false );
    selected maps\mp\_utility::giveperk( "specialty_localjammer", false );
    selected maps\mp\_utility::giveperk( "specialty_delaymine", false );
    selected maps\mp\_utility::giveperk( "specialty_heartbreaker", false );
    selected maps\mp\_utility::giveperk( "specialty_quieter", false );
    selected maps\mp\_utility::giveperk( "specialty_detectexplosive", false );
    selected maps\mp\_utility::giveperk( "specialty_selectivehearing", false );
    selected maps\mp\_utility::giveperk( "specialty_pistoldeath", false );
    selected maps\mp\_utility::giveperk( "specialty_laststandoffhand", false );
    selected maps\mp\_utility::giveperk( "specialty_combathigh", false );
    selected maps\mp\_utility::giveperk( "specialty_shield", false );
    selected maps\mp\_utility::giveperk( "specialty_feigndeath", false );
    selected maps\mp\_utility::giveperk( "specialty_shellshock", false );
    selected maps\mp\_utility::giveperk( "specialty_blackbox", false );
    selected maps\mp\_utility::giveperk( "specialty_steelnerves", false );
    selected maps\mp\_utility::giveperk( "specialty_saboteur", false );
    selected maps\mp\_utility::giveperk( "specialty_endgame", false );
    selected maps\mp\_utility::giveperk( "specialty_rearview", false );
    selected maps\mp\_utility::giveperk( "specialty_primarydeath", false );
    selected maps\mp\_utility::giveperk( "specialty_hardjack", false );
    selected maps\mp\_utility::giveperk( "specialty_extraspecialduration", false );
    selected maps\mp\_utility::giveperk( "specialty_stun_resistance", false );
    selected maps\mp\_utility::giveperk( "specialty_double_load", false );
    selected maps\mp\_utility::giveperk( "specialty_regenspeed", false );
    selected maps\mp\_utility::giveperk( "specialty_autospot", false );
    selected maps\mp\_utility::giveperk( "specialty_twoprimaries", false );
    selected maps\mp\_utility::giveperk( "specialty_overkillpro", false );
    selected maps\mp\_utility::giveperk( "specialty_anytwo", false );
    selected maps\mp\_utility::giveperk( "specialty_fasterlockon", false );
    selected maps\mp\_utility::giveperk( "specialty_paint", false );
    selected maps\mp\_utility::giveperk( "specialty_paint_pro", false );
    selected maps\mp\_utility::giveperk( "specialty_silentkill", false );
    selected maps\mp\_utility::giveperk( "specialty_crouchmovement", false );
    selected maps\mp\_utility::giveperk( "specialty_personaluav", false );
    selected maps\mp\_utility::giveperk( "specialty_unwrapper", false );
    selected maps\mp\_utility::giveperk( "specialty_class_blindeye", false );
    selected maps\mp\_utility::giveperk( "specialty_class_lowprofile", false );
    selected maps\mp\_utility::giveperk( "specialty_class_coldblooded", false );
    selected maps\mp\_utility::giveperk( "specialty_class_hardwired", false );
    selected maps\mp\_utility::giveperk( "specialty_class_scavenger", false );
    selected maps\mp\_utility::giveperk( "specialty_class_hoarder", false );
    selected maps\mp\_utility::giveperk( "specialty_class_gungho", false );
    selected maps\mp\_utility::giveperk( "specialty_class_steadyhands", false );
    selected maps\mp\_utility::giveperk( "specialty_class_hardline", false );
    selected maps\mp\_utility::giveperk( "specialty_class_peripherals", false );
    selected maps\mp\_utility::giveperk( "specialty_class_quickdraw", false );
    selected maps\mp\_utility::giveperk( "specialty_class_lightweight", false );
    selected maps\mp\_utility::giveperk( "specialty_class_toughness", false );
    selected maps\mp\_utility::giveperk( "specialty_class_engineer", false );
    selected maps\mp\_utility::giveperk( "specialty_class_dangerclose", false );
    selected maps\mp\_utility::giveperk( "specialty_horde_weaponsfree", false );
    selected maps\mp\_utility::giveperk( "specialty_horde_dualprimary", false );
    selected maps\mp\_utility::giveperk( "specialty_marksman", false );
    selected maps\mp\_utility::giveperk( "specialty_sharp_focus", false );
    selected maps\mp\_utility::giveperk( "specialty_moredamage", false );
    selected maps\mp\_utility::giveperk( "specialty_copycat", false );
    selected maps\mp\_utility::giveperk( "specialty_finalstand", false );
    selected maps\mp\_utility::giveperk( "specialty_juiced", false );
    selected maps\mp\_utility::giveperk( "specialty_light_armor", false );
    selected maps\mp\_utility::giveperk( "specialty_stopping_power", false );
    selected maps\mp\_utility::giveperk( "specialty_uav", false );
    selected iPrintln( "^:All Perks Given" );
    self iPrintln( "^:All Perks Given To: " + "^7" + selected.name );
}

remove_player_perks( selected ) {
    if( !host_or_admin() )
        return;

    selected maps\mp\_utility::_unsetperk( "specialty_longersprint" );
    selected maps\mp\_utility::_unsetperk( "specialty_fastmantle" );
    selected maps\mp\_utility::_unsetperk( "specialty_fastreload" );
    selected maps\mp\_utility::_unsetperk( "specialty_quickdraw" );
    selected maps\mp\_utility::_unsetperk( "specialty_scavenger" );
    selected maps\mp\_utility::_unsetperk( "specialty_extraammo" );
    selected maps\mp\_utility::_unsetperk( "specialty_bling" );
    selected maps\mp\_utility::_unsetperk( "specialty_secondarybling" );
    selected maps\mp\_utility::_unsetperk( "specialty_onemanarmy" );
    selected maps\mp\_utility::_unsetperk( "specialty_omaquickchange" );
    selected maps\mp\_utility::_unsetperk( "specialty_bulletdamage" );
    selected maps\mp\_utility::_unsetperk( "specialty_armorpiercing" );
    selected maps\mp\_utility::_unsetperk( "specialty_lightweight" );
    selected maps\mp\_utility::_unsetperk( "specialty_fastsprintrecovery" );
    selected maps\mp\_utility::_unsetperk( "specialty_hardline" );
    selected maps\mp\_utility::_unsetperk( "specialty_rollover" );
    selected maps\mp\_utility::_unsetperk( "specialty_radarimmune" );
    selected maps\mp\_utility::_unsetperk( "specialty_spygame" );
    selected maps\mp\_utility::_unsetperk( "specialty_explosivedamage" );
    selected maps\mp\_utility::_unsetperk( "specialty_dangerclose" );
    selected maps\mp\_utility::_unsetperk( "specialty_extendedmelee" );
    selected maps\mp\_utility::_unsetperk( "specialty_falldamage" );
    selected maps\mp\_utility::_unsetperk( "specialty_bulletaccuracy" );
    selected maps\mp\_utility::_unsetperk( "specialty_holdbreath" );
    selected maps\mp\_utility::_unsetperk( "specialty_localjammer" );
    selected maps\mp\_utility::_unsetperk( "specialty_delaymine" );
    selected maps\mp\_utility::_unsetperk( "specialty_heartbreaker" );
    selected maps\mp\_utility::_unsetperk( "specialty_quieter" );
    selected maps\mp\_utility::_unsetperk( "specialty_detectexplosive" );
    selected maps\mp\_utility::_unsetperk( "specialty_selectivehearing" );
    selected maps\mp\_utility::_unsetperk( "specialty_pistoldeath" );
    selected maps\mp\_utility::_unsetperk( "specialty_laststandoffhand" );
    selected maps\mp\_utility::_unsetperk( "specialty_combathigh" );
    selected maps\mp\_utility::_unsetperk( "specialty_shield" );
    selected maps\mp\_utility::_unsetperk( "specialty_feigndeath" );
    selected maps\mp\_utility::_unsetperk( "specialty_shellshock" );
    selected maps\mp\_utility::_unsetperk( "specialty_blackbox" );
    selected maps\mp\_utility::_unsetperk( "specialty_steelnerves" );
    selected maps\mp\_utility::_unsetperk( "specialty_saboteur" );
    selected maps\mp\_utility::_unsetperk( "specialty_endgame" );
    selected maps\mp\_utility::_unsetperk( "specialty_rearview" );
    selected maps\mp\_utility::_unsetperk( "specialty_primarydeath" );
    selected maps\mp\_utility::_unsetperk( "specialty_hardjack" );
    selected maps\mp\_utility::_unsetperk( "specialty_extraspecialduration" );
    selected maps\mp\_utility::_unsetperk( "specialty_stun_resistance" );
    selected maps\mp\_utility::_unsetperk( "specialty_double_load" );
    selected maps\mp\_utility::_unsetperk( "specialty_regenspeed" );
    selected maps\mp\_utility::_unsetperk( "specialty_autospot" );
    selected maps\mp\_utility::_unsetperk( "specialty_twoprimaries" );
    selected maps\mp\_utility::_unsetperk( "specialty_overkillpro" );
    selected maps\mp\_utility::_unsetperk( "specialty_anytwo" );
    selected maps\mp\_utility::_unsetperk( "specialty_fasterlockon" );
    selected maps\mp\_utility::_unsetperk( "specialty_paint" );
    selected maps\mp\_utility::_unsetperk( "specialty_paint_pro" );
    selected maps\mp\_utility::_unsetperk( "specialty_silentkill" );
    selected maps\mp\_utility::_unsetperk( "specialty_crouchmovement" );
    selected maps\mp\_utility::_unsetperk( "specialty_personaluav" );
    selected maps\mp\_utility::_unsetperk( "specialty_unwrapper" );
    selected maps\mp\_utility::_unsetperk( "specialty_class_blindeye" );
    selected maps\mp\_utility::_unsetperk( "specialty_class_lowprofile" );
    selected maps\mp\_utility::_unsetperk( "specialty_class_coldblooded" );
    selected maps\mp\_utility::_unsetperk( "specialty_class_hardwired" );
    selected maps\mp\_utility::_unsetperk( "specialty_class_scavenger" );
    selected maps\mp\_utility::_unsetperk( "specialty_class_hoarder" );
    selected maps\mp\_utility::_unsetperk( "specialty_class_gungho" );
    selected maps\mp\_utility::_unsetperk( "specialty_class_steadyhands" );
    selected maps\mp\_utility::_unsetperk( "specialty_class_hardline" );
    selected maps\mp\_utility::_unsetperk( "specialty_class_peripherals" );
    selected maps\mp\_utility::_unsetperk( "specialty_class_quickdraw" );
    selected maps\mp\_utility::_unsetperk( "specialty_class_lightweight" );
    selected maps\mp\_utility::_unsetperk( "specialty_class_toughness" );
    selected maps\mp\_utility::_unsetperk( "specialty_class_engineer" );
    selected maps\mp\_utility::_unsetperk( "specialty_class_dangerclose" );
    selected maps\mp\_utility::_unsetperk( "specialty_horde_weaponsfree" );
    selected maps\mp\_utility::_unsetperk( "specialty_horde_dualprimary" );
    selected maps\mp\_utility::_unsetperk( "specialty_marksman" );
    selected maps\mp\_utility::_unsetperk( "specialty_sharp_focus" );
    selected maps\mp\_utility::_unsetperk( "specialty_moredamage" );
    selected maps\mp\_utility::_unsetperk( "specialty_copycat" );
    selected maps\mp\_utility::_unsetperk( "specialty_finalstand" );
    selected maps\mp\_utility::_unsetperk( "specialty_juiced" );
    selected maps\mp\_utility::_unsetperk( "specialty_light_armor" );
    selected maps\mp\_utility::_unsetperk( "specialty_stopping_power" );
    selected maps\mp\_utility::_unsetperk( "specialty_uav" );
    self iPrintln( "^:All Perks Removed For: " + "^7" + selected.name );
}

remove_player_weapons( selected ) {
    if( !host_or_admin() )
        return;

    selected takeAllWeapons();
}

freeze_player( selected ) {
    if( !host_or_admin() )
        return;

    selected freezeControls( true );
}

unfreeze_player( selected ) {
    if( !host_or_admin() )
        return;

    selected freezeControls( false );
}

teleport_player_self( selected ) {
    if( !host_or_admin() )
        return;

    selected setOrigin( self.origin );
    self iprintln( "^:Teleported: " + "^7" + selected.name );
}

teleport_player_crosshair( selected ) {
    if( !host_or_admin() )
        return;

    forwardTrace = self getEye() + ( anglestoforward( self getPlayerAngles() ) * 1000000 );
    traceResult = bulletTrace( self getEye(), forwardTrace, false, self );
    teleportPosition = traceResult[ "position" ];
    selected setOrigin( teleportPosition );
    self iprintln( "^:Teleported: " + "^7" + selected.name );
}

space_player( selected ) {
    if( !host_or_admin() )
        return;

    x = randomIntRange( -75, 75 );
    y = randomIntRange( -75, 75 );
    z = 45;
    space_location = ( 0 + x, 0 + y, 170000 + z );
    space_angle = ( 0, 176, 0 );
    selected setOrigin( space_location );
    selected setPlayerAngles( space_angle );
}

warn_player( selected ) {
    if( !host_or_admin() )
        return;

    selected iprintlnBold( "^1Stop That" );
    selected iprintln( "^1Stop That" );
    selected PlayLocalSound( "h2_nuke_timer" );
    self iprintln( selected.name + " was ^2Warned^7." );
}

kill_player( selected ) {
    if( !host_or_admin() )
        return;

    selected suicide();
}

kick_player( selected ) {
    if( !host_or_admin() )
        return;

    kick( selected );
}

admin_access( selected ) {
    if( !host_or_admin() )
        return;

    if( selected.access != "Host" ) {
        selected.has_access = true;
        selected.access = "Admin";
        selected iprintln( "^:Current Access: " + selected.access );
        selected suicide();
        self iprintln( "^:Admin Given To: " + "^7" + selected.name );
    }
    else {
        self iprintln( "^1Can't Change Host Access!" );
    }
}

menu_access( selected ) {
    if( !host_or_admin() )
        return;

    if( selected.access != "Host" ) {
        selected.has_access = true;
        selected.access = "Access";
        selected iprintln( "^:Current Access: " + selected.access );
        selected suicide();
        self iprintln( "^:Access Given For: " + "^7" + selected.name );
    }
    else {
        self iprintln( "^1Can't Change Host Access!" );
    }
}

remove_access( selected ) {
    if( !host_or_admin() )
        return;

    if( selected.access != "Host" ) {
        selected.has_access = false;
        selected.access = "None";
        selected close_menu();
        selected iprintln( "^1Menu Access Revoked" );
        selected suicide();
        self iprintln( "^1Menu Access Revoked For: "+ "^7" + selected.name );
    }
    else {
        self iprintln( "^1Can't Change Host Access!" );
    }
}

print_guid() {
    self iprintln( "^:GUID: ^7" + self.guid );
}

print_player_guid( selected ) {
    if( !host_or_admin() )
        return;

    self iprintln( "^:GUID: ^7" + selected.guid );
}

teleport_to_player( selected ) {
    if( !host_or_admin() )
        return;

    self SetOrigin( selected.origin );
}

tempban_iw4madmin( selected ) {
    if( !host_or_admin() )
        return;

    iPrintLn( selected.name + " Was ^1Temp Banned^7." );
    executeCommand( "say !tempban " + selected.name );
}

ban_iw4madmin( selected ) {
    if( !host_or_admin() )
        return;

    iPrintLn( selected.name + " Was ^1Banned^7." );
    executeCommand( "say !ban " + selected.name );
}

warn_iw4madmin( selected ) {
    if( !host_or_admin() )
        return;

    iPrintLn( selected.name + " Was ^3Warned^7." );
    executeCommand( "say !warn " + selected.name );
}

print_iw4madmin( command ) {
    if( !host_or_admin() )
        return;

    executeCommand( "say !" + command );
}

warnclear_iw4madmin( selected ) {
    if( !host_or_admin() )
        return;

    self iPrintLn( "^:Warnings ^2Cleared ^:For: " + "^7" + selected.name );
    executeCommand( "say !warnclear " + selected.name );
}

quit_iw4madmin( ) {
    if( !host_or_admin() )
        return;

    self iPrintLn( "^:IW4M Admin Quitting!" );
    executeCommand( "say !quit" );
}

resetac_iw4madmin( ) {
    if( !host_or_admin() )
        return;

    self iPrintLn( "^:IW4M Admin Anti Cheat Resetting!" );
    executeCommand( "say !resetanticheat" );
}

maprotate_iw4madmin( ) {
    if( !host_or_admin() )
        return;

    self iPrintLn( "^:IW4M Admin Rotating Map!" );
    executeCommand( "say !maprotate" );
}

fastrestart_iw4madmin( ) {
    if( !host_or_admin() )
        return;

    self iPrintLn( "^:IW4M Admin Fast Restarting!" );
    executeCommand( "say !fastrestart" );
}

restart_iw4madmin( ) {
    if( !host_or_admin() )
        return;

    self iPrintLn( "^:IW4M Admin Restarting!" );
    executeCommand( "say !restart" );
}

kill_aura_toggle() {
    if( !host_or_admin() )
        return;

    self.kill_aura_toggle = !( isdefined( self.kill_aura_toggle ) && self.kill_aura_toggle );

    if( level.kill_aura_toggle == false ) {
        level.kill_aura_toggle = true;
        level.kill_aura_toggle2 = true;
        self iPrintln( "^:Kill Aura: ^7[^2On^7]" );
        while( isdefined( level.kill_aura_toggle2 ) ) {
            foreach( player in level.players )
            if( isalive( player ) && player != self && distance( self.origin, player.origin ) <= 225 )
            player suicide();

            wait 0.05;
        }
    }
    else {
        level.kill_aura_toggle2 = undefined;
        level.kill_aura_toggle = false;
        self iPrintln( "^:Kill Aura: ^7[^1Off^7]" );
    }
}

allow_team_change() {
    if( !host_or_admin() )
        return;

    self.allow_team_change = !( isdefined( self.allow_team_change ) && self.allow_team_change );

    if( level.allow_team_change == false ) {
        self setclientomnvar( "ui_disable_team_change", 0 );
        level.allow_team_change = true;
        self iPrintln( "^:Allow Team Change: ^7[^2On^7]" );
    }
    else {
        self setclientomnvar( "ui_disable_team_change", 1 );
        level.allow_team_change = false;
        self iPrintln( "^:Allow Team Change: ^7[^1Off^7]" );
    }
}

constant_uav_toggle() {
    if( !host_or_admin() )
        return;

    self.constant_uav_toggle = !( isdefined( self.constant_uav_toggle ) && self.constant_uav_toggle );

    if( level.constant_uav_toggle == false ) {
        setdynamicdvar( "scr_game_forceuav", 1 );
        setdynamicdvar( "bg_compassShowEnemies", 1 );
        level.constant_uav_toggle = true;
        self iPrintln( "^:Constant UAV: ^7[^2On^7]" );
    }
    else {
        setdynamicdvar( "scr_game_forceuav", 0 );
        setdynamicdvar( "bg_compassShowEnemies", 0 );
        level.constant_uav_toggle = false;
        self iPrintln( "^:Constant UAV: ^7[^1Off^7]" );
    }
}

bounce_toggle() {
    if( !host_or_admin() )
        return;

    self.bounce_toggle = !( isdefined( self.bounce_toggle ) && self.bounce_toggle );

    if( level.bounce_toggle == false ) {
        setdynamicdvar( "pm_bouncing", 1 );
        setdynamicdvar( "pm_bouncingAllAngles", 1 );
        level.bounce_toggle = true;
        self iPrintln( "^:Bounces: ^7[^2On^7]" );
    }
    else {
        setdynamicdvar( "pm_bouncing", 0 );
        setdynamicdvar( "pm_bouncingAllAngles", 0 );
        level.bounce_toggle = false;
        self iPrintln( "^:Bounces: ^7[^1Off^7]" );
    }
}

collision_toggle() {
    if( !host_or_admin() )
        return;

    self.collision_toggle = !( isdefined( self.collision_toggle ) && self.collision_toggle );

    if( level.collision_toggle == false ) {
        setdvar( "g_playerCollision", 0 );
        setdvar( "g_playerEjection", 0 );
        level.collision_toggle = true;
        self iPrintln( "^:No Player Collision: ^7[^2On^7]" );
    }
    else {
        setdvar( "g_playerCollision", 1 );
        setdvar( "g_playerEjection", 1 );
        level.collision_toggle = false;
        self iPrintln( "^:No Player Collision: ^7[^1Off^7]" );
    }
}

switch_teams() {
    if( !host_or_admin() )
        return;

    self setclientomnvar( "ui_options_menu", 1 );
}

set_team_max( max_score ) {
    if( !host_or_admin() )
        return;

    setdynamicdvar( "scr_" + level.gametype + "_scoreLimit", max_score );
    self iprintln( "^:Score Limit Set: " + max_score );
}

set_time_limit( time_limit ) {
    if( !host_or_admin() )
        return;

    setdynamicdvar( "scr_" + level.gametype + "_timeLimit", time_limit );
    self iprintln( "^:Time Limit Set: " + time_limit );
}

change_map( selected_map ) {
    if( !host_or_admin() )
        return;

    map_lower = tolower( selected_map );
    say( "^:Map Changing: " + "^2" + selected_map );
    wait 1;
    executeCommand( "map mp_"+ map_lower );
    wait 300;
}

change_map_cr( selected_map ) {
    if( !host_or_admin() )
        return;

    map_lower = tolower( selected_map );
    say( "^:Map Changing: " + "^2" + selected_map );
    wait 1;
    executeCommand( "map "+ map_lower );
    wait 300;
}

infinite_equipment_toggle() {
    if( !host_or_admin() )
        return;

    self.infinite_equipment_toggle = !( isdefined( self.infinite_equipment_toggle ) && self.infinite_equipment_toggle );

    if( level.infinite_equipment_toggle == false ) {
        level.infinite_equipment_toggle2 = true;
        level.infinite_equipment_toggle = true;
        self iPrintln( "^:Infinite Equipment: ^7[^2On^7]" );
        while( isdefined( level.infinite_equipment_toggle2 ) ) {
            foreach( weapon in self getweaponslistall() ) {
                if( is_offhand( weapon ) && self getweaponammoclip( weapon ) != 1 )
                self setweaponammoclip( weapon, 1 );
                if( issubstr( weapon, "alt" ) && issubstr( weapon, "gl" ) && self getweaponammoclip( weapon ) != weaponmaxammo( weapon ) )
                self setweaponammoclip( weapon, weaponmaxammo( weapon ) );

                if( weapon == "h1_rpg_mp" && self getweaponammoclip( weapon ) != weaponmaxammo( weapon ) ) {
                    self setweaponammoclip( weapon, weaponclipsize( weapon ) );
                    self setweaponammostock( weapon, 4 );
                }
            }
            self waittill_any( "grenade_fire", "missile_fire" );
        }
    }
    else {
        level.infinite_equipment_toggle2 = undefined;
        level.infinite_equipment_toggle = false;
        self iPrintln( "^:Infinite Equipment: ^7[^1Off^7]" );
    }
}

all_voice_toggle() {
    if( !host_or_admin() )
        return;

    self.all_voice_toggle = !( isdefined( self.all_voice_toggle ) && self.all_voice_toggle );

    if( level.all_voice_toggle == false ) {
        setdvar( "sv_voice_all", 1 );
        setdvar( "cg_everyoneHearsEveryone", 1 );
        setdvar( "cg_deadHearTeamLiving", 1 );
        setdvar( "cg_deadHearAllLiving", 1 );
        level.all_voice_toggle = true;
        self iPrintln( "^:Global Voice Chat: ^7[^2On^7]" );
    }
    else {
        setdvar( "sv_voice_all", 0 );
        setdvar( "cg_everyoneHearsEveryone", 0 );
        setdvar( "cg_deadHearTeamLiving", 0 );
        setdvar( "cg_deadHearAllLiving", 0 );
        level.all_voice_toggle = false;
        self iPrintln( "^:Global Voice Chat: ^7[^1Off^7]" );
    }
}

view_pos_toggle() {
    if( !host_or_admin() )
        return;

    self.view_pos_toggle = !( isdefined( self.view_pos_toggle ) && self.view_pos_toggle );

    if( level.view_pos_toggle == false ) {
        setdvar( "cg_drawViewPos", 1 );
        level.view_pos_toggle = true;
        self iPrintln( "^:Viewmodel Position: ^7[^2On^7]" );
    }
    else {
        setdvar( "cg_drawViewPos", 0 );
        level.view_pos_toggle = false;
        self iPrintln( "^:Viewmodel Position: ^7[^1Off^7]" );
    }
}

fps_toggle() {
    if( !host_or_admin() )
        return;

    self.fps_toggle = !( isdefined( self.fps_toggle ) && self.fps_toggle );

    if( level.fps_toggle == false ) {
        setdvar( "cg_drawFPS", 1 );
        level.fps_toggle = true;
        self iPrintln( "^:FPS: ^7[^2On^7]" );
    }
    else {
        setdvar( "cg_drawFPS", 0 );
        level.fps_toggle = false;
        self iPrintln( "^:FPS: ^7[^1Off^7]" );
    }
}

ping_toggle() {
    if( !host_or_admin() )
        return;

    self.ping_toggle = !( isdefined( self.ping_toggle ) && self.ping_toggle );

    if( level.ping_toggle == false ) {
        setdvar( "cg_drawPing", 1 );
        level.ping_toggle = true;
        self iPrintln( "^:Ping: ^7[^2On^7]" );
    }
    else {
        setdvar( "cg_drawPing", 0 );
        level.ping_toggle = false;
        self iPrintln( "^:Ping: ^7[^1Off^7]" );
    }
}

elevator_toggle() {
    if( !host_or_admin() )
        return;

    self.elevator_toggle = !( isdefined( self.elevator_toggle ) && self.elevator_toggle );

    if( level.elevator_toggle == false ) {
        setdvar( "g_enableElevators", 1 );
        level.elevator_toggle = true;
        self iPrintln( "^:Elevators: ^7[^2On^7]" );
    }
    else {
        setdvar( "g_enableElevators", 0 );
        level.elevator_toggle = false;
        self iPrintln( "^:Elevators: ^7[^1Off^7]" );
    }
}

oldschool_toggle() {
    if( !host_or_admin() )
        return;

    self.oldschool_toggle = !( isdefined( self.oldschool_toggle ) && self.oldschool_toggle );

    if( level.oldschool_toggle == false ) {
        setdvar( "g_oldschool", 1 );
        level.oldschool_toggle = true;
        self iPrintln( "^:Old School Mode: ^7[^2On^7]" );
    }
    else {
        setdvar( "g_oldschool", 0 );
        level.oldschool_toggle = false;
        self iPrintln( "^:Old School Mode: ^7[^1Off^7]" );
    }
}

knockback_set( knockback_set ) {
    if( !host_or_admin() )
        return;

    setDvar( "g_knockback", knockback_set );
    self iPrintln( "^:Knockback set to: " + knockback_set );
}

raygun_give() {
    if( !host_or_admin() )
        return;

    self giveWeapon( level.raygun_weapon );
    self switchToWeapon( level.raygun_weapon );
    self thread raygun_main();
}

raygun_main() {
    for( ;; ) {
        self waittill( "weapon_fired", weaponName );
        if( self getCurrentWeapon() != level.raygun_weapon )
        continue;
        start = self getTagOrigin( "tag_eye" );
        end = self getTagOrigin( "tag_eye" ) + vec_scal( anglestoforward( self getPlayerAngles() ), 100000 );
        trace = bulletTrace( start, end, true, self );
        thread raygun_fx( self getTagOrigin( "tag_eye" ), anglestoforward( self getPlayerAngles() ), trace[ "position" ] );
    }
}

raygun_fx( startPos, direction, endPos ) {
    doDamage = 1;
    for( i = 1; ; i ++ ) {
        pos = startPos + vec_scal( direction, i * 150 );
        if( distance( startPos, pos ) > 9000 ) {
            doDamage = 0;
            break;
        }
        trace = bulletTrace( startPos, pos, true, self );
        if( !bulletTracePassed( startPos, pos, true, self ) ) {
            impactFX = spawnFX( level.raygun_fx[ "impact" ], bulletTrace( startPos, pos, true, self )[ "position" ] );
            level.fx_count++;
            triggerFX( impactFX );
            wait( 0.2 );
            impactFX delete();
            level.fx_count--;
            break;
        }
        laserFX = spawnFX( level.raygun_fx[ "raygun" ], pos );
        level.fx_count++;
        triggerFX( laserFX );
        laserFX thread delete_after_time( 0.1 );
        if( level.fx_count < 200 ) {
            for( j = 0; j < 3; j ++ ) {
                laserFX = spawnFX( level.large_metalhit_1, pos + ( randomInt( 50 ) / 10, randomInt( 50 ) / 10, randomInt( 50 ) / 10 ) - vec_scal( direction, i * randomInt( 10 ) * 3 ) );
                level.fx_count++;
                triggerFX( laserFX );
                laserFX thread delete_after_time( 0.05 + randomInt( 3 ) * 0.05 );
            }
        }
        wait( 0.05 );
    }
    if( doDamage )
        radiusDamage( endPos, 60, 150, 60, self );
}

variable_zoom_toggle() {
    if( !host_or_admin() )
        return;

    self.variable_zoom_toggle = !( isdefined( self.variable_zoom_toggle ) && self.variable_zoom_toggle );

    if( self.variable_zoom == false ) {
        self.variable_zoom = true;
        thread variable_zoom_main();
        self iPrintln( "^:Variable Zoom: ^7[^2On^7]" );
    }
    else {
        for( k = 0; k < 8; k++ )
        if( isDefined( self.zoomElem[ k ]) )
        self.zoomElem[ k ] destroy();
        self.variable_zoom = false;
        self iPrintln( "^:Variable Zoom: ^7[^1Off^7]" );
    }
}

variable_zoom_main() {
    self endon( "lobby_choose" );
    self endon( "disconnect" );

    dvar = [];
    curs = 1;
    elemNames = strTok( "1x;2x;4x;8x;16x;32x;64x", ";" );
    for( k = 0; k < 8; k++ )
    dvar[ 8 - k ] = int( k * 10 );
    while( self.variable_zoom ) {
        while( self adsButtonPressed() && self useButtonPressed() && self playerAds() ) {
            for( k = 0; k < 8; k++ ) {
                if( !isDefined( self.zoomElem[ k ] ) ) {
                    self.zoomElem[ k ] = create_text_2( "default", 1.4, "", "TOP", ( ( k * 40 ) - 120 ), 35, 1, 200, elemNames[ k ] );
                    if( k == curs - 1 )
                    self.zoomElem[ curs - 1 ].color = ( 1, 0, 0 );
                }
            }
            if( self useButtonPressed() ) {
                self playsound( "wpn_dryfire_lmg_plr" );
                self.zoomElem[ curs - 1 ].color = ( 1, 1, 1 );
                curs++;
                if( curs >= dvar.size )
                curs = 1;
                self.zoomElem[ curs - 1 ].color = ( 1, 0, 0 );
                wait 0.2;
            }
            setDvar( "cg_fovmin", int( dvar[ curs ] ) );
            wait 0.05;
        }
        for( k = 0; k < 8; k++ )
            self.zoomElem[ k ] destroy();
        wait 0.05;
    }
}

fireworks_toggle() {
    if( !host_or_admin() )
        return;

    self.fireworks_toggle = !( isdefined( self.fireworks_toggle ) && self.fireworks_toggle );

    if( level.fireworks_toggle == false ) {
        self thread fireworks_main();
        level.fireworks_toggle = true;
        self iPrintln( "^:Fireworks: ^7[^2On^7]" );
    }
    else {
        self notify( "stopfw" );
        level.fireworks_toggle = false;
        self iPrintln( "^:Fireworks: ^7[^1Off^7]" );
    }
}

fireworks_main() {
    self endon( "stopfw" );
    self endon( "disconnect" );

    for(;;) {
        Z = randomintrange( 4000, 8000 );
        X = randomintrange( 0, 5000 );
        Y = randomintrange( 0, 5000 );
        self thread fireworks_effect_1( X, Y, Z );
        wait 0.25;
        self thread fireworks_effect_2( X, Y, Z );
        wait 0.25;
        self thread fireworks_effect_3( X, Y, Z );
        wait 0.15;
        self playSound( "detpack_explo_main" );
    }
}

fireworks_effect_1( X, Y, Z ) {
    level.firework = loadfx( "vfx/explosion/mp_gametype_bomb" );
    Playfx( level.firework, self.origin + ( X, Y, Z ) );
}

fireworks_effect_2( X, Y, Z ) {
    level.expbullt = loadfx( "explosions/clusterbomb_exp" );
    Playfx( level.expbullt, self.origin + ( X, Y, Z ) );
}

fireworks_effect_3( X, Y, Z ) {
    level.flamez = loadfx( "explosions/javelin_explosion" );
    Playfx( level.flamez, self.origin + ( X, Y, Z ) );
}

rocket_nade() {
    if( !host_or_admin() )
        return;

    self iprintln( "^:Rocket Grenade Added!" );
    self setlethalweapon( "h1_fraggrenade_mp" );
    self SetWeaponAmmoClip( "h1_fraggrenade_mp", 1 );
    self waittill( "grenade_fire", grenade, weaponName );
    if( weaponName == "h1_fraggrenade_mp" ) {
        grenade hide();
        self.rocket_nade = spawn( "script_model", grenade.origin );
        self.rocket_nade setModel( "projectile_hellfire_missile" );
        self.rocket_nade linkTo( grenade );
        self.rocket_nade playSound( "h2_nuke_timer" );
        grenade waittill( "death" );
        self.glow = spawnfx( loadfx( "vfx/explosion/mp_gametype_bomb" ), self.rocket_nade.origin );
        TriggerFX( self.glow );
        radiusDamage( self.rocket_nade.origin, 550, 550, 550, self );
        self.rocket_nade delete();
        self switchToWeapon( self.oldWeapon );
    }
}

drunk_mode_toggle() {
    if( !host_or_admin() )
        return;

    self.drunk_mode_toggle = !( isdefined( self.drunk_mode_toggle ) && self.drunk_mode_toggle );

    if( level.drunk_mode_toggle == false ) {
        self.drunk = true;
        thread drunk_main();
        level.drunk_mode_toggle = true;
        self iPrintln( "^:Wasted Mode: ^7[^2On^7]" );
    }
    else {
        thread drunk_end();
        level.drunk_mode_toggle = false;
        self iPrintln( "^:Wasted Mode: ^7[^1Off^7]" );
        self notify( "endDrunk" );
        self notify( "sober" );
    }
}

drunk_main() {
    self endon( "endDrunk" );

    thread drunk_angles();
    thread drunk_effect();
    thread drunk_death();
    thread drunk_vision();
    thread drunk_flipping();
    self.drunkHud = create_rectangle( "", "", 0, 0, 1000, 720, get_color(), "white", 1, 0.2 );
    for(;;) {
        for( k = 0; k < 5; k += 0.2 ) {
            self setClientDvar( "r_blur", k );
            self.drunkHud fadeOverTime( 0.1 );
            self.drunkHud.color = get_color();
            wait 0.1;
        }
        for( k = 5; k > 0; k -= 0.2 ) {
            self setClientDvar( "r_blur", k );
            self.drunkHud fadeOverTime( 0.1 );
            self.drunkHud.color = get_color();
            wait 0.1;
        }
        wait 0.2;
    }
}

drunk_effect() {
    self endon( "endDrunk" );
    self allowJump( false );
    self allowSprint( false );
    self setMoveSpeedScale( 0.5 );

    for(;;) {
        for( k = 65; k < 80; k += 0.5 ) {
            self setClientDvar( "cg_fov", k );
            wait 0.05;
        }
        for( k = 80;k > 65;k-=.5 ) {
            self setClientDvar( "cg_fov", k );
            wait 0.05;
        }
        wait 0.05;
    }
}

drunk_angles() {
    self endon( "sober" );

    angleInUse = false;
    while( self.drunk ) {
        angles = self getPlayerAngles();
        if( !angleInUse ) {
            self setPlayerAngles( angles + ( 0.5, 0, 1 ) );
            if( angles[ 2 ] >= 25 )
            angleInUse = true;
        }
        if( angleInUse ) {
            self setPlayerAngles( angles - ( 0.5, 0, 1 ) );
            if( angles[ 2 ] <= -25 )
            angleInUse = false;
        }
        wait 0.05;
    }
}

drunk_vision() {
    self endon( "sober" );

    while( 1 ) {
        visionSetNaked( "cheat_invert", 4.2 );
        wait 0.1;
        VisionSetNaked( "cheat_invert_contrast", 0.2 );
        wait 0.1;
        VisionSetNaked( "sepia", 0.2 );
        wait 0.1;
        VisionSetNaked( "cargoship_blast", 0.2 );
        wait 0.1;
        VisionSetNaked( "cheat_chaplinnight", 0.2 );
        wait 0.1;
        VisionSetNaked( "bog_a_sunrise", 0.2 );
        wait 0.1;
        VisionSetNaked( "cheat_bw", 0.2 );
        wait 0.1;
        VisionSetNaked( "ac130", 0.2 );
        wait 0.1;
        VisionSetNaked( "cheat_bw_contrast", 0.2 );
        wait 0.1;
        VisionSetNaked( "cheat_contrast", 0.2 );
        wait 0.1;
        VisionSetNaked( "ac130_inverted", 0.2 );
        wait 0.1;
        VisionSetNaked( "mpoutro", 0.2 );
        wait 0.1;
        VisionSetNaked( "grayscale", 0.2 );
        wait 0.1;
        VisionSetNaked( "cheat_bw_invert_contrast", 3 );
    }
}

drunk_flipping() {
    self endon( "sober" );

    for(;;) {
        self.angle = self GetPlayerAngles();
        if( self.angle[ 1 ] < 179 )
        self setPlayerAngles( self.angle + ( 0, 0, 2 ) );
        else
        self SetPlayerAngles( self.angle * ( 1, -1, 1 ) );
        wait 0.05;
    }
}

drunk_death() {
    self waittill( "death" );
    thread drunk_end();
}

drunk_end() {
    if( self.drunk ) {
        self notify( "endDrunk" );
        self notify( "sober" );
        self.drunkHud destroy();
        self allowJump( true );
        self allowSprint( true );
        self setMoveSpeedScale( 1 );
        self setPlayerAngles( ( 0, self getPlayerAngles()[ 1 ], 0 ) );
        VisionSetNaked( getDvar( "mapname" ), 0.2 );
        self setClientDvar( "cg_fov", 90 );
        self.drunk = false;
    }
}

give_current_weapon( selected ) {
    if( !host_or_admin() )
        return;

    weapon = self getCurrentWeapon();
    selected giveWeapon( weapon );
    selected switchToWeapon( weapon );
    self iprintln( "^:" + weapon + " ^2given to: " + "^7" + selected.name );
}

forcefield_toggle() {
    if( !host_or_admin() )
        return;

    self.forcefield_toggle = !( isdefined( self.forcefield_toggle ) && self.forcefield_toggle );

    if( level.forcefield_toggle == false ) {
        self thread forcefield_monitor();
        level.forcefield_toggle = true;
        self iPrintln( "^:Force Field: ^7[^2On^7]" );
    }
    else {
        level.forcefield_toggle = false;
        self notify( "forceend" );
        self iPrintln( "^:Force Field: ^7[^1Off^7]" );
    }
}

forcefield_monitor() {
    self endon( "death" );
    self endon( "forceend" );

    while( 1 ) {
        foreach( p in level.players ) {
            if( distance( self.origin, p.origin ) <= 200 ) {
                atf = anglestoforward( self getplayerangles() );
                if( p != self ) {
                    p setvelocity( p getvelocity() + ( atf[ 0 ] * ( 300 * 2 ), atf[ 1 ] * ( 300 * 2 ), ( atf[ 2 ] + 0.25 ) * ( 300 * 2 ) ) );
                }
            }
        }
        wait 0.05;
    }
}

ladder_jump_toggle() {
    if( !host_or_admin() )
        return;

    self.ladder_jump_toggle = !( isdefined( self.ladder_jump_toggle ) && self.ladder_jump_toggle );

    if( level.ladder_jump_toggle == false ) {
        setdvar( "jump_ladderPushVel", 1024 );
        level.ladder_jump_toggle = true;
        self iPrintln( "^:Super Ladder Jump: ^7[^2On^7]" );
    }
    else {
        setdvar( "jump_ladderPushVel", 128 );
        level.ladder_jump_toggle = false;
        self iPrintln( "^:Super Ladder Jump: ^7[^1Off^7]" );
    }
}

bounce_create() {
    if( !host_or_admin() )
        return;

    if( level.bounce_amount >= level.bounce_limit ) {
        self thread bounce_delete();
    }
    level.BL[ level.bounce_amount ] = self.origin;
    level.bounce_amount++;
    self iPrintln( "^:Fake Bounce ^2Spawned!" );
    foreach( player in level.players )
        player notify( "BounceCreated" );
}

bounce_delete() {
    if( !host_or_admin() )
        return;

    for( i = 0; i < level.bounce_amount; i++ )
        level.BL[ i ] destroy();
    level.bounce_amount = 0;
    self iPrintln( "^:Fake Bounces ^1Deleted!" );
}

bounce_monitor() {
    self endon( "disconnect" );
    self waittill( "BounceCreated" );

    for(;;) {
        for( i = 0; i < level.bounce_amount; i++ ) {
            if( distance( self.origin, level.BL[ i ] ) < 85 ) {
                self setVelocity( self getVelocity() + ( 0, 0, 350 ) );
            }
            wait 0.05;
        }
        wait 0.05;
    }
}

inspect_glide() {
    if( !host_or_admin() )
        return;

    self.inspect_glide = !( isdefined( self.inspect_glide ) && self.inspect_glide );

    if( level.inspect_glide == false ) {
        setdvar( "g_glideOnInspect", 1 );
        level.inspect_glide = true;
        self iPrintln( "^:Glide On Inspect: ^7[^2On^7]" );
    }
    else {
        setdvar( "g_glideOnInspect", 0 );
        level.inspect_glide = false;
        self iPrintln( "^:Glide On Inspect: ^7[^1Off^7]" );
    }
}

legacy_nacs() {
    if( !host_or_admin() )
        return;

    self.legacy_nacs = !( isdefined( self.legacy_nacs ) && self.legacy_nacs );

    if( level.legacy_nacs == false ) {
        setdvar( "g_legacyNacs", 1 );
        level.legacy_nacs = true;
        self iPrintln( "^:Legacy Nacs: ^7[^2On^7]" );
    }
    else {
        setdvar( "g_legacyNacs", 0 );
        level.legacy_nacs = false;
        self iPrintln( "^:Legacy Nacs: ^7[^1Off^7]" );
    }
}

disable_streaks_toggle() {
    if( !host_or_admin() )
        return;

    self.disable_streaks_toggle = !( isdefined( self.disable_streaks_toggle ) && self.disable_streaks_toggle );

    if( level.disable_streaks_toggle == false ) {
        setdvar( "scr_game_hardpoints", 0 );
        level.disable_streaks_toggle = true;
        self iPrintln( "^:Killstreaks: ^7[^1Off^7]" );
    }
    else {
        setdvar( "scr_game_hardpoints", 1 );
        level.disable_streaks_toggle = false;
        self iPrintln( "^:Killstreaks: ^7[^2On^7]" );
    }
}

player_explosives_toggle() {
    if( !host_or_admin() )
        return;

    self.player_explosives_toggle = !( isdefined( self.player_explosives_toggle ) && self.player_explosives_toggle );

    if( level.player_explosives_toggle == false ) {
        setdvar( "scr_maxPerPlayerExplosives", 9999 );
        level.player_explosives_toggle = true;
        self iPrintln( "^:More Explosive Equipment: ^7[^2On^7] ^7(^1Requires Restart!^7 )" );
    }
    else {
        setdvar( "scr_maxPerPlayerExplosives", 2 );
        level.player_explosives_toggle = false;
        self iPrintln( "^:More Explosive Equipment: ^7[^1Off^7] ^7(^1Requires Restart!^7 )" );
    }
}

rain_model_toggle( model ) {
    if( !host_or_admin() )
        return;

    if( level.rain_model_toggle == false ) {
        self thread rain_model( model );
        level.rain_model_toggle = true;
        self iPrintln( "^:Model Rain: ^7[^2On^7]" );
    }
    else {
        self notify( "Stop_RM" );
        level.rain_model_toggle = false;
        self iPrintln( "^:Model Rain: ^7[^1Off^7]" );
    }
}

rain_model( model ) {
    self endon( "Stop_RM" );
    self endon( "gameStart" );

    lr = maps\mp\gametypes\_spawnlogic::findBoxCenter( level.spawnMins, level.spawnMaxs );
    lc = get_above_buildings( lr );
    for(;;) {
        Z = 2000;
        X = randomintrange( -3000, 3000 );
        Y = randomintrange( -3000, 3000 );
        l= lr + ( x, y, z );
        bomb = spawn( "script_model", l );
        bomb setModel( model );
        bomb.angles = bomb.angles + ( 90, 90, 90 );
        bomb moveto( bomb.origin - ( 0, 0, 2012 ), 5, 0 );
        bomb thread delete_after_time( 10 );
        wait 0.2;
    }
}

use_pred_missile() {
    if( !host_or_admin() )
        return;

    maps\mp\h2_killstreaks\_remotemissile::tryUsePredatorMissile( self.pers[ "killstreaks" ][ 0 ].lifeId );
}

exploding_crawler() {
    if( !host_or_admin() )
        return;

    self thread maps\mp\gametypes\_hud_message::hintMessage( "^:Press [{+actionslot 3}] For Exploding Crawler" );
    self notifyOnPlayerCommand( "AS1", "+actionslot 3" );
    self waittill( "AS1" );
    self thread exploding_crawler_main();
}

exploding_crawler_prone() {
    self endon( "death" );
    self endon( "disconnect" );

    while( 1 ) {
        self SetStance( "prone" );
        self SetMoveSpeedScale( 10 );
        wait 0.5;
    }
}

exploding_crawler_main() {
    self setModel( "body_infect" );
    self setviewmodel( "viewhands_infect" );
    self takeAllWeapons();
    self giveweapon( "h2_infect_mp" );
    self switchtoweapon( "h2_infect_mp" );
    //self attach( "weapon_c4_mp", "j_shouldertwist_le", false );
    self thread exploding_crawler_prone();
    self SetMoveSpeedScale( 10 );
    self maps\mp\_utility::giveperk( "specialty_class_coldblooded" );
    self maps\mp\_utility::giveperk( "specialty_thermal" );
    self setClientDvar( "friction", 0.5 );
    self setClientDvar( "g_gravity", 500 );
    self iPrintLnBold( "^:Press [[{+activate}]] to explode" );
    self notifyOnPlayerCommand( "AS3", "+activate" );

    self waittill( "AS3" ); {
        MagicBullet( "ac130_105mm_mp", self.origin + ( 0, 0, 1 ), self.origin, self );
        self suicide();
    }
    self notifyOnPlayerCommand( "AS3", "+activate" );
}

custom_minimap( material ) {
    if( !host_or_admin() )
        return;

    self.customMinimap = !( isdefined( self.customMinimap ) && self.customMinimap );

    if( level.customMinimap == false ) {
        maps\mp\_compass::setupminimap( material );
        level.customMinimap = true;
        self iPrintln( "^:Custom Minimap: ^7[^2On^7]" );
    }
    else {
        normal = getdvar( "mapname" );
        maps\mp\_compass::setupminimap( "compass_map_" + normal );
        level.customMinimap = false;
        self iPrintln( "^:Custom Minimap: ^7[^1Off^7]" );
    }
}

tracking_knife_toggle() {
    if( !host_or_admin() )
        return;

    self.tracking_knife_toggle = !( isdefined( self.tracking_knife_toggle ) && self.tracking_knife_toggle );

    if( level.tracking_knife_toggle == false ) {
        level.tracking_knife_toggle = true;
        self iPrintln( "^:Tracking Knife: ^7[^2On^7]" );
        self setlethalweapon( "iw9_throwknife_mp" );
        self setweaponammoclip( "iw9_throwknife_mp", 99 );
        self GiveMaxAmmo( "iw9_throwknife_mp" );
        Viable_Targets = [];
        enemy = self;
        time_to_target = 0;
        velocity = 500;
        while( level.tracking_knife_toggle ) {
            self waittill( "grenade_fire", grenade, weapname );
            if( !isDefined( level.tracking_knife_toggle ) )
            break;
            if( weapname == "iw9_throwknife_mp" ) {
                wait 0.25;
                enemy = undefined;
                minDistance = 9999999;
                foreach ( player in level.players ) {
                    if( player != self && ( !level.teambased || player.team != self.team ) ) {
                        distance = distance( grenade getOrigin(), player getOrigin() );
                        if( distance < minDistance ) {
                            minDistance = distance;
                            enemy = player;
                        }
                    }
                }
                if( enemy != undefined ) {
                    grenade thread track_player( enemy, self );
                }
            }
        }
    }
    else {
        level.tracking_knife_toggle = undefined;
        self iPrintln( "^:Tracking Knife: ^7[^1Off^7]" );
    }
}

track_player( enemy, host ) {
    attempts = 0;
    if( isDefined( enemy ) && enemy != host ) {
        while( !self isTouching( enemy ) && isDefined( self ) && isDefined( enemy ) && isAlive( enemy ) && attempts < 50 ) {
            self.origin += ( ( enemy getOrigin() + ( 0, 0, 50 ) ) - self getorigin() ) * ( attempts / 50 );
            wait 0.1;
            attempts++;
        }
        enemy dodamage( 9999, enemy getOrigin(), "MOD_GRENADE", "iw9_throwknife_mp" );
        wait 0.05;
        self delete();
    }
}

change_specular( int ) {
    if( !host_or_admin() )
        return;

    setdvar( "r_specularmap", int );
    self iprintln( "^:Specular Map Set" );
}

modded_lobby_toggle() {
    self endon( "disconnect" );

    if( !host_or_admin() )
        return;

    self.modded_lobby_toggle = !( isdefined( self.modded_lobby_toggle ) && self.modded_lobby_toggle );

    if( level.modded_lobby_toggle == false ) {
        setDvar( "g_gravity", 175 );
        setDvar( "jump_height", 1000 );
        setDvar( "g_speed", 800 );
        setDvar( "perk_weapSpreadMultiplier", 0.0001 );
        foreach( player in level.players ) {
            player give_sniper_perks();
        }
        level.modded_lobby_toggle = true;
        self iPrintln( "^:Modded Lobby: ^7[^2On^7]" );
    }
    else {
        setDvar( "g_gravity", 800 );
        setDvar( "jump_height", 41 );
        setDvar( "g_speed", 190 );
        setDvar( "perk_weapSpreadMultiplier", 0.65 );
        level.modded_lobby_toggle = false;
        self iPrintln( "^:Modded Lobby: ^7[^1Off^7]" );
    }
}

team_freeze( team ) {
    if( !host_or_admin() )
        return;

    self iprintln( "^:Controls Frozen For Team: ^7" + team );
    i = 0;
    while( i < level.players.size ) {
        if( i != 0 && level.players[ i ].pers[ "team" ] == team ) {
            if( !( level.players[ i ].froz ) && !( level.players[ i ] ishost() ) ) {
                level.players[ i ] freezecontrols( 1 );
                level.players[ i ].froz = 1;
            }
            else {
                level.players[ i ] freezecontrols( 0 );
                level.players[ i ].froz = 0;
            }
        }
        i++;
    }
}

team_kill( team ) {
    if( !host_or_admin() )
        return;

    self iprintln( "^:Killed Team: ^7" + team );
    foreach( player in level.players ) {
        if( player.team == team ) {
            if( !( player ishost() ) ) {
                player suicide();
            }
        }
    }
}

team_teleport_crosshair( team ) {
    if( !host_or_admin() )
        return;

    self iprintln( "^:Teleported to Crosshair: ^7" + team );
    foreach( p in level.players ) {
        if( isalive( p ) && p != self && p.team == team ) {
            p SetOrigin( BulletTrace( self getTagOrigin( "tag_eye" ), vector_multiply( anglestoforward( self getPlayerAngles() ), 1000000 ), 0, self )[ "position" ] );
        }
    }
}

team_take_weapons( team ) {
    if( !host_or_admin() )
        return;

    self iprintln( "^:Weapons Taken From: ^7" + team );
    foreach( player in level.players ) {
        if( !( player ishost() ) && player.team == team ) {
            player takeallweapons();
        }
    }
}

team_space( team ) {
    if( !host_or_admin() )
        return;

    self iprintln( "^:Sent Team to Space: ^7" + team );
    foreach( player in level.players ) {
        if( !( player ishost() ) && player.team == team ) {
            x = randomintrange( -75, 75 );
            y = randomintrange( -75, 75 );
            z = 45;
            player.location = ( 0 + x, 0 + y, 500000 + z );
            player.angle = ( 0, 176, 0 );
            player setorigin( player.location );
            player setplayerangles( player.angle );
        }
    }
}

team_give_weapon( team ) {
    if( !host_or_admin() )
        return;

    self iprintln( "^:Current Weapon Given To: ^7" + team );
    weapon = self getCurrentWeapon();
    foreach( player in level.players ) {
        if( !( player ishost() ) && player.team == team ) {
            player giveWeapon( weapon );
            player switchToWeapon( weapon );
        }
    }
}

team_teleport_custom( team ) {
    if( !host_or_admin() )
        return;

    newLocation = location_selector();
    self iprintln( "^:Teleported to Selected Location: ^7" + team );
    foreach( player in level.players ) {
        if( !( player ishost() ) && player.team == team ) {
            player SetOrigin( newLocation );
        }
    }
}

all_teleport_crosshair() {
    if( !host_or_admin() )
        return;

    self iprintln( "^:Teleported All to Crosshair" );

    foreach( p in level.players ) {
        if( isalive( p ) && p != self ) {
            p SetOrigin( BulletTrace( self getTagOrigin( "tag_eye" ), vector_multiply( anglestoforward( self getPlayerAngles() ), 1000000 ), 0, self )[ "position" ] );
        }
    }
}

all_give_curr_weapon() {
    if( !host_or_admin() )
        return;

    self iprintln( "^:Current Weapon Given to All" );
    weapon = self getCurrentWeapon();
    foreach( player in level.players ) {
        if( !( player ishost() ) ) {
            player giveWeapon( weapon );
            player switchToWeapon( weapon );
        }
    }
}

all_teleport_custom() {
    if( !host_or_admin() )
        return;

    newLocation = location_selector();
    self iprintln( "^:All Players Teleported to Selected Location" );
    foreach( player in level.players ) {
        if( !( player ishost() ) ) {
            player SetOrigin( newLocation );
        }
    }
}

all_freeze() {
    if( !host_or_admin() )
        return;

    self iprintln( "^:All players frozen/unfrozen" );
    i = 0;
    while( i < level.players.size ) {
        if( !( level.players[ i ].froz ) && !( level.players[ i ] ishost() )  ) {
            level.players[ i ] freezecontrols( 1 );
            level.players[ i ].froz = 1;
        }
        else {
            level.players[ i ] freezecontrols( 0 );
            level.players[ i ].froz = 0;
        }
        i++;
    }
}

all_kill() {
    if( !host_or_admin() )
        return;

    self iprintln( "^:All players killed" );
    foreach( player in level.players ) {
        if( !( player ishost() ) ) {
            player suicide();
        }
    }
}

all_space() {
    if( !host_or_admin() )
        return;

    self iprintln( "^:All Players Sent to Space" );
    foreach( player in level.players ) {
        if( !( player ishost() ) ) {
            x = randomintrange( -75, 75 );
            y = randomintrange( -75, 75 );
            z = 45;
            player.location = ( 0 + x, 0 + y, 500000 + z );
            player.angle = ( 0, 176, 0 );
            player setorigin( player.location );
            player setplayerangles( player.angle );
        }
    }
}

all_take_weapons() {
    if( !host_or_admin() )
        return;

    self iprintln( "^:All Players Weapons Removed" );
    foreach( player in level.players ) {
        if( !( player ishost() ) ) {
            player takeallweapons();
        }
    }
}

give_sniper_perks() {
    if( !host_or_admin() )
        return;

    self maps\mp\_utility::giveperk( "specialty_longersprint", false );
    self maps\mp\_utility::giveperk( "specialty_fastmantle", false );
    self maps\mp\_utility::giveperk( "specialty_fastreload", false );
    self maps\mp\_utility::giveperk( "specialty_quickdraw", false );
    self maps\mp\_utility::giveperk( "specialty_extraammo", false );
    self maps\mp\_utility::giveperk( "specialty_bulletdamage", false );
    self maps\mp\_utility::giveperk( "specialty_armorpiercing", false );
    self maps\mp\_utility::giveperk( "specialty_lightweight", false );
    self maps\mp\_utility::giveperk( "specialty_fastsprintrecovery", false );
    self maps\mp\_utility::giveperk( "specialty_spygame", false );
    self maps\mp\_utility::giveperk( "specialty_extendedmelee", false );
    self maps\mp\_utility::giveperk( "specialty_falldamage", false );
    self maps\mp\_utility::giveperk( "specialty_bulletaccuracy", false );
    self maps\mp\_utility::giveperk( "specialty_holdbreath", false );
    self maps\mp\_utility::giveperk( "specialty_quieter", false );
    self maps\mp\_utility::giveperk( "specialty_selectivehearing", false );
    self maps\mp\_utility::giveperk( "specialty_regenspeed", false );
    self maps\mp\_utility::giveperk( "specialty_crouchmovement", false );
    self maps\mp\_utility::giveperk( "specialty_class_lowprofile", false );
    self maps\mp\_utility::giveperk( "specialty_class_coldblooded", false );
    self maps\mp\_utility::giveperk( "specialty_class_steadyhands", false );
    self maps\mp\_utility::giveperk( "specialty_class_quickdraw", false );
    self maps\mp\_utility::giveperk( "specialty_class_lightweight", false );
    self maps\mp\_utility::giveperk( "specialty_marksman", false );
    self maps\mp\_utility::giveperk( "specialty_sharp_focus", false );
    self maps\mp\_utility::giveperk( "specialty_moredamage", false );
    self maps\mp\_utility::giveperk( "specialty_stopping_power", false );
}