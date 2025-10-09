#include user_scripts\mp\m203\source\structure;
#include scripts\utility;
#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_gamelogic;
#include user_scripts\mp\m203\scripts\common;

init_isnipe() {
    level.sniper_array = [ "h2_cheytac_mp", "h2_m40a3_mp", "h2_msr_mp" ];
    level.camo_array = [ "", "_camo006", "_camo007", "_camo008", "_camo026", "_camo027", "_camo028", "_camo029", "_camo028", "_camo030", "_camo031", "_camo032", "_camo033", "_camo034", "_camo035", "_camo036", "_camo037", "_camo038", "_camo039", "_camo040", "_camo044", "_camo009", "_camo025" ];
    level.secondary_array = [ "h1_deserteagle55_mp_xmagmwr", "h1_deserteagle55_mp_akimbo_xmagmwr", "h2_usp_mp_tacknifeusp_xmagmwr", "h2_usp_mp_akimbo_xmagmwr", "h2_coltanaconda_mp_tacknifecolt44_xmagmwr", "h2_coltanaconda_mp_akimbo_xmagmwr", "h2_m9_mp_tacknifem9_xmagmwr", "h2_m9_mp_akimbo_xmagmwr", "h2_colt45_mp_tacknifecolt45_xmagmwr", "h2_colt45_mp_akimbo_xmagmwr", "h2_deserteagle_mp_tacknifedeagle_xmagmwr", "h2_deserteagle_mp_akimbo_xmagmwr", "h2_mp412_mp_tacknifemp412_xmagmwr", "h2_mp412_mp_akimbo_xmagmwr" ];

    if( getDvarInt( "hmw_rtd" ) != 1 ) {
        level.OriginalCallbackPlayerDamage = level.callbackPlayerDamage;
        level.callbackPlayerDamage = ::CodeCallback_PlayerDamage;
    }

    level thread onPlayerConnect();
}

onPlayerConnect() {
    for( ;; ) {
        level waittill( "connected", player );
        player.antiCamp[ "time" ] = 0;

        setDvar( "cg_drawBreathHint", 0 );
        setDvar( "sv_disableCustomClasses", 1 );
        setDvar( "scr_skipclasschoice", 1 );
        setDvar( "scr_game_killstreakdelay", 99999 );
        setDvar( "scr_game_hardpoints", 0 );

        player thread onPlayerSpawned();
    }
}

onPlayerSpawned() {
    self endon( "disconnect" );
    level endon( "game_ended" );

    while( true ) {
        self waittill( "spawned_player" );

        if( isDefined( self.playerSpawned ) ) {
            continue;
        }

        self thread spawnThreads();
    }
}

spawnThreads() {
    self endon( "endmonitor" );
    self endon( "death" );

    self thread antiCamp();
    
    if( !isSubStr( self.guid, "bot" ) ) {
		self thread EnableAntiHardScope( 0.15 );
	}

    if( getDvarInt( "hmw_rtd" ) != 1 ) {
        self set_health( 50 );
    }

    self removePerks();
    self giveLoadout( random( level.sniper_array ) + "_fmj_ogscope_xmagmwr" + random( level.camo_array ), random( level.secondary_array ) + random( level.camo_array ), "iw9_throwknife_mp", "" );

    for( ;; ) {
        self monitorClass();
		wait( 1 );
	}
}

setSettingIfNotExists( property, defaultValue ) {
    if( !isDefined( level.antiCamp[ property ] ) ) {
        level.antiCamp[ property ] = defaultValue;
    }
}

antiCampInit() {
    setSettingIfNotExists( "killTime", 10 );
    setSettingIfNotExists( "minDistance", 150 );
}

antiCamp() {
    self endon( "death" );
    self endon( "disconnect" );

    self.antiCamp[ "time" ] = 0;
    lastPosition = self.origin;
    killTime = level.antiCamp[ "killTime" ];
    minDistance = level.antiCamp[ "minDistance" ];

    maps\mp\_utility::gameflagwait( "prematch_done" );

    for( ;; ) {
        wait 1;

        currentPosition = self.origin;
        distance = distance2d( lastPosition, currentPosition );

        if( self in_menu() ) {
            lastPosition = currentPosition;
            self.antiCamp[ "time" ] = 0;
        }
        if( distance < minDistance ) {
            self.antiCamp[ "time" ]++;
            if( self.antiCamp[ "time" ] >= killTime - 5 ) {
                self iprintlnbold( "^3Camping^7: ^1" + ( level.antiCamp[ "killTime" ] - self.antiCamp[ "time" ] ) );
            }
            if( self.antiCamp[ "time" ] == killTime ) {
                self suicide();
            }
        }
        else {
            lastPosition = currentPosition;
            self.antiCamp[ "time" ] = 0;
        }
    }
}


