//todo: refactor, add comments
slide_toggle() {
    self.slide_toggle = !( isdefined( self.slide_toggle ) && self.slide_toggle );

    if( level.slide_toggle == false ) {
        level.slide_toggle = true;
        self iprintln( "^:Sliding: ^7[^2On^7]" );
        setDvar( "hmw_slide", 1 );
        level user_scripts\mp\preload::gametype_check();
        foreach( player in level.players )
            player suicide();
    }
    else {
        level.slide_toggle = false;
        self iprintln( "^:Sliding: ^7[^1Off^7]" );
        setDvar( "hmw_slide", 0 );
        if( isDefined( level.slide_time ) )
            level.slide_time = undefined;
        if( isDefined( level.slide_multiplier ) )
            level.slide_multiplier = undefined;
        if( isDefined( level.slide_dampening ) )
            level.slide_dampening = undefined;
        level notify( "endslide" );
    }
}

headshots_only_toggle() {
    self.headshots_only_toggle = !( isdefined( self.headshots_only_toggle ) && self.headshots_only_toggle );

    if( level.headshots_only_toggle == false ) {
        level.headshots_only_toggle = true;
        self iprintln( "^:Headshots Only: ^7[^2On^7]" );
        setDvar( "hmw_headshots_only", 1 );
    }
    else {
        level.headshots_only_toggle = false;
        self iprintln( "^:Headshots Only: ^7[^1Off^7]" );
        setDvar( "hmw_headshots_only", 0 );
    }
}

rtd_toggle() {
    self.rtd_toggle = !( isdefined( self.rtd_toggle ) && self.rtd_toggle );

    level notify( "gametypechangedrtd" );

    if( level.rtd_toggle == false ) {
        level.rtd_toggle = true;
        self iprintln( "^:Gamemode: ^5Roll The Dice: ^7[^2On^7]" );
        setDvar( "hmw_rtd", 1 );
        setDvar( "scr_game_killstreakdelay", 0 );
        setDvar( "scr_game_hardpoints", 1 );
        level user_scripts\mp\preload::load_menu_arrays();
        level user_scripts\mp\preload::gametype_check();
        foreach( player in level.players ) {
            player thread user_scripts\mp\scripts\gametypes\rtd::rtd_spawn();
            player suicide();
        }
    }
    else {
        level.rtd_toggle = false;
        self iprintln( "^:Gamemode: ^5Roll The Dice: ^7[^1Off^7]" );
        setDvar( "hmw_rtd", 0 );
        if( isDefined( level.rtd_roll_count ) )
            level.rtd_roll_count = undefined;
        if( isDefined( level.rtd_qs_time ) )
            level.rtd_qs_time = undefined;
        level user_scripts\mp\preload::load_menu_arrays();
        foreach( player in level.players )
            player suicide();
    }
}

sniper_only_toggle() {
    self.sniper_only_toggle = !( isdefined( self.sniper_only_toggle ) && self.sniper_only_toggle );

    self notify( "gametypechanged" );

    if( level.sniper_only_toggle == false ) {
        level.sniper_only_toggle = true;
        self iprintln( "^:Gamemode: ^5Snipers Only: ^7[^2On^7]" );
        if( getDvarInt( "hmw_pistol_only" ) == 1 ) {
            pistol_only_toggle();
            setDvar( "hmw_pistol_only", 0 );
        }
        else if( getDvarInt( "hmw_shotgun_only" ) == 1 ) {
            shotgun_only_toggle();
            setDvar( "hmw_shotgun_only", 0 );
        }
        else if( getDvarInt( "hmw_launcher_only" ) == 1 ) {
            launcher_only_toggle();
            setDvar( "hmw_launcher_only", 0 );
        }
        else if( getDvarInt( "hmw_melee_only" ) == 1 ) {
            melee_only_toggle();
            setDvar( "hmw_melee_only", 0 );
        }
        setDvar( "hmw_sniper_only", 1 );
        setDvar( "sv_disableCustomClasses", 1 );
        setDvar( "scr_skipclasschoice", 1 );
        if( getDvar( "g_gametype" ) != "dz" ) {
            setDvar( "scr_game_killstreakdelay", 99999 );
            setDvar( "scr_game_hardpoints", 0 );
        }
        level user_scripts\mp\preload::load_menu_arrays();
        level user_scripts\mp\preload::gametype_check();
        foreach( player in level.players ) {
            player thread user_scripts\mp\scripts\gametypes\restrict::restrict_spawn();
            player suicide();
        }
    }
    else {
        level.sniper_only_toggle = false;
        self iprintln( "^:Gamemode: ^5Snipers Only: ^7[^1Off^7]" );
        setDvar( "hmw_sniper_only", 0 );
        setDvar( "sv_disableCustomClasses", 0 );
        setDvar( "scr_skipclasschoice", 0 );
        setDvar( "scr_game_killstreakdelay", 0 );
        setDvar( "scr_game_hardpoints", 1 );
        level user_scripts\mp\preload::load_menu_arrays();
        foreach( player in level.players )
            player suicide();
    }
}

