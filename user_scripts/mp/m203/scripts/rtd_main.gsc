#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\gametypes\_gamelogic;
#include user_scripts\mp\m203\scripts\rtd_func;

init_rtd() {
    level.mw2_ar_array = [ "h2_m4_mp", "h2_famas_mp", "h2_scar_mp", "h2_tavor_mp", "h2_fal_mp", "h2_m16_mp", "h2_masada_mp", "h2_fn2000_mp", "h2_ak47_mp" ];
    level.mw2_smg_array = [ "h2_mp5k_mp", "h2_ump45_mp", "h2_kriss_mp", "h2_p90_mp", "h2_uzi_mp", "h2_ak74u_mp" ];
    level.mw2_lmg_array = [ "h2_sa80_mp", "h2_rpd_mp", "h2_mg4_mp", "h2_aug_mp", "h2_m240_mp" ];
    level.mw2_sniper_array = [ "h2_cheytac_mp", "h2_barrett_mp", "h2_wa2000_mp", "h2_m21_mp", "h2_m40a3_mp" ];
    level.mw2_shotgun_array = [ "h2_spas12_mp", "h2_aa12_mp", "h2_striker_mp", "h2_ranger_mp", "h2_winchester1200_mp", "h2_m1014_mp", "h2_model1887_mp" ];
    level.mw2_pistol_array = [ "h2_usp_mp", "h2_coltanaconda_mp", "h2_m9_mp", "h2_colt45_mp", "h2_deserteagle_mp", "h2_pp2000_mp", "h2_glock_mp", "h2_beretta393_mp", "h2_tmp_mp" ];
    level.mw2_launcher_array = [ "at4_mp", "h2_m79", "stinger_mp", "javelin_mp", "h2_rpg_mp" ];
    level.mw2_melee_array = [ "h2_hatchet_mp", "h2_sickle_mp", "h2_shovel_mp", "h2_icepick_mp", "h2_karambit_mp", "h2_infect_mp" ];

    level.mwr_ar_array = [ "h1_mp44_mp", "h1_galil_mp", "h1_g36c_mp", "h1_m4_mp", "h1_m16_mp", "h1_fal_mp", "h1_g3_mp" ];
    level.mwr_smg_array = [ "h1_ak74u_mp", "h1_p90_mp", "h1_skorpion_mp", "h1_mac10_mp" ];
    level.mwr_lmg_array = [ "h1_m60e4_mp", "h1_m240_mp", "h1_rpd_mp", "h1_saw_mp" ];
    level.mwr_sniper_array = [ "h1_m40a3_mp", "h1_dragunov_mp", "h1_remington700_mp", "h1_vssvintorez_mp", "h1_barrett_mp", "h1_m21_mp", "h1_m14_mp" ];
    level.mwr_shotgun_array = [ "h1_m1014_mp", "h1_striker_mp", "h1_winchester1200_mp" ];
    level.mwr_pistol_array = [ "h1_colt45_mp", "h1_coltanaconda_mp", "h1_deserteagle_mp", "h1_deserteagle55_mp", "h1_pp2000_mp", "h1_beretta_mp", "h1_usp_mp" ];

    level.dlc_ar_array = [ "h2_g36c_mp", "h2_cm901_mp" ];
    level.dlc_smg_array = [ "h2_bizon_mp", "h2_mp7_mp", "h2_pm9_mp" ];
    level.dlc_lmg_array = [ "h2_pkm_mp" ];
    level.dlc_sniper_array = [ "h2_msr_mp", "h2_as50_mp", "h2_d25s_mp" ];
    level.dlc_shotgun_array = [ "h2_ksg_mp" ];
    level.dlc_pistol_array = [ "h2_fmg9_mp", "h2_mp412_mp" ];
    level.dlc_launcher_array = [ "h2_m320_mp" ];

    level.bolt_sniper_array = [ "h1_remington700_mp_acogmwr_fmj_xmagmwr", "h2_cheytac_mp_fmj_ogscope_xmagmwr", "h2_msr_mp_fmj_ogscope_xmagmwr", "h2_m40a3_mp_fmj_ogscope_xmagmwr" ];

    level.attach_array1 = [ "_reflex", "_acog", "_holo", "_thermal" ];
    level.attach_array2 = [ "_silencersmg", "_silencerlmg", "_silencerar", "_silencersniper", "_silencerpistol" ];

    level.camo_array = [ "_camo026", "_camo027", "_camo028", "_camo029", "_camo028", "_camo030", "_camo031", "_camo032", "_camo033", "_camo034", "_camo035", "_camo036", "_camo037", "_camo038", "_camo039", "_camo040", "_camo009", "_camo025" ];
    level.classic_camo_array = [ "camo001", "camo002", "camo003", "camo004", "camo005", "camo006", "camo007", "camo008" ];
    level.color_camo_array = [ "camo010", "camo011", "camo012", "camo013", "camo014", "camo015", "camo016", "camo017", "camo018", "camo019", "camo020", "camo021", "camo022", "camo023", "camo024" ];
    level.polyatomic_camo_array = [ "camo026", "camo027", "camo028", "camo029", "camo030", "camo031", "camo032", "camo033", "camo034" ];
    level.elemental_camo_array = [ "camo035", "camo036", "camo037", "camo038", "camo039", "camo040" ];
    level.special_camo_array = [ "camo041", "camo042", "camo043", "camo044", "camo045" ];
    level.gold_camo_array = [ "camo009", "camo025" ];

    level.mw2_weapon_array = [ level.mw2_ar_array, level.mw2_smg_array, level.mw2_lmg_array, level.mw2_sniper_array ];
    level.mwr_weapon_array = [ level.mwr_ar_array, level.mwr_smg_array, level.mwr_lmg_array, level.mwr_sniper_array, level.mwr_shotgun_array, level.mwr_pistol_array ];
    level.dlc_weapon_array = [ level.dlc_ar_array, level.dlc_smg_array, level.dlc_sniper_array, level.dlc_shotgun_array ];

    level.weapons_array = [ level.mw2_weapon_array, level.dlc_weapon_array ];

    level.op_weapons_array1 = [ level.mw2_ar_array, level.mw2_lmg_array, level.dlc_ar_array, level.dlc_smg_array ];
    level.op_weapons_array2 = [ "h2_ksg_mp", "h2_spas12_mp", "h2_aa12_mp", "h2_striker_mp" ];

    level.explosive_projectile_array = [ "at4_mp", "h2_rpg_mp", "stinger_mp", "remotemissile_projectile_mp", "javelin_mp", "h2_m79_mp", "harrier_FFAR_mp", "ac130_25mm_mp", "ac130_40mm_mp", "ac130_105mm_mp" ];

    level.killstreak_array = [ "radar_mp", "counter_radar_mp", "airdrop_marker_mp", "sentry_mp", "predator_mp", "airstrike_mp", "harrier_airstrike_mp", "helicopter_mp", "advanced_uav_mp", "airdrop_mega_marker_mp", "stealth_airstrike_mp", "ah6_mp", "pavelow_mp", "reaper_mp", "chopper_gunner_mp", "ac130_mp", "emp_mp", "nuke_mp" ];

    level.qs_time = 0.15;

    level.roll_count = 155;

    level._effect[ "fire_smoke_trail_l" ] = loadfx( "fx/fire/fire_smoke_trail_l" );
    level._effect[ "frag_grenade_default" ] = loadfx( "vfx/explosion/frag_grenade_default" );
}

