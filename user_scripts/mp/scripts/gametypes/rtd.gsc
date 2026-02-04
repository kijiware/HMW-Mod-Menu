//todo: refactor, add comments, fix/replace certain rolls
rtd_spawn() {
    level endon( "game_ended" );
    level endon( "gametypechangedrtd" );
    for( ;; ) {
        self waittill( "spawned_player" );
        self.rollstreak = -1;
        self.lastrollprinted = -1;
        self thread rtd_start();
    }
}

rtd_add_roll() {
    level endon( "game_ended" );
    level endon( "gametypechangedrtd" );
    self endon( "disconnect" );
    self endon( "death" );

    self notify( "newRoll" );
    self thread rtd_random();
}

rtd_choose_roll( int ) {
    level endon( "game_ended" );
    level endon( "gametypechangedrtd" );
    self endon( "disconnect" );
    self endon( "death" );

    self.chooseRoll = 1;
    self.presentroll = int;
    self notify( "newRoll" );
    self thread rtd_random();
}

rtd_new_roll() {
    level endon( "game_ended" );
    level endon( "gametypechangedrtd" );
    self endon( "disconnect" );
    self endon( "death" );
    self notify( "cancelRoll" );
    self notify( "newRoll" );
    self notify( "defaultProj" );
    self notify( "endMultijump" );
    self notify( "endForce" );
    self notify( "endRicochet" );
    self notify( "endQS" );
    self notify( "randRounds" );

    self laseroff();
    self ThermalVisionFOFOverlayOff();
    self Show();
    self setClientDvar( "cg_drawShellshock", 1 );
    self setClientDvar( "cg_drawDamageDirection", 1 );
    self setClientDvar( "player_breath_snd_delay", 1 );
    self setClientDvar( "perk_extraBreath", 5 );
    self setClientDvar( "cg_brass", 1 );
    self setClientDvar( "r_blur", 0 );
    self setClientDvar( "r_specularcolorscale", 0 );
    self setClientDvar( "r_filmusetweaks", 0 );
    self setClientDvar( "r_filmtweakenable", 0 );
    self setClientDvar( "r_filmtweakcontrast", 1.4 );
    self setClientDvar( "r_brightness", 0 );
    self setClientDvar( "fx_drawclouds", 1 );
    self setClientDvar( "cg_blood", 1 );
    self setClientDvar( "r_dlightLimit", 8 );
    self setClientDvar( "r_fog", 1 );
    self setClientDvar( "r_specularmap", 1 );
    setDvar( "perk_weapReloadMultiplier", 0.5 );
    setDvar( "jump_height", 39 );
    self thread rtd_random();
}

rtd_print_roll( name ) {
    level endon( "game_ended" );
    level endon( "gametypechangedrtd" );
    self endon( "disconnect" );
    self endon( "death" );

    self iPrintlnBold( "You Rolled: " + name );

    self notifyOnPlayerCommand( "PrintRoll", "+actionslot 1" );

    for( ;; ) {
        self waittill( "PrintRoll" );
        self iPrintlnBold( "You Rolled: " + name );
        wait 0.1;
    }
}

rtd_evasion( percentage ) {
    level endon( "game_ended" );
    level endon( "gametypechangedrtd" );
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "cancelevasion" );
    self endon( "cancelRoll" );

    self.maxhealth = 1000;
    self.health = self.maxhealth;

    while( 1 ) {
        if( self.health != self.maxhealth ) {
            chance = RandomInt( 100 ) + 1;

            if( chance <= percentage )
                self suicide();
            else
                self.health = self.maxhealth;
        }
        wait 0.05;
    }
}

rtd_highjump() {
    level endon( "game_ended" );
    level endon( "gametypechangedrtd" );
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "cancelRoll" );
    self endon( "newRoll" );

    self notifyOnPlayerCommand( "jump", "+gostand" );
    for( ;; ) {
        while( self UseButtonPressed( ) ) {
            setDvar( "jump_height", 390 );
            wait 0.05;
        }
        setDvar( "jump_height", 39 );
        wait 0.05;
    }
}

rtd_kill_upgrades() {
    level endon( "game_ended" );
    level endon( "gametypechangedrtd" );
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "cancelRoll" );

    while( 1 ) {
        if( self.streaknumber != self.pers[ "kills" ] - self.startscore ) {
            self.streaknumber = self.pers[ "kills" ] - self.startscore;

            if( self.streaknumber > 0 && self.upgstart == 1 ) {
                self thread rtd_print_roll( "^5Lvl 1 [+UAV]" );
                self maps\mp\gametypes\_hardpoints::giveHardpoint( "radar_mp", true );
                self.upgstart = 0;
                self.upglvl1 = 1;
            }

            if( self.streaknumber > 1 && self.upglvl1 == 1 ) {
                self thread rtd_print_roll( "^5Lvl 2 [+ShellShock Immunity]" );

                for( ;; ) {
                    self StopShellShock();
                    wait 0.05;
                }
                self.upglvl1 = 0;
                self.upglvl2 = 1;
            }

            if( self.streaknumber > 2 && self.upglvl2 == 1 ) {
                self thread rtd_print_roll( "^5Lvl 3 [+Third Weapon]" );
                self giveWeapon( "h2_ump45_mp_fastfire_fmj_silencersniper_xmagmwr_camo025" );
                self.upglvl2 = 0;
                self.upglvl3 = 1;
            }

            if( self.streaknumber > 3 && self.upglvl3 == 1 ) {
                self thread rtd_print_roll( "^5Lvl 4 [+All Perks]" );
                self user_scripts\mp\scripts\player::give_all_perks();
                self.upglvl3 = 0;
                self.upglvl4 = 1;
            }

            if( self.streaknumber > 4 && self.upglvl4 == 1 ) {
                self thread rtd_print_roll( "^5Lvl 5 [+Unlimited Lethals]" );
                self thread rtd_nades( 99 );
                self.upglvl4 = 0;
                self.upglvl5 = 1;
            }

            if( self.streaknumber > 5 && self.upglvl5 == 1 ) {
                self thread rtd_print_roll( "^5Lvl 6 [+Unlimited Ammo]" );
                self thread rtd_ammo( 999 );
                self.upglvl5 = 0;
                self.upglvl6 = 1;
            }

            if( self.streaknumber > 6 && self.upglvl6 == 1 ) {
                self thread rtd_print_roll( "^5Lvl 7 [+150 HP]" );
                self.maxhealth = self.maxhealth + 150;
                self.health = self.maxhealth;
                self.upglvl6 = 0;
                self.upglvl7 = 1;
            }

            if( self.streaknumber > 7 && self.upglvl7 == 1 ) {
                self thread rtd_print_roll( "^5Lvl 8 [+1.5 Speed]" );
                self thread rtd_loop( "speed", 1.5 );
                self.upglvl7 = 0;
                self.upglvl8 = 1;
            }

            if( self.streaknumber > 8 && self.upglvl8 == 1 ) {
                self thread rtd_print_roll( "^5Lvl 9 [+You're Flashing Invisible]" );

                while( 1 ) {
                    self Hide();
                    wait 0.50;
                    self Show();
                    wait 0.50;
                }
                self.upglvl8 = 0;
                self.upglvl9 = 1;
            }

            if( self.streaknumber > 9 && self.upglvl9 == 1 ) {
                self thread rtd_print_roll( "^5Lvl 10 [+Explosive Rounds]" );
                self thread rtd_explosive_rounds( 9999 );
            }
        }
        wait 0.25;
    }
}

rtd_all_random() {
    level endon( "game_ended" );
    level endon( "gametypechangedrtd" );
    self endon( "disconnect" );
    self endon( "death" );

    while( 1 ) {
        self.rollstreak = self.rollstreak - 1;

        self thread rtd_random();
        wait 7;

        self notify( "cancelRoll" );
        self notify( "newRoll" );
        self notify( "defaultProj" );
        self notify( "endMultijump" );
        self notify( "endForce" );
        self notify( "endRicochet" );
        self notify( "endQS" );
        self notify( "randRounds" );

        self.maxhealth = 100;
        self.health = 100;

        self laseroff();
        self ThermalVisionFOFOverlayOff();
        self Show();
        self setClientDvar( "cg_drawShellshock", 1 );
        self setClientDvar( "cg_drawDamageDirection", 1 );
        self setClientDvar( "player_breath_snd_delay", 1 );
        self setClientDvar( "perk_extraBreath", 5 );
        self setClientDvar( "cg_brass", 1 );
        self setClientDvar( "r_blur", 0 );
        self setClientDvar( "r_specularcolorscale", 0 );
        self setClientDvar( "r_filmusetweaks", 0 );
        self setClientDvar( "r_filmtweakenable", 0 );
        self setClientDvar( "r_filmtweakcontrast", 1.4 );
        self setClientDvar( "r_brightness", 0 );
        self setClientDvar( "fx_drawclouds", 1 );
        self setClientDvar( "cg_blood", 1 );
        self setClientDvar( "r_dlightLimit", 8 );
        self setClientDvar( "r_fog", 1 );
        self setClientDvar( "r_specularmap", 1 );
        setDvar( "perk_weapReloadMultiplier", 0.5 );
        setDvar( "jump_height", 39 );
    }
}

rtd_camping() {
    level endon( "game_ended" );
    level endon( "gametypechangedrtd" );
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "cancelRoll" );

    while( 1 ) {
        self SetMoveSpeedScale( 0 );
        wait 0.25;
    }
}

