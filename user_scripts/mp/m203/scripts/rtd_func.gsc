#include scripts\utility;
#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\gametypes\_gamelogic;
#include maps\mp\gametypes\_gamescore;
#include user_scripts\mp\m203\scripts\rtd_main;

printRoll( name ) {
    self endon( "disconnect" );
    self endon( "death" );

    self iPrintlnBold( "You Rolled: " + name );

    self notifyOnPlayerCommand( "N", "+actionslot 1" );

    for( ;; ) {
        self waittill( "N" );
        self iPrintlnBold( "You Rolled: " + name );
        wait 0.1;
    }
}

MonitorHP( correction ) {
    self endon( "disconnect" );
    self endon( "death" );

    self.starthp = 1;

    while( 1 ) {

        if( self.health != self.maxhealth || self.starthp == 1 ) {

            if( self.health != self.maxhealth ) {
                self.damaged = 1;
            }
            self.starthp = 0;
        }

        if( self.health == self.maxheath && self.damaged == 1 ) {
            self.starthp = 1;
            self.damaged = 0;
        }
        wait 1;
    }
}

Evasion( percentage ) {
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "cancelevasion" );
    self endon( "cancelRoll" );

    self.maxhealth = 1000;
    self.health = self.maxhealth;

    while( 1 ) {

        if( self.health != self.maxhealth ) {
            chance = RandomInt( 100 ) + 1;

            if( chance <= percentage ) {
                self suicide();
            }
            else {
                self.health = self.maxhealth;
            }
        }
        wait 0.05;
    }
}

doGod() {
    self endon( "disconnect" );
    self endon( "death" );

    self.oldhealth = self.maxhealth;
    self.maxhealth = 99999;
    self.health = self.maxhealth;
    wait 10;
    self iPrintlnBold( "God Mode: ^1Off" );
    self.maxhealth = self.oldhealth;
    wait 0.5;
    self.health = self.maxhealth;
    wait 1.5;
    self thread doRandom();
}

highJump() {
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

killUpgrades() {
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "cancelRoll" );

    while( 1 ) {

        if( self.streaknumber != self.pers[ "kills" ] - self.startscore ) {
            self.streaknumber = self.pers[ "kills" ] - self.startscore;

            if( self.streaknumber > 0 && self.upgstart == 1 ) {
                self thread printRoll( "^5Lvl 1 [+UAV]" );
                self maps\mp\gametypes\_hardpoints::giveHardpoint( "radar_mp", true );
                self.upgstart = 0;
                self.upglvl1 = 1;
            }

            if( self.streaknumber > 1 && self.upglvl1 == 1 ) {
                self thread printRoll( "^5Lvl 2 [+ShellShock Immunity]" );

                for( ;; ) {
                    self StopShellShock();
                    wait 0.05;
                }
                self.upglvl1 = 0;
                self.upglvl2 = 1;
            }

            if( self.streaknumber > 2 && self.upglvl2 == 1 ) {
                self thread printRoll( "^5Lvl 3 [+Third Weapon]" );
                self giveWeapon( "h2_ump45_mp_fastfire_fmj_silencersniper_xmagmwr_camo025" );
                self.upglvl2 = 0;
                self.upglvl3 = 1;
            }

            if( self.streaknumber > 3 && self.upglvl3 == 1 ) {
                self thread printRoll( "^5Lvl 4 [+All Perks]" );
                self givePerks();
                self.upglvl3 = 0;
                self.upglvl4 = 1;
            }

            if( self.streaknumber > 4 && self.upglvl4 == 1 ) {
                self thread printRoll( "^5Lvl 5 [+Unlimited Lethals]" );
                self thread UnlimitedNades( 99 );
                self.upglvl4 = 0;
                self.upglvl5 = 1;
            }

            if( self.streaknumber > 5 && self.upglvl5 == 1 ) {
                self thread printRoll( "^5Lvl 6 [+Unlimited Ammo]" );
                self thread UnlimitedAmmo( 999 );
                self.upglvl5 = 0;
                self.upglvl6 = 1;
            }

            if( self.streaknumber > 6 && self.upglvl6 == 1 ) {
                self thread printRoll( "^5Lvl 7 [+150 HP]" );
                self.maxhealth = self.maxhealth + 150;
                self.health = self.maxhealth;
                self.upglvl6 = 0;
                self.upglvl7 = 1;
            }

            if( self.streaknumber > 7 && self.upglvl7 == 1 ) {
                self thread printRoll( "^5Lvl 8 [+1.5 Speed]" );
                self thread Loop( "speed", 1.5 );
                self.upglvl7 = 0;
                self.upglvl8 = 1;
            }

            if( self.streaknumber > 8 && self.upglvl8 == 1 ) {
                self thread printRoll( "^5Lvl 9 [+You're Flashing Invisible]" );

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
                self thread printRoll( "^5Lvl 10 [+Explosive Rounds]" );
                self thread ExplosionWednesday( 9999 );
            }
        }
        wait 0.25;
    }
}