pistol_only_toggle() {
    self.pistol_only_toggle = !( isdefined( self.pistol_only_toggle ) && self.pistol_only_toggle );

    self notify( "gametypechanged" );

    if( level.pistol_only_toggle == false ) {
        level.pistol_only_toggle = true;
        self iprintln( "^:Gamemode: ^5Pistols Only: ^7[^2On^7]" );
        if( getDvarInt( "hmw_sniper_only" ) == 1 ) {
            sniper_only_toggle();
            setDvar( "hmw_sniper_only", 0 );
        }
        else if( getDvarInt( "hmw_shotgun_only" ) == 1 ) {
            shotgun_only_toggle();
            setDvar( "hmw_shotgun_only", 0 );
        }
        else if( getDvarInt( "hmw_launcher_only" ) == 1 ) {
            launcher_only_toggle();
            setDvar( "hmw_launcher_only", 0 );
        }
        else if( getDvarInt( "hmw_melee_only" ) == 1 ) {
            melee_only_toggle();
            setDvar( "hmw_melee_only", 0 );
        }
        if( getDvarInt( "hmw_antihardscope" ) == 1 )
            setDvar( "hmw_antihardscope", 0 );
        setDvar( "hmw_pistol_only", 1 );
        setDvar( "sv_disableCustomClasses", 1 );
        setDvar( "scr_skipclasschoice", 1 );
        if( getDvar( "g_gametype" ) != "dz" ) {
            setDvar( "scr_game_killstreakdelay", 99999 );
            setDvar( "scr_game_hardpoints", 0 );
        }
        level user_scripts\mp\preload::load_menu_arrays();
        level user_scripts\mp\preload::gametype_check();
        foreach( player in level.players ) {
            player thread user_scripts\mp\scripts\gametypes\restrict::restrict_spawn();
            player suicide();
        }
    }
    else {
        level.pistol_only_toggle = false;
        self iprintln( "^:Gamemode: ^5Pistols Only: ^7[^1Off^7]" );
        setDvar( "hmw_pistol_only", 0 );
        setDvar( "sv_disableCustomClasses", 0 );
        setDvar( "scr_skipclasschoice", 0 );
        setDvar( "scr_game_killstreakdelay", 0 );
        setDvar( "scr_game_hardpoints", 1 );
        level user_scripts\mp\preload::load_menu_arrays();
        foreach( player in level.players )
            player suicide();
    }
}

shotgun_only_toggle() {
    self.shotgun_only_toggle = !( isdefined( self.shotgun_only_toggle ) && self.shotgun_only_toggle );

    self notify( "gametypechanged" );

    if( level.shotgun_only_toggle == false ) {
        level.shotgun_only_toggle = true;
        self iprintln( "^:Gamemode: ^5Shotguns Only: ^7[^2On^7]" );
        if( getDvarInt( "hmw_sniper_only" ) == 1 ) {
            sniper_only_toggle();
            setDvar( "hmw_sniper_only", 0 );
        }
        else if( getDvarInt( "hmw_pistol_only" ) == 1 ) {
            pistol_only_toggle();
            setDvar( "hmw_pistol_only", 0 );
        }
        else if( getDvarInt( "hmw_launcher_only" ) == 1 ) {
            launcher_only_toggle();
            setDvar( "hmw_launcher_only", 0 );
        }
        else if( getDvarInt( "hmw_melee_only" ) == 1 ) {
            melee_only_toggle();
            setDvar( "hmw_melee_only", 0 );
        }
        if( getDvarInt( "hmw_antihardscope" ) == 1 )
            setDvar( "hmw_antihardscope", 0 );
        setDvar( "hmw_shotgun_only", 1 );
        setDvar( "sv_disableCustomClasses", 1 );
        setDvar( "scr_skipclasschoice", 1 );
        if( getDvar( "g_gametype" ) != "dz" ) {
            setDvar( "scr_game_killstreakdelay", 99999 );
            setDvar( "scr_game_hardpoints", 0 );
        }
        level user_scripts\mp\preload::load_menu_arrays();
        level user_scripts\mp\preload::gametype_check();
        foreach( player in level.players ) {
            player thread user_scripts\mp\scripts\gametypes\restrict::restrict_spawn();
            player suicide();
        }
    }
    else {
        level.shotgun_only_toggle = false;
        self iprintln( "^:Gamemode: ^5Shotguns Only: ^7[^1Off^7]" );
        setDvar( "hmw_shotgun_only", 0 );
        setDvar( "sv_disableCustomClasses", 0 );
        setDvar( "scr_skipclasschoice", 0 );
        setDvar( "scr_game_killstreakdelay", 0 );
        setDvar( "scr_game_hardpoints", 1 );
        level user_scripts\mp\preload::load_menu_arrays();
        foreach( player in level.players )
            player suicide();
    }
}

