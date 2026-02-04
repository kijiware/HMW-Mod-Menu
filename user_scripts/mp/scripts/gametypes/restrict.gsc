//todo: refactor, add comments
restrict_init() {
    level endon( "game_ended" );
    level endon( "gametypechanged" );

    level thread restrict_connect();
}

restrict_connect() {
    level endon( "game_ended" );
    level endon( "gametypechanged" );
    for( ;; ) {
        level waittill( "connected", player );
        setDvar( "sv_disableCustomClasses", 1 );
        setDvar( "scr_skipclasschoice", 1 );
        if( getDvar( "g_gametype" ) != "dz" ) {
            setDvar( "scr_game_killstreakdelay", 99999 );
            setDvar( "scr_game_hardpoints", 0 );
        }

        player thread restrict_spawn();
    }
}

restrict_spawn() {
    self endon( "disconnect" );
    level endon( "gametypechanged" );
    level endon( "game_ended" );

    //Antihardscope
    if( getDvarInt( "hmw_sniper_only" ) == 1 && getDvarInt( "hmw_antihardscope" ) == 0 )
        setDvar( "hmw_antihardscope", 1 );

    while( true ) {
        self waittill( "spawned_player" );
        if( isDefined( self.playerSpawned ) )
            continue;

        self thread restrict_spawn_threads();

        if( getDvarInt( "hmw_melee_only" ) != 1 )
            self thread restrict_unlimited_stock();
    }
}

