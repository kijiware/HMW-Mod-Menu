//todo: refactor, add comments
set_health( health ) {
    self.maxhealth = isdefined( health ) ? health : 100;
    self.health    = self.maxhealth;
    self iprintln( "^:Health Set^7: [" + "^:" + self.maxhealth + "^7]" );
}

set_origin( origin, angles ) {
    self setorigin( isdefined( origin ) ? origin : self.spawn_origin );
    self setplayerangles( isdefined( angles ) ? angles : self.spawn_angles );
    self iprintln( "^:Teleported^7: ^:Spawn ^7- ^:" + self.origin );
}

god_mode() {
    self.god_mode = !( isdefined( self.god_mode ) && self.god_mode );
    self iprintln( "^:God Mode^7: [" + "^:" + self.god_mode + "^7]" );
}

give_demigod_mode( selected ) {
    selected.maxhealth = 99999;
    selected.health = 99999;
    selected iprintln( "^2Demi-God Mode Given" );
    self iprintln( "^:Demi-God Mode Given To^7: " + "^3" + selected.name );
}

remove_god_mode( selected ) {
    self endon( "disconnect" );

    selected.maxhealth = 100;
    selected.health = 100;
    selected iprintln( "^1Demi-God Mode Removed" );
    self iprintln( "^:Demi-God Mode Removed From^7: " + "^3" + selected.name );
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

all_perks_toggle() {
    self endon( "disconnect" );

    self.all_perks_toggle = !( isdefined( self.all_perks_toggle ) && self.all_perks_toggle );

    if( level.AllPerks == false ) {
        self give_all_perks();
        self iPrintln( "^:All Perks: ^7[^2On^7]" );
        level.AllPerks = true;
    }
    else {
        self remove_all_perks();
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
        else
            self.Fly = 0;
        if( self AdsButtonPressed() && self.Fly == 0 ) {
            self unlink();
            self.Fly = 0;
            self.UFO delete();
        }
        if( self.Fly == 1 ) {
            Fly = self.origin + user_scripts\mp\scripts\util::vec_scal( anglesToForward( self getPlayerAngles() ), 20 );
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

teleporter() {
    self maps\mp\_utility::_beginLocationSelection( "", "map_artillery_selector", true, ( level.mapSize / 5.625 ) );
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
        self maps\mp\_utility::giveperk( "specialty_thermal", 0 );
        self iPrintln( "^:Thermal Vision: ^7[^2On^7]" );
        level.therm_vis_toggle = true;
    }
    else {
        self maps\mp\_utility::_unsetperk( "specialty_thermal" );
        self iPrintln( "^:Thermal Vision: ^7[^1Off^7]" );
        level.therm_vis_toggle = false;
    }
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

    self.multi_jump_toggle = !( isdefined( self.multi_jump_toggle ) && self.multi_jump_toggle );

    if( level.multi_jump_toggle == false ) {
        level.multi_jump_toggle = true;
        self iPrintln( "^:Multi-Jump: ^7[^2On^7]" );
        self thread multi_jump_land();
        if( !isDefined( self.numOfMultijumps ) )
            self.numOfMultijumps = 999;
        for(;;) {
            currentNum = 0;
            while(!self jumpbuttonpressed() )
                wait 0.05;
            while( self jumpbuttonpressed() )
                wait 0.05;
            if( getDvarInt( "jump_height" ) > 250 )
                continue;
            if( !isAlive( self ) ) {
                self waittill( "spawned_player" );
                continue;
            }
            if( !self isOnGround() ) {
                while( !self isOnGround() && isAlive( self ) && currentNum < self.numOfMultijumps ) {
                    waittillResult = self common_scripts\utility::waittill_any_timeout( 0.11, "landedOnGround", "disconnect", "death" );
                    while( waittillResult == "timeout" ) {
                        if( self jumpbuttonpressed() ) {
                            waittillResult = "jump";
                            break;
                        }
                        waittillResult = self common_scripts\utility::waittill_any_timeout( 0.05, "landedOnGround", "disconnect", "death" );
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

disco_mode() {
    self endon( "disconnect" );
    self endon( "endThaFukingDisco" );

    if( !self.DiscoDisco )
        self.DiscoDisco = true;
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
        if( i >= Vis.size )
            i = 0;
        wait 0.5;
    }
}

earthquake_mode() {
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

        if( !isDefined( level.disco_x ) )
            level.disco_x = 0.0;
        if( !isDefined( level.disco_y ) )
            level.disco_y = 0.0;
        if( !isDefined( level.disco_z ) )
            level.disco_z = 0.0;

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
            ent thread user_scripts\mp\scripts\util::destroy_model_on_time( 3 );
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

jetpack_toggle() {
    self endon( "death" );
    self endon( "jetpack_off" );

    self.jetpack_toggle = !( isdefined( self.jetpack_toggle ) && self.jetpack_toggle );

    if( level.jetpack_toggle == false ) {
        level.jetpack_toggle = true;
        self.fuel = 200;
        self iPrintln( "^:Jetpack: ^7[^2On^7]" );
        self attach( "projectile_hellfire_missile", "tag_stowed_back" );
        for( i = 0 ;; i++ ) {
            if( self usebuttonpressed() && self.fuel > 0 ) {
                self playsound( "boost_jump_plr_mp" );
                playFX( level._effect[ "fire_smoke_trail_l" ], self getTagOrigin( "J_Ankle_RI" ) );
                playFx( level._effect[ "fire_smoke_trail_l" ], self getTagOrigin( "J_Ankle_LE" ) );
                earthquake( 0.15, 0.2, self gettagorigin( "j_spine4" ), 50 );
                self.fuel--;
                if( self getvelocity() [ 2 ] < 300 )
                    self setvelocity( self getvelocity() + ( 0, 0, 60 ) );
            }
            if( self.fuel < 200 && !self usebuttonpressed() )
                self.fuel++;
            wait 0.05;
        }
    }
    else {
        self notify( "jetpack_off" );
        level.jetpack_toggle = false;
        self iPrintln( "^:Jetpack: ^7[^1Off^7]" );
    }
}

give_player_weapon( selected, weapon ) {
    selected giveWeapon( weapon );
    selected switchToWeapon( weapon );
    self iprintln( "^:" + weapon + " ^2given to: " + "^7" + selected.name );
}

give_player_killstreak( selected, killstreak ) {
    selected maps\mp\gametypes\_hardpoints::giveHardpoint( killstreak );
    self iprintln( "^:" + killstreak + " ^2given to: " + "^7" + selected.name );
}

give_sniper_perks() {
    self maps\mp\_utility::giveperk( "specialty_longersprint", 0 );
    self maps\mp\_utility::giveperk( "specialty_fastmantle", 0 );
    self maps\mp\_utility::giveperk( "specialty_fastreload", 0 );
    self maps\mp\_utility::giveperk( "specialty_quickdraw", 0 );
    self maps\mp\_utility::giveperk( "specialty_extraammo", 0 );
    self maps\mp\_utility::giveperk( "specialty_bulletdamage", 0 );
    self maps\mp\_utility::giveperk( "specialty_armorpiercing", 0 );
    self maps\mp\_utility::giveperk( "specialty_lightweight", 0 );
    self maps\mp\_utility::giveperk( "specialty_fastsprintrecovery", 0 );
    self maps\mp\_utility::giveperk( "specialty_spygame", 0 );
    self maps\mp\_utility::giveperk( "specialty_extendedmelee", 0 );
    self maps\mp\_utility::giveperk( "specialty_falldamage", 0 );
    self maps\mp\_utility::giveperk( "specialty_bulletaccuracy", 0 );
    self maps\mp\_utility::giveperk( "specialty_holdbreath", 0 );
    self maps\mp\_utility::giveperk( "specialty_quieter", 0 );
    self maps\mp\_utility::giveperk( "specialty_selectivehearing", 0 );
    self maps\mp\_utility::giveperk( "specialty_regenspeed", 0 );
    self maps\mp\_utility::giveperk( "specialty_crouchmovement", 0 );
    self maps\mp\_utility::giveperk( "specialty_class_lowprofile", 0 );
    self maps\mp\_utility::giveperk( "specialty_class_coldblooded", 0 );
    self maps\mp\_utility::giveperk( "specialty_class_steadyhands", 0 );
    self maps\mp\_utility::giveperk( "specialty_class_quickdraw", 0 );
    self maps\mp\_utility::giveperk( "specialty_class_lightweight", 0 );
    self maps\mp\_utility::giveperk( "specialty_marksman", 0 );
    self maps\mp\_utility::giveperk( "specialty_sharp_focus", 0 );
    self maps\mp\_utility::giveperk( "specialty_moredamage", 0 );
    self maps\mp\_utility::giveperk( "specialty_stopping_power", 0 );
}

give_all_perks() {
    self maps\mp\_utility::giveperk( "specialty_longersprint", 0 );
    self maps\mp\_utility::giveperk( "specialty_fastmantle", 0 );
    self maps\mp\_utility::giveperk( "specialty_fastreload", 0 );
    self maps\mp\_utility::giveperk( "specialty_quickdraw", 0 );
    self maps\mp\_utility::giveperk( "specialty_scavenger", 0 );
    self maps\mp\_utility::giveperk( "specialty_extraammo", 0 );
    self maps\mp\_utility::giveperk( "specialty_bling", 0 );
    self maps\mp\_utility::giveperk( "specialty_secondarybling", 0 );
    self maps\mp\_utility::giveperk( "specialty_onemanarmy", 0 );
    self maps\mp\_utility::giveperk( "specialty_omaquickchange", 0 );
    self maps\mp\_utility::giveperk( "specialty_bulletdamage", 0 );
    self maps\mp\_utility::giveperk( "specialty_armorpiercing", 0 );
    self maps\mp\_utility::giveperk( "specialty_lightweight", 0 );
    self maps\mp\_utility::giveperk( "specialty_fastsprintrecovery", 0 );
    self maps\mp\_utility::giveperk( "specialty_hardline", 0 );
    self maps\mp\_utility::giveperk( "specialty_rollover", 0 );
    self maps\mp\_utility::giveperk( "specialty_radarimmune", 0 );
    self maps\mp\_utility::giveperk( "specialty_spygame", 0 );
    self maps\mp\_utility::giveperk( "specialty_explosivedamage", 0 );
    self maps\mp\_utility::giveperk( "specialty_dangerclose", 0 );
    self maps\mp\_utility::giveperk( "specialty_extendedmelee", 0 );
    self maps\mp\_utility::giveperk( "specialty_falldamage", 0 );
    self maps\mp\_utility::giveperk( "specialty_bulletaccuracy", 0 );
    self maps\mp\_utility::giveperk( "specialty_holdbreath", 0 );
    self maps\mp\_utility::giveperk( "specialty_localjammer", 0 );
    self maps\mp\_utility::giveperk( "specialty_delaymine", 0 );
    self maps\mp\_utility::giveperk( "specialty_heartbreaker", 0 );
    self maps\mp\_utility::giveperk( "specialty_quieter", 0 );
    self maps\mp\_utility::giveperk( "specialty_detectexplosive", 0 );
    self maps\mp\_utility::giveperk( "specialty_selectivehearing", 0 );
    self maps\mp\_utility::giveperk( "specialty_pistoldeath", 0 );
    self maps\mp\_utility::giveperk( "specialty_laststandoffhand", 0 );
    self maps\mp\_utility::giveperk( "specialty_shield", 0 );
    self maps\mp\_utility::giveperk( "specialty_feigndeath", 0 );
    self maps\mp\_utility::giveperk( "specialty_shellshock", 0 );
    self maps\mp\_utility::giveperk( "specialty_blackbox", 0 );
    self maps\mp\_utility::giveperk( "specialty_steelnerves", 0 );
    self maps\mp\_utility::giveperk( "specialty_saboteur", 0 );
    self maps\mp\_utility::giveperk( "specialty_endgame", 0 );
    self maps\mp\_utility::giveperk( "specialty_rearview", 0 );
    self maps\mp\_utility::giveperk( "specialty_primarydeath", 0 );
    self maps\mp\_utility::giveperk( "specialty_hardjack", 0 );
    self maps\mp\_utility::giveperk( "specialty_extraspecialduration", 0 );
    self maps\mp\_utility::giveperk( "specialty_stun_resistance", 0 );
    self maps\mp\_utility::giveperk( "specialty_double_load", 0 );
    self maps\mp\_utility::giveperk( "specialty_regenspeed", 0 );
    self maps\mp\_utility::giveperk( "specialty_autospot", 0 );
    self maps\mp\_utility::giveperk( "specialty_twoprimaries", 0 );
    self maps\mp\_utility::giveperk( "specialty_overkillpro", 0 );
    self maps\mp\_utility::giveperk( "specialty_anytwo", 0 );
    self maps\mp\_utility::giveperk( "specialty_fasterlockon", 0 );
    self maps\mp\_utility::giveperk( "specialty_paint", 0 );
    self maps\mp\_utility::giveperk( "specialty_paint_pro", 0 );
    self maps\mp\_utility::giveperk( "specialty_silentkill", 0 );
    self maps\mp\_utility::giveperk( "specialty_crouchmovement", 0 );
    self maps\mp\_utility::giveperk( "specialty_personaluav", 0 );
    self maps\mp\_utility::giveperk( "specialty_unwrapper", 0 );
    self maps\mp\_utility::giveperk( "specialty_class_blindeye", 0 );
    self maps\mp\_utility::giveperk( "specialty_class_lowprofile", 0 );
    self maps\mp\_utility::giveperk( "specialty_class_coldblooded", 0 );
    self maps\mp\_utility::giveperk( "specialty_class_hardwired", 0 );
    self maps\mp\_utility::giveperk( "specialty_class_scavenger", 0 );
    self maps\mp\_utility::giveperk( "specialty_class_hoarder", 0 );
    self maps\mp\_utility::giveperk( "specialty_class_gungho", 0 );
    self maps\mp\_utility::giveperk( "specialty_class_steadyhands", 0 );
    self maps\mp\_utility::giveperk( "specialty_class_hardline", 0 );
    self maps\mp\_utility::giveperk( "specialty_class_peripherals", 0 );
    self maps\mp\_utility::giveperk( "specialty_class_quickdraw", 0 );
    self maps\mp\_utility::giveperk( "specialty_class_lightweight", 0 );
    self maps\mp\_utility::giveperk( "specialty_class_toughness", 0 );
    self maps\mp\_utility::giveperk( "specialty_class_engineer", 0 );
    self maps\mp\_utility::giveperk( "specialty_class_dangerclose", 0 );
    self maps\mp\_utility::giveperk( "specialty_horde_weaponsfree", 0 );
    self maps\mp\_utility::giveperk( "specialty_horde_dualprimary", 0 );
    self maps\mp\_utility::giveperk( "specialty_marksman", 0 );
    self maps\mp\_utility::giveperk( "specialty_sharp_focus", 0 );
    self maps\mp\_utility::giveperk( "specialty_moredamage", 0 );
    self maps\mp\_utility::giveperk( "specialty_copycat", 0 );
    self maps\mp\_utility::giveperk( "specialty_finalstand", 0 );
    self maps\mp\_utility::giveperk( "specialty_light_armor", 0 );
    self maps\mp\_utility::giveperk( "specialty_stopping_power", 0 );
    self maps\mp\_utility::giveperk( "specialty_uav", 0 );
}

remove_all_perks() {
    self clearPerks();
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
    self maps\mp\_utility::_unsetperk( "specialty_combathigh" );
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
    self maps\mp\_utility::_unsetperk( "specialty_juiced" );
    self maps\mp\_utility::_unsetperk( "specialty_light_armor" );
    self maps\mp\_utility::_unsetperk( "specialty_stopping_power" );
    self maps\mp\_utility::_unsetperk( "specialty_uav" );
}

give_player_perks( selected ) {
    selected give_all_perks();
    selected iPrintln( "^:All Perks Given" );
    self iPrintln( "^:All Perks Given To: " + "^7" + selected.name );
}

remove_player_perks( selected ) {
    selected remove_all_perks();
    selected iPrintln( "^:All Perks Removed" );
    self iPrintln( "^:All Perks Removed For: " + "^7" + selected.name );
}

remove_player_weapons( selected ) {
    selected takeAllWeapons();
}

freeze_player( selected ) {
    selected freezeControls( true );
}

unfreeze_player( selected ) {
    selected freezeControls( false );
}

teleport_player_self( selected ) {
    selected setOrigin( self.origin );
    self iprintln( "^:Teleported: " + "^7" + selected.name );
}

teleport_player_crosshair( selected ) {
    forwardTrace = self getEye() + ( anglestoforward( self getPlayerAngles() ) * 1000000 );
    traceResult = bulletTrace( self getEye(), forwardTrace, false, self );
    teleportPosition = traceResult[ "position" ];
    selected setOrigin( teleportPosition );
    self iprintln( "^:Teleported: " + "^7" + selected.name );
}

space_player( selected ) {
    x = randomIntRange( -75, 75 );
    y = randomIntRange( -75, 75 );
    z = 45;
    space_location = ( 0 + x, 0 + y, 170000 + z );
    space_angle = ( 0, 176, 0 );
    selected setOrigin( space_location );
    selected setPlayerAngles( space_angle );
}

warn_player( selected ) {
    selected iprintlnBold( "^1Stop That" );
    selected iprintln( "^1Stop That" );
    selected PlayLocalSound( "h2_nuke_timer" );
    self iprintln( selected.name + " was ^2Warned^7." );
}

kill_player( selected ) {
    selected suicide();
}

kick_player( selected ) {
    kick( selected );
}

admin_access( selected ) {
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
    if( selected.access != "Host" ) {
        selected.has_access = false;
        selected.access = "None";
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
    self iprintln( "^:GUID: ^7" + selected.guid );
}

teleport_to_player( selected ) {
    self SetOrigin( selected.origin );
}

kill_aura_toggle() {
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

view_pos_toggle() {
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

forcefield_toggle() {
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
                if( p != self )
                    p setvelocity( p getvelocity() + ( atf[ 0 ] * ( 300 * 2 ), atf[ 1 ] * ( 300 * 2 ), ( atf[ 2 ] + 0.25 ) * ( 300 * 2 ) ) );
            }
        }
        wait 0.05;
    }
}

/*
drunk_mode_toggle() {
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
    self.drunkHud = user_scripts\mp\scripts\util::create_rectangle( "", "", 0, 0, 1000, 720, user_scripts\mp\scripts\util::get_color(), "white", 1, 0.2 );
    for(;;) {
        for( k = 0; k < 5; k += 0.2 ) {
            self setClientDvar( "r_blur", k );
            self.drunkHud fadeOverTime( 0.1 );
            self.drunkHud.color = user_scripts\mp\scripts\util::get_color();
            wait 0.1;
        }
        for( k = 5; k > 0; k -= 0.2 ) {
            self setClientDvar( "r_blur", k );
            self.drunkHud fadeOverTime( 0.1 );
            self.drunkHud.color = user_scripts\mp\scripts\util::get_color();
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
*/