launcher_only_toggle() {
    self.launcher_only_toggle = !( isdefined( self.launcher_only_toggle ) && self.launcher_only_toggle );

    self notify( "gametypechanged" );

    if( level.launcher_only_toggle == false ) {
        level.launcher_only_toggle = true;
        self iprintln( "^:Gamemode: ^5Launchers Only: ^7[^2On^7]" );
        if( getDvarInt( "hmw_sniper_only" ) == 1 ) {
            sniper_only_toggle();
            setDvar( "hmw_sniper_only", 0 );
        }
        else if( getDvarInt( "hmw_pistol_only" ) == 1 ) {
            pistol_only_toggle();
            setDvar( "hmw_pistol_only", 0 );
        }
        else if( getDvarInt( "hmw_shotgun_only" ) == 1 ) {
            shotgun_only_toggle();
            setDvar( "hmw_shotgun_only", 0 );
        }
        else if( getDvarInt( "hmw_melee_only" ) == 1 ) {
            melee_only_toggle();
            setDvar( "hmw_melee_only", 0 );
        }
        if( getDvarInt( "hmw_antihardscope" ) == 1 )
            setDvar( "hmw_antihardscope", 0 );
        setDvar( "hmw_launcher_only", 1 );
        setDvar( "sv_disableCustomClasses", 1 );
        setDvar( "scr_skipclasschoice", 1 );
        if( getDvar( "g_gametype" ) != "dz" ) {
            setDvar( "scr_game_killstreakdelay", 99999 );
            setDvar( "scr_game_hardpoints", 0 );
        }
        level user_scripts\mp\preload::load_menu_arrays();
        level user_scripts\mp\preload::gametype_check();
        foreach( player in level.players ) {
            player thread user_scripts\mp\scripts\gametypes\restrict::restrict_spawn();
            player suicide();
        }
    }
    else {
        level.launcher_only_toggle = false;
        self iprintln( "^:Gamemode: ^5Launchers Only: ^7[^1Off^7]" );
        setDvar( "hmw_launcher_only", 0 );
        setDvar( "sv_disableCustomClasses", 0 );
        setDvar( "scr_skipclasschoice", 0 );
        setDvar( "scr_game_killstreakdelay", 0 );
        setDvar( "scr_game_hardpoints", 1 );
        level user_scripts\mp\preload::load_menu_arrays();
        foreach( player in level.players )
            player suicide();
    }
}

melee_only_toggle() {
    self.melee_only_toggle = !( isdefined( self.melee_only_toggle ) && self.melee_only_toggle );

    self notify( "gametypechanged" );

    if( level.melee_only_toggle == false ) {
        level.melee_only_toggle = true;
        self iprintln( "^:Gamemode: ^5Melee Only: ^7[^2On^7]" );
        if( getDvarInt( "hmw_sniper_only" ) == 1 ) {
            sniper_only_toggle();
            setDvar( "hmw_sniper_only", 0 );
        }
        else if( getDvarInt( "hmw_pistol_only" ) == 1 ) {
            pistol_only_toggle();
            setDvar( "hmw_pistol_only", 0 );
        }
        else if( getDvarInt( "hmw_shotgun_only" ) == 1 ) {
            shotgun_only_toggle();
            setDvar( "hmw_shotgun_only", 0 );
        }
        else if( getDvarInt( "hmw_launcher_only" ) == 1 ) {
            launcher_only_toggle();
            setDvar( "hmw_launcher_only", 0 );
        }
        if( getDvarInt( "hmw_antihardscope" ) == 1 )
            setDvar( "hmw_antihardscope", 0 );

        setDvar( "hmw_melee_only", 1 );
        setDvar( "sv_disableCustomClasses", 1 );
        setDvar( "scr_skipclasschoice", 1 );
        if( getDvar( "g_gametype" ) != "dz" ) {
            setDvar( "scr_game_killstreakdelay", 99999 );
            setDvar( "scr_game_hardpoints", 0 );
        }
        level user_scripts\mp\preload::load_menu_arrays();
        level user_scripts\mp\preload::gametype_check();
        foreach( player in level.players ) {
            player thread user_scripts\mp\scripts\gametypes\restrict::restrict_spawn();
            player suicide();
        }
    }
    else {
        level.melee_only_toggle = false;
        self iprintln( "^:Gamemode: ^5Melee Only: ^7[^1Off^7]" );
        setDvar( "hmw_melee_only", 0 );
        setDvar( "sv_disableCustomClasses", 0 );
        setDvar( "scr_skipclasschoice", 0 );
        setDvar( "scr_game_killstreakdelay", 0 );
        setDvar( "scr_game_hardpoints", 1 );
        level user_scripts\mp\preload::load_menu_arrays();
        foreach( player in level.players )
            player suicide();
    }
}

