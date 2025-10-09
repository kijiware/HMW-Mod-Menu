#include user_scripts\mp\m203\source\structure;
#include scripts\utility;
#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_gamelogic;
#include user_scripts\mp\m203\scripts\common;

init_restrict() {
    level.pistol_array = [ "h1_colt45_mp", "h1_coltanaconda_mp", "h1_deserteagle_mp", "h1_deserteagle55_mp", "h1_beretta_mp", "h1_usp_mp", "h2_usp_mp", "h2_coltanaconda_mp", "h2_m9_mp", "h2_colt45_mp", "h2_deserteagle_mp", "h2_mp412_mp" ];
    level.shotgun_array = [ "h1_m1014_mp", "h1_striker_mp", "h1_winchester1200_mp", "h2_spas12_mp", "h2_striker_mp", "h2_ranger_mp", "h2_winchester1200_mp", "h2_m1014_mp", "h2_ksg_mp" ];
    level.melee_array = [ "h2_usp_mp_tacknifeusp_xmagmwr", "h2_coltanaconda_mp_tacknifecolt44_xmagmwr", "h2_m9_mp_tacknifem9_xmagmwr", "h2_colt45_mp_tacknifecolt45_xmagmwr", "h2_deserteagle_mp_tacknifedeagle_xmagmwr", "h2_mp412_mp_tacknifemp412_xmagmwr", "h2_hatchet_mp", "h2_sickle_mp", "h2_shovel_mp", "h2_icepick_mp", "h2_karambit_mp" ];
    level.launcher_array = [ "at4_mp", "h2_m79_mp", "h2_rpg_mp", "h2_m320_mp" ];
    level.launcher_bot_array = [ "h2_m79_mp", "h2_m320_mp" ];

    level.camo_array = [ "", "_camo006", "_camo007", "_camo008", "_camo026", "_camo027", "_camo028", "_camo029", "_camo028", "_camo030", "_camo031", "_camo032", "_camo033", "_camo034", "_camo035", "_camo036", "_camo037", "_camo038", "_camo039", "_camo040", "_camo044", "_camo009", "_camo025" ];

    if( getDvarInt( "hmw_rtd" ) != 1 ) {
        level.OriginalCallbackPlayerDamage = level.callbackPlayerDamage;
        level.callbackPlayerDamage = ::CodeCallback_PlayerDamage;
    }

    level thread on_player_connect();
}

on_player_connect() {
    for( ;; ) {
        level waittill( "connected", player );
        setDvar( "sv_disableCustomClasses", 1 );
        setDvar( "scr_skipclasschoice", 1 );
        setDvar( "scr_game_killstreakdelay", 99999 );
        setDvar( "scr_game_hardpoints", 0 );

        player thread on_player_spawned();
    }
}

on_player_spawned() {
    self endon( "disconnect" );
    level endon( "game_ended" );

    while( true ) {
        self waittill( "spawned_player" );
        if( isDefined( self.playerSpawned ) ) {
            continue;
        }

        self thread spawn_threads();

        if( getDvarInt( "hmw_melee_only" ) != 1 ) {
            self thread unlimited_stock();
        }
    }
}

spawn_threads() {
    self endon( "endmonitor" );
    self endon( "death" );

    self remove_perks();

    if( getDvarInt( "hmw_pistol_only" ) == 1 ) {
        self give_loadout( random( level.pistol_array ) + "_fmj_xmagmwr" + random( level.camo_array ), "", "iw9_throwknife_mp", "" );
    }

    if( getDvarInt( "hmw_shotgun_only" ) == 1 ) {
        self give_loadout( random( level.shotgun_array ) + "_fmj_xmagmwr" + random( level.camo_array ), "", "iw9_throwknife_mp", "" );
    }

    if( getDvarInt( "hmw_launcher_only" ) == 1 && isbot( self ) ) {
        self give_loadout( random( level.launcher_bot_array ), "", "iw9_throwknife_mp", "" );
    }
    else if( getDvarInt( "hmw_launcher_only" ) == 1 ) {
        self give_loadout( random( level.launcher_array ), "", "iw9_throwknife_mp", "" );
    }

    if( getDvarInt( "hmw_melee_only" ) == 1 ) {
        self give_loadout( random( level.melee_array ) + random( level.camo_array ), "", "", "" );
        wait 0.05;
        weapon = self getCurrentWeapon();
        self setWeaponAmmoClip( weapon, 0 );
        self setWeaponAmmoStock( weapon, 0 );
    }

    for( ;; ) {
        self monitor_class();
        if( getDvarInt( "hmw_melee_only" ) == 1 ) {
            weapon = self getCurrentWeapon();
            if( self getWeaponAmmoClip( weapon ) != 0 || self getWeaponAmmoStock( weapon ) != 0 ) {
                self setWeaponAmmoClip( weapon, 0 );
                self setWeaponAmmoStock( weapon, 0 );
            }
        }
		wait( 1 );
	}
}