allRandom() {
    self endon( "disconnect" );
    self endon( "death" );

    while( 1 ) {
        self.rollstreak = self.rollstreak - 1;

        self thread doRandom();
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

new_roll() {
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
    self thread doRandom();
}

add_roll() {
    self endon( "disconnect" );
    self endon( "death" );

    self notify( "newRoll" );
    self thread doRandom();
}

Camping() {
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "cancelRoll" );

    while( 1 ) {
        self SetMoveSpeedScale( 0 );
        wait 0.25;
    }
}

cycleWeapons() {
    self notify( "cancelRoll" );
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "cancelRoll" );

    while( 1 ) {
        self takeAllWeapons();
        self cycleAux( "h2_m9_mp_fmj" + random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self cycleAux( "h2_usp_mp_fmj" + random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self cycleAux( "h1_deserteagle55_mp_fmj" );
        wait 2;
        self takeAllWeapons();
        self cycleAux( "h2_coltanaconda_mp_fmj" + random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self cycleAux( "h2_glock_mp_fmj" + random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self cycleAux( "h2_beretta393_mp_fmj" + random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self cycleAux( "h2_mp5k_mp_fmj" + random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self cycleAux( "h2_pp2000_mp_fmj" + random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self cycleAux( "h2_uzi_mp_fmj" + random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self cycleAux( "h2_p90_mp_fmj" + random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self cycleAux( "h2_kriss_mp_fmj" + random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self cycleAux( "h2_ump45_mp_fmj" + random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self cycleAux( "h2_tmp_mp_fmj" + random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self cycleAux( "h2_ak47_mp_fmj" + random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self cycleAux( "h2_m16_mp_fmj" + random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self cycleAux( "h2_m4_mp_fmj" + random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self cycleAux( "h2_fn2000_mp_fmj" + random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self cycleAux( "h2_masada_mp_fmj" + random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self cycleAux( "h2_famas_mp_fmj" + random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self cycleAux( "h2_fal_mp_fmj" + random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self cycleAux( "h2_scar_mp_fmj" + random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self cycleAux( "h2_tavor_mp_fmj" + random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self cycleAux( "h2_barrett_mp_fmj" + random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self cycleAux( "h2_wa2000_mp_fmj" + random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self cycleAux( "h2_m21_mp_fmj" + random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self cycleAux( "h2_cheytac_mp_fmj" + random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self cycleAux( "h2_model1887_mp_akimbo_fmj" + random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self cycleAux( "h2_striker_mp_fmj" + random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self cycleAux( "h2_aa12_mp_fmj" + random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self cycleAux( "h2_m1014_mp_fmj" + random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self cycleAux( "h2_spas12_mp_fmj" + random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self cycleAux( "h2_rpd_mp_foregrip_fmj" + random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self cycleAux( "h2_sa80_mp_foregrip_fmj" + random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self cycleAux( "h2_mg4_mp_foregrip_fmj" + random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self cycleAux( "h2_m240_mp_foregrip_fmj" + random( level.camo_array ) );
        wait 2;
        self takeAllWeapons();
        self cycleAux( "h2_aug_mp_foregrip_fmj" + random( level.camo_array ) );
        wait 2;
    }
}

cycleAux( allowed ) {
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

ExplosionWednesday( time ) {
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "cancelRoll" );

    self thread doTimer( time, 0 );

    while( self.timer > 0 ) {
        self waittill( "weapon_fired" );
        SPLOSIONlocation = aim();
        playfx( level._effect[ "frag_grenade_default" ], SPLOSIONlocation );
        RadiusDamage( SPLOSIONlocation, 275, 15 * time, 3 * time, self );
    }
}

doTimer( time, print ) {
    self endon( "disconnect" );
    self endon( "death" );

    self.timer = time;

    while( self.timer != 0 ) {

        if( print == 1 ) {
            self iPrintlnBold( "^:" + self.timer );
        }
        self.timer = self.timer - 1;
        wait 1;
    }
}

autoAim() {
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "cancelRoll" );

    self thread doTimer( 15, 0 );

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

                if( isDefined( aimAt ) ) {

                    if( closer( self getTagOrigin( "j_head" ), player getTagOrigin( "j_head" ), aimAt getTagOrigin( "j_head" ) ) ) {
                        aimAt = player;
                    }
                }
                else {
                    aimAt = player;
                }
            }

            if( isDefined( aimAt ) ) {
                self setplayerangles( VectorToAngles( ( aimAt getTagOrigin( "j_head" ) ) - ( self getTagOrigin( "j_head" ) ) ) );
            }
        }
        break;
    }
}

doVision() {
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

locationSelector() {
    self endon( "disconnect" );
    self endon( "death" );

    self _beginLocationSelection( "", "map_artillery_selector", true, ( level.mapSize / 5.625 ) );
    self.selectingLocation = true;
    self waittill( "confirm_location", location, directionYaw );
    newLocation = BulletTrace( location + ( 0, 0, 0 ), location, 0, self )[ "position" ];
    self notify( "used" );
    self endLocationSelection();
    self.selectingLocation = undefined;
    return newLocation;
}

DeathHarrier() {
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "cancelRoll" );

    self notifyOnPlayerCommand( "dpad_down", "+actionslot 2" );

    self waittill( "dpad_down" );

    Location = locationSelector();

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

SavePos() {
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

LoadPos() {
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

Loop( type, amnt ) {
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "cancelRoll" );
    self endon( "stoploop" );
    self endon( "newRoll" );

    while( 1 ) {

        if( type == "speed" ) {
            self SetMoveSpeedScale( amnt );
        }

        if( type == "vision" ) {
            self VisionSetNakedForPlayer( amnt, 0 );
        }
        wait 0.05;
    }
}

UnlimitedStock( amnt ) {
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

UnlimitedNades( amnt ) {
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

UnlimitedAmmo( amnt ) {
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

MonitorWeapon( allowed, add ) {
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

                    if( add != "gl" ) {
                        self takeWeapon( self getCurrentWeapon() );
                    }
                    self giveWeapon( allowed );
                    self switchToWeapon( allowed );
                }
            }
        }
        wait 0.5;
    }
}

AlternateQS() {
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "cancelRoll" );

    self notifyOnPlayercommand( "tmouse2", "+toggleads_throw" );
    self notifyOnPlayercommand( "tmouse2O", "-speed_throw" );

    while( 1 ) {
        self thread UnlimitedAmmo( 0 );
        self waittill( "tmouse2" );
        self notify( "endammo" );
        self thread UnlimitedAmmo( 99 );
        self waittill( "tmouse2O" );
        self notify( "endammo" );
    }
}

GunGame() {
    self notify( "endgungame" );
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "cancelRoll" );
    self endon( "endgungame" );

    self.startscore = self.pers[ "kills" ];

    self thread UnlimitedStock( 99 );
    self thread MonitorWeapon( self.weapon1 );

    while( 1 ) {

        if( self.weaponnumber != self.pers[ "kills" ] - self.startscore ) {
            self.weaponnumber = self.pers[ "kills" ] - self.startscore;

            switch( self.weaponnumber ) {
                case 1:
                    self notify( "nextgun" );
                    self thread MonitorWeapon( self.weapon2 );
                    break;
                case 2:
                    self notify( "nextgun" );
                    self thread MonitorWeapon( self.weapon3 );
                    break;
                case 3:
                    self notify( "nextgun" );
                    self thread MonitorWeapon( self.weapon4 );
                    break;
                case 4:
                    self notify( "nextgun" );
                    self thread MonitorWeapon( self.weapon5 );
                    break;
                case 5:
                    self notify( "nextgun" );
                    self thread MonitorWeapon( self.weapon6 );
                    break;
                case 6:
                    self notify( "nextgun" );
                    self thread MonitorWeapon( self.weapon7 );
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

laserBeam() {
    self notify( "newlaser" );
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "newlaser" );

    self laseron( "mp_attachment_lasersight" );
    self playSound( "h1_wpn_rpg_exp_default" );
    location = aim();
    MagicBullet( "ac130_25mm_mp", self getTagOrigin( "tag_eye" ), location, self );
    wait 0.1;
    self laseroff();
}

landsOnGround() {
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

reflectbullet( times, weapon ) {
    self endon( "disconnect" );
    self endon( "death" );

    incident = anglestoforward( self getplayerangles() );
    trace = bullettrace( self geteye(), self geteye() + incident * 100000, 0, self );
    reflection = incident - ( 2 * trace[ "normal" ] * vectordot( incident, trace[ "normal" ] ) );

    magicbullet( weapon, trace[ "position" ], trace[ "position" ] + ( reflection * 100000 ) );
    wait 0.05;

    for( i = 0; i < times - 1; i ++  ) {
        trace = bullettrace( trace[ "position" ], trace[ "position" ] + ( reflection * 100000 ), 0, self );
        incident = reflection;
        reflection = incident - ( 2 * trace[ "normal" ] * vectordot( incident, trace[ "normal" ] ) );
        magicbullet( weapon, trace[ "position" ], trace[ "position" ] + ( reflection * 100000 ) );
        wait 0.05;
    }
}

givePerks() {
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
    self maps\mp\_utility::giveperk( "specialty_light_armor", false );
    self maps\mp\_utility::giveperk( "specialty_stopping_power", false );
    self maps\mp\_utility::giveperk( "specialty_uav", false );
}

choose_roll( int ) {
    self endon( "disconnect" );
    self endon( "death" );

    self.chooseRoll = 1;
    self.presentroll = int;
    self notify( "newRoll" );
    self thread doRandom();
}

vector_scal( vec, scale ) {
    vec = ( vec[ 0 ] * scale, vec[ 1 ] * scale, vec[ 2 ] * scale );
    return vec;
}

aim() {
    forward = self getTagOrigin( "tag_eye" );
    end = self thread vector_scal( anglestoforward( self getPlayerAngles() ), 1000000 );
    location = BulletTrace( forward, end, 0, self )[ "position" ];
    return location;
}