restrict_spawn_threads() {
    level endon( "game_ended" );
    level endon( "gametypechanged" );
    self endon( "endmonitor" );
    self endon( "death" );

    if( getDvarInt( "hmw_sniper_only" ) == 1 )
        self user_scripts\mp\scripts\weapon::give_loadout( common_scripts\utility::random( level.sniper_array ) + "_xmagmwr" + common_scripts\utility::random( level.camo_array ), common_scripts\utility::random( level.pistol_array ) + common_scripts\utility::random( level.camo_array ), "iw9_throwknife_mp", "" );

    if( getDvarInt( "hmw_pistol_only" ) == 1 )
        self user_scripts\mp\scripts\weapon::give_loadout( common_scripts\utility::random( level.pistol_array ) + "_fmj_xmagmwr" + common_scripts\utility::random( level.camo_array ), "", "iw9_throwknife_mp", "" );

    if( getDvarInt( "hmw_shotgun_only" ) == 1 )
        self user_scripts\mp\scripts\weapon::give_loadout( common_scripts\utility::random( level.shotgun_array ) + "_fmj_xmagmwr" + common_scripts\utility::random( level.camo_array ), "", "iw9_throwknife_mp", "" );

    if( getDvarInt( "hmw_launcher_only" ) == 1 && isbot( self ) )
        self user_scripts\mp\scripts\weapon::give_loadout( common_scripts\utility::random( level.launcher_bot_array ), "", "iw9_throwknife_mp", "" );
    else if( getDvarInt( "hmw_launcher_only" ) == 1 )
        self user_scripts\mp\scripts\weapon::give_loadout( common_scripts\utility::random( level.launcher_array ), "", "iw9_throwknife_mp", "" );

    if( getDvarInt( "hmw_melee_only" ) == 1 ) {
        self user_scripts\mp\scripts\weapon::give_loadout( common_scripts\utility::random( level.melee_array ) + common_scripts\utility::random( level.camo_array ), "", "", "" );
        wait 0.05;
        weapon = self getCurrentWeapon();
        self setWeaponAmmoClip( weapon, 0 );
        self setWeaponAmmoStock( weapon, 0 );
    }

    for( ;; ) {
        self restrict_monitor();
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

restrict_monitor() {
    level endon( "game_ended" );

    weapon = self getCurrentWeapon();

    if( ( getDvarInt( "hmw_sniper_only" ) == 1 ) && !( restrict_valid_weapon( weapon ) || user_scripts\mp\scripts\util::array_contains_weapon( level.pistol_array, weapon ) ) )
        self user_scripts\mp\scripts\weapon::give_loadout( common_scripts\utility::random( level.sniper_array ) + "_xmagmwr" + common_scripts\utility::random( level.camo_array ), common_scripts\utility::random( level.pistol_array ) + common_scripts\utility::random( level.camo_array ), "iw9_throwknife_mp", "" );

    if( ( getDvarInt( "hmw_pistol_only" ) == 1 ) && !( restrict_valid_weapon( weapon ) ) )
        self user_scripts\mp\scripts\weapon::give_loadout( common_scripts\utility::random( level.pistol_array ) + "_fmj_xmagmwr" + common_scripts\utility::random( level.camo_array ), "", "iw9_throwknife_mp", "" );

    if( ( getDvarInt( "hmw_shotgun_only" ) == 1 ) && !( restrict_valid_weapon( weapon ) ) )
        self user_scripts\mp\scripts\weapon::give_loadout( common_scripts\utility::random( level.shotgun_array ) + "_fmj_xmagmwr" + common_scripts\utility::random( level.camo_array ), "", "iw9_throwknife_mp", "" );

    if( ( getDvarInt( "hmw_launcher_only" ) == 1 ) && !( restrict_valid_weapon( weapon ) ) )
        self user_scripts\mp\scripts\weapon::give_loadout( common_scripts\utility::random( level.launcher_array ), "", "iw9_throwknife_mp", "" );

    if( ( getDvarInt( "hmw_melee_only" ) == 1 ) && !( restrict_valid_weapon( weapon ) ) ) {
        self user_scripts\mp\scripts\weapon::give_loadout( common_scripts\utility::random( level.melee_array ) + common_scripts\utility::random( level.camo_array ), "", "", "" );
        wait 0.05;
        weapon = self getCurrentWeapon();
        self setWeaponAmmoClip( weapon, 0 );
        self setWeaponAmmoStock( weapon, 0 );
    }
}

restrict_valid_weapon( weapon ) {
    level endon( "game_ended" );

    if( getDvarInt( "hmw_sniper_only" ) == 1 )
        return ( maps\mp\_utility::isStrStart( weapon, "h2_cheytac" ) || maps\mp\_utility::isStrStart( weapon, "h2_m40a3" ) || maps\mp\_utility::isStrStart( weapon, "h2_msr" ) || maps\mp\_utility::isStrStart( weapon, "h2_l118a" ) || maps\mp\_utility::isStrStart( weapon, "h2_usr" ) || maps\mp\_utility::isStrStart( weapon, "iw9_throwknife" ) || maps\mp\_utility::isStrStart( weapon, "none" ) || isSubStr( weapon, "briefcase_bomb_mp" ) || isSubStr( weapon, "briefcase_bomb_defuse_mp" ) );

    if( getDvarInt( "hmw_pistol_only" ) == 1 )
        return ( maps\mp\_utility::isStrStart( weapon, "h1_colt45" ) || maps\mp\_utility::isStrStart( weapon, "h1_coltanaconda" ) || maps\mp\_utility::isStrStart( weapon, "h1_deserteagle" ) || maps\mp\_utility::isStrStart( weapon, "h1_deserteagle55" ) || maps\mp\_utility::isStrStart( weapon, "h1_beretta" ) || maps\mp\_utility::isStrStart( weapon, "h1_usp" ) || maps\mp\_utility::isStrStart( weapon, "h2_usp" ) || maps\mp\_utility::isStrStart( weapon, "h2_coltanaconda" ) || maps\mp\_utility::isStrStart( weapon, "h2_m9" ) || maps\mp\_utility::isStrStart( weapon, "h2_colt45" ) || maps\mp\_utility::isStrStart( weapon, "h2_deserteagle" ) || maps\mp\_utility::isStrStart( weapon, "h2_mp412" ) || maps\mp\_utility::isStrStart( weapon, "h2_p226" ) || maps\mp\_utility::isStrStart( weapon, "h2_boomhilda" ) || maps\mp\_utility::isStrStart( weapon, "iw9_throwknife" ) || maps\mp\_utility::isStrStart( weapon, "none" ) || isSubStr( weapon, "briefcase_bomb_mp" ) || isSubStr( weapon, "briefcase_bomb_defuse_mp" ) );

    if( getDvarInt( "hmw_shotgun_only" ) == 1 )
        return ( maps\mp\_utility::isStrStart( weapon, "h1_m1014" ) || maps\mp\_utility::isStrStart( weapon, "h1_striker" ) || maps\mp\_utility::isStrStart( weapon, "h1_winchester1200" ) || maps\mp\_utility::isStrStart( weapon, "h2_spas12" ) || maps\mp\_utility::isStrStart( weapon, "h2_striker" ) || maps\mp\_utility::isStrStart( weapon, "h2_ranger" ) || maps\mp\_utility::isStrStart( weapon, "h2_winchester1200" ) || maps\mp\_utility::isStrStart( weapon, "h2_m1014" ) || maps\mp\_utility::isStrStart( weapon, "h2_model1887" ) || maps\mp\_utility::isStrStart( weapon, "h2_ksg" ) || maps\mp\_utility::isStrStart( weapon, "iw9_throwknife" ) || maps\mp\_utility::isStrStart( weapon, "none" ) || isSubStr( weapon, "briefcase_bomb_mp" ) || isSubStr( weapon, "briefcase_bomb_defuse_mp" ) );

    if( getDvarInt( "hmw_launcher_only" ) == 1 )
        return ( maps\mp\_utility::isStrStart( weapon, "at4" ) || maps\mp\_utility::isStrStart( weapon, "h2_m79" ) || maps\mp\_utility::isStrStart( weapon, "h2_rpg" ) || maps\mp\_utility::isStrStart( weapon, "h2_m320" ) || maps\mp\_utility::isStrStart( weapon, "iw9_throwknife" ) || maps\mp\_utility::isStrStart( weapon, "none" ) || isSubStr( weapon, "briefcase_bomb_mp" ) || isSubStr( weapon, "briefcase_bomb_defuse_mp" ) );

    if( getDvarInt( "hmw_melee_only" ) == 1 )
        return ( maps\mp\_utility::isStrStart( weapon, "h2_usp" ) || maps\mp\_utility::isStrStart( weapon, "h2_coltanaconda" ) || maps\mp\_utility::isStrStart( weapon, "h2_m9" ) || maps\mp\_utility::isStrStart( weapon, "h2_colt45" ) || maps\mp\_utility::isStrStart( weapon, "h2_deserteagle" ) || maps\mp\_utility::isStrStart( weapon, "h2_mp412" ) || maps\mp\_utility::isStrStart( weapon, "h2_hatchet" ) || maps\mp\_utility::isStrStart( weapon, "h2_sickle" ) || maps\mp\_utility::isStrStart( weapon, "h2_shovel" ) || maps\mp\_utility::isStrStart( weapon, "h2_icepick" ) || maps\mp\_utility::isStrStart( weapon, "h2_karambit" ) || maps\mp\_utility::isStrStart( weapon, "h2_axe" ) || maps\mp\_utility::isStrStart( weapon, "iw9_throwknife" ) || maps\mp\_utility::isStrStart( weapon, "none" ) || isSubStr( weapon, "briefcase_bomb_mp" ) || isSubStr( weapon, "briefcase_bomb_defuse_mp" ) );
}

restrict_unlimited_stock() {
    level endon( "game_ended" );
    self endon( "disconnect" );
    level endon( "gametypechanged" );

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