give_loadout( primary, secondary, lethal, equipment ) {
    self takeAllWeapons();
    self give_perks();
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

monitor_class() {
    weapon = self getCurrentWeapon();

    if( ( getDvarInt( "hmw_pistol_only" ) == 1 ) && !( valid_weapon( weapon ) ) ) {
        self remove_perks();
        self give_loadout( random( level.pistol_array ) + "_fmj_xmagmwr" + random( level.camo_array ), "", "iw9_throwknife_mp", "" );
    }

    if( ( getDvarInt( "hmw_shotgun_only" ) == 1 ) && !( valid_weapon( weapon ) ) ) {
        self remove_perks();
        self give_loadout( random( level.shotgun_array ) + "_fmj_xmagmwr" + random( level.camo_array ), "", "iw9_throwknife_mp", "" );
    }

    if( ( getDvarInt( "hmw_launcher_only" ) == 1 ) && !( valid_weapon( weapon ) ) ) {
        self remove_perks();
        self give_loadout( random( level.launcher_array ), "", "iw9_throwknife_mp", "" );
    }

    if( ( getDvarInt( "hmw_melee_only" ) == 1 ) && !( valid_weapon( weapon ) ) ) {
        self remove_perks();
        self give_loadout( random( level.melee_array ) + random( level.camo_array ), "", "", "" );
        wait 0.05;
        weapon = self getCurrentWeapon();
        self setWeaponAmmoClip( weapon, 0 );
        self setWeaponAmmoStock( weapon, 0 );
    }
}

valid_weapon( weapon ) {
    if( getDvarInt( "hmw_pistol_only" ) == 1 )
        return ( isStrStart( weapon, "h1_colt45" ) || isStrStart( weapon, "h1_coltanaconda" ) || isStrStart( weapon, "h1_deserteagle" ) || isStrStart( weapon, "h1_deserteagle55" ) || isStrStart( weapon, "h1_beretta" ) || isStrStart( weapon, "h1_usp" ) || isStrStart( weapon, "h2_usp" ) || isStrStart( weapon, "h2_coltanaconda" ) || isStrStart( weapon, "h2_m9" ) || isStrStart( weapon, "h2_colt45" ) || isStrStart( weapon, "h2_deserteagle" ) || isStrStart( weapon, "h2_mp412" ) || isStrStart( weapon, "iw9_throwknife" ) || isStrStart( weapon, "none" ) || isSubStr( weapon, "briefcase_bomb_mp" ) || isSubStr( weapon, "briefcase_bomb_defuse_mp" ) );

    if( getDvarInt( "hmw_shotgun_only" ) == 1 )
        return ( isStrStart( weapon, "h1_m1014" ) || isStrStart( weapon, "h1_striker" ) || isStrStart( weapon, "h1_winchester1200" ) || isStrStart( weapon, "h2_spas12" ) || isStrStart( weapon, "h2_striker" ) || isStrStart( weapon, "h2_ranger" ) || isStrStart( weapon, "h2_winchester1200" ) || isStrStart( weapon, "h2_m1014" ) || isStrStart( weapon, "h2_model1887" ) || isStrStart( weapon, "h2_ksg" ) || isStrStart( weapon, "iw9_throwknife" ) || isStrStart( weapon, "none" ) || isSubStr( weapon, "briefcase_bomb_mp" ) || isSubStr( weapon, "briefcase_bomb_defuse_mp" ) );

    if( getDvarInt( "hmw_launcher_only" ) == 1 )
        return ( isStrStart( weapon, "at4" ) || isStrStart( weapon, "h2_m79" ) || isStrStart( weapon, "h2_rpg" ) || isStrStart( weapon, "h2_m320" ) || isStrStart( weapon, "iw9_throwknife" ) || isStrStart( weapon, "none" ) || isSubStr( weapon, "briefcase_bomb_mp" ) || isSubStr( weapon, "briefcase_bomb_defuse_mp" ) );

    if( getDvarInt( "hmw_melee_only" ) == 1 )
        return ( isStrStart( weapon, "h2_usp" ) || isStrStart( weapon, "h2_coltanaconda" ) || isStrStart( weapon, "h2_m9" ) || isStrStart( weapon, "h2_colt45" ) || isStrStart( weapon, "h2_deserteagle" ) || isStrStart( weapon, "h2_mp412" ) || isStrStart( weapon, "h2_hatchet" ) || isStrStart( weapon, "h2_sickle" ) || isStrStart( weapon, "h2_shovel" ) || isStrStart( weapon, "h2_icepick" ) || isStrStart( weapon, "h2_karambit" ) || isStrStart( weapon, "iw9_throwknife" ) || isStrStart( weapon, "none" ) || isSubStr( weapon, "briefcase_bomb_mp" ) || isSubStr( weapon, "briefcase_bomb_defuse_mp" ) );
}

CodeCallback_PlayerDamage( eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset ) {
    self endon( "disconnect" );

    if( getDvarInt( "hmw_melee_only" ) != 1 ) {
        if( sMeansOfDeath == "MOD_TRIGGER_HURT" || sMeansOfDeath == "MOD_HIT_BY_OBJECT" || sMeansOfDeath == "MOD_FALLING" || sMeansOfDeath == "MOD_MELEE" )
            return;
        if( !valid_weapon( sWeapon ) )
            return;
    }
    else if( getDvarInt( "hmw_melee_only" ) == 1 ) {
        if( sMeansOfDeath != "MOD_MELEE" )
            return;
    }

    [ [ level.OriginalCallbackPlayerDamage ] ]( eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset );
}

remove_perks() {
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

give_perks() {
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
    self maps\mp\_utility::giveperk( "specialty_explosivedamage", false );
    self maps\mp\_utility::giveperk( "specialty_dangerclose", false );
    self maps\mp\_utility::giveperk( "specialty_class_dangerclose", false );
}

unlimited_stock() {
    self endon( "game_ended" );
    self endon( "disconnect" );

    if( getDvarInt( "hmw_launcher_only" ) == 1 ) {
        for(;;) {
            self waittill( "weapon_fired" );
	    	weapon = self getCurrentWeapon();
	    	if( self getWeaponAmmoStock( weapon ) <= 1 )
                self setWeaponAmmoStock( weapon, 2 );
            wait 0.05;
        }
    }
    else {
        for(;;) {
            self waittill( "weapon_fired" );
            weapon = self getCurrentWeapon();
		    self setWeaponAmmoStock( weapon, 999 );
		    wait 0.05;
        }
    }
}