restart_map() {
    map_restart( false );
    level user_scripts\mp\preload::load_menu_arrays();
}

end_game() {
    level thread maps\mp\gametypes\_gamelogic::forceend();
}

change_gametype( gametype ) {
    setDvar( "g_gametype", gametype );
    setDvar( "ui_gametype", gametype );
    map_restart( false );
    level user_scripts\mp\preload::load_menu_arrays();
}

infinite_game_toggle() {
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

print_controls() {
    self iprintln( "^:[{+speed_throw}] + [{+melee_zoom}] to open menu" );
    self iprintln( "^:[{+attack}] / [{+speed_throw}] to scroll up or down" );
    self iprintln( "^:[{+frag}] / [{+smoke}] to slide left or right" );
    self iprintln( "^:[{+activate}] to accept [{+melee_zoom}] to go back" );
}

gravity_set( gravity_set ) {
    setDvar( "g_gravity", gravity_set );
    self iPrintln( "^:Gravity set to: " + gravity_set );
}

timescale_set( timescale_set ) {
    setDvar( "timescale", timescale_set );
    self iPrintln( "^:Timescale set to: " + timescale_set );
}

jumpheight_set( jumpheight_set ) {
    setDvar( "jump_height", jumpheight_set );
    self iPrintln( "^:Jump height set to: " + jumpheight_set );
}

speed_set( speed_set ) {
    setDvar( "g_speed", speed_set );
    self iPrintln( "^:Speed set to: " + speed_set );
}

knockback_set( knockback_set ) {
    setDvar( "g_knockback", knockback_set );
    self iPrintln( "^:Knockback set to: " + knockback_set );
}

inspect_glide() {
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

death_barriers_toggle() {
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
				if( isDefined( ents[ index ].originalOrigin ) )
					ents[ index ].origin = ents[ index ].originalOrigin;
				else
					self iprintln( "Original position not found for entity " + index + ", cannot reset." );
			}
		}
        level.DeathBarriers = true;
        self iPrintln( "^:Death Barriers: ^7[^1Reset^7]" );
    }
}

allow_team_change() {
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

all_voice_toggle() {
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

elevator_toggle() {
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

ladder_jump_toggle() {
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

fireworks_toggle() {
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

custom_minimap( material ) {
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

change_specular( int ) {
    setdvar( "r_specularmap", int );
    self iprintln( "^:Specular Map Set" );
}

modded_lobby_toggle() {
    self endon( "disconnect" );

    self.modded_lobby_toggle = !( isdefined( self.modded_lobby_toggle ) && self.modded_lobby_toggle );

    if( level.modded_lobby_toggle == false ) {
        setDvar( "g_gravity", 175 );
        setDvar( "jump_height", 1000 );
        setDvar( "g_speed", 800 );
        setDvar( "perk_weapSpreadMultiplier", 0.0001 );
        foreach( player in level.players ) {
            player user_scripts\mp\scripts\player::give_sniper_perks();
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

switch_teams() {
    self setclientomnvar( "ui_options_menu", 1 );
}

set_team_max( max_score ) {
    setdynamicdvar( "scr_" + level.gametype + "_scoreLimit", max_score );
    self iprintln( "^:Score Limit Set: " + max_score );
}

set_time_limit( time_limit ) {
    setdynamicdvar( "scr_" + level.gametype + "_timeLimit", time_limit );
    self iprintln( "^:Time Limit Set: " + time_limit );
}

change_map( selected_map ) {
    map_lower = tolower( selected_map );
    say( "^:Map Changing: " + "^2" + selected_map );
    wait 1;
    executeCommand( "map "+ map_lower );
    wait 300;
}