EnableAntiHardScope( time ) {
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "endmonitor" );

    if( !isDefined( time ) || time < 0.05 )
        time = 3;

    adsTime = 0;

    for( ;; ) {
        weapon = self getCurrentWeapon();
        if( validWeapon( weapon ) ) {
            if( self playerAds() == 1 ) {
            adsTime ++;
            }
            else {
                adsTime = 0;
            }

            if( adsTime >= int( time / 0.05 ) ) {
                adsTime = 0;
                self allowAds( false );

                while( self playerAds() > 0 ) {
                    wait( 0.05 );
                }

                self allowAds( true );
            }
        }
        wait 0.05;
    }
}

giveLoadout( primary, secondary, lethal, equipment ) {
    self takeAllWeapons();
    self clearPerks();
    self giveSniperPerks();
    self giveWeapon( primary );
    self setWeaponAmmoStock( primary, 999 );
    self giveMaxAmmo( primary );
    self giveWeapon( secondary );
    self setWeaponAmmoClip( secondary, 0 );
    self setWeaponAmmoStock( secondary, 0 );
    self setWeaponAmmoClip( secondary, 0, "left" );
    self setWeaponAmmoStock( secondary, 0, "left" );
    self setLethalWeapon( lethal );
    self giveWeapon( lethal );
    self setWeaponAmmoStock( lethal, 99 );
    self giveMaxAmmo( lethal );
    self setTacticalWeapon( equipment );
    self giveWeapon( equipment );
    self setWeaponAmmoStock( equipment, 99 );
    self giveMaxAmmo( equipment );
    wait 0.05;
    self switchToWeapon( primary );
}

monitorClass() {
    weapon = self getCurrentWeapon();

    if ( !( isStrStart( weapon, "h2_cheytac" ) || isStrStart( weapon, "h2_m40a3" ) || isStrStart( weapon, "h2_msr" ) || isStrStart( weapon, "h2_as50" ) || isStrStart( weapon, "h2_deserteagle" ) || isStrStart( weapon, "h2_usp" ) || isStrStart( weapon, "h2_coltanaconda" ) || isStrStart( weapon, "h2_m9" ) || isStrStart( weapon, "h2_colt45" ) || isStrStart( weapon, "h1_deserteagle55" ) || isStrStart( weapon, "h2_mp412" ) || isStrStart( weapon, "iw9_throwknife" ) || isSubStr( weapon, "none" ) || isSubStr( weapon, "briefcase_bomb_mp" ) || isSubStr( weapon, "briefcase_bomb_defuse_mp" ) ) ) {
        self giveLoadout( random( level.sniper_array ) + "_fmj_ogscope_xmagmwr" + random( level.camo_array ), random( level.secondary_array ) + random( level.camo_array ), "iw9_throwknife_mp", "" );
    }
}

removePerks() {
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

giveSniperPerks() {
    self maps\mp\_utility::giveperk( "specialty_longersprint", false );
	self maps\mp\_utility::giveperk( "specialty_fastmantle", false );
	self maps\mp\_utility::giveperk( "specialty_fastreload", false );
	self maps\mp\_utility::giveperk( "specialty_quickdraw", false );
	self maps\mp\_utility::giveperk( "specialty_bulletdamage", false );
	self maps\mp\_utility::giveperk( "specialty_armorpiercing", false );
	self maps\mp\_utility::giveperk( "specialty_lightweight", false );
	self maps\mp\_utility::giveperk( "specialty_fastsprintrecovery", false );
	self maps\mp\_utility::giveperk( "specialty_extendedmelee", false );
	self maps\mp\_utility::giveperk( "specialty_falldamage", false );
	self maps\mp\_utility::giveperk( "specialty_bulletaccuracy", false );
	self maps\mp\_utility::giveperk( "specialty_holdbreath", false );
	self maps\mp\_utility::giveperk( "specialty_regenspeed", false );
	self maps\mp\_utility::giveperk( "specialty_crouchmovement", false );
	self maps\mp\_utility::giveperk( "specialty_class_steadyhands", false );
	self maps\mp\_utility::giveperk( "specialty_class_quickdraw", false );
	self maps\mp\_utility::giveperk( "specialty_class_lightweight", false );
	self maps\mp\_utility::giveperk( "specialty_marksman", false );
	self maps\mp\_utility::giveperk( "specialty_sharp_focus", false );
	self maps\mp\_utility::giveperk( "specialty_moredamage", false );
	self maps\mp\_utility::giveperk( "specialty_stopping_power", false );
}

validWeapon( weapon ) {
    return ( isStrStart( weapon, "h2_cheytac" ) || isStrStart( weapon, "h2_m40a3" ) || isStrStart( weapon, "h2_msr" ) || isStrStart( weapon, "iw9_throwknife" ) );
}

CodeCallback_PlayerDamage( eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset ) {
    self endon( "disconnect" );

    if( sMeansOfDeath == "MOD_TRIGGER_HURT" || sMeansOfDeath == "MOD_HIT_BY_OBJECT" || sMeansOfDeath == "MOD_FALLING" || sMeansOfDeath == "MOD_MELEE" ) {
        return;
    }
    else {
        if( validWeapon( sWeapon ) ) {
            iDamage = 999;  
        }
        else {
            return;
        }

        [ [ level.OriginalCallbackPlayerDamage ] ]( eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset );
    }
}