rtd_cycle() {
    level endon( "game_ended" );
    level endon( "gametypechangedrtd" );
    self notify( "cancelRoll" );
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "cancelRoll" );

    while( 1 ) {
        self takeAllWeapons();
        self rtd_cycle_monitor( "h2_m9_mp_fmj" + common_scripts\utility::random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self rtd_cycle_monitor( "h2_usp_mp_fmj" + common_scripts\utility::random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self rtd_cycle_monitor( "h1_deserteagle55_mp_fmj" );
        wait 2;
        self takeAllWeapons();
        self rtd_cycle_monitor( "h2_coltanaconda_mp_fmj" + common_scripts\utility::random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self rtd_cycle_monitor( "h2_glock_mp_fmj" + common_scripts\utility::random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self rtd_cycle_monitor( "h2_beretta393_mp_fmj" + common_scripts\utility::random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self rtd_cycle_monitor( "h2_mp5k_mp_fmj" + common_scripts\utility::random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self rtd_cycle_monitor( "h2_pp2000_mp_fmj" + common_scripts\utility::random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self rtd_cycle_monitor( "h2_uzi_mp_fmj" + common_scripts\utility::random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self rtd_cycle_monitor( "h2_p90_mp_fmj" + common_scripts\utility::random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self rtd_cycle_monitor( "h2_kriss_mp_fmj" + common_scripts\utility::random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self rtd_cycle_monitor( "h2_ump45_mp_fmj" + common_scripts\utility::random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self rtd_cycle_monitor( "h2_tmp_mp_fmj" + common_scripts\utility::random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self rtd_cycle_monitor( "h2_ak47_mp_fmj" + common_scripts\utility::random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self rtd_cycle_monitor( "h2_m16_mp_fmj" + common_scripts\utility::random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self rtd_cycle_monitor( "h2_m4_mp_fmj" + common_scripts\utility::random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self rtd_cycle_monitor( "h2_fn2000_mp_fmj" + common_scripts\utility::random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self rtd_cycle_monitor( "h2_masada_mp_fmj" + common_scripts\utility::random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self rtd_cycle_monitor( "h2_famas_mp_fmj" + common_scripts\utility::random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self rtd_cycle_monitor( "h2_fal_mp_fmj" + common_scripts\utility::random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self rtd_cycle_monitor( "h2_scar_mp_fmj" + common_scripts\utility::random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self rtd_cycle_monitor( "h2_tavor_mp_fmj" + common_scripts\utility::random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self rtd_cycle_monitor( "h2_barrett_mp_fmj" + common_scripts\utility::random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self rtd_cycle_monitor( "h2_wa2000_mp_fmj" + common_scripts\utility::random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self rtd_cycle_monitor( "h2_m21_mp_fmj" + common_scripts\utility::random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self rtd_cycle_monitor( "h2_cheytac_mp_fmj" + common_scripts\utility::random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self rtd_cycle_monitor( "h2_model1887_mp_akimbo_fmj" + common_scripts\utility::random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self rtd_cycle_monitor( "h2_striker_mp_fmj" + common_scripts\utility::random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self rtd_cycle_monitor( "h2_aa12_mp_fmj" + common_scripts\utility::random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self rtd_cycle_monitor( "h2_m1014_mp_fmj" + common_scripts\utility::random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self rtd_cycle_monitor( "h2_spas12_mp_fmj" + common_scripts\utility::random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self rtd_cycle_monitor( "h2_rpd_mp_foregrip_fmj" + common_scripts\utility::random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self rtd_cycle_monitor( "h2_sa80_mp_foregrip_fmj" + common_scripts\utility::random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self rtd_cycle_monitor( "h2_mg4_mp_foregrip_fmj" + common_scripts\utility::random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self rtd_cycle_monitor( "h2_m240_mp_foregrip_fmj" + common_scripts\utility::random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self rtd_cycle_monitor( "h2_aug_mp_foregrip_fmj" + common_scripts\utility::random( level.camo_array ) );
        wait 2;
    }
}

rtd_cycle_monitor( allowed ) {
    level endon( "game_ended" );
    level endon( "gametypechangedrtd" );
    self endon( "disconnect" );
    self endon( "death" );

    if( self getCurrentWeapon( ) != allowed ) {

        if( isSubStr( allowed, "akimbo" ) ) {
            self takeAllWeapons();
            self giveWeapon( allowed );
            self switchToWeapon( allowed );
        }

        if( !isSubStr( allowed, "akimbo" ) ) {
            self takeAllWeapons();
            self giveWeapon( allowed );
            self switchToWeapon( allowed );
        }
        wait 0.5;
    }
    wait 0.5;
}

rtd_explosive_rounds( time ) {
    level endon( "game_ended" );
    level endon( "gametypechangedrtd" );
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "cancelRoll" );

    self thread rtd_timer( time, 0 );

    while( self.timer > 0 ) {
        self waittill( "weapon_fired" );
        SPLOSIONlocation = user_scripts\mp\scripts\util::cursor_pos();
        playfx( level._effect[ "frag_grenade_default" ], SPLOSIONlocation );
        RadiusDamage( SPLOSIONlocation, 275, 15 * time, 3 * time, self );
    }
}

rtd_timer( time, print ) {
    level endon( "game_ended" );
    level endon( "gametypechangedrtd" );
    self endon( "disconnect" );
    self endon( "death" );

    self.timer = time;

    while( self.timer != 0 ) {
        if( print == 1 )
            self iPrintlnBold( "^:" + self.timer );
        self.timer = self.timer - 1;
        wait 1;
    }
}

rtd_aimbot() {
    level endon( "game_ended" );
    level endon( "gametypechangedrtd" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "cancelRoll" );

    self thread rtd_timer( 15, 0 );

    for( ;; ) {
        while( self.timer > 0 ) {
            wait 0.01;
            aimAt = undefined;

            foreach( player in level.players ) {
                if( player == self )
                    continue;
                if( !isAlive( player ) )
                    continue;
                if( level.teamBased && self.pers[ "team" ] == player.pers[ "team" ] )
                    continue;
                if( !bulletTracePassed( self getTagOrigin( "j_head" ), player getTagOrigin( "j_head" ), false, self ) )
                    continue;
                if( isDefined( aimAt ) )
                    if( closer( self getTagOrigin( "j_head" ), player getTagOrigin( "j_head" ), aimAt getTagOrigin( "j_head" ) ) )
                        aimAt = player;
                else
                    aimAt = player;
            }

            if( isDefined( aimAt ) )
                self setplayerangles( VectorToAngles( ( aimAt getTagOrigin( "j_head" ) ) - ( self getTagOrigin( "j_head" ) ) ) );
        }
        break;
    }
}

rtd_vision() {
    level endon( "game_ended" );
    level endon( "gametypechangedrtd" );
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "cancelRoll" );

    for( ;; ) {
        self VisionSetNakedForPlayer( "default_night_mp", 0.5 );
        wait ( 0.4 );
        self VisionSetNakedForPlayer( "thermal_mp", 0.5 );
        wait ( 0.4 );
        self VisionSetNakedForPlayer( "icbm_sunrise4", 0.5 );
        wait ( 0.4 );
        self VisionSetNakedForPlayer( "grayscale", 0.5 );
        wait ( 0.4 );
        self VisionSetNakedForPlayer( "sepia", 0.5 );
        wait ( 0.4 );
        self VisionSetNakedForPlayer( "cheat_chaplinnight", 0.5 );
        wait ( 0.4 );
        self VisionSetNakedForPlayer( "cheat_contrast", 0.5 );
        wait ( 0.4 );
        self VisionSetNakedForPlayer( "cheat_invert", 0.5 );
        wait ( 0.4 );
        self VisionSetNakedForPlayer( "armada_water", 0.5 );
        wait ( 0.4 );
        self VisionSetNakedForPlayer( "cheat_invert_contrast", 0.5 );
        wait ( 0.4 );
        self VisionSetNakedForPlayer( "cobra_sunset3", 0.5 );
        wait ( 0.4 );
        self VisionSetNakedForPlayer( "contingency_thermal_inverted", 0.5 );
        wait ( 0.4 );
        self VisionSetNakedForPlayer( "cliffhanger_heavy", 0.5 );
        wait ( 0.4 );
        self VisionSetNakedForPlayer( "mpnuke_aftermath", 0.5 );
        wait ( 0.4 );
        self VisionSetNakedForPlayer( "missilecam", 0.5 );
        wait ( 0.4 );
        self VisionSetNakedForPlayer( "cheat_invert", 0.1 );
        wait ( 0.4 );
        self VisionSetNakedForPlayer( "default", 0.1 );
        wait ( 0.4 );
        self VisionSetNakedForPlayer( "cheat_contrast", 0.1 );
        wait ( 0.4 );
        self VisionSetNakedForPlayer( "default", 0.1 );
        wait ( 0.4 );
        self VisionSetNakedForPlayer( "cheat_contrast", 0.1 );
        wait ( 0.4 );
        self VisionSetNakedForPlayer( "cheat_invert", 0.1 );
        wait ( 0.4 );
        self VisionSetNakedForPlayer( "default", 0.1 );
        wait ( 0.4 );
        self VisionSetNakedForPlayer( "cheat_contrast", 0.1 );
        wait ( 0.4 );
        self VisionSetNakedForPlayer( "default", 0.1 );
        wait ( 0.4 );
        self VisionSetNakedForPlayer( "cheat_contrast", 0.1 );
        wait ( 0.4 );
        self VisionSetNakedForPlayer( "cheat_invert", 0.1 );
        wait ( 0.4 );
        self VisionSetNakedForPlayer( "default", 0.1 );
        wait ( 0.4 );
        self VisionSetNakedForPlayer( "cheat_contrast", 0.1 );
        wait ( 0.4 );
        self VisionSetNakedForPlayer( "default", 0.1 );
        wait ( 0.4 );
        self VisionSetNakedForPlayer( "cheat_contrast", 0.1 );
        wait ( 0.4 );
        self VisionSetNakedForPlayer( "cheat_invert", 0.1 );
        wait ( 0.4 );
        self VisionSetNakedForPlayer( "default", 10 );
    }
}

rtd_harrier() {
    level endon( "game_ended" );
    level endon( "gametypechangedrtd" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "cancelRoll" );

    self notifyOnPlayerCommand( "dpad_down", "+actionslot 2" );

    self waittill( "dpad_down" );

    Location = user_scripts\mp\scripts\util::location_selector();

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
    self RadiusDamage( SuicidePlane.origin, 5000, 5000, 2500, self );

    SuicidePlane delete();
    Earthquake( 0.4, 4, SuicidePlane.origin, 800 );
}

rtd_save_pos() {
    level endon( "game_ended" );
    level endon( "gametypechangedrtd" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "cancelRoll" );

    self.allowjumper = 0;

    self notifyOnPlayerCommand( "blButton", "+activate" );

    for( ;; ) {
        self waittill( "blButton" );
        self iPrintlnBold( "^2Current Position Saved!" );
        self.save1pos = self.origin;
        self.save1ang = self.angles;
        self.allowjumper = 1;
    }
}

rtd_load_pos() {
    level endon( "game_ended" );
    level endon( "gametypechangedrtd" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "cancelRoll" );

    self notifyOnPlayerCommand( "5", "+actionslot 2" );

    for( ;; ) {
        self waittill( "5" );

        if( self.allowjumper == 1 ) {
            self iPrintlnBold( "^2You've Teleported Back!" );
            self setOrigin( self.save1pos );
            self setPlayerAngles( self.save1ang );
            self freezeControls( true );
            wait 0.1;
            self freezeControls( false );
            self.allowjumper = 0;
        }
    }
}

rtd_loop( type, amnt ) {
    level endon( "game_ended" );
    level endon( "gametypechangedrtd" );
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "cancelRoll" );
    self endon( "stoploop" );
    self endon( "newRoll" );

    while( 1 ) {
        if( type == "speed" )
            self SetMoveSpeedScale( amnt );

        if( type == "vision" )
            self VisionSetNakedForPlayer( amnt, 0 );
        wait 0.05;
    }
}

rtd_stock( amnt ) {
    level endon( "game_ended" );
    level endon( "gametypechangedrtd" );
    self notify( "endstock" );
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "endstock" );
    self endon( "cancelRoll" );

    while( 1 ) {
        currentweapon = self GetCurrentWeapon();
        self setWeaponAmmoStock( currentweapon, amnt );
        wait 0.05;
    }
}

rtd_nades( amnt ) {
    level endon( "game_ended" );
    level endon( "gametypechangedrtd" );
    self notify( "endnades" );
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "endnades" );
    self endon( "cancelRoll" );

    while( 1 ) {
        currentoffhand = self GetCurrentOffhand();
        self setWeaponAmmoClip( currentoffhand, amnt );
        self GiveMaxAmmo( currentoffhand );
        wait 0.05;
    }
}

rtd_ammo( amnt ) {
    level endon( "game_ended" );
    level endon( "gametypechangedrtd" );
    self notify( "endammo" );
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "endammo" );
    self endon( "cancelRoll" );

    while( 1 ) {
        currentweapon = self GetCurrentWeapon();
        self setWeaponAmmoClip( currentweapon, amnt );
        self setWeaponAmmoClip( currentweapon, amnt, "left" );
        self setWeaponAmmoClip( currentweapon, amnt, "right" );
        wait 0.05;
    }
}

rtd_landed() {
    level endon( "game_ended" );
    level endon( "gametypechangedrtd" );
    self endon( "disconnect" );
    self endon( "death" );

    loopResult = true;

    for( ;; ) {
        wait 0.05;
        newResult = self isOnGround();

        if( newResult != loopResult ) {
            if( !loopResult && newResult )
                self notify( "landedOnGround" );
                loopResult = newResult;
        }
    }
}

rtd_monitor( allowed, add ) {
    level endon( "game_ended" );
    level endon( "gametypechangedrtd" );
    self notify( "endmonitor" );
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "endmonitor" );
    self endon( "cancelRoll" );
    self endon( "newRoll" );
    self endon( "nextgun" );

    while( 1 ) {
        if( self getCurrentWeapon( ) != allowed ) {
            if( isSubStr( allowed, "akimbo" ) || allowed == "m79_mp" ) {
                self takeWeapon( self getCurrentWeapon() );
                self giveWeapon( allowed );
                self switchToWeapon( allowed );
            }
            if( !isSubStr( allowed, "akimbo" ) ) {
                if( allowed != "m79_mp" ) {
                    if( add != "gl" )
                        self takeWeapon( self getCurrentWeapon() );
                    self giveWeapon( allowed );
                    self switchToWeapon( allowed );
                }
            }
        }
        wait 0.5;
    }
}

rtd_qs() {
    level endon( "game_ended" );
    level endon( "gametypechangedrtd" );
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "cancelRoll" );

    self notifyOnPlayercommand( "tmouse2", "+toggleads_throw" );
    self notifyOnPlayercommand( "tmouse2O", "-speed_throw" );

    while( 1 ) {
        self thread rtd_ammo( 0 );
        self waittill( "tmouse2" );
        self notify( "endammo" );
        self thread rtd_ammo( 99 );
        self waittill( "tmouse2O" );
        self notify( "endammo" );
    }
}

rtd_gun_game() {
    level endon( "game_ended" );
    level endon( "gametypechangedrtd" );
    self notify( "endgungame" );
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "cancelRoll" );
    self endon( "endgungame" );

    self.startscore = self.pers[ "kills" ];

    self thread rtd_stock( 99 );
    self thread rtd_monitor( self.weapon1 );

    while( 1 ) {
        if( self.weaponnumber != self.pers[ "kills" ] - self.startscore ) {
            self.weaponnumber = self.pers[ "kills" ] - self.startscore;

            switch( self.weaponnumber ) {
                case 1:
                    self notify( "nextgun" );
                    self thread rtd_monitor( self.weapon2 );
                    break;
                case 2:
                    self notify( "nextgun" );
                    self thread rtd_monitor( self.weapon3 );
                    break;
                case 3:
                    self notify( "nextgun" );
                    self thread rtd_monitor( self.weapon4 );
                    break;
                case 4:
                    self notify( "nextgun" );
                    self thread rtd_monitor( self.weapon5 );
                    break;
                case 5:
                    self notify( "nextgun" );
                    self thread rtd_monitor( self.weapon6 );
                    break;
                case 6:
                    self notify( "nextgun" );
                    self thread rtd_monitor( self.weapon7 );
                    break;
                case 7:
                    self notify( "nextgun" );
                    self notify( "reward" );
                    break;
            }
        }
        wait 0.05;
    }
}

rtd_laser() {
    level endon( "game_ended" );
    level endon( "gametypechangedrtd" );
    self notify( "newlaser" );
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "newlaser" );

    self laseron( "mp_attachment_lasersight" );
    self playSound( "h1_wpn_rpg_exp_default" );
    location = user_scripts\mp\scripts\util::cursor_pos();
    MagicBullet( "ac130_25mm_mp", self getTagOrigin( "tag_eye" ), location, self );
    wait 0.1;
    self laseroff();
}

rtd_start() {
    level endon( "game_ended" );
    level endon( "gametypechangedrtd" );
    self endon( "disconnect" );
    self endon( "death" );

    self thread rtd_death();

    self Show();

    self setactionslot( 1, "" );
    self.chooseRoll = 0;
    wait 0.05;
    self thread rtd_random();
}

rtd_death() {
    level endon( "game_ended" );
    level endon( "gametypechangedrtd" );
    self endon( "disconnect" );
    self endon( "death" );

    self waittill( "death" );
    self notify( "defaultProj" );
    self notify( "endMultijump" );
    self notify( "endForce" );
    self notify( "endRicochet" );
    self notify( "endQS" );
    self notify( "randRounds" );

    self laseroff();
    self ThermalVisionFOFOverlayOff();
    self Show();
    self setClientDvar( "cg_drawShellshock", 1 );
    self setClientDvar( "cg_drawDamageDirection", 1 );
    self setClientDvar( "player_breath_snd_delay", 1 );
    self setClientDvar( "perk_extraBreath", 5 );
    self setClientDvar( "cg_brass", 1 );
    self setClientDvar( "r_blur", 0 );
    self setClientDvar( "r_specularcolorscale", 0 );
    self setClientDvar( "r_filmusetweaks", 0 );
    self setClientDvar( "r_filmtweakenable", 0 );
    self setClientDvar( "r_filmtweakcontrast", 1.4 );
    self setClientDvar( "r_brightness", 0 );
    self setClientDvar( "fx_drawclouds", 1 );
    self setClientDvar( "cg_blood", 1 );
    self setClientDvar( "r_dlightLimit", 8 );
    self setClientDvar( "r_fog", 1 );
    self setClientDvar( "r_specularmap", 1 );
    self.god_mode = undefined;
    setDvar( "perk_weapReloadMultiplier", 0.5 );
    setDvar( "jump_height", 39 );
}

rtd_random() {
    level endon( "game_ended" );
    level endon( "gametypechangedrtd" );
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "cancelRoll" );

    if( self.chooseRoll == 1 )
        self.chooseRoll = 0;
    else
        self.presentroll = RandomInt( level.rtd_roll_count );
    self.rollstreak = self.rollstreak + 1;

    switch( self.presentroll ) {
        case 0:
            self thread rtd_print_roll( "^2000 - [Emergency Airdrop]" );
            self maps\mp\gametypes\_hardpoints::giveHardpoint( "airdrop_mega_marker_mp" );
            break;
        case 1:
            self thread rtd_print_roll( "^2001 - [1.5 Speed]" );
            self thread rtd_loop( "speed", 1.5 );
            break;
        case 2:
            self thread rtd_print_roll( "^2002 - [Thumper Unlimited Ammo]" );
            self notify( "newRoll" );

            self user_scripts\mp\scripts\player::give_all_perks();
            self thread rtd_stock( 999 );
            self thread rtd_monitor( "h2_m79_mp" );
            break;
        case 3:
            self thread rtd_print_roll( "^2003 - [Teleporter]" );
            self maps\mp\_utility::_beginLocationSelection( "", "map_artillery_selector", true, ( level.mapSize / 5.625 ) );
            self.selectingLocation = true;
            self waittill( "confirm_location", location, directionYaw );
            newLocation = PhysicsTrace( location + ( 0, 0, 1000 ), location - ( 0, 0, 1000 ) );
            self SetOrigin( newLocation );
            self SetPlayerAngles( directionYaw );
            self notify( "used" );
            self endLocationSelection();
            self.selectingLocation = undefined;
            self iPrintlnBold( "^2Teleported^7! Press ^3[{+actionslot 1}] ^7to Teleport Again!" );
            self notifyOnPlayerCommand( "dpad_up", "+actionslot 1" );
            self waittill( "dpad_up" );
            self.chooseRoll = 1;
            self.presentroll = 3;
            self notify( "newRoll" );
            self thread rtd_random();
            break;
        case 4:
            self thread rtd_print_roll( "^1004 - [1 HP]" );
            self.maxhealth = 2;
            self.health = 1;
            break;
        case 5:
            self thread rtd_print_roll( "^1005 - [No ADS]" );
            self allowADS( false );
            break;
        case 6:
            self thread rtd_print_roll( "^2006 - [+200 HP]" );
            self.maxhealth = self.maxhealth + 200;
            self.health = self.maxhealth;
            break;
        case 7:
            self thread rtd_print_roll( "^2007 - [All Perks]" );
            self user_scripts\mp\scripts\player::give_all_perks();
            break;
        case 8:
            self thread rtd_print_roll( "^2008 - [Unlimited Frag Grenades]" );
            self takeWeapon( "h1_concussiongrenade_mp" );
            self takeWeapon( "h1_flashgrenade_mp" );
            self takeWeapon( "h1_smokegrenade_mp" );
            self takeWeapon( self GetCurrentOffhand() );
            wait 0.5;
            self setlethalweapon( "h1_fraggrenade_mp" );
            self setweaponammoclip( "h1_fraggrenade_mp", 99 );
            self GiveMaxAmmo( "h1_fraggrenade_mp" );
            self thread rtd_nades( 99 );
            break;
        case 9:
            self thread rtd_print_roll( "^2009 - [RPD Rapid Fire]" );
            self notify( "newRoll" );

            self thread rtd_monitor( "h2_rpd_mp_fastfire_fmj_foregrip_xmagmwr" + common_scripts\utility::random( level.camo_array ) );
            self thread rtd_stock( 999 );
            break;
        case 10:
            self thread rtd_print_roll( "^3010 - [Drone Swarm Vision]" );
            self thread rtd_loop( "vision", "drone_swarm" );
            break;
        case 11:
            self thread rtd_print_roll( "^3011 - [Thermal Vision]" );
            self maps\mp\_utility::giveperk( "specialty_thermal" );
            break;
        case 12:
            self thread rtd_print_roll( "^1012 - [Space]" );
            x = randomIntRange( -75, 75 );
            y = randomIntRange( -75, 75 );
            z = 45;
            space_location = ( 0 + x, 0 + y, 170000 + z );
            space_angle = ( 0, 176, 0 );
            self setOrigin( space_location );
            self setPlayerAngles( space_angle );
            wait 2;
            self iPrintlnBold( "Press ^3[{+actionslot 1}] ^7to Suicide" );
            self notifyOnPlayerCommand( "dpad_up", "+actionslot 1" );
            self waittill( "dpad_up" );
            self suicide();
            break;
        case 13:
            self thread rtd_print_roll( "^3013 - [Inverted Contrast]" );
            self thread rtd_loop( "vision", "cheat_invert_contrast" );
            break;
        case 14:
            self thread rtd_print_roll( "^3014 - [Melee Only]" );
            self notify( "newRoll" );
            self endon( "newRoll" );

            self user_scripts\mp\scripts\player::give_all_perks();
            self thread rtd_monitor( "h2_coltanaconda_mp_tacknifecolt44" + common_scripts\utility::random( level.camo_array ) );
            self thread rtd_loop( "speed", 1.2 );
            self thread rtd_ammo( 0 );
            self thread rtd_stock( 0 );
            break;
        case 15:
            self thread rtd_print_roll( "^1015 - [Half Speed]" );
            self thread rtd_loop( "speed", 0.50 );
            break;
        case 16:
            self thread rtd_print_roll( "^3016 - [Model 1887 FMJ Akimbo + Unlimited Ammo]" );
            self notify( "newRoll" );

            self user_scripts\mp\scripts\player::give_all_perks();
            self thread rtd_monitor( "h2_model1887_mp_akimbo_fmj" + common_scripts\utility::random( level.camo_array ) );
            self thread rtd_ammo( 999 );
            break;
        case 17:
            self thread rtd_print_roll( "^1017 - [Nuke Vision]" );
            self thread rtd_loop( "vision", "mpnuke_aftermath" );
            break;
        case 18:
            self thread rtd_print_roll( "^2018 - [Unlimited Ammo]" );
            self thread rtd_ammo( 999 );
            break;
        case 19:
            self thread rtd_print_roll( "^2019 - [Wallhack For 30 Seconds]" );
            self ThermalVisionFOFOverlayOn();
            wait 30;
            self iPrintlnBold( "Wallhack: ^1Off" );
            self ThermalVisionFOFOverlayOff();
            self thread rtd_random();
            break;
        case 20:
            self thread rtd_print_roll( "^2020 - [+100 HP + Reroll]" );
            self.maxhealth = self.maxhealth + 100;
            self.health = self.maxhealth;
            wait 2;
            self thread rtd_random();
            break;
        case 21:
            self thread rtd_print_roll( "^2021 - [Invulnerable For 10 Seconds]" );
            self.god_mode = 1;
            wait 10;
            self iPrintlnBold( "God Mode: ^1Off" );
            self.god_mode = 0;
            wait 1.5;
            self thread rtd_random();
            break;
        case 22:
            self thread rtd_print_roll( "^1022 - [Throwing Knife Only]" );
            self notify( "newRoll" );
            self notify( "endmonitor" );
            self endon( "newRoll" );

            self user_scripts\mp\scripts\player::give_all_perks();
            self thread rtd_nades( 99 );

            while( 1 ) {
                if( self getCurrentWeapon( ) != "iw9_throwknife_mp" ) {
                    self takeAllWeapons();
                    self giveWeapon( "iw9_throwknife_mp" );
                    self switchToWeapon( "iw9_throwknife_mp" );
                }
                wait 0.5;
            }
            break;
        case 23:
            self thread rtd_print_roll( "^2023 - [RPG Only]" );
            self notify( "newRoll" );

            self user_scripts\mp\scripts\player::give_all_perks();
            self thread rtd_stock( 999 );
            self thread rtd_monitor( "h2_rpg_mp" );
            break;
        case 24:
            self thread rtd_print_roll( "^1024 - [No Jump, Sprint, ADS]" );
            self allowJump( false );
            self allowSprint( false );
            self allowADS( false );
            break;
        case 25:
            self thread rtd_print_roll( "^3025 - [AZUMIKKEL's Class]" );
            self notify( "newRoll" );
            self notify( "endmonitor" );

            self takeAllWeapons();
            self user_scripts\mp\scripts\player::give_all_perks();
            self giveWeapon( "h2_ump45_mp_silencersmg_xmagmwr_camo009" );
            self GiveMaxAmmo( "h2_ump45_mp_silencersmg_xmagmwr_camo009" );
            self giveWeapon( "h2_aa12_mp_foregrip_xmagmwr_camo009" );
            self GiveMaxAmmo( "h2_aa12_mp_foregrip_xmagmwr_camo009" );
            self setlethalweapon( "h2_semtex_mp" );
            self setweaponammoclip( "h2_semtex_mp", 99 );
            self GiveMaxAmmo( "h2_semtex_mp" );
            self settacticalweapon( "h1_concussiongrenade_mp" );
            self setweaponammoclip( "h1_concussiongrenade_mp", 99 );
            self GiveMaxAmmo( "h1_concussiongrenade_mp" );
            wait 0.05;
            self switchToWeapon( "h2_ump45_mp_silencersmg_xmagmwr_camo009" );
            break;
        case 26:
            self thread rtd_print_roll( "^1026 - [Freeze Every 8 Seconds]" );

            while( 1 ) {
                wait 8;
                self iPrintlnBold( "^1Frozen" );
                self freezeControls( true );
                wait 4;
                self iPrintlnBold( "^2Unfrozen" );
                self freezeControls( false );
            }
            break;
        case 27:
            self thread rtd_print_roll( "^1027 - [Earthquakes]" );

            while( 1 ) {
                earthquake( 0.6, 10, self.origin, 90 );
                wait 0.5;
            }
            break;
        case 28:
            self thread rtd_print_roll( "^2028 - [MW3 Class]" );
            self notify( "newRoll" );
            self notify( "endmonitor" );

            self takeAllWeapons();
            self user_scripts\mp\scripts\player::give_all_perks();
            self giveWeapon( "h2_cm901_mp_fastfire_xmagmwr_camo029" );
            self GiveMaxAmmo( "h2_cm901_mp_fastfire_xmagmwr_camo029" );
            self giveWeapon( "h2_bizon_mp_fastfire_xmagmwr_camo030" );
            self GiveMaxAmmo( "h2_bizon_mp_fastfire_xmagmwr_camo030" );
            self setlethalweapon( "h1_fraggrenade_mp" );
            self setweaponammoclip( "h1_fraggrenade_mp", 99 );
            self GiveMaxAmmo( "h1_fraggrenade_mp" );
            self settacticalweapon( "h1_smokegrenade_mp" );
            self setweaponammoclip( "h1_smokegrenade_mp", 99 );
            self GiveMaxAmmo( "h1_smokegrenade_mp" );
            wait 0.05;
            self switchToWeapon( "h2_cm901_mp_fastfire_xmagmwr_camo029" );
            break;
        case 29:
            self thread rtd_print_roll( "^3029 - [MP5K Akimbo]" );
            self notify( "newRoll" );

            self user_scripts\mp\scripts\player::give_all_perks();
            self thread rtd_monitor( "h2_mp5k_mp_akimbo_fmj_silencersmg_xmagmwr" + common_scripts\utility::random( level.camo_array ) );
            self thread rtd_stock( 999 );
            break;
        case 30:
            self thread rtd_print_roll( "^2030 - [Unlimited Ammo + Reroll]" );
            self thread rtd_ammo( 999 );
            wait 2;
            self thread rtd_random();
            break;
        case 31:
            self thread rtd_print_roll( "^2031 - [BO1 Class]" );
            self notify( "newRoll" );
            self notify( "endmonitor" );

            self takeAllWeapons();
            self user_scripts\mp\scripts\player::give_all_perks();
            self giveWeapon( "h1_galil_mp_xmagmwr" );
            self GiveMaxAmmo( "h1_galil_mp_xmagmwr" );
            self giveWeapon( "h1_colt45_mp_silencermwr_xmagmwr" );
            self GiveMaxAmmo( "h1_colt45_mp_silencermwr_xmagmwr" );
            self setlethalweapon( "h1_fraggrenade_mp" );
            self setweaponammoclip( "h1_fraggrenade_mp", 99 );
            self GiveMaxAmmo( "h1_fraggrenade_mp" );
            self settacticalweapon( "h1_smokegrenade_mp" );
            self setweaponammoclip( "h1_smokegrenade_mp", 99 );
            self GiveMaxAmmo( "h1_smokegrenade_mp" );
            wait 0.05;
            self switchToWeapon( "h1_galil_mp_xmagmwr" );
            self thread rtd_ammo( 999 );
            break;
        case 32:
            self thread rtd_print_roll( "^3032 - [USP FMJ Akimbo + Unlimited Ammo]" );
            self notify( "newRoll" );

            self thread rtd_monitor( "h2_usp_mp_akimbo_fmj_silencerpistol_xmagmwr" + common_scripts\utility::random( level.camo_array ) );
            self thread rtd_ammo( 999 );
            break;
        case 33:
            self thread rtd_print_roll( "^2033 - [Extra Speed + Reroll]" );
            wait 1;
            self thread rtd_random();
            wait 1;
            self thread rtd_loop( "speed", 1.5 );
            break;
        case 34:
            self thread rtd_print_roll( "^2034 - [Walking AC130 25mm]" );
            self notify( "newRoll" );

            self takeAllWeapons();
            self thread rtd_monitor( "ac130_25mm_mp" );
            break;
        case 35:
            self thread rtd_print_roll( "^2035 - [Invisibility For 15 Seconds]" );
            self Hide();
            wait 15;
            self iPrintlnBold( "Invisibility: ^1Off" );
            self Show();
            wait 2;
            self thread rtd_random();
            break;
        case 36:
            self thread rtd_print_roll( "^3036 - [Night Vision]" );
            self thread rtd_loop( "vision", "default_night_mp" );
            break;
        case 37:
            self thread rtd_print_roll( "^1037 - [Last Mag, Make It Count]" );
            self thread rtd_stock( 0 );
            break;
        case 38:
            self thread rtd_print_roll( "^1038 - [Javelin Only]" );
            self notify( "newRoll" );

            self user_scripts\mp\scripts\player::give_all_perks();
            self thread rtd_stock( 999 );
            self thread rtd_monitor( "javelin_mp" );
            break;
        case 39:
            self thread rtd_print_roll( "^3039 - [Night Effect]" );
            self thread rtd_loop( "vision", "cobra_sunset3" );
            break;
        case 40:
            self thread rtd_print_roll( "^1040 - [Infected]" );
            self notify( "newRoll" );

            self takeAllWeapons();
            self user_scripts\mp\scripts\player::give_all_perks();
            self thread rtd_monitor( "h2_infect_mp" );
            break;
        case 41:
            self thread rtd_print_roll( "^2041 - [SPAS-12 FMJ Grip + Unlimited Ammo]" );
            self notify( "newRoll" );

            self user_scripts\mp\scripts\player::give_all_perks();
            self thread rtd_monitor( "h2_spas12_mp_fmj_foregrip" + common_scripts\utility::random( level.camo_array ) );
            self thread rtd_ammo( 999 );
            break;
        case 42:
            self thread rtd_print_roll( "^2042 - [Ranger Akimbo + Unlimited Ammo]" );
            self notify( "newRoll" );

            self user_scripts\mp\scripts\player::give_all_perks();
            self thread rtd_monitor( "h2_ranger_mp_akimbo" + common_scripts\utility::random( level.camo_array ) );
            self thread rtd_ammo( 999 );
            break;
        case 43:
            self thread rtd_print_roll( "^2043 - [FAL Red Dot Silenced + Unlimited Ammo]" );
            self notify( "newRoll" );

            self user_scripts\mp\scripts\player::give_all_perks();
            self thread rtd_monitor( "h2_fal_mp_reflex_silencerar" + common_scripts\utility::random( level.camo_array ) );
            self thread rtd_ammo( 999 );
            break;
        case 44:
            self thread rtd_print_roll( "^2044 - [Unlimited Claymores]" );
            self takeWeapon( "h1_concussiongrenade_mp" );
            self takeWeapon( "h1_flashgrenade_mp" );
            self takeWeapon( "h1_smokegrenade_mp" );
            self takeWeapon( self GetCurrentOffhand() );
            wait 0.5;
            self setlethalweapon( "h1_claymore_mp" );
            self setweaponammoclip( "h1_claymore_mp", 99 );
            self GiveMaxAmmo( "h1_claymore_mp" );
            self thread rtd_nades( 99 );
            break;
        case 45:
            self thread rtd_print_roll( "^3045 - [Greyscale Vision]" );
            self thread rtd_loop( "vision", "ac130" );
            break;
        case 46:
            self thread rtd_print_roll( "^3046 - [1/13 Chance of Nuke + Reroll]" );
            wait 2;
            successroll = RandomInt( 12 );
            self iPrintlnBold( "Roll " + ( successroll + 1 ) + " for a ^:NUKE^7!" );
            wait 1;
            self iPrintlnBold( "Rolling..." );
            wait 1;
            rollnumb = RandomInt( 12 );

            if( rollnumb == successroll ) {
                self iPrintlnBold( "You Rolled " + ( successroll + 1 ) + " - ^2NUKE GRANTED" );
                self maps\mp\gametypes\_hardpoints::giveHardpoint( "nuke_mp", true );
            }
            else
                self iPrintlnBold( "You Rolled " + ( rollnumb + 1 ) + " - ^1NUKE DENIED" );
            wait 2;
            self iPrintlnBold( "Rerolling..." );
            wait 1;
            self thread rtd_random();
            break;
        case 47:
            self thread rtd_print_roll( "^3047 - [Sepia Vision]" );
            self thread rtd_loop( "vision", "sepia" );
            break;
        case 48:
            self thread rtd_print_roll( "^2048 - [Flashing Invisible]" );

            while( 1 ) {
                self Hide();
                wait 0.50;
                self Show();
                wait 0.50;
            }
            break;
        case 49:
            self thread rtd_print_roll( "^1049 - [No Perks]" );
            self maps\mp\_utility::_clearperks();
            break;
        case 50:
            self thread rtd_print_roll( "^1050 - [No Primary]" );
            wait 0.05;
            self takeWeapon( self getCurrentWeapon() );
            wait 1;
            self iPrintlnBold( "^1Switch to Your Secondary!" );
            break;
        case 51:
            self thread rtd_print_roll( "^1051 - [ADS to Shoot]" );
            self notifyOnPlayercommand( "mouse2", "+speed_throw" );
            self notifyOnPlayercommand( "mouse2O", "-speed_throw" );
            self thread rtd_stock( 0 );
            self thread rtd_qs();

            while( 1 ) {
                self thread rtd_ammo( 0 );
                self waittill( "mouse2" );
                self notify( "endammo" );
                self setWeaponAmmoClip( self getCurrentWeapon(), 99 );
                self waittill( "mouse2O" );
                self notify( "endammo" );
            }
            break;
        case 52:
            self thread rtd_print_roll( "^1052 - [Hold F to Move]" );

            while( 1 ) {
                if( self UseButtonPressed( ) )
                    self freezeControls( false );
                else
                    self freezeControls( true );
                wait 0.05;
            }
            break;
        case 53:
            self thread rtd_print_roll( "^3053 - [Mini Pistol Gun Game]" );
            self notify( "newRoll" );

            self.weapon1 = "h2_beretta393_mp_fmj" + common_scripts\utility::random( level.camo_array );
            self.weapon2 = "h2_deserteagle_mp_fmj";
            self.weapon3 = "h2_usp_mp_fmj" + common_scripts\utility::random( level.camo_array );
            self.weapon4 = "h2_m9_mp_fmj" + common_scripts\utility::random( level.camo_array );
            self.weapon5 = "h2_coltanaconda_mp_fmj" + common_scripts\utility::random( level.camo_array );
            self.weapon6 = "h2_colt45_mp_fmj" + common_scripts\utility::random( level.camo_array );
            self.weapon7 = "h1_deserteagle55_mp_xmagmwr";
            self thread rtd_gun_game();
            self waittill( "reward" );
            self thread rtd_monitor( "h1_deserteagle55_mp_xmagmwr" );
            self thread rtd_explosive_rounds( 9999 );
            self iPrintlnBold( "^2You've Completed The Gun Game!" );
            wait 1.5;
            self iPrintlnBold( "Reward: ^:Explosive Rounds" );
            break;
        case 54:
            self thread rtd_print_roll( "^1054 - [Your Gun May Jam + No Equipment]" );
            self notifyOnPlayerCommand( "dpad_down", "+actionslot 2" );
            curwep = self getCurrentWeapon();
            self takeAllWeapons();

            if( isSubStr( curwep, "akimbo" ) )
                self giveWeapon( curwep );
            else
                self giveWeapon( curwep );

            while( 1 ) {
                self waittill ( "weapon_fired" );
                chance = RandomInt( 15 );

                if( chance == 0 ) {
                    self setWeaponAmmoClip( self getCurrentWeapon(), 0 );
                    self setWeaponAmmoStock( self getCurrentWeapon(), 0 );
                    self iPrintlnBold( "^1Gun jammed! ^7Keep pressing ^3[{+actionslot 2}] ^7to fix your weapon!" );
                    self waittill( "dpad_down" );
                    self waittill( "dpad_down" );
                    self waittill( "dpad_down" );
                    self waittill( "dpad_down" );
                    self waittill( "dpad_down" );
                    self waittill( "dpad_down" );
                    self waittill( "dpad_down" );
                    self waittill( "dpad_down" );
                    self iPrintlnBold( "^2Weapon fixed!" );
                    self setWeaponAmmoStock( self getCurrentWeapon(), 999 );
                }
            }
            break;
        case 55:
            self thread rtd_print_roll( "^3055 - [Purple Vision]" );
            self VisionSetNakedForPlayer( "default_night_mp", 1 );
            wait 0.5;
            self VisionSetNakedForPlayer( "ac130_inverted", 2000 );
            break;
        case 56:
            self thread rtd_print_roll( "^3056 - [Blind But Wallhack]" );
            self thread rtd_loop( "vision", "black_bw" );
            self ThermalVisionFOFOverlayOn();
            break;
        case 57:
            self thread rtd_print_roll( "^3057 - [G18 Akimbo FMJ]" );
            self notify( "newRoll" );

            self user_scripts\mp\scripts\player::give_all_perks();
            self thread rtd_monitor( "h2_glock_mp_akimbo_fmj_xmagmwr" + common_scripts\utility::random( level.camo_array ) );
            self thread rtd_stock( 999 );
            break;
        case 58:
            self thread rtd_print_roll( "^2058 - [EMP Grenades Only]" );

            self notify( "newRoll" );
            self notify( "endmonitor" );
            self endon( "newRoll" );

            self user_scripts\mp\scripts\player::give_all_perks();
            self thread rtd_nades( 99 );
            while( 1 ) {
                self StopShellShock();
                if( self getCurrentWeapon( ) != "h2_empgrenade_mp" ) {
                    self takeAllWeapons();
                    self giveWeapon( "h2_empgrenade_mp" );
                    self switchToWeapon( "h2_empgrenade_mp" );
                }
                wait 0.5;
            }
            break;
        case 59:
            self thread rtd_print_roll( "^3059 - [Underwater Vision]" );

            self thread rtd_loop( "vision", "oilrig_underwater" );
            break;
        case 60:
            self thread rtd_print_roll( "^2060 - [Thermal Class]" );
            self notify( "newRoll" );
            self notify( "endmonitor" );

            self takeAllWeapons();
            self thread rtd_monitor( "h2_aug_mp_thermal_xmagmwr" + common_scripts\utility::random( level.camo_array ) );

            while( 1 ) {
                self settacticalweapon( "h1_smokegrenade_mp" );
                self setweaponammoclip( "h1_smokegrenade_mp", 99 );
                self GiveMaxAmmo( "h1_smokegrenade_mp" );
                wait 3;
            }
            break;
        case 61:
            self thread rtd_print_roll( "^1061 - [Drugs]" );

            while( 1 ) {
                self VisionSetNakedForPlayer( "cheat_chaplinnight", 1 );
                wait 1;
                self VisionSetNakedForPlayer( "cobra_sunset3", 1 );
                wait 1;
                self VisionSetNakedForPlayer( "mpnuke", 1 );
                wait 1;
            }
            break;
        case 62:
            self thread rtd_print_roll( "^2062 - [Kills Increase HP]" );

            self.rollstreak = self.rollstreak + 1;
            self.startscore = self.pers[ "kills" ];
            self.streaknumber = 0;
            while( 1 ) {
                if( self.streaknumber != self.pers[ "kills" ] - self.startscore ) {
                    self.streaknumber = self.pers[ "kills" ] - self.startscore;
                    if( self.streaknumber == 11 )
                        break;
                    self thread rtd_print_roll( "^5HP Lvl " + self.streaknumber + " [+" + 40 * self.streaknumber + " Bonus HP]" );
                    self.maxhealth = self.maxhealth + 40;
                    self.health = self.health + 40;
                }
                wait 0.05;
            }
            break;
        case 63:
            self thread rtd_print_roll( "^3063 - [+400 HP But No Regen]" );

            self.maxhealth = self.maxhealth + 400;
            self.health = self.maxhealth;
            while( 1 ) {
                self.maxhealth = self.health;
                wait 0.05;
            }
            break;
        case 64:
            self thread rtd_print_roll( "^2064 - [Cycling Lethals]" );

            self notifyOnPlayercommand( "G", "+frag" );
            self takeWeapon( self getCurrentOffhand() );
            while( 1 ) {
                self takeWeapon( self getCurrentOffhand() );
                self setlethalweapon( "h1_fraggrenade_mp" );
                self setWeaponAmmoClip( "h1_fraggrenade_mp", 1 );
                self waittill( "G" );
                wait 1;
                self takeWeapon( self getCurrentOffhand() );
                self setlethalweapon( "iw9_throwknife_mp" );
                self setWeaponAmmoClip( "iw9_throwknife_mp", 1 );
                self waittill( "G" );
                wait 1;
                self takeWeapon( self getCurrentOffhand() );
                self setlethalweapon( "h2_semtex_mp" );
                self setWeaponAmmoClip( "h2_semtex_mp", 1 );
                self waittill( "G" );
                wait 1;
                self takeWeapon( self getCurrentOffhand() );
                self setlethalweapon( "h1_claymore_mp" );
                self setWeaponAmmoClip( "h1_claymore_mp", 1 );
                self waittill( "G" );
                wait 1;
            }
            break;
        case 65:
            self thread rtd_print_roll( "^1065 - [Lag]" );

            while( 1 ) {
                self freezeControls( true );
                wait 0.20;
                self freezeControls( false );
                wait 1;
            }
            break;
        case 66:
            self thread rtd_print_roll( "^2066 - [Only Die From Melee or HS]" );
            self notify( "killhp" );

            self.maxhealth = 1000;

            while( 1 ) {
                if( self.health >= self.maxhealth - 139 )
                    if( self.health < self.maxhealth - 130 )
                        self suicide();
                else
                    self.health = self.maxhealth;
                wait 0.05;
            }
            break;
        case 67:
            self thread rtd_print_roll( "^2067 - [Double Roll]" );
            wait 1;
            self thread rtd_random();
            wait 1;
            self thread rtd_random();
            break;
        case 68:
            self thread rtd_print_roll( "^1068 - [Constantly Losing HP]" );

            while( 1 ) {

                if( self.health > 5 )
                    self.health = self.health - 5;
                else
                    self suicide();
                wait 2;
            }
            break;
        case 69:
            self thread rtd_print_roll( "^2069 - [Ability: ^:Cloaking^2]" );
            self notify( "newability" );
            self endon( "newability" );

            self notifyOnPlayerCommand( "dpad_down", "+actionslot 2" );
            wait 2;

            while( 1 ) {
                self iPrintlnBold( "Press ^3[{+actionslot 2}] ^7For Cloaking" );
                self waittill( "dpad_down" );
                self hide();
                self iPrintlnBold( "^2Cloaked For 5 Seconds" );
                wait 5;
                self show();
                self iPrintlnBold( "Cloaking: ^1Off" );
                wait 2;
                self iPrintlnBold( "^3Recharging..." );
                wait 13;
            }
            break;
        case 70:
            self thread rtd_print_roll( "^1070 - [Crouch Only]" );

            while( 1 ) {
                self SetStance( "crouch" );
                wait 0.05;
            }
            break;
        case 71:
            self thread rtd_print_roll( "^2071 - [Exorcist]" );

            while( 1 ) {
                self SetStance( "prone" );
                self SetMoveSpeedScale( 9 );
                wait 0.05;
            }
            break;
        case 72:
            self thread rtd_print_roll( "^1072 - [Blackouts]" );

            while( 1 ) {
                self VisionSetNakedForPlayer( "black_bw", 1 );
                wait 1;
                self VisionSetNakedForPlayer( "dcemp_emp", 1 );
                wait 3;
            }
            break;
        case 73:
            self thread rtd_print_roll( "^3073 - [Stun Grenades Only]" );
            self notify( "newRoll" );
            self notify( "endmonitor" );
            self endon( "newRoll" );

            self user_scripts\mp\scripts\player::give_all_perks();
            self thread rtd_nades( 99 );

            while( 1 ) {
                self StopShellShock();

                if( self getCurrentWeapon( ) != "h1_concussiongrenade_mp" ) {
                    self takeAllWeapons();
                    self giveWeapon( "h1_concussiongrenade_mp" );
                    self switchToWeapon( "h1_concussiongrenade_mp" );
                }
                wait 0.5;
            }
            break;
        case 74:
            self thread rtd_print_roll( "^3074 - [1 HP But Kills Give Evasion]" );
            self notify ( "killhp" );

            self.rollstreak = self.rollstreak + 1;
            self.startscore = self.pers[ "kills" ];
            self.streaknumber = "";
            wait 2;

            while( 1 ) {
                if( self.streaknumber != self.pers[ "kills" ] - self.startscore ) {
                    self.streaknumber = self.pers[ "kills" ] - self.startscore;
                    if( self.streaknumber == 0 )
                        self.hitchance = 80;
                    else {
                        if( self.streaknumber == 1 )
                            self.hitchance = 55;
                        else {
                            if( self.streaknumber == 11 )
                                break;
                            else
                                self.hitchance = int( 75 / self.streaknumber );
                        }
                    }
                    self thread rtd_print_roll( "^5Evasion Lvl " + self.streaknumber + " [" + self.hitchance + " Percent Chance To Evade]" );
                    self notify( "cancelevasion" );
                    self thread rtd_evasion( self.hitchance );
                }
                wait 0.05;
            }
            break;
        case 75:
            self thread rtd_print_roll( "^1075 - [Camper]" );
            wait 3;
            self rtd_timer( 15, 1 );
            self iPrintlnBold( "You're Now rtd_camping... Press ^3[{+actionslot 1}] ^7to Suicide" );
            self thread rtd_camping();
            self notifyOnPlayerCommand( "dpad_up", "+actionslot 1" );
            self waittill( "dpad_up" );
            self suicide();
            break;
        case 76:
            self thread rtd_print_roll( "^2076 - [1 Shot 1 Kill Every 3 Seconds]" );
            self notify( "newRoll" );
            self notify( "endammo" );
            self notify( "endstock" );

            self user_scripts\mp\scripts\player::give_all_perks();
            self thread rtd_monitor( "h2_coltanaconda_mp_camo009" );
            self thread rtd_explosive_rounds( 9999 );

            while( 1 ) {
                self setWeaponAmmoClip( "h2_coltanaconda_mp_camo009", 1 );
                self setWeaponAmmoStock( "h2_coltanaconda_mp_camo009", 0 );
                self waittill( "weapon_fired" );
                wait 2.75;
            }
            break;
        case 77:
            self thread rtd_print_roll( "^3077 - [Laser]" );
            self laseron( "mp_attachment_lasersight" );
            break;
        case 78:
            self thread rtd_print_roll( "^378 - [Roll Every Kill]" );

            for( ;; ) {
                self waittill( "killed_enemy" );
                self thread rtd_random();
                wait 0.05;
            }
            break;
        case 79:
            self thread rtd_print_roll( "^2079 - [Hold ^3[{+activate}] ^2And Press ^3[{+gostand}] ^2For Higher Jump]" );
            self thread rtd_highjump();
            self maps\mp\_utility::giveperk( "specialty_falldamage", 0 );
            break;
        case 80:
            self thread rtd_print_roll( "^1080 - [Lose HP When Firing]" );

            while( 1 ) {
                self waittill ( "weapon_fired" );
                self.health = self.health - 3;

                if( self.health < 1 )
                    self suicide();
            }
            break;
        case 81:
            self thread rtd_print_roll( "^2081 - [Ability: ^:God Mode^2]" );
            self notify( "newability" );
            self endon( "newability" );

            self notifyOnPlayerCommand( "dpad_down", "+actionslot 2" );
            wait 2;

            while( 1 ) {
                self iPrintlnBold( "Press ^3[{+actionslot 2}] ^7For 5 Seconds of Invulnerability" );
                self waittill( "dpad_down" );
                self iPrintlnBold( "^2God Mode For 5 Seconds" );
                self.health = 0;
                wait 5;
                self.health = self.maxhealth;
                self iPrintlnBold( "God Mode: ^1Off" );
                wait 2;
                self iPrintlnBold( "^3Recharging..." );
                wait 13;
            }
            break;
        case 82:
            self thread rtd_print_roll( "^2082 - [Ability: ^:Full Heal^2]" );
            self notify( "newability" );
            self endon( "newability" );

            self notifyOnPlayerCommand( "dpad_down", "+actionslot 2" );
            wait 2;

            while( 1 ) {
                self iPrintlnBold( "Press ^3[{+actionslot 2}] ^7For Full Health" );
                self waittill( "dpad_down" );

                if( self.health != self.maxhealth ) {
                    self.health = self.maxhealth;
                    self iPrintlnBold( "^2Fully Healed" );
                    wait 2;
                    self iPrintlnBold( "^3Recharging..." );
                    wait 8;
                }
                else {
                    self iPrintlnBold( "^1Health Already Full" );
                    wait 1.5;
                }
            }
            break;
        case 83:
            self thread rtd_print_roll( "^3083 - [Mini Akimbo Gun Game]" );
            self notify( "newRoll" );

            self.weapon1 = "h2_usp_mp_akimbo" + common_scripts\utility::random( level.camo_array );
            self.weapon2 = "h2_tmp_mp_akimbo" + common_scripts\utility::random( level.camo_array );
            self.weapon3 = "h2_model1887_mp_akimbo" + common_scripts\utility::random( level.camo_array );
            self.weapon4 = "h2_mp5k_mp_akimbo" + common_scripts\utility::random( level.camo_array );
            self.weapon5 = "h2_kriss_mp_akimbo" + common_scripts\utility::random( level.camo_array );
            self.weapon6 = "h2_ak74u_mp_akimbo" + common_scripts\utility::random( level.camo_array );
            self.weapon7 = "h2_aa12_mp_akimbo" + common_scripts\utility::random( level.camo_array );
            self thread rtd_gun_game();
            self waittill( "reward" );
            self user_scripts\mp\scripts\player::give_all_perks();
            self thread rtd_loop( "speed", 2 );
            self thread rtd_ammo( 99 );
            self iPrintlnBold( "^2You've Completed The Gun Game!" );
            wait 1.5;
            self iPrintlnBold( "Reward: ^:Double Speed + Unlimited Ammo + All Perks" );
            break;
        case 84:
            self thread rtd_print_roll( "^2084 - [Press ^3[{+activate}] ^2to Save Position / ^3[{+actionslot 2}] ^2to Load Position]" );
            self thread rtd_save_pos();
            self thread rtd_load_pos();
            break;
        case 85:
            self thread rtd_print_roll( "^2085 - [Cold Blooded, Ninja Pro]" );
            self maps\mp\_utility::giveperk( "specialty_coldblooded" );
            self maps\mp\_utility::giveperk( "specialty_spygame" );
            self maps\mp\_utility::giveperk( "specialty_heartbreaker" );
            self maps\mp\_utility::giveperk( "specialty_quieter" );
            break;
        case 86:
            self thread rtd_print_roll( "^3086 - [Mini Bling Gun Game]" );
            self notify( "newRoll" );

            self.weapon1 = "h2_m9_mp_fmj_tacknifem9" + common_scripts\utility::random( level.camo_array );
            self.weapon2 = "h2_pp2000_mp_silencerpistol_xmagmwr" + common_scripts\utility::random( level.camo_array );
            self.weapon3 = "h2_m1014_mp_foregrip_xmagmwr" + common_scripts\utility::random( level.camo_array );
            self.weapon4 = "h2_ump45_mp_holo_silencersmg" + common_scripts\utility::random( level.camo_array );
            self.weapon5 = "h2_aug_mp_foregrip_silencerar" + common_scripts\utility::random( level.camo_array );
            self.weapon6 = "h2_masada_mp_fmj_silencersmg" + common_scripts\utility::random( level.camo_array );
            self.weapon7 = "h2_fn2000_mp_reflex_silencerar" + common_scripts\utility::random( level.camo_array );
            self thread rtd_gun_game();
            self waittill( "reward" );
            self user_scripts\mp\scripts\player::give_all_perks();
            self thread rtd_ammo( 99 );
            self iPrintlnBold( "^1You've Completed The Gun Game!" );
            wait 1.5;
            self iPrintlnBold( "Reward: ^:All Perks + Unlimited ammo" );
            break;
        case 87:
            self thread rtd_print_roll( "^2087 - [Kills Give Boosts]" );
            self.rollstreak = self.rollstreak + 1;
            self.upgstart = 1;
            self.startscore = self.pers[ "kills" ];
            self thread rtd_kill_upgrades();
            break;
        case 88:
            self thread rtd_print_roll( "^3088 - [Magnum FMJ Akimbo + Unlimited Ammo]" );
            self notify( "newRoll" );

            self thread rtd_monitor( "h2_coltanaconda_mp_akimbo_fmj_xmagmwr" + common_scripts\utility::random( level.camo_array ) );
            self thread rtd_ammo( 99 );
            break;
        case 89:
            self thread rtd_print_roll( "^2089 - [WWII Class]" );
            self notify( "newRoll" );
            self notify( "endmonitor" );

            self takeAllWeapons();
            self user_scripts\mp\scripts\player::give_all_perks();
            self giveWeapon( "h1_mp44_mp_xmagmwr" );
            self GiveMaxAmmo( "h1_mp44_mp_xmagmwr" );
            self giveWeapon( "h1_colt45_mp_xmagmwr" );
            self GiveMaxAmmo( "h1_colt45_mp_xmagmwr" );
            self setlethalweapon( "h1_fraggrenade_mp" );
            self setweaponammoclip( "h1_fraggrenade_mp", 99 );
            self GiveMaxAmmo( "h1_fraggrenade_mp" );
            self settacticalweapon( "h1_smokegrenade_mp" );
            self setweaponammoclip( "h1_smokegrenade_mp", 99 );
            self GiveMaxAmmo( "h1_smokegrenade_mp" );
            wait 0.05;
            self switchToWeapon( "h1_mp44_mp_xmagmwr" );
            break;
        case 90:
            self thread rtd_print_roll( "^2090 - [Constantly Damage Nearby Enemies]" );
            self thread rtd_loop( "speed", 1.25 );

            while( 1 ) {
                RadiusDamage( self.origin, 500, 51, 10, self );
                if( self.health == self.maxhealth - 51 )
                    self.health = self.maxhealth;
                if( self.health < self.maxhealth - 51 )
                    self.health = self.health + 51;
                self StopShellShock();
                wait 0.50;
            }
            break;
        case 91:
            self thread rtd_print_roll( "^3091 - [Mini Sprayer Gun Game]" );
            self notify( "newRoll" );

            self.weapon1 = "h2_glock_mp_akimbo" + common_scripts\utility::random( level.camo_array );
            self.weapon2 = "h2_tmp_mp_akimbo" + common_scripts\utility::random( level.camo_array );
            self.weapon3 = "h2_aa12_mp_foregrip" + common_scripts\utility::random( level.camo_array );
            self.weapon4 = "h2_uzi_mp_akimbo_silencersmg" + common_scripts\utility::random( level.camo_array );
            self.weapon5 = "h2_rpd_mp_foregrip_silencerlmg" + common_scripts\utility::random( level.camo_array );
            self.weapon6 = "h2_barrett_mp_acog_xmagmwr" + common_scripts\utility::random( level.camo_array );
            self.weapon7 = "h2_ak47_mp_reflex_silencerar" + common_scripts\utility::random( level.camo_array );
            self thread rtd_gun_game();
            self waittill( "reward" );
            self notify( "endstock" );
            self.maxhealth = self.maxhealth + 200;
            self.health = self.maxhealth;
            self user_scripts\mp\scripts\player::give_all_perks();
            self thread rtd_loop( "speed", 2 );
            self thread rtd_monitor( "h2_usp_mp_tacknifeusp" + common_scripts\utility::random( level.camo_array ) );
            self thread rtd_stock( 0 );
            self thread rtd_ammo( 0 );
            self iPrintlnBold( "^2You've Completed The Gun Game!" );
            wait 1.5;
            self iPrintlnBold( "Reward: ^:Knife Runner + 200 HP" );
            break;
        case 92:
            self thread rtd_print_roll( "^3092 - [C4 Only]" );
            self notify( "newRoll" );
            self notify( "endmonitor" );
            self endon( "newRoll" );

            self user_scripts\mp\scripts\player::give_all_perks();
            self thread rtd_nades( 99 );

            while( 1 ) {
                if( self getCurrentWeapon( ) != "h1_c4_mp" ) {
                    self takeAllWeapons();
                    self giveWeapon( "h1_c4_mp" );
                    self switchToWeapon( "h1_c4_mp" );
                }
                wait 0.5;
            }
            break;
        case 93:
            self thread rtd_print_roll( "^2093 - [Extreme Speed For 15 Seconds]" );
            self thread rtd_loop( "speed", 3 );
            wait 15;
            self notify( "stoploop" );
            self SetMoveSpeedScale( 1 );
            wait 0.01;
            self thread rtd_random();
            break;
        case 94:
            self thread rtd_print_roll( "^2094 - [UAV + Reroll]" );
            self maps\mp\gametypes\_hardpoints::giveHardpoint( "radar_mp", true );
            wait 2;
            self thread rtd_random();
            break;
        case 95:
            self thread rtd_print_roll( "^2095 - [2: Airtrike, 4: Stealth, 6: EMP]" );
            self.startscore = self.pers[ "kills" ];

            while( 1 ) {
                if( self.streaknumber != self.pers[ "kills" ] - self.startscore ) {
                    self.streaknumber = self.pers[ "kills" ] - self.startscore;
                    switch( self.streaknumber ) {
                    case 2:
                        self maps\mp\gametypes\_hardpoints::giveHardpoint( "airstrike_mp", true );
                        break;
                    case 4:
                        self maps\mp\gametypes\_hardpoints::giveHardpoint( "stealth_airstrike_mp", true );
                        break;
                    case 6:
                        self maps\mp\gametypes\_hardpoints::giveHardpoint( "emp_mp", true );
                        break;
                    }
                }
                wait 0.05;
            }
            break;
        case 96:
            self thread rtd_print_roll( "^2096 - [Uzi Akimbo + Unlimited Ammo]" );
            self notify( "newRoll" );

            self user_scripts\mp\scripts\player::give_all_perks();
            self thread rtd_monitor( "h2_uzi_mp_akimbo_fmj_foregrip_silencerlmg" + common_scripts\utility::random( level.camo_array ) );
            self thread rtd_ammo( 99 );
            break;
        case 97:
            self thread rtd_print_roll( "^2097 - [AA12 Rapid Fire]" );
            self notify( "newRoll" );

            self user_scripts\mp\scripts\player::give_all_perks();
            self thread rtd_monitor( "h2_aa12_mp_fastfire_fmj_foregrip_xmagmwr" + common_scripts\utility::random( level.camo_array ) );
            self thread rtd_stock( 99 );
            break;
        case 98:
            self thread rtd_print_roll( "^2098 - [Ability: ^:Nitro^2]" );
            self notify( "newability" );
            self endon( "newability" );

            self notifyOnPlayerCommand( "dpad_down", "+actionslot 2" );
            wait 2;

            while( 1 ) {
                self iPrintlnBold( "Press ^3[{+actionslot 2}] ^7For Speed Boost" );
                self waittill( "dpad_down" );
                self iPrintlnBold( "^2Speed Boost For 5 Seconds" );
                self thread rtd_loop( "speed", 2 );
                wait 5;
                self notify( "stoploop" );
                self SetMoveSpeedScale( 1 );
                self iPrintlnBold( "Speed Boost: ^1Off" );
                wait 2;
                self iPrintlnBold( "^3Recharging..." );
                wait 13;
            }
            break;
        case 99:
            self thread rtd_print_roll( "^2099 - [Faster Regen]" );

            while( 1 ) {

                if( self.health >= self.maxhealth )
                    self.health = self.health + 1;
                wait 0.05;
            }
            break;
        case 100:
            self thread rtd_print_roll( "^3100 - [1/6 Chance of EMP + Reroll]" );
            wait 2;
            successroll = RandomInt( 5 );
            self iPrintlnBold( "Roll " +( successroll + 1 ) +" for an ^:EMP" );
            wait 1;
            self iPrintlnBold( "Rolling..." );
            wait 1;
            rollnumb = RandomInt( 5 );

            if( rollnumb == successroll ) {
                self iPrintlnBold( "You Rolled " + ( successroll + 1 ) +" - ^2EMP GRANTED" );
                self maps\mp\gametypes\_hardpoints::giveHardpoint( "emp_mp", true );
            }
            else
                self iPrintlnBold( "You Rolled " +( rollnumb + 1 ) +" - ^1EMP DENIED" );
            wait 2;
            self iPrintlnBold( "Rerolling..." );
            wait 1;
            self thread rtd_random();
            break;
        case 101:
            self thread rtd_print_roll( "^1101 - [No Scope Sniper]" );
            self notify( "newRoll" );

            self user_scripts\mp\scripts\player::give_all_perks();
            self allowADS( false );
            self thread rtd_monitor( "h1_remington700_mp_acogmwr_fmj_xmagmwr" + common_scripts\utility::random( level.camo_array ) );
            break;
        case 102:
            self thread rtd_print_roll( "^1102 - [Nothing Changes]" );
            break;
        case 103:
            self thread rtd_print_roll( "^2103 - [AK47 Rapid Fire FMJ]" );
            self notify( "newRoll" );

            self thread rtd_monitor( "h2_ak47_mp_fastfire_fmj" + common_scripts\utility::random( level.camo_array ) );
            self thread rtd_stock( 999 );
            break;
        case 104:
            self thread rtd_print_roll( "^2104 - [Ninja Pro, 1.25 Speed, Martyrdom]" );
            self maps\mp\_utility::giveperk( "specialty_grenadepulldeath" );
            self maps\mp\_utility::giveperk( "specialty_heartbreaker" );
            self maps\mp\_utility::giveperk( "specialty_quieter" );
            self thread rtd_loop( "speed", 1.25 );
            break;
        case 105:
            self thread rtd_print_roll( "^0105 - [You're Dead!]" );
            self suicide();
            break;
        case 106:
            self thread rtd_print_roll( "^1106 - [You're Dying...]" );
            wait 3.00;
            self rtd_timer( 30, 1 );
            self suicide();
            break;
        case 107:
            self thread rtd_print_roll( "^3107 - [New Roll Every 7 Seconds]" );
            self.rollstreak = self.rollstreak + 1;
            wait 2;
            self thread rtd_all_random();
            break;
        case 108:
            self thread rtd_print_roll( "^3108 - [Wallhack + Thermal But Only Melee]" );
            self notify( "newRoll" );

            self ThermalVisionFOFOverlayOn();
            self maps\mp\_utility::giveperk( "specialty_thermal" );
            self thread rtd_monitor( "h2_deserteagle_mp_tacknifedeagle_camo009" );

            while( 1 ) {
                self setWeaponAmmoClip( "h2_deserteagle_mp_tacknifedeagle_camo009", 0 );
                self setWeaponAmmoStock( "h2_deserteagle_mp_tacknifedeagle_camo009", 0 );
                wait 0.5;
            }
            break;
        case 109:
            self thread rtd_print_roll( "^3109 - [Default Weapon]" );
            self notify( "newRoll" );

            self user_scripts\mp\scripts\player::give_all_perks();
            self thread rtd_monitor( "defaultweapon_mp" );
            self thread rtd_ammo( 99 );
            break;
        case 110:
            self thread rtd_print_roll( "^2110 - [Desert Eagle Akimbo + Unlimited Ammo]" );
            self notify( "newRoll" );

            self user_scripts\mp\scripts\player::give_all_perks();
            self thread rtd_monitor( "h1_deserteagle55_mp_akimbo_xmagmwr" );
            self thread rtd_ammo( 99 );
            break;
        case 111:
            self thread rtd_print_roll( "^2111 - [Care Package + Reroll]" );
            self maps\mp\gametypes\_hardpoints::giveHardpoint( "airdrop_marker_mp", true );
            wait 2;
            self thread rtd_random();
            break;
        case 112:
            self thread rtd_print_roll( "^2112 - [Explosive Rounds For 15 Seconds]" );
            self rtd_explosive_rounds( 15 );
            self iPrintlnBold( "Explosive Rounds: ^1Off" );
            self thread rtd_random();
            break;
        case 113:
            self thread rtd_print_roll( "^2113 - [Shellshock Immune]" );

            for( ;; ) {
                self StopShellShock();
                wait 0.05;
            }
            break;
        case 114:
            self thread rtd_print_roll( "^1114 - [Disco Time]" );
            self thread rtd_vision();
            break;
        case 115:
            self thread rtd_print_roll( "^2115 - [Press ^3[{+actionslot 2}] ^2to Call a Suicide Plane]" );
            self thread rtd_harrier();
            break;
        case 116:
            self thread rtd_print_roll( "^2116 - [Aimbot For 15 Seconds]" );
            self rtd_aimbot();
            self iPrintlnBold( "Aimbot: ^1Off" );
            wait 3;
            self thread rtd_random();
            break;
        case 117:
            self thread rtd_print_roll( "^3117 - [Cycling Weapons]" );
            self thread rtd_cycle();
            break;
        case 118:
            self thread rtd_print_roll( "^1118 - [Military Training]" );

            while( 1 ) {
                self SetStance( "stand" );
                wait 0.7;
                self SetStance( "crouch" );
                wait 0.7;
                self SetStance( "prone" );
                wait 0.7;
            }
            break;
        case 119:
            self thread rtd_print_roll( "^2119 - [Walking AC130 105mm]" );
            self notify( "newRoll" );

            self takeAllWeapons();
            self thread rtd_monitor( "ac130_105mm_mp" );
            break;
        case 120:
            self thread rtd_print_roll( "^3120 - [+400 HP But 1/4 Speed]" );
            self.maxhealth = self.maxhealth + 400;
            self.health = self.maxhealth;
            self thread rtd_loop( "speed", 0.25 );
            break;
        case 121:
            self thread rtd_print_roll( "^1121 - [No HP Regen]" );

            while( 1 ) {
                if( self.health < self.maxhealth )
                    self.maxhealth = self.health;
                wait 0.25;
            }
            break;
        case 122:
            self thread rtd_print_roll( "^3122 - [Sniper Class I]" );
            self notify( "newRoll" );
            self notify( "endmonitor" );

            self takeAllWeapons();
            self user_scripts\mp\scripts\player::give_all_perks();
            self giveWeapon( "h2_msr_mp_ogscope_xmagmwr_camo009" );
            self GiveMaxAmmo( "h2_msr_mp_ogscope_xmagmwr_camo009" );
            self giveWeapon( "h1_deserteagle55_mp" );
            wait 0.05;
            self switchToWeapon( "h2_msr_mp_ogscope_xmagmwr_camo009" );
            self setlethalweapon( "iw9_throwknife_mp" );
            self setweaponammoclip( "iw9_throwknife_mp", 99 );
            self GiveMaxAmmo( "iw9_throwknife_mp" );
            self settacticalweapon( "h1_concussiongrenade_mp" );
            self setweaponammoclip( "h1_concussiongrenade_mp", 99 );
            self GiveMaxAmmo( "h1_concussiongrenade_mp" );
            break;
        case 123:
            self thread rtd_print_roll( "^2123 - [Triple Roll]" );
            wait 1;
            self thread rtd_random();
            wait 1;
            self thread rtd_random();
            wait 1;
            self thread rtd_random();
            break;
        case 124:
            self thread rtd_print_roll( "^2124 - [RPG Rounds]" );
            self endon( "defaultProj" );

            for( ;; ) {
                self waittill( "weapon_fired" );
                location = user_scripts\mp\scripts\util::cursor_pos();
                MagicBullet( "h2_rpg_mp", self getTagOrigin( "tag_eye" ), location, self );
            }
            break;
        case 125:
            self thread rtd_print_roll( "^2125 - [M79 Grenade Rounds]" );
            self endon( "defaultProj" );

            for( ;; ) {
                self waittill( "weapon_fired" );
                location = user_scripts\mp\scripts\util::cursor_pos();
                MagicBullet( "h2_m79_mp", self getTagOrigin( "tag_eye" ), location, self );
            }
            break;
        case 126:
            self thread rtd_print_roll( "^2126 - [Artillery Rounds]" );
            wait 2;

            for( ;; ) {
                self iPrintlnBold( "^2Artillery Rounds Ready!" );
                self waittill ( "weapon_fired" );
                location = user_scripts\mp\scripts\util::cursor_pos();
                MagicBullet( "remotemissile_projectile_mp", location + ( 0, 0, 8000 ), location, self );
                MagicBullet( "javelin_mp", location + ( 0, 0, 8000 ), location, self );
                self iPrintlnBold( "^3Artillery Rounds Rearming..." );
                wait 7;
            }
            break;
        case 127:
            self thread rtd_print_roll( "^2127 - [AH6 + Reroll]" );
            self maps\mp\gametypes\_hardpoints::giveHardpoint( "ah6_mp", true );
            wait 2;
            self thread rtd_random();
            break;
        case 128:
            self thread rtd_print_roll( "^3128 - [QuickScope Only]" );
            self endon( "endQS" );
            self notify( "newRoll" );

            self user_scripts\mp\scripts\player::give_all_perks();
            self thread rtd_monitor( "h2_l118a_mp_fmj_l118ascope_ogscopeiw5_xmagmwr" + common_scripts\utility::random( level.camo_array ) );
            if( !isDefined( level.qs_time ) || level.qs_time < 0.05 )
                level.qs_time = 3;
            self.adsTime = 0;

            for( ;; ) {
                if( self playerAds( ) == 1 )
                    self.adsTime++ ;
                else
                    self.adsTime = 0;

                if( self.adsTime >= int( level.qs_time / 0.05 ) ) {
                    self.adsTime = 0;
                    self allowAds( false );
                    while( self playerAds( ) > 0 )
                        wait( 0.05 );
                    self allowAds( true );
                }
                wait( 0.05 );
            }
            break;
        case 129:
            self thread rtd_print_roll( "^2129 - [Double Jump]" );
            self endon( "endMultijump" );

            self user_scripts\mp\scripts\player::give_all_perks();
            self thread rtd_landed();
            if( !isDefined( self.numOfMultijumps ) )
                self.numOfMultijumps = 1;

            for( ;; ) {
                currentNum = 0;
                while( !self jumpbuttonpressed( ) )
                    wait 0.05;
                while( self jumpbuttonpressed( ) )
                    wait 0.05;
                if( getDvarInt( "jump_height" ) > 250 )
                    continue;

                if( !isAlive( self ) ) {
                    self waittill( "spawned_player" );
                    continue;
                }

                if( !self isOnGround( ) ) {

                    while( !self isOnGround( ) && isAlive( self ) && currentNum < self.numOfMultijumps ) {
                        waittillResult = self common_scripts\utility::waittill_any_timeout( 0.11, "landedOnGround", "disconnect", "death" );

                        while( waittillResult == "timeout" ) {

                            if( self jumpbuttonpressed( ) ) {
                                waittillResult = "jump";
                                break;
                            }
                            waittillResult = self common_scripts\utility::waittill_any_timeout( 0.05, "landedOnGround", "disconnect", "death" );
                        }

                        if( waittillResult == "jump" && !self isOnGround( ) && isAlive( self ) ) {
                            playerAngles = self getplayerangles();
                            playerVelocity = self getVelocity();
                            self setvelocity( ( playerVelocity[ 0 ], playerVelocity[ 1 ], playerVelocity[ 2 ] / 2 ) + anglestoforward( ( 270, playerAngles[ 1 ], playerAngles[ 2 ] ) ) * getDvarInt( "jump_height" ) * ( ( ( -1 / 39 ) * getDvarInt( "jump_height" ) ) + ( 17 / 2 ) ) );
                            currentNum++;
                            while( self jumpbuttonpressed( ) )
                                wait 0.05;
                        }
                        else
                            break;
                    }
                    while( !self isOnGround( ) )
                        wait 0.05;
                }
            }
            break;
        case 130:
            self thread rtd_print_roll( "^3130 - [Sniper Class II]" );
            self notify( "newRoll" );
            self notify( "endmonitor" );

            self takeAllWeapons();
            self user_scripts\mp\scripts\player::give_all_perks();
            self giveWeapon( "h1_vssvintorez_mp_xmagmwr" );
            self GiveMaxAmmo( "h1_vssvintorez_mp_xmagmwr" );
            self giveWeapon( "h1_deserteagle55_mp_xmagmwr_camo025" );
            wait 0.05;
            self switchToWeapon( "h1_vssvintorez_mp_xmagmwr" );
            self setlethalweapon( "iw9_throwknife_mp" );
            self setweaponammoclip( "iw9_throwknife_mp", 99 );
            self GiveMaxAmmo( "iw9_throwknife_mp" );
            self settacticalweapon( "h1_concussiongrenade_mp" );
            self setweaponammoclip( "h1_concussiongrenade_mp", 99 );
            self GiveMaxAmmo( "h1_concussiongrenade_mp" );
            break;
        case 131:
            self thread rtd_print_roll( "^2131 - [Ability: ^:Predator Drone^2]" );
            self notify( "newability" );
            self endon( "newability" );

            self notifyOnPlayerCommand( "dpad_down", "+actionslot 2" );
            wait 2;

            while( 1 ) {
                self iPrintlnBold( "Press ^3[{+actionslot 2}] ^7For Predator Missile" );
                self waittill( "dpad_down" );
                maps\mp\h2_killstreaks\_remotemissile::tryUsePredatorMissile( self.pers[ "killstreaks" ][ 0 ].lifeId );
                wait 2;
                self iPrintlnBold( "^3Recharging..." );
                wait 8;
            }
            break;
        case 132:
            self thread rtd_print_roll( "^2132 - [Juggernaut]" );
            self notify( "newRoll" );
            self notify( "endmonitor" );

            self.maxhealth = self.maxhealth + 400;
            self.health = self.maxhealth;
            self takeAllWeapons();
            self user_scripts\mp\scripts\player::give_all_perks();
            self giveWeapon( "h1_m60e4_mp_fmj_xmagmwr_camo009" );
            self GiveMaxAmmo( "h1_m60e4_mp_fmj_xmagmwr_camo009" );
            self setlethalweapon( "h1_fraggrenade_mp" );
            self setweaponammoclip( "h1_fraggrenade_mp", 99 );
            self GiveMaxAmmo( "h1_fraggrenade_mp" );
            self settacticalweapon( "h1_smokegrenade_mp" );
            self setweaponammoclip( "h1_smokegrenade_mp", 99 );
            self GiveMaxAmmo( "h1_smokegrenade_mp" );
            wait 0.05;
            self switchToWeapon( "h1_m60e4_mp_fmj_xmagmwr_camo009" );
            self thread rtd_loop( "speed", 0.55 );

            for( ;; ) {
                self StopShellShock();
                wait 0.05;
            }
            break;
        case 133:
            self thread rtd_print_roll( "^3133 - [Pro Mod Vision]" );
            self VisionSetNakedForPlayer( "default", 2 );
            self setClientDvar( "player_breath_snd_delay ", 0 );
            self setClientDvar( "perk_extraBreath", 0 );
            self setClientDvar( "cg_brass", 0 );
            self setClientDvar( "r_blur", 0.3 );
            self setClientDvar( "r_specularcolorscale", 10 );
            self setClientDvar( "r_filmusetweaks", 1 );
            self setClientDvar( "r_filmtweakenable", 1 );
            self setClientDvar( "r_filmtweakcontrast", 1.6 );
            self setClientDvar( "r_brightness", 0 );
            self setClientDvar( "fx_drawclouds", 0 );
            self setClientDvar( "cg_blood", 0 );
            self setClientDvar( "r_dlightLimit", 0 );
            self setClientDvar( "r_fog", 0 );
            break;
        case 134:
            self thread rtd_print_roll( "^2134 - [Unlimited Jumps]" );
            self endon( "endMultijump" );

            self user_scripts\mp\scripts\player::give_all_perks();
            self thread rtd_landed();
            if( !isDefined( self.numOfMultijumps ) )
                self.numOfMultijumps = 99999;

            for( ;; ) {
                currentNum = 0;
                while( !self jumpbuttonpressed( ) )
                    wait 0.05;
                while( self jumpbuttonpressed( ) )
                    wait 0.05;
                if( getDvarInt( "jump_height" ) > 250 )
                    continue;

                if( !isAlive( self ) ) {
                    self waittill( "spawned_player" );
                        continue;
                }

                if( !self isOnGround( ) ) {

                    while( !self isOnGround( ) && isAlive( self ) && currentNum < self.numOfMultijumps ) {
                        waittillResult = self common_scripts\utility::waittill_any_timeout( 0.11, "landedOnGround", "disconnect", "death" );
                        while( waittillResult == "timeout" ) {
                            if( self jumpbuttonpressed( ) ) {
                                waittillResult = "jump";
                                break;
                            }
                            waittillResult = self common_scripts\utility::waittill_any_timeout( 0.05, "landedOnGround", "disconnect", "death" );
                        }
                        if( waittillResult == "jump" && !self isOnGround( ) && isAlive( self ) ) {
                            playerAngles = self getplayerangles();
                            playerVelocity = self getVelocity();
                            self setvelocity( ( playerVelocity[ 0 ], playerVelocity[ 1 ], playerVelocity[ 2 ] / 2 ) + anglestoforward( ( 270, playerAngles[ 1 ], playerAngles[ 2 ] ) ) * getDvarInt( "jump_height" ) * ( ( ( -1 / 39 ) * getDvarInt( "jump_height" ) ) + ( 17 / 2 ) ) );
                            currentNum++;
                            while( self jumpbuttonpressed( ) )
                                wait 0.05;
                        }
                        else
                            break;
                    }
                    while( !self isOnGround( ) )
                    wait 0.05;
                }
            }
            break;
        case 135:
            self thread rtd_print_roll( "^2135 - [Push Nearby Enemies]" );
            self endon( "endForce" );

            while( 1 ) {
                foreach( p in level.players ) {
                    if( ( distance( self.origin, p.origin ) <= 200 && level.teamBased && p.pers[ "team" ] != self.team ) || ( distance( self.origin, p.origin ) <= 200 && !level.teamBased ) ) {
                        atf = anglestoforward( self getplayerangles() );
                        if( p != self )
                            p setvelocity( p getvelocity() + ( atf[ 0 ] * ( 300 * 2 ), atf[ 1 ] * ( 300 * 2 ), ( atf[ 2 ] + 0.25 ) * ( 300 * 2 ) ) );
                    }
                }
                wait 0.05;
            }
            break;
        case 136:
            self thread rtd_print_roll( "^3136 - [Random Third Weapon]" );
            self notify( "newRoll" );
            self notify( "endmonitor" );

            third_weapon = common_scripts\utility::random( level.mw2_ar_array ) + "_fastfire_fmj_xmagmwr" + common_scripts\utility::random( level.camo_array );
            self GiveWeapon( third_weapon );
            self GiveMaxAmmo( third_weapon );
            wait 0.05;
            self switchToWeapon( third_weapon );
            break;
        case 137:
            self thread rtd_print_roll( "^2137 - [Nova Gas Grenade]" );
            self notify( "newRoll" );
            self notify( "endmonitor" );

            cur = self getCurrentWeapon();
            wait 0.1;
            self giveweapon( "h1_smokegrenade_mp" );
            self SwitchToWeapon( "h1_smokegrenade_mp" );
            self waittill( "grenade_fire", grenade );

            if( self getCurrentWeapon( ) == "h1_smokegrenade_mp" ) {
                nova = spawn( "script_model", grenade.origin );
                nova setModel( "wpn_h1_grenade_smoke_proj" );
                nova Linkto( grenade );
                wait 1;
                self switchToWeapon( cur );

                for( i = 0; i <= 15; i ++ ) {
                    RadiusDamage( nova.origin, 300, 100, 50, self );
                    wait 1;
                }
                nova delete();
            }
            break;
        case 138:
            self thread rtd_print_roll( "^2138 - [Bullets Ricochet]" );
            self endon( "endRicochet" );

            for( ;; ) {
                self waittill( "weapon_fired" );
                self thread user_scripts\mp\scripts\weapon::bullet_ricochet_reflect( 30, self getcurrentweapon() );
            }
            break;
        case 139:
            self thread rtd_print_roll( "^1139 - [Rotating]" );

            for( ;; ) {
                self.angle = self GetPlayerAngles();
                if( self.angle[ 1 ] < 179 )
                    self SetPlayerAngles( self.angle + ( 0, 1, 0 ) );
                else
                    self SetPlayerAngles( self.angle * ( 1, -1, 1 ) );
                wait 0.05;
            }
            break;
        case 140:
            self thread rtd_print_roll( "^2140 - [Mustang & Sally]" );
            self notify( "newRoll" );

            self user_scripts\mp\scripts\player::give_all_perks();
            self thread rtd_monitor( "h2_colt45_mp_akimbo_xmagmwr_camo036" );
            self thread rtd_stock( 99 );

            for( ;; ) {
                self waittill( "weapon_fired" );

                if( self getCurrentWeapon( ) == "h2_colt45_mp_akimbo_xmagmwr_camo036" ) {
                    location = user_scripts\mp\scripts\util::cursor_pos();
                    MagicBullet( "h2_m79_mp", self getTagOrigin( "tag_eye" ), location, self );
                }
                wait 0.05;
            }
            break;
        case 141:
            self thread rtd_print_roll( "^2141 - [Ability: ^:Leap^2]" );
            self notify( "newability" );
            self endon( "newability" );

            self notifyOnPlayerCommand( "dpad_down", "+actionslot 2" );
            wait 2;

            while( 1 ) {
                self iPrintlnBold( "Press ^3[{+actionslot 2}] ^7to Leap" );
                self waittill( "dpad_down" );
                forward = AnglesToForward( self getPlayerAngles() );
                self setOrigin( self.origin + ( 0, 0, 5 ) );
                self setVelocity( ( forward[ 0 ] * 800, forward[ 1 ] * 800, 300 ) );
                wait 1;
                self iPrintlnBold( "^3Recharging..." );
                wait 4;
            }
            break;
        case 142:
            self thread rtd_print_roll( "^2142 - [Ability: ^:Rocket Barrage^2]" );
            self notify( "newability" );
            self endon( "newability" );

            self notifyOnPlayerCommand( "dpad_down", "+actionslot 2" );
            wait 2;

            while( 1 ) {
                self iPrintlnBold( "Press ^3[{+actionslot 2}] ^7For Rocket Barrage" );
                self waittill( "dpad_down" );
                self iprintlnbold( "^2Rocket Barrage Launched!" );
                level.mapCenter = maps\mp\gametypes\_spawnlogic::findBoxCenter( level.spawnMins, level.spawnMaxs );

                foreach( player in level.players ) {
                    if( ( isAlive( player ) && level.teamBased && player.pers[ "team" ] != self.team ) || ( isAlive( player ) && player != self && !level.teamBased ) ) {
                        MagicBullet( "remotemissile_projectile_mp", level.mapCenter + ( 0, 0, 4000 ), player getTagOrigin( "j_spineupper" ), self );
                        self setvelocity( self getvelocity() - ( 0, 0, 60 ) );
                    }
                }
                wait 2;
                self iPrintlnBold( "^3Recharging..." );
                wait 45;
            }
            break;
        case 143:
            self thread rtd_print_roll( "^3143 - [Flash Grenades Only]" );
            self notify( "newRoll" );
            self notify( "endmonitor" );
            self endon( "newRoll" );

            self user_scripts\mp\scripts\player::give_all_perks();
            self thread rtd_nades( 99 );

            while( 1 ) {
                self StopShellShock();

                if( self getCurrentWeapon( ) != "h1_flashgrenade_mp" ) {
                    self takeAllWeapons();
                    self giveWeapon( "h1_flashgrenade_mp" );
                    self switchToWeapon( "h1_flashgrenade_mp" );
                }
                wait 0.5;
            }
            break;
        case 144:
            self thread rtd_print_roll( "^2144 - [Unlimited Semtex]" );
            self takeWeapon( "h1_concussiongrenade_mp" );
            self takeWeapon( "h1_flashgrenade_mp" );
            self takeWeapon( "h1_smokegrenade_mp" );
            self takeWeapon( self GetCurrentOffhand() );
            wait 0.5;
            self setlethalweapon( "h2_semtex_mp" );
            self setweaponammoclip( "h2_semtex_mp", 99 );
            self GiveMaxAmmo( "h2_semtex_mp" );
            self thread rtd_nades( 99 );
            break;
        case 145:
            self thread rtd_print_roll( "^1145 - [Bugged Weapons]" );
            self notify( "newRoll" );
            self notify( "endmonitor" );

            self takeAllWeapons();
            self user_scripts\mp\scripts\player::give_all_perks();
            self giveWeapon( "h1_ak47_mp" );
            self GiveMaxAmmo( "h1_ak47_mp" );
            self giveWeapon( "h1_mp5_mp" );
            self GiveMaxAmmo( "h1_mp5_mp" );
            self setlethalweapon( "h1_fraggrenade_mp" );
            self setweaponammoclip( "h1_fraggrenade_mp", 99 );
            self GiveMaxAmmo( "h1_fraggrenade_mp" );
            self settacticalweapon( "h1_smokegrenade_mp" );
            self setweaponammoclip( "h1_smokegrenade_mp", 99 );
            self GiveMaxAmmo( "h1_smokegrenade_mp" );
            wait 0.05;
            self switchToWeapon( "h1_ak47_mp" );
            break;
        case 146:
            self thread rtd_print_roll( "^3146 - [Random Gun Game]" );
            self notify( "newRoll" );

            self.weapon1 = common_scripts\utility::random( level.mw2_pistol_array ) + common_scripts\utility::random( level.camo_array );
            self.weapon2 = common_scripts\utility::random( level.mw2_smg_array ) + common_scripts\utility::random( level.camo_array );
            self.weapon3 = common_scripts\utility::random( level.mw2_shotgun_array ) + common_scripts\utility::random( level.camo_array );
            self.weapon4 = common_scripts\utility::random( level.mw2_ar_array ) + common_scripts\utility::random( level.camo_array );
            self.weapon5 = common_scripts\utility::random( level.mw2_sniper_array ) + common_scripts\utility::random( level.camo_array );
            self.weapon6 = "h2_m320_mp";
            self.weapon7 = "h2_fn2000_mp_camo009";
            self thread rtd_gun_game();
            self waittill( "reward" );
            self thread rtd_monitor( "h2_fn2000_mp_camo009" );
            self thread rtd_explosive_rounds( 9999 );
            self iPrintlnBold( "^2You've Completed The Gun Game!" );
            wait 1.5;
            self iPrintlnBold( "Reward: ^:Explosive Rounds" );
            break;
        case 147:
            self thread rtd_print_roll( "^2147 - [Random Rounds]" );
            self notify( "newRoll" );
            self endon( "randRounds" );

            self user_scripts\mp\scripts\player::give_all_perks();
            self thread rtd_monitor( "defaultweapon_mp" );
            self thread rtd_ammo( 99 );

            for( ;; ) {
                if( self AttackButtonPressed( ) ) {
                    location = user_scripts\mp\scripts\util::cursor_pos();
                    MagicBullet( common_scripts\utility::random( level.mw2_ar_array ), self getTagOrigin( "tag_eye" ), location, self );
                }
                wait 0.09;
            }
            break;
        case 148:
            self thread rtd_print_roll( "^2148 - [OP Class]" );
            self notify( "newRoll" );
            self notify( "endmonitor" );

            self takeAllWeapons();
            self user_scripts\mp\scripts\player::give_all_perks();
            self giveWeapon( "h2_ump45_mp_fastfire_fmj_silencersmg_xmagmwr_camo009" );
            self GiveMaxAmmo( "h2_ump45_mp_fastfire_fmj_silencersmg_xmagmwr_camo009" );
            self giveWeapon( "h2_aa12_mp_akimbo_fmj_foregrip_xmagmwr_camo009" );
            self GiveMaxAmmo( "h2_aa12_mp_akimbo_fmj_foregrip_xmagmwr_camo009" );
            self setlethalweapon( "h2_semtex_mp" );
            self setweaponammoclip( "h2_semtex_mp", 99 );
            self GiveMaxAmmo( "h2_semtex_mp" );
            self settacticalweapon( "h1_smokegrenade_mp" );
            self setweaponammoclip( "h1_smokegrenade_mp", 99 );
            self GiveMaxAmmo( "h1_smokegrenade_mp" );
            wait 0.05;
            self switchToWeapon( "h2_ump45_mp_fastfire_fmj_silencersmg_xmagmwr_camo009" );
            break;
        case 149:
            self thread rtd_print_roll( "^2149 - [MWR Class]" );
            self notify( "newRoll" );
            self notify( "endmonitor" );

            self takeAllWeapons();
            self user_scripts\mp\scripts\player::give_all_perks();
            self giveWeapon( "h1_saw_mp_fmj_xmagmwr" );
            self GiveMaxAmmo( "h1_saw_mp_fmj_xmagmwr" );
            self giveWeapon( "h1_skorpion_mp_fmj_xmagmwr" );
            self GiveMaxAmmo( "h1_skorpion_mp_fmj_xmagmwr" );
            self setlethalweapon( "h1_fraggrenade_mp" );
            self setweaponammoclip( "h1_fraggrenade_mp", 99 );
            self GiveMaxAmmo( "h1_fraggrenade_mp" );
            self settacticalweapon( "h1_smokegrenade_mp" );
            self setweaponammoclip( "h1_smokegrenade_mp", 99 );
            self GiveMaxAmmo( "h1_smokegrenade_mp" );
            wait 0.05;
            self switchToWeapon( "h1_saw_mp_fmj_xmagmwr" );
            break;
        case 150:
            self thread rtd_print_roll( "^3150 - [End Game Vision]" );
            self thread rtd_loop( "vision", "end_game" );
            break;
        case 151:
            self thread rtd_print_roll( "^2151 - [Jetpack]" );
            self endon( "jetpack_off" );

            self.fuel = 200;
            self attach( "projectile_hellfire_missile", "tag_stowed_back" );
            wait 2;
            self iPrintlnBold( "Hold ^3[{+activate}] ^7For Jetpack" );

            for( i = 0 ; ; i++ ) {
                if( self usebuttonpressed( ) && self.fuel > 0 ) {
                    self playsound( "boost_jump_plr_mp" );
                    playFX( level._effect[ "fire_smoke_trail_l" ], self getTagOrigin( "J_Ankle_RI" ) );
                    playFx( level._effect[ "fire_smoke_trail_l" ], self getTagOrigin( "J_Ankle_LE" ) );
                    earthquake( 0.15, 0.2, self gettagorigin( "j_spine4" ), 50 );
                    self.fuel--;
                    if( self getvelocity( ) [ 2 ] < 300 )
                        self setvelocity( self getvelocity() + ( 0, 0, 60 ) );
                }
                if( self.fuel < 200 && !self usebuttonpressed( ) )
                    self.fuel++;
                wait 0.05;
            }
            break;
        case 152:
            self thread rtd_print_roll( "^2152 - [Ability: ^:Feign Death^2]" );
            self notify( "newability" );
            self endon( "newability" );

            self notifyOnPlayerCommand( "dpad_down", "+actionslot 2" );
            wait 2;

            while( 1 ) {
                self iPrintlnBold( "Press ^3[{+actionslot 2}] ^7For Feign Death" );
                self waittill( "dpad_down" );
                clone = self ClonePlayer( 3 );
                clone StartRagdoll();
                self hide();
                self DisableWeapons();

                for( i = 3; i > 0; i -- ) {
                    self iPrintLnBold( i );
                    wait 1;
                }
                self show();
                self EnableWeapons();
                self iPrintlnBold( "Feign Death: ^1Off" );
                wait 2;
                self iPrintlnBold( "^3Recharging..." );
                wait 13;
            }
            break;
    }
}