rtd() {

    for( ;; ) {
        self waittill( "spawned_player" );
        self.rollstreak = -1;
        self.lastrollprinted = -1;
        self thread doStart();
        self thread MonitorHP( 0 );
    }
}

onJoinedTeam() {
    self endon( "disconnect" );

    for( ;; ) {
        self waittill( "joined_team" );
        self waittill( "spawned_player" );
    }
}

doStart() {
    self endon( "disconnect" );
    self endon( "death" );

    self thread onDeath();

    self Show();

    self setactionslot( 1, "" );
    self.chooseRoll = 0;
    wait 0.05;
    self thread doRandom();
}

doRandom() {
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "cancelRoll" );

    if( self.chooseRoll == 1 ) {
        self.chooseRoll = 0;
    }
    else {
        self.presentroll = RandomInt( level.roll_count );
    }
    self.rollstreak = self.rollstreak + 1;

    switch( self.presentroll ) {
        case 0:
            self thread printRoll( "^2000 - [Emergency Airdrop]" );
            self maps\mp\gametypes\_hardpoints::giveHardpoint( "airdrop_mega_marker_mp" );
            break;
        case 1:
            self thread printRoll( "^2001 - [1.5 Speed]" );
            self thread Loop( "speed", 1.5 );
            break;
        case 2:
            self thread printRoll( "^2002 - [Thumper Unlimited Ammo]" );
            self notify( "newRoll" );

            self givePerks();
            self thread UnlimitedStock( 999 );
            self thread MonitorWeapon( "h2_m79_mp" );
            break;
        case 3:
            self thread printRoll( "^2003 - [Teleporter]" );
            self _beginLocationSelection( "", "map_artillery_selector", true, ( level.mapSize / 5.625 ) );
            self.selectingLocation = true;
            self waittill( "confirm_location", location, directionYaw );
            newLocation = PhysicsTrace( location + ( 0, 0, 1000 ), location - ( 0, 0, 1000 ) );
            self SetOrigin( newLocation );
            self SetPlayerAngles( directionYaw );
            self notify( "used" );
            self endLocationSelection();
            self.selectingLocation = undefined;
            self iPrintlnBold( "^2Teleported^7! Press ^3[{+actionslot 1}] ^7to Suicide If Stuck" );
            self notifyOnPlayerCommand( "dpad_up", "+actionslot 1" );
            self waittill( "dpad_up" );
            self suicide();
            break;
        case 4:
            self thread printRoll( "^1004 - [1 HP]" );
            self.maxhealth = 2;
            self.health = 1;
            break;
        case 5:
            self thread printRoll( "^1005 - [No ADS]" );
            self allowADS( false );
            break;
        case 6:
            self thread printRoll( "^2006 - [+200 HP]" );
            self.maxhealth = self.maxhealth + 200;
            self.health = self.maxhealth;
            break;
        case 7:
            self thread printRoll( "^2007 - [All Perks]" );
            self givePerks();
            break;
        case 8:
            self thread printRoll( "^2008 - [Unlimited Frag Grenades]" );
            self takeWeapon( "h1_concussiongrenade_mp" );
            self takeWeapon( "h1_flashgrenade_mp" );
            self takeWeapon( "h1_smokegrenade_mp" );
            self takeWeapon( self GetCurrentOffhand() );
            wait 0.5;
            self setlethalweapon( "h1_fraggrenade_mp" );
            self setweaponammoclip( "h1_fraggrenade_mp", 99 );
            self GiveMaxAmmo( "h1_fraggrenade_mp" );
            self thread UnlimitedNades( 99 );
            break;
        case 9:
            self thread printRoll( "^2009 - [RPD Rapid Fire]" );
            self notify( "newRoll" );

            self thread MonitorWeapon( "h2_rpd_mp_fastfire_fmj_foregrip_xmagmwr" + random( level.camo_array ) );
            self thread UnlimitedStock( 999 );
            break;
        case 10:
            self thread printRoll( "^3010 - [Drone Swarm Vision]" );
            self thread Loop( "vision", "drone_swarm" );
            break;
        case 11:
            self thread printRoll( "^3011 - [Thermal Vision]" );
            self maps\mp\_utility::giveperk( "specialty_thermal" );
            break;
        case 12:
            self thread printRoll( "^212 - [Random Sniper Rounds]" );
            self notify( "newRoll" );

            self givePerks();
            self thread MonitorWeapon( "defaultweapon_mp" );
            self thread UnlimitedAmmo( 99 );

            for( ;; ) {
                self waittill( "weapon_fired" );
                location = aim();
                MagicBullet( random( level.mw2_sniper_array ), self getTagOrigin( "tag_eye" ), location, self );
            }
            break;
        case 13:
            self thread printRoll( "^3013 - [Inverted Contrast]" );
            self thread Loop( "vision", "cheat_invert_contrast" );
            break;
        case 14:
            self thread printRoll( "^3014 - [Melee Only]" );
            self notify( "newRoll" );
            self endon( "newRoll" );

            self givePerks();
            self thread MonitorWeapon( "h2_coltanaconda_mp_tacknifecolt44" + random( level.camo_array ) );
            self thread Loop( "speed", 1.2 );
            self thread UnlimitedAmmo( 0 );
            self thread UnlimitedStock( 0 );
            break;
        case 15:
            self thread printRoll( "^1015 - [Half Speed]" );
            self thread Loop( "speed", 0.50 );
            break;
        case 16:
            self thread printRoll( "^3016 - [Model 1887 FMJ Akimbo + Unlimited Ammo]" );
            self notify( "newRoll" );

            self givePerks();
            self thread MonitorWeapon( "h2_model1887_mp_akimbo_fmj" + random( level.camo_array ) );
            self thread UnlimitedAmmo( 999 );
            break;
        case 17:
            self thread printRoll( "^1017 - [Nuke Vision]" );
            self thread Loop( "vision", "mpnuke_aftermath" );
            break;
        case 18:
            self thread printRoll( "^2018 - [Unlimited Ammo]" );
            self thread UnlimitedAmmo( 999 );
            break;
        case 19:
            self thread printRoll( "^2019 - [Wallhack For 30 Seconds]" );
            self ThermalVisionFOFOverlayOn();
            wait 30;
            self iPrintlnBold( "Wallhack: ^1Off" );
            self ThermalVisionFOFOverlayOff();
            self thread doRandom();
            break;
        case 20:
            self thread printRoll( "^2020 - [+100 HP + Reroll]" );
            self.maxhealth = self.maxhealth + 100;
            self.health = self.maxhealth;
            wait 2;
            self thread doRandom();
            break;
        case 21:
            self thread printRoll( "^2021 - [Invulnerable For 10 Seconds]" );
            self thread doGod();
            break;
        case 22:
            self thread printRoll( "^1022 - [Throwing Knife Only]" );
            self notify( "newRoll" );
            self notify( "endmonitor" );
            self endon( "newRoll" );

            self givePerks();
            self thread UnlimitedNades( 99 );

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
            self thread printRoll( "^2023 - [RPG Only]" );
            self notify( "newRoll" );

            self givePerks();
            self thread UnlimitedStock( 999 );
            self thread MonitorWeapon( "h2_rpg_mp" );
            break;
        case 24:
            self thread printRoll( "^1024 - [No Jump, Sprint, ADS]" );
            self allowJump( false );
            self allowSprint( false );
            self allowADS( false );
            break;
        case 25:
            self thread printRoll( "^3025 - [AZUMIKKEL's Class]" );
            self notify( "newRoll" );
            self notify( "endmonitor" );

            self takeAllWeapons();
            self givePerks();
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
            self thread printRoll( "^1026 - [Freeze Every 8 Seconds]" );

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
            self thread printRoll( "^1027 - [Earthquakes]" );

            while( 1 ) {
                earthquake( 0.6, 10, self.origin, 90 );
                wait 0.5;
            }
            break;
        case 28:
            self thread printRoll( "^2028 - [MW3 Class]" );
            self notify( "newRoll" );
            self notify( "endmonitor" );

            self takeAllWeapons();
            self givePerks();
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
            self thread printRoll( "^3029 - [MP5K Akimbo]" );
            self notify( "newRoll" );

            self givePerks();
            self thread MonitorWeapon( "h2_mp5k_mp_akimbo_fmj_silencersmg_xmagmwr" + random( level.camo_array ) );
            self thread UnlimitedStock( 999 );
            break;
        case 30:
            self thread printRoll( "^2030 - [Unlimited Ammo + Reroll]" );
            self thread UnlimitedAmmo( 999 );
            wait 2;
            self thread doRandom();
            break;
        case 31:
            self thread printRoll( "^2031 - [BO1 Class]" );
            self notify( "newRoll" );
            self notify( "endmonitor" );

            self takeAllWeapons();
            self givePerks();
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
            self thread UnlimitedAmmo( 999 );
            break;
        case 32:
            self thread printRoll( "^3032 - [USP FMJ Akimbo + Unlimited Ammo]" );
            self notify( "newRoll" );

            self thread MonitorWeapon( "h2_usp_mp_akimbo_fmj_silencerpistol_xmagmwr" + random( level.camo_array ) );
            self thread UnlimitedAmmo( 999 );
            break;
        case 33:
            self thread printRoll( "^2033 - [Extra Speed + Reroll]" );
            self thread Loop( "speed", 1.5 );
            wait 2;
            self thread doRandom();
            break;
        case 34:
            self thread printRoll( "^2034 - [Walking AC130 25mm]" );
            self notify( "newRoll" );

            self takeAllWeapons();
            self thread MonitorWeapon( "ac130_25mm_mp" );
            break;
        case 35:
            self thread printRoll( "^2035 - [Invisibility For 15 Seconds]" );
            self Hide();
            wait 15;
            self iPrintlnBold( "Invisibility: ^1Off" );
            self Show();
            wait 2;
            self thread doRandom();
            break;
        case 36:
            self thread printRoll( "^3036 - [Night Vision]" );
            self thread Loop( "vision", "default_night_mp" );
            break;
        case 37:
            self thread printRoll( "^1037 - [Last Mag, Make It Count]" );
            self thread UnlimitedStock( 0 );
            break;
        case 38:
            self thread printRoll( "^1038 - [Javelin Only]" );
            self notify( "newRoll" );

            self givePerks();
            self thread UnlimitedStock( 999 );
            self thread MonitorWeapon( "javelin_mp" );
            break;
        case 39:
            self thread printRoll( "^3039 - [Night Effect]" );
            self thread Loop( "vision", "cobra_sunset3" );
            break;
        case 40:
            self thread printRoll( "^1040 - [Infected]" );
            self notify( "newRoll" );

            self takeAllWeapons();
            self givePerks();
            self thread MonitorWeapon( "h2_infect_mp" );
            break;
        case 41:
            self thread printRoll( "^2041 - [SPAS-12 FMJ Grip + Unlimited Ammo]" );
            self notify( "newRoll" );

            self givePerks();
            self thread MonitorWeapon( "h2_spas12_mp_fmj_foregrip" + random( level.camo_array ) );
            self thread UnlimitedAmmo( 999 );
            break;
        case 42:
            self thread printRoll( "^2042 - [Ranger Akimbo + Unlimited Ammo]" );
            self notify( "newRoll" );

            self givePerks();
            self thread MonitorWeapon( "h2_ranger_mp_akimbo" + random( level.camo_array ) );
            self thread UnlimitedAmmo( 999 );
            break;
        case 43:
            self thread printRoll( "^2043 - [FAL Red Dot Silenced + Unlimited Ammo]" );
            self notify( "newRoll" );

            self givePerks();
            self thread MonitorWeapon( "h2_fal_mp_reflex_silencerar" + random( level.camo_array ) );
            self thread UnlimitedAmmo( 999 );
            break;
        case 44:
            self thread printRoll( "^2044 - [Unlimited Claymores]" );
            self takeWeapon( "h1_concussiongrenade_mp" );
            self takeWeapon( "h1_flashgrenade_mp" );
            self takeWeapon( "h1_smokegrenade_mp" );
            self takeWeapon( self GetCurrentOffhand() );
            wait 0.5;
            self setlethalweapon( "h1_claymore_mp" );
            self setweaponammoclip( "h1_claymore_mp", 99 );
            self GiveMaxAmmo( "h1_claymore_mp" );
            self thread UnlimitedNades( 99 );
            break;
        case 45:
            self thread printRoll( "^3045 - [Greyscale Vision]" );
            self thread Loop( "vision", "ac130" );
            break;
        case 46:
            self thread printRoll( "^3046 - [1/13 Chance of Nuke + Reroll]" );
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
            else {
                self iPrintlnBold( "You Rolled " + ( rollnumb + 1 ) + " - ^1NUKE DENIED" );
            }
            wait 2;
            self iPrintlnBold( "Rerolling..." );
            wait 1;
            self thread doRandom();
            break;
        case 47:
            self thread printRoll( "^3047 - [Sepia Vision]" );
            self thread Loop( "vision", "sepia" );
            break;
        case 48:
            self thread printRoll( "^2048 - [Flashing Invisible]" );

            while( 1 ) {
                self Hide();
                wait 0.50;
                self Show();
                wait 0.50;
            }
            break;
        case 49:
            self thread printRoll( "^1049 - [No Perks]" );
            self maps\mp\_utility::_clearperks();
            break;
        case 50:
            self thread printRoll( "^1050 - [No Primary]" );
            wait 0.05;
            self takeWeapon( self getCurrentWeapon() );
            wait 1;
            self iPrintlnBold( "^1Switch to Your Secondary!" );
            break;
        case 51:
            self thread printRoll( "^1051 - [ADS to Shoot]" );
            self notifyOnPlayercommand( "mouse2", "+speed_throw" );
            self notifyOnPlayercommand( "mouse2O", "-speed_throw" );
            self thread UnlimitedStock( 0 );
            self thread AlternateQS();

            while( 1 ) {
                self thread UnlimitedAmmo( 0 );
                self waittill( "mouse2" );
                self notify( "endammo" );
                self setWeaponAmmoClip( self getCurrentWeapon(), 99 );
                self waittill( "mouse2O" );
                self notify( "endammo" );
            }
            break;
        case 52:
            self thread printRoll( "^1052 - [Hold F to Move]" );

            while( 1 ) {

                if( self UseButtonPressed( ) ) {
                    self freezeControls( false );
                }
                else {
                    self freezeControls( true );
                }
                wait 0.05;
            }
            break;
        case 53:
            self thread printRoll( "^3053 - [Mini Pistol Gun Game]" );
            self notify( "newRoll" );

            self.weapon1 = "h2_beretta393_mp_fmj" + random( level.camo_array );
            self.weapon2 = "h2_deserteagle_mp_fmj";
            self.weapon3 = "h2_usp_mp_fmj" + random( level.camo_array );
            self.weapon4 = "h2_m9_mp_fmj" + random( level.camo_array );
            self.weapon5 = "h2_coltanaconda_mp_fmj" + random( level.camo_array );
            self.weapon6 = "h2_colt45_mp_fmj" + random( level.camo_array );
            self.weapon7 = "h1_deserteagle55_mp_xmagmwr";
            self thread GunGame();
            self waittill( "reward" );
            self thread MonitorWeapon( "h1_deserteagle55_mp_xmagmwr" );
            self thread ExplosionWednesday( 9999 );
            self iPrintlnBold( "^2You've Completed The Gun Game!" );
            wait 1.5;
            self iPrintlnBold( "Reward: ^:Explosive Rounds" );
            break;
        case 54:
            self thread printRoll( "^1054 - [Your Gun May Jam + No Equipment]" );
            self notifyOnPlayerCommand( "dpad_down", "+actionslot 2" );
            curwep = self getCurrentWeapon();
            self takeAllWeapons();

            if( isSubStr( curwep, "akimbo" ) ) {
                self giveWeapon( curwep );
            }
            else {
                self giveWeapon( curwep );
            }

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
            self thread printRoll( "^3055 - [Purple Vision]" );
            self VisionSetNakedForPlayer( "default_night_mp", 1 );
            wait 0.5;
            self VisionSetNakedForPlayer( "ac130_inverted", 2000 );
            break;
        case 56:
            self thread printRoll( "^3056 - [Blind But Wallhack]" );
            self thread Loop( "vision", "black_bw" );
            self ThermalVisionFOFOverlayOn();
            break;
        case 57:
            self thread printRoll( "^3057 - [G18 Akimbo FMJ]" );
            self notify( "newRoll" );

            self givePerks();
            self thread MonitorWeapon( "h2_glock_mp_akimbo_fmj_xmagmwr" + random( level.camo_array ) );
            self thread UnlimitedStock( 999 );
            break;
        case 58:
            self thread printRoll( "^2058 - [200 HP + Immune to Melee]" );
            self notify( "killhp" );

            self thread MonitorHP( 800 );
            self.maxhealth = 1000;
            self.health = self.maxhealth;

            while( 1 ) {

                if( self.lasthealth - 139 <= self.health && self.lasthealth - 135 >= self.health ) {
                    self.health = self.lasthealth;
                }

                if( self.health < 800 ) {
                    self suicide();
                }
                self.lasthealth = self.health;
                wait 0.05;
            }
            break;
        case 59:
            self thread printRoll( "^3059 - [Underwater Vision]" );
            self thread Loop( "vision", "oilrig_underwater" );
            break;
        case 60:
            self thread printRoll( "^2060 - [Thermal Class]" );
            self notify( "newRoll" );
            self notify( "endmonitor" );

            self takeAllWeapons();
            self thread MonitorWeapon( "h2_aug_mp_thermal_xmagmwr" + random( level.camo_array ) );

            while( 1 ) {
                self settacticalweapon( "h1_smokegrenade_mp" );
                self setweaponammoclip( "h1_smokegrenade_mp", 99 );
                self GiveMaxAmmo( "h1_smokegrenade_mp" );
                wait 3;
            }
            break;
        case 61:
            self thread printRoll( "^1061 - [Drugs]" );

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
            self thread printRoll( "^2062 - [Kills Increase HP]" );
            self.rollstreak = self.rollstreak + 1;
            self.startscore = self.pers[ "kills" ];
            self.streaknumber = 0;

            while( 1 ) {

                if( self.streaknumber != self.pers[ "kills" ] - self.startscore ) {
                    self.streaknumber = self.pers[ "kills" ] - self.startscore;

                    if( self.streaknumber == 11 ) {
                        break;
                    }
                    self thread printRoll( "^5HP Lvl " + self.streaknumber + " [+" + 40 * self.streaknumber + " Bonus HP]" );
                    self.maxhealth = self.maxhealth + 40;
                    self.health = self.health + 40;
                }
                wait 0.05;
            }
            break;
        case 63:
            self thread printRoll( "^3063 - [+400 HP But No Regen]" );
            self.maxhealth = self.maxhealth + 400;
            self.health = self.maxhealth;

            while( 1 ) {
                self.maxhealth = self.health;
                wait 0.05;
            }
            break;
        case 64:
            self thread printRoll( "^2064 - [Cycling Lethals]" );
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
            self thread printRoll( "^1065 - [Lag]" );

            while( 1 ) {
                self freezeControls( true );
                wait 0.20;
                self freezeControls( false );
                wait 1;
            }
            break;
        case 66:
            self thread printRoll( "^2066 - [Only Die From Melee or HS]" );
            self notify( "killhp" );

            self.maxhealth = 1000;

            while( 1 ) {

                if( self.health >= self.maxhealth - 139 ) {

                    if( self.health < self.maxhealth - 130 ) {
                        self suicide();
                    }
                }
                else {
                    self.health = self.maxhealth;
                }
                wait 0.05;
            }
            break;
        case 67:
            self thread printRoll( "^2067 - [Double Roll]" );
            wait 1;
            self thread doRandom();
            wait 1;
            self thread doRandom();
            break;
        case 68:
            self thread printRoll( "^1068 - [Constantly Losing HP]" );

            while( 1 ) {

                if( self.health > 5 ) {
                    self.health = self.health - 5;
                }
                else {
                    self suicide();
                }
                wait 2;
            }
            break;
        case 69:
            self thread printRoll( "^2069 - [Ability: ^:Cloaking^2]" );
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
            self thread printRoll( "^1070 - [Crouch Only]" );

            while( 1 ) {
                self SetStance( "crouch" );
                wait 0.05;
            }
            break;
        case 71:
            self thread printRoll( "^2071 - [Exorcist]" );

            while( 1 ) {
                self SetStance( "prone" );
                self SetMoveSpeedScale( 9 );
                wait 0.05;
            }
            break;
        case 72:
            self thread printRoll( "^1072 - [Blackouts]" );

            while( 1 ) {
                self VisionSetNakedForPlayer( "black_bw", 1 );
                wait 1;
                self VisionSetNakedForPlayer( "dcemp_emp", 1 );
                wait 3;
            }
            break;
        case 73:
            self thread printRoll( "^3073 - [Stun Grenades Only]" );
            self notify( "newRoll" );
            self notify( "endmonitor" );
            self endon( "newRoll" );

            self givePerks();
            self thread UnlimitedNades( 99 );

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
            self thread printRoll( "^3074 - [1 HP But Kills Give Evasion]" );
            self notify ( "killhp" );

            self.rollstreak = self.rollstreak + 1;
            self.startscore = self.pers[ "kills" ];
            self.streaknumber = "";
            wait 2;

            while( 1 ) {

                if( self.streaknumber != self.pers[ "kills" ] - self.startscore ) {
                    self.streaknumber = self.pers[ "kills" ] - self.startscore;

                    if( self.streaknumber == 0 ) {
                        self.hitchance = 80;
                    }
                    else {

                        if( self.streaknumber == 1 ) {
                            self.hitchance = 55;
                        }
                        else {

                            if( self.streaknumber == 11 ) {
                                break;
                            }
                            else {
                                self.hitchance = int( 75 / self.streaknumber );
                            }
                        }
                    }
                    self thread printRoll( "^5Evasion Lvl " + self.streaknumber + " [" + self.hitchance + "Percent Chance To Hit]" );
                    self notify( "cancelevasion" );
                    self thread Evasion( self.hitchance );
                }
                wait 0.05;
            }
            break;
        case 75:
            self thread printRoll( "^1075 - [Camper]" );
            wait 3;
            self doTimer( 15, 1 );
            self iPrintlnBold( "You're Now Camping... Press ^3[{+actionslot 1}] ^7to Suicide" );
            self thread Camping();
            self notifyOnPlayerCommand( "dpad_up", "+actionslot 1" );
            self waittill( "dpad_up" );
            self suicide();
            break;
        case 76:
            self thread printRoll( "^2076 - [1 Shot 1 Kill Every 3 Seconds]" );
            self notify( "newRoll" );
            self notify( "endammo" );
            self notify( "endstock" );

            self givePerks();
            self thread MonitorWeapon( "h2_coltanaconda_mp_camo009" );
            self thread ExplosionWednesday( 9999 );

            while( 1 ) {
                self setWeaponAmmoClip( "h2_coltanaconda_mp_camo009", 1 );
                self setWeaponAmmoStock( "h2_coltanaconda_mp_camo009", 0 );
                self waittill( "weapon_fired" );
                wait 2.75;
            }
            break;
        case 77:
            self thread printRoll( "^3077 - [Laser]" );
            self laseron( "mp_attachment_lasersight" );
            break;
        case 78:
            self thread printRoll( "^378 - [Roll Every Kill]" );

            for( ;; ) {
                self waittill( "killed_enemy" );
                self thread doRandom();
                wait 0.05;
            }
            break;
        case 79:
            self thread printRoll( "^2079 - [Hold ^3[{+activate}] ^2And Press ^3[{+gostand}] ^2For Higher Jump]" );
            self thread highJump();
            self maps\mp\_utility::giveperk( "specialty_falldamage", false );
            break;
        case 80:
            self thread printRoll( "^1080 - [Lose HP When Firing]" );

            while( 1 ) {
                self waittill ( "weapon_fired" );
                self.health = self.health - 3;

                if( self.health < 1 ) {
                    self suicide();
                }
            }
            break;
        case 81:
            self thread printRoll( "^2081 - [Ability: ^:God Mode^2]" );
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
            self thread printRoll( "^2082 - [Ability: ^:Full Heal^2]" );
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
            self thread printRoll( "^3083 - [Mini Akimbo Gun Game]" );
            self notify( "newRoll" );

            self.weapon1 = "h2_usp_mp_akimbo" + random( level.camo_array );
            self.weapon2 = "h2_tmp_mp_akimbo" + random( level.camo_array );
            self.weapon3 = "h2_model1887_mp_akimbo" + random( level.camo_array );
            self.weapon4 = "h2_mp5k_mp_akimbo" + random( level.camo_array );
            self.weapon5 = "h2_kriss_mp_akimbo" + random( level.camo_array );
            self.weapon6 = "h2_ak74u_mp_akimbo" + random( level.camo_array );
            self.weapon7 = "h2_aa12_mp_akimbo" + random( level.camo_array );
            self thread GunGame();
            self waittill( "reward" );
            self givePerks();
            self thread Loop( "speed", 2 );
            self thread UnlimitedAmmo( 99 );
            self iPrintlnBold( "^2You've Completed The Gun Game!" );
            wait 1.5;
            self iPrintlnBold( "Reward: ^:Double Speed + Unlimited Ammo + All Perks" );
            break;
        case 84:
            self thread printRoll( "^2084 - [Press ^3[{+activate}] ^2to Save Position / ^3[{+actionslot 2}] ^2to Load Position]" );
            self thread SavePos();
            self thread LoadPos();
            break;
        case 85:
            self thread printRoll( "^2085 - [Cold Blooded, Ninja Pro]" );
            self maps\mp\_utility::giveperk( "specialty_coldblooded" );
            self maps\mp\_utility::giveperk( "specialty_spygame" );
            self maps\mp\_utility::giveperk( "specialty_heartbreaker" );
            self maps\mp\_utility::giveperk( "specialty_quieter" );
            break;
        case 86:
            self thread printRoll( "^3086 - [Mini Bling Gun Game]" );
            self notify( "newRoll" );

            self.weapon1 = "h2_m9_mp_fmj_tacknifem9" + random( level.camo_array );
            self.weapon2 = "h2_pp2000_mp_silencerpistol_xmagmwr" + random( level.camo_array );
            self.weapon3 = "h2_m1014_mp_foregrip_xmagmwr" + random( level.camo_array );
            self.weapon4 = "h2_ump45_mp_holo_silencersmg" + random( level.camo_array );
            self.weapon5 = "h2_aug_mp_foregrip_silencerar" + random( level.camo_array );
            self.weapon6 = "h2_masada_mp_fmj_silencersmg" + random( level.camo_array );
            self.weapon7 = "h2_fn2000_mp_reflex_silencerar" + random( level.camo_array );
            self thread GunGame();
            self waittill( "reward" );
            self givePerks();
            self thread UnlimitedAmmo( 99 );
            self iPrintlnBold( "^1You've Completed The Gun Game!" );
            wait 1.5;
            self iPrintlnBold( "Reward: ^:All Perks + Unlimited ammo" );
            break;
        case 87:
            self thread printRoll( "^2087 - [Kills Give Boosts]" );
            self.rollstreak = self.rollstreak + 1;
            self.upgstart = 1;
            self.startscore = self.pers[ "kills" ];
            self thread killUpgrades();
            break;
        case 88:
            self thread printRoll( "^3088 - [Magnum FMJ Akimbo + Unlimited Ammo]" );
            self notify( "newRoll" );

            self thread MonitorWeapon( "h2_coltanaconda_mp_akimbo_fmj_xmagmwr" + random( level.camo_array ) );
            self thread UnlimitedAmmo( 99 );
            break;
        case 89:
            self thread printRoll( "^2089 - [WWII Class]" );
            self notify( "newRoll" );
            self notify( "endmonitor" );

            self takeAllWeapons();
            self givePerks();
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
            self thread printRoll( "^2090 - [Constantly Damage Nearby Enemies]" );
            self thread Loop( "speed", 1.25 );

            while( 1 ) {
                RadiusDamage( self.origin, 500, 51, 10, self );

                if( self.health == self.maxhealth - 51 ) {
                    self.health = self.maxhealth;
                }

                if( self.health < self.maxhealth - 51 ) {
                    self.health = self.health + 51;
                }
                self StopShellShock();
                wait 0.50;
            }
            break;
        case 91:
            self thread printRoll( "^3091 - [Mini Sprayer Gun Game]" );
            self notify( "newRoll" );

            self.weapon1 = "h2_glock_mp_akimbo" + random( level.camo_array );
            self.weapon2 = "h2_tmp_mp_akimbo" + random( level.camo_array );
            self.weapon3 = "h2_aa12_mp_foregrip" + random( level.camo_array );
            self.weapon4 = "h2_uzi_mp_akimbo_silencersmg" + random( level.camo_array );
            self.weapon5 = "h2_rpd_mp_foregrip_silencerlmg" + random( level.camo_array );
            self.weapon6 = "h2_barrett_mp_acog_xmagmwr" + random( level.camo_array );
            self.weapon7 = "h2_ak47_mp_reflex_silencerar" + random( level.camo_array );
            self thread GunGame();
            self waittill( "reward" );
            self notify( "endstock" );
            self.maxhealth = self.maxhealth + 200;
            self.health = self.maxhealth;
            self givePerks();
            self thread Loop( "speed", 2 );
            self thread MonitorWeapon( "h2_usp_mp_tacknifeusp" + random( level.camo_array ) );
            self thread UnlimitedStock( 0 );
            self thread UnlimitedAmmo( 0 );
            self iPrintlnBold( "^2You've Completed The Gun Game!" );
            wait 1.5;
            self iPrintlnBold( "Reward: ^:Knife Runner + 200 HP" );
            break;
        case 92:
            self thread printRoll( "^3092 - [C4 Only]" );
            self notify( "newRoll" );
            self notify( "endmonitor" );
            self endon( "newRoll" );

            self givePerks();
            self thread UnlimitedNades( 99 );

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
            self thread printRoll( "^2093 - [Extreme Speed For 15 Seconds]" );
            self thread Loop( "speed", 3 );
            wait 15;
            self notify( "stoploop" );
            self SetMoveSpeedScale( 1 );
            wait 0.01;
            self thread doRandom();
            break;
        case 94:
            self thread printRoll( "^2094 - [UAV + Reroll]" );
            self maps\mp\gametypes\_hardpoints::giveHardpoint( "radar_mp", true );
            wait 2;
            self thread doRandom();
            break;
        case 95:
            self thread printRoll( "^2095 - [2: Airtrike, 4: Stealth, 6: EMP]" );
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
            self thread printRoll( "^2096 - [Uzi Akimbo + Unlimited Ammo]" );
            self notify( "newRoll" );

            self givePerks();
            self thread MonitorWeapon( "h2_uzi_mp_akimbo_fmj_foregrip_silencerlmg" + random( level.camo_array ) );
            self thread UnlimitedAmmo( 99 );
            break;
        case 97:
            self thread printRoll( "^2097 - [AA12 Rapid Fire]" );
            self notify( "newRoll" );

            self givePerks();
            self thread MonitorWeapon( "h2_aa12_mp_fastfire_fmj_foregrip_xmagmwr" + random( level.camo_array ) );
            self thread UnlimitedStock( 99 );
            break;
        case 98:
            self thread printRoll( "^2098 - [Ability: ^:Nitro^2]" );
            self notify( "newability" );
            self endon( "newability" );

            self notifyOnPlayerCommand( "dpad_down", "+actionslot 2" );
            wait 2;

            while( 1 ) {
                self iPrintlnBold( "Press ^3[{+actionslot 2}] ^7For Speed Boost" );
                self waittill( "dpad_down" );
                self iPrintlnBold( "^2Speed Boost For 5 Seconds" );
                self thread Loop( "speed", 2 );
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
            self thread printRoll( "^2099 - [Faster Regen]" );

            while( 1 ) {

                if( self.health >= self.maxhealth ) {
                    self.health = self.health + 1;
                }
                wait 0.05;
            }
            break;
        case 100:
            self thread printRoll( "^3100 - [1/6 Chance of EMP + Reroll]" );
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
            else {
                self iPrintlnBold( "You Rolled " +( rollnumb + 1 ) +" - ^1EMP DENIED" );
            }
            wait 2;
            self iPrintlnBold( "Rerolling..." );
            wait 1;
            self thread doRandom();
            break;
        case 101:
            self thread printRoll( "^1101 - [No Scope Sniper]" );
            self notify( "newRoll" );

            self givePerks();
            self allowADS( false );
            self thread MonitorWeapon( random( level.bolt_sniper_array ) + random( level.camo_array ) );
            break;
        case 102:
            self thread printRoll( "^1102 - [Nothing Changes]" );
            break;
        case 103:
            self thread printRoll( "^2103 - [AK47 Rapid Fire FMJ]" );
            self notify( "newRoll" );

            self thread MonitorWeapon( "h2_ak47_mp_fastfire_fmj" + random( level.camo_array ) );
            self thread UnlimitedStock( 999 );
            break;
        case 104:
            self thread printRoll( "^2104 - [Ninja Pro, 1.25 Speed, Martyrdom]" );
            self maps\mp\_utility::giveperk( "specialty_grenadepulldeath" );
            self maps\mp\_utility::giveperk( "specialty_heartbreaker" );
            self maps\mp\_utility::giveperk( "specialty_quieter" );
            self thread Loop( "speed", 1.25 );
            break;
        case 105:
            self thread printRoll( "^0105 - [You're Dead!]" );
            self suicide();
            break;
        case 106:
            self thread printRoll( "^1106 - [You're Dying...]" );
            wait 3.00;
            self doTimer( 30, 1 );
            self suicide();
            break;
        case 107:
            self thread printRoll( "^3107 - [New Roll Every 7 Seconds]" );
            self.rollstreak = self.rollstreak + 1;
            wait 2;
            self thread allRandom();
            break;
        case 108:
            self thread printRoll( "^3108 - [Wallhack + Thermal But Only Melee]" );
            self notify( "newRoll" );

            self ThermalVisionFOFOverlayOn();
            self maps\mp\_utility::giveperk( "specialty_thermal" );
            self thread MonitorWeapon( "h2_deserteagle_mp_tacknifedeagle_camo009" );

            while( 1 ) {
                self setWeaponAmmoClip( "h2_deserteagle_mp_tacknifedeagle_camo009", 0 );
                self setWeaponAmmoStock( "h2_deserteagle_mp_tacknifedeagle_camo009", 0 );
                wait 0.5;
            }
            break;
        case 109:
            self thread printRoll( "^3109 - [Default Weapon]" );
            self notify( "newRoll" );

            self givePerks();
            self thread MonitorWeapon( "defaultweapon_mp" );
            self thread UnlimitedAmmo( 99 );
            break;
        case 110:
            self thread printRoll( "^2110 - [Desert Eagle Akimbo + Unlimited Ammo]" );
            self notify( "newRoll" );

            self givePerks();
            self thread MonitorWeapon( "h1_deserteagle55_mp_akimbo_xmagmwr" );
            self thread UnlimitedAmmo( 99 );
            break;
        case 111:
            self thread printRoll( "^2111 - [Care Package + Reroll]" );
            self maps\mp\gametypes\_hardpoints::giveHardpoint( "airdrop_marker_mp", true );
            wait 2;
            self thread doRandom();
            break;
        case 112:
            self thread printRoll( "^2112 - [Explosive Rounds For 15 Seconds]" );
            self ExplosionWednesday( 15 );
            self iPrintlnBold( "Explosive Rounds: ^1Off" );
            self thread doRandom();
            break;
        case 113:
            self thread printRoll( "^2113 - [Shellshock Immune]" );

            for( ;; ) {
                self StopShellShock();
                wait 0.05;
            }
            break;
        case 114:
            self thread printRoll( "^1114 - [Disco Time]" );
            self thread doVision();
            break;
        case 115:
            self thread printRoll( "^2115 - [Press ^3[{+actionslot 2}] ^2to Call a Suicide Plane]" );
            self thread DeathHarrier();
            break;
        case 116:
            self thread printRoll( "^2116 - [Aimbot For 15 Seconds]" );
            self autoAim();
            self iPrintlnBold( "Aimbot: ^1Off" );
            wait 3;
            self thread doRandom();
            break;
        case 117:
            self thread printRoll( "^3117 - [Cycling Weapons]" );
            self thread cycleWeapons();
            break;
        case 118:
            self thread printRoll( "^1118 - [Military Training]" );

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
            self thread printRoll( "^2119 - [Walking AC130 105mm]" );
            self notify( "newRoll" );

            self takeAllWeapons();
            self thread MonitorWeapon( "ac130_105mm_mp" );
            break;
        case 120:
            self thread printRoll( "^3120 - [+400 HP But 1/4 Speed]" );
            self.maxhealth = self.maxhealth + 400;
            self.health = self.maxhealth;
            self thread Loop( "speed", 0.25 );
            break;
        case 121:
            self thread printRoll( "^1121 - [No HP Regen]" );

            while( 1 ) {

                if( self.health < self.maxhealth ) {
                    self.maxhealth = self.health;
                }
                wait 0.25;
            }
            break;
        case 122:
            self thread printRoll( "^3122 - [Sniper Class I]" );
            self notify( "newRoll" );
            self notify( "endmonitor" );

            self takeAllWeapons();
            self givePerks();
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
            self thread printRoll( "^2123 - [Triple Roll]" );
            wait 1;
            self thread doRandom();
            wait 1;
            self thread doRandom();
            wait 1;
            self thread doRandom();
            break;
        case 124:
            self thread printRoll( "^2124 - [RPG Rounds]" );
            self endon( "defaultProj" );

            for( ;; ) {
                self waittill( "weapon_fired" );
                location = aim();
                MagicBullet( "h2_rpg_mp", self getTagOrigin( "tag_eye" ), location, self );
            }
            break;
        case 125:
            self thread printRoll( "^2125 - [M79 Grenade Rounds]" );
            self endon( "defaultProj" );

            for( ;; ) {
                self waittill( "weapon_fired" );
                location = aim();
                MagicBullet( "h2_m79_mp", self getTagOrigin( "tag_eye" ), location, self );
            }
            break;
        case 126:
            self thread printRoll( "^2126 - [Artillery Rounds]" );
            wait 2;

            for( ;; ) {
                self iPrintlnBold( "^2Artillery Rounds Ready!" );
                self waittill ( "weapon_fired" );
                location = aim();
                MagicBullet( "remotemissile_projectile_mp", location + ( 0, 0, 8000 ), location, self );
                MagicBullet( "javelin_mp", location + ( 0, 0, 8000 ), location, self );
                self iPrintlnBold( "^3Artillery Rounds Rearming..." );
                wait 7;
            }
            break;
        case 127:
            self thread printRoll( "^2127 - [Random Killstreak + Reroll]" );
            self maps\mp\gametypes\_hardpoints::giveHardpoint( random( level.killstreak_array ) );
            wait 2;
            self thread doRandom();
            break;
        case 128:
            self thread printRoll( "^2128 - [Laser Gun]" );
            self notify( "newRoll" );

            self thread MonitorWeapon( "h2_fn2000_mp_fastfire_silencersniper_xmagmwr_camo030" );
            for( ;; ) {
                self waittill( "weapon_fired" );
                self thread laserBeam();
            }
            break;
        case 129:
            self thread printRoll( "^2129 - [Double Jump]" );
            self endon( "endMultijump" );

            self givePerks();
            self thread landsOnGround();
            if( !isDefined( self.numOfMultijumps ) )
            self.numOfMultijumps = 1;

            for( ;; ) {
                currentNum = 0;
                while( !self jumpbuttonpressed( ) ) wait 0.05;
                while( self jumpbuttonpressed( ) ) wait 0.05;
                if( getDvarInt( "jump_height" ) > 250 )
                continue;

                if( !isAlive( self ) ) {
                    self waittill( "spawned_player" );
                    continue;
                }

                if( !self isOnGround( ) ) {

                    while( !self isOnGround( ) && isAlive( self ) && currentNum < self.numOfMultijumps ) {
                        waittillResult = self waittill_any_timeout( 0.11, "landedOnGround", "disconnect", "death" );

                        while( waittillResult == "timeout" ) {

                            if( self jumpbuttonpressed( ) ) {
                                waittillResult = "jump";
                                break;
                            }
                            waittillResult = self waittill_any_timeout( 0.05, "landedOnGround", "disconnect", "death" );
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
            self thread printRoll( "^3130 - [Sniper Class II]" );
            self notify( "newRoll" );
            self notify( "endmonitor" );

            self takeAllWeapons();
            self givePerks();
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
            self thread printRoll( "^2131 - [Ability: ^:Predator Drone^2]" );
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
            self thread printRoll( "^2132 - [Juggernaut]" );
            self notify( "newRoll" );
            self notify( "endmonitor" );

            self.maxhealth = self.maxhealth + 400;
            self.health = self.maxhealth;
            self takeAllWeapons();
            self givePerks();
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
            self thread Loop( "speed", 0.55 );

            for( ;; ) {
                self StopShellShock();
                wait 0.05;
            }
            break;
        case 133:
            self thread printRoll( "^3133 - [Pro Mod Vision]" );
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
            self thread printRoll( "^2134 - [Unlimited Jumps]" );
            self endon( "endMultijump" );

            self givePerks();
            self thread landsOnGround();
            if( !isDefined( self.numOfMultijumps ) )
            self.numOfMultijumps = 99999;

            for( ;; ) {
                currentNum = 0;
                while( !self jumpbuttonpressed( ) ) wait 0.05;
                while( self jumpbuttonpressed( ) ) wait 0.05;
                if( getDvarInt( "jump_height" ) > 250 )
                continue;

                if( !isAlive( self ) ) {
                    self waittill( "spawned_player" );
                    continue;
                }

                if( !self isOnGround( ) ) {

                    while( !self isOnGround( ) && isAlive( self ) && currentNum < self.numOfMultijumps ) {
                        waittillResult = self waittill_any_timeout( 0.11, "landedOnGround", "disconnect", "death" );

                        while( waittillResult == "timeout" ) {

                            if( self jumpbuttonpressed( ) ) {
                                waittillResult = "jump";
                                break;
                            }
                            waittillResult = self waittill_any_timeout( 0.05, "landedOnGround", "disconnect", "death" );
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
            self thread printRoll( "^2135 - [Push Nearby Enemies]" );
            self endon( "endForce" );

            while( 1 ) {

                foreach( p in level.players ) {

                    if( ( distance( self.origin, p.origin ) <= 200 && level.teamBased && p.pers[ "team" ] != self.team ) || ( distance( self.origin, p.origin ) <= 200 && !level.teamBased ) ) {
                        atf = anglestoforward( self getplayerangles() );

                        if( p != self ) {
                            p setvelocity( p getvelocity() + ( atf[ 0 ] * ( 300 * 2 ), atf[ 1 ] * ( 300 * 2 ), ( atf[ 2 ] + 0.25 ) * ( 300 * 2 ) ) );
                        }
                    }
                }
                wait 0.05;
            }
            break;
        case 136:
            self thread printRoll( "^3136 - [Random Third Weapon]" );
            self notify( "newRoll" );
            self notify( "endmonitor" );

            weapon_array1 = random( level.weapons_array );
            weapon_array2 = random( weapon_array1 );
            //third_weapon = random(weapon_array2) + "_fastfire_fmj" + random(level.attach_array2) + "_xmagmwr" + random(level.camo_array);
            third_weapon = random( weapon_array2 ) + "_fastfire_fmj_xmagmwr" + random( level.camo_array );
            self GiveWeapon( third_weapon );
            self GiveMaxAmmo( third_weapon );
            wait 0.05;
            self switchToWeapon( third_weapon );
            break;
        case 137:
            self thread printRoll( "^2137 - [Nova Gas Grenade]" );
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
            self thread printRoll( "^2138 - [Bullets Ricochet]" );
            self endon( "endRicochet" );

            for( ;; ) {
                self waittill( "weapon_fired" );
                self thread reflectbullet( 30, self getcurrentweapon() );
            }
            break;
        case 139:
            self thread printRoll( "^1139 - [Rotating]" );

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
            self thread printRoll( "^2140 - [Mustang & Sally]" );
            self notify( "newRoll" );

            self givePerks();
            self thread MonitorWeapon( "h2_colt45_mp_akimbo_xmagmwr_camo036" );
            self thread UnlimitedStock( 99 );

            for( ;; ) {
                self waittill( "weapon_fired" );

                if( self getCurrentWeapon( ) == "h2_colt45_mp_akimbo_xmagmwr_camo036" ) {
                    location = aim();
                    MagicBullet( "h2_m79_mp", self getTagOrigin( "tag_eye" ), location, self );
                }
                wait 0.001;
            }
            break;
        case 141:
            self thread printRoll( "^2141 - [Ability: ^:Leap^2]" );
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
            self thread printRoll( "^2142 - [Ability: ^:Rocket Barrage^2]" );
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
            self thread printRoll( "^3143 - [Flash Grenades Only]" );
            self notify( "newRoll" );
            self notify( "endmonitor" );
            self endon( "newRoll" );

            self givePerks();
            self thread UnlimitedNades( 99 );

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
            self thread printRoll( "^2144 - [Unlimited Semtex]" );
            self takeWeapon( "h1_concussiongrenade_mp" );
            self takeWeapon( "h1_flashgrenade_mp" );
            self takeWeapon( "h1_smokegrenade_mp" );
            self takeWeapon( self GetCurrentOffhand() );
            wait 0.5;
            self setlethalweapon( "h2_semtex_mp" );
            self setweaponammoclip( "h2_semtex_mp", 99 );
            self GiveMaxAmmo( "h2_semtex_mp" );
            self thread UnlimitedNades( 99 );
            break;
        case 145:
            self thread printRoll( "^1145 - [Bugged Weapons]" );
            self notify( "newRoll" );
            self notify( "endmonitor" );

            self takeAllWeapons();
            self givePerks();
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
            self thread printRoll( "^2146 - [Random OP Class]" );
            self notify( "newRoll" );
            self notify( "endmonitor" );

            op_weapon_array1 = random( level.op_weapons_array1 );
            op_weapon_array2 = random( level.op_weapons_array2 );

            op_weapon_1 = random( op_weapon_array1 ) + "_fastfire_fmj_xmagmwr" + random( level.camo_array );
            op_weapon_2 = op_weapon_array2 + "_akimbo_fmj_foregrip_xmagmwr" + random( level.camo_array );

            self takeAllWeapons();
            self givePerks();
            self giveWeapon( op_weapon_1 );
            self GiveMaxAmmo( op_weapon_1 );
            self giveWeapon( op_weapon_2 );
            self GiveMaxAmmo( op_weapon_2 );
            self setlethalweapon( "h2_semtex_mp" );
            self setweaponammoclip( "h2_semtex_mp", 99 );
            self GiveMaxAmmo( "h2_semtex_mp" );
            self settacticalweapon( "h1_smokegrenade_mp" );
            self setweaponammoclip( "h1_smokegrenade_mp", 99 );
            self GiveMaxAmmo( "h1_smokegrenade_mp" );
            wait 0.05;
            self switchToWeapon( op_weapon_1 );
            break;
        case 147:
            self thread printRoll( "^2147 - [Random Rounds]" );
            self notify( "newRoll" );
            self endon( "randRounds" );

            self givePerks();
            self thread MonitorWeapon( "defaultweapon_mp" );
            self thread UnlimitedAmmo( 99 );

            for( ;; ) {

                if( self AttackButtonPressed( ) ) {
                    weapon_array1 = random( level.weapons_array );
                    weapon_array2 = random( weapon_array1 );
                    location = aim();
                    MagicBullet( random( weapon_array2 ), self getTagOrigin( "tag_eye" ), location, self );
                }
                wait 0.09;
            }
            break;
        case 148:
            self thread printRoll( "^2148 - [OP Class]" );
            self notify( "newRoll" );
            self notify( "endmonitor" );

            self takeAllWeapons();
            self givePerks();
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
            self thread printRoll( "^2149 - [MWR Class]" );
            self notify( "newRoll" );
            self notify( "endmonitor" );

            self takeAllWeapons();
            self givePerks();
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
            self thread printRoll( "^3150 - [End Game Vision]" );
            self thread Loop( "vision", "end_game" );
            break;
        case 151:
            self thread printRoll( "^2151 - [Jetpack]" );
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
                if( self.fuel < 200 && !self usebuttonpressed( ) ) self.fuel++;
                wait 0.05;
            }
            break;
        case 152:
            self thread printRoll( "^2152 - [Ability: ^:Feign Death^2]" );
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
        case 153:
            self thread printRoll( "^1153 - [Space]" );
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
        case 154:
            self thread printRoll( "^3154 - [QuickScope Only]" );
            self endon( "endQS" );
            self notify( "newRoll" );

            self givePerks();
            self thread MonitorWeapon( random( level.bolt_sniper_array ) + random( level.camo_array ) );
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
        case 155:
            self thread printRoll( "^3155 - [Random Gun Game]" );
            self notify( "newRoll" );

            self.weapon1 = random( level.mw2_pistol_array ) + random( level.camo_array );
            self.weapon2 = random( level.mw2_smg_array ) + random( level.camo_array );
            self.weapon3 = random( level.mw2_shotgun_array ) + random( level.camo_array );
            self.weapon4 = random( level.mw2_ar_array ) + random( level.camo_array );
            self.weapon5 = random( level.mw2_sniper_array ) + random( level.camo_array );
            self.weapon6 = "h2_m320_mp";
            self.weapon7 = "h2_fn2000_mp_camo009";
            self thread GunGame();
            self waittill( "reward" );
            self thread MonitorWeapon( "h2_fn2000_mp_camo009" );
            self thread ExplosionWednesday( 9999 );
            self iPrintlnBold( "^2You've Completed The Gun Game!" );
            wait 1.5;
            self iPrintlnBold( "Reward: ^:Explosive Rounds" );
            break;
    }
}

onDeath() {
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
    setDvar( "perk_weapReloadMultiplier", 0.5 );
    setDvar( "jump_height", 39 );
}
