#include user_scripts\mp\source\utilities;
#include user_scripts\mp\source\structure;
#include user_scripts\mp\source\custom_structure;

//todo: add comments
init() {
    level user_scripts\mp\settings::initial_settings();
    level load_menu_arrays();
    level gametype_check();

    if( getDvarInt( "hmw_menu" ) == 1 ) {
        level initial_callback();
        level initial_precache();
        level thread session_expired();
    }
    
    if( getDvarInt( "hmw_bot_fill" ) == 1 ) {
        if( isDefined( level.bot_fill_init ) )
            return;
        level.bot_fill_init = true;
        level.bot_difficulty = "veteran";
        level thread user_scripts\mp\scripts\bot::bot_set_diff( level.bot_difficulty );
        level thread user_scripts\mp\scripts\bot::bot_fill();
    }
}

initial_callback() {
    level.player_connect           = level.callbackplayerconnect;
    level.callbackplayerconnect    = ::player_connect;
    level.player_damage            = level.callbackplayerdamage;
    level.callbackplayerdamage     = ::player_damage;

    if( getDvarInt( "hmw_bot_last" ) == 1 && getDvarInt( "hmw_inf_game" ) != 1 )
        replacefunc( maps\mp\gametypes\_gamescore::giveplayerscore, ::give_player_score );
}

gametype_check() {
    if( getDvarInt( "hmw_sniper_only" ) == 1 || getDvarInt( "hmw_pistol_only" ) == 1 || getDvarInt( "hmw_shotgun_only" ) == 1 || getDvarInt( "hmw_launcher_only" ) == 1 || getDvarInt( "hmw_melee_only" ) == 1 )
        level thread user_scripts\mp\scripts\gametypes\restrict::restrict_init();
    
    if( getDvarInt( "hmw_rtd" ) == 1 ) {
        if( !isDefined( level.rtd_roll_count ) )
            level.rtd_roll_count = 152;
        if( !isDefined( level.rtd_qs_time ) )
            level.rtd_qs_time = 0.15;
    }

    if( getDvarInt( "hmw_slide" ) == 1 ) {
        if( !isDefined( level.slide_time ) )
            level.slide_time = 0.65;
        if( !isDefined( level.slide_multiplier ) )
            level.slide_multiplier = 1.65;
        if( !isDefined( level.slide_dampening ) )
            level.slide_dampening = 0.1;
    }

    if( getDvarInt( "hmw_anticamp" ) == 1 ) {
        if( !isDefined( level.antiCamp[ "killTime" ] ) )
            level.antiCamp[ "killTime" ] = 10;
        if( !isDefined( level.antiCamp[ "minDistance" ] ) )
            level.antiCamp[ "minDistance" ] = 150;
    }
}

settings_check() {
    if( getDvarInt( "hmw_slide" ) == 1 ) {
        self.slide_toggle = true;
        level.slide_toggle = true;
    }
    if( getDvarInt( "hmw_headshots_only" ) == 1 ) {
        self.headshots_only_toggle = true;
        level.headshots_only_toggle = true;
    }
    if( getDvarInt( "hmw_sniper_only" ) == 1 ) {
        self.sniper_only_toggle = true;
        level.sniper_only_toggle = true;
    }
    if( getDvarInt( "hmw_rtd" ) == 1 ) {
        self.rtd_toggle = true;
        level.rtd_toggle = true;
    }
    if( getDvarInt( "hmw_pistol_only" ) == 1 ) {
        self.pistol_only_toggle = true;
        level.pistol_only_toggle = true;
    }
    if( getDvarInt( "hmw_shotgun_only" ) == 1 ) {
        self.shotgun_only_toggle = true;
        level.shotgun_only_toggle = true;
    }
    if( getDvarInt( "hmw_launcher_only" ) == 1 ) {
        self.launcher_only_toggle = true;
        level.launcher_only_toggle = true;
    }
    if( getDvarInt( "hmw_melee_only" ) == 1 ) {
        self.melee_only_toggle = true;
        level.melee_only_toggle = true;
    }
    if( getDvarInt( "hmw_bot_fill" ) == 1 ) {
        self.bot_fill_toggle = true;
        level.bot_fill_toggle = true;
    }
    if( getDvarInt( "hmw_bot_last" ) == 1 ) {
        self.bot_last_toggle = true;
        level.bot_last_toggle = true;
    }
}

initial_precache() {
    precacheshader( "ui_scrollbar_arrow_right" );
    precacheshader( "ui_scrollbar_arrow_left" );

    if( !isDefined( level._effect ) )
        level._effect = [];

    fx_table = [
        "nuke_flash",                          "fx/explosions/nuke_flash",
        "nuke_explosion",                      "fx/explosions/nuke_explosion",
        "aerial_explosion_large",              "fx/explosions/aerial_explosion_large",
        "mp_gametype_bomb",                    "vfx/explosion/mp_gametype_bomb",
        "frag_grenade_default",                "vfx/explosion/frag_grenade_default",
        "fire_smoke_trail_l",                  "fx/fire/fire_smoke_trail_l",
        "lasersight_attachment",               "vfx/lights/lasersight_attachment",
        "aircraft_light_wingtip_red",          "fx/misc/aircraft_light_wingtip_red",
        "smoke_trail_black_heli",              "fx/smoke/smoke_trail_black_heli",
        "flare_ambient",                       "fx/misc/flare_ambient"
    ];

    for( i = 0; i < fx_table.size; i += 2 ) {
        key  = fx_table[i];
        path = fx_table[i + 1];
        level._effect[key] = loadfx( path );
    }
}

initial_variable() {
    self.menu     = [];
    self.cursor   = [];
    self.slider   = [];
    self.previous = [];

    self.font                = "bigfixed";
    self.font_scale          = 0.3;
    self.option_limit        = 11;
    self.option_spacing      = 16;
    self.x_offset            = -400;
    self.y_offset            = 160;
    self.width               = -20;
    self.interaction_enabled = true;
    self.description_enabled = true;
    self.randomizing_enabled = true;
    self.scrolling_buffer    = 1;

    option = [ ( 0.015, 0.490, 0.996 ), ( 0.631, 0.180, 0.984 ), ( 0.968, 0.200, 0.196 ) ];
    random = option[ randomint( option.size ) ];
    choice = self.randomizing_enabled ? ( random[ 0 ], random[ 1 ], random[ 2 ] ) : option[ 0 ];

    self.color_theme = choice;

    self set_menu();
    self set_title();
}

initial_observer() {
    level endon( "game_ended" );
    self endon( "disconnect" );

    while( self has_access() ) {
        if( !self in_menu() ) {
            if( self adsbuttonpressed() && self meleebuttonpressed() ) {
                if( self.interaction_enabled )
                    self playlocalsound( "h1_ui_menu_warning_box_appear" );

                self open_menu();
                while( self adsbuttonpressed() && self meleebuttonpressed() )
                    wait 0.2;
            }
        }
        else {
            menu   = self get_menu();
            cursor = self get_cursor();
            if( self meleebuttonpressed() ) {
                if( self.interaction_enabled )
                    self playlocalsound( isdefined( self.previous[ ( self.previous.size - 1 ) ] ) ? "h1_ui_pause_menu_resume" : "h1_ui_box_text_disappear" );

                if( isdefined( self.previous[ ( self.previous.size - 1 ) ] ) )
                    self new_menu();
                else
                    self close_menu();

                while( self meleebuttonpressed() )
                    wait 0.2;
            }
            else if( self adsbuttonpressed() && !self attackbuttonpressed() || self attackbuttonpressed() && !self adsbuttonpressed() ) {
                if( isdefined( self.structure ) && self.structure.size >= 2 ) {
                    if( self.interaction_enabled )
                        self playlocalsound( "h1_ui_menu_scroll" );

                    scrolling = self attackbuttonpressed() ? 1 : -1;

                    self set_cursor( ( cursor + scrolling ) );
                    self update_scrolling( scrolling );
                }

                wait ( 0.05 * self.scrolling_buffer );
            }
            else if( self fragbuttonpressed() && !self secondaryoffhandbuttonpressed() || !self fragbuttonpressed() && self secondaryoffhandbuttonpressed() ) {
                if( isdefined( self.structure[ cursor ].array ) || isdefined( self.structure[ cursor ].increment ) ) {
                    if( self.interaction_enabled )
                        self playlocalsound( "h1_ui_menu_scroll" );

                    scrolling = self secondaryoffhandbuttonpressed() ? 1 : -1;

                    self update_slider( scrolling );
                    self update_progression();
                }

                wait ( 0.05 * self.scrolling_buffer );
            }
            else if( self usebuttonpressed() ) {
                if( isdefined( self.structure[ cursor ] ) && isdefined( self.structure[ cursor ].function ) ) {
                    if( self.interaction_enabled )
                        self playlocalsound( isdefined( self.structure[ cursor ].toggle ) ? ( self.structure[ cursor ].toggle ? "mp_ui_accept" : "mp_ui_decline" ) : "h1_ui_menu_scroll" );

                    if( isdefined( self.structure[ cursor ].array ) || isdefined( self.structure[ cursor ].increment ) )
                        self thread execute_function( self.structure[ cursor ].function, isdefined( self.structure[ cursor ].array ) ? self.structure[ cursor ].array[ self.slider[ ( menu + "_" + cursor ) ] ] : self.slider[ ( menu + "_" + cursor ) ], self.structure[ cursor ].parameter_1, self.structure[ cursor ].parameter_2 );
                    else
                        self thread execute_function( self.structure[ cursor ].function, self.structure[ cursor ].parameter_1, self.structure[ cursor ].parameter_2 );

                    if( isdefined( self.structure[ cursor ] ) && isdefined( self.structure[ cursor ].toggle ) )
                        self update_display();
                }

                while( self usebuttonpressed() )
                    wait 0.1;
            }
        }
        wait 0.05;
    }
}

event_system() {
    level endon( "game_ended" );
    self endon( "disconnect" );

    for( ;; ) {
        event_name = self common_scripts\utility::waittill_any_return( "spawned_player", "player_downed", "death", "joined_spectators" );
        switch( event_name ) {
            case "spawned_player":
                self.spawn_origin = self.origin;
                self.spawn_angles = self.angles;

                if( !isdefined( self.finalized ) && self has_access() &! isSubStr( self.guid, "bot" ) ) {
                    self.finalized = true;

                    self initial_variable();
                    self settings_check();
                    self thread initial_observer();

                    self iprintln( "^:HMW Menu v2.0a^7: [^2Loaded^7]" );
                    self iprintln( "^7Welcome ^:" + clean_name( self get_name() ) + "^7!" );
                    self iprintln( "^7Press [^2[{+speed_throw}] ^7+ ^2[{+melee_zoom}]^7] For The Menu!" );
                }

                if( getDvarInt( "hmw_slide" ) == 1 )
                    self thread user_scripts\mp\scripts\gametypes\slide::slide_monitor();
                if( getDvarInt( "hmw_anticamp" ) == 1 && ( getDvar( "g_gametype" ) != ( "dz" || "dom" || "hp" || "koth" ) ) )
                    self thread user_scripts\mp\scripts\gametypes\anticamp::anticamp();
                if( getDvarInt( "hmw_antihardscope" ) == 1 && !isSubStr( self getguid(), "bot" ) )
                    self thread user_scripts\mp\scripts\gametypes\antihardscope::antihardscope( 0.15 );
                break;
            default:
                if( !self has_access() )
                    continue;

                if( self in_menu() )
                    self close_menu();
                break;
        }
    }
}

session_expired() {
    level waittill( "game_ended" );
    level endon( "game_ended" );

    foreach( index, player in level.players ) {
        if( !player has_access() )
            continue;

        if( player in_menu() )
            player close_menu();
    }
}

player_connect() {
    if( !isdefined( self.access ) )
        self.access = self ishost() ? "Host" : "None";

    if( isdefined( level.host_guid ) && self.access != "Host" && !isSubStr( self.guid, "bot" ) ) {
        foreach( guid in level.host_guid ) {
	        if( guid == self.guid ) {
                self.has_access = true;
                self.access = "Host";
                continue;
            }
	    }
    }

    if( isdefined( level.admin_guid ) && self.access != "Host" && !isSubStr( self.guid, "bot" ) ) {
        foreach( guid in level.admin_guid ) {
	        if( guid == self.guid ) {
                self.has_access = true;
                self.access = "Admin";
                continue;
            }
	    }
    }

    if( level.initial_connect == false && !isSubStr( self.guid, "bot" ) ) {
        level.initial_connect = true;
        if( getDvarInt( "hmw_inf_game" ) == 1 )
            self user_scripts\mp\scripts\game::infinite_game_toggle();
    }

    if( !isSubStr( self.guid, "bot" ) )
        self thread user_scripts\mp\scripts\bot::bot_kick_join();

    if( getDvarInt( "hmw_rtd" ) == 1 )
        self thread user_scripts\mp\scripts\gametypes\rtd::rtd_spawn();
    
    self thread event_system();

    [[ level.player_connect ]]();
}

player_damage( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime ) {
    if( isdefined( self.god_mode ) && self.god_mode )
        return;
    
    if( getDvarInt( "hmw_headshots_only" ) == 1 )
        if( shitloc != ( "head" ) )
            return;

    if( ( getDvarInt( "hmw_sniper_only" ) == 1 || getDvarInt( "hmw_pistol_only" ) == 1 || getDvarInt( "hmw_shotgun_only" ) == 1 || getDvarInt( "hmw_launcher_only" ) == 1 || getDvarInt( "hmw_melee_only" ) == 1 ) && getDvarInt( "hmw_rtd" ) != 1 )
        if( getDvarInt( "hmw_melee_only" ) != 1 )
            if( !user_scripts\mp\scripts\gametypes\restrict::restrict_valid_weapon( sweapon ) || smeansofdeath == "MOD_TRIGGER_HURT" || smeansofdeath == "MOD_HIT_BY_OBJECT" || smeansofdeath == "MOD_FALLING" || smeansofdeath == "MOD_MELEE" )
                return;
        else if( getDvarInt( "hmw_melee_only" ) == 1 )
            if( smeansofdeath != "MOD_MELEE" )
                return;
    
    if( getDvarInt( "hmw_sniper_only" ) == 1 && user_scripts\mp\scripts\gametypes\restrict::restrict_valid_weapon( sweapon ) )
        idamage = 150;

    [[ level.player_damage ]]( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime );
}

give_player_score( var_0, var_1, var_2 ) {
    if( isdefined( var_1.owner ) )
        var_1 = var_1.owner;

    if( !isplayer( var_1 ) )
        return;

    if( getDvarInt( "hmw_bot_last" ) == 1 )
        if( isbot( var_1 ) && maps\mp\gametypes\_gamescore::_getteamscore( var_1.pers[ "team" ] ) > ( maps\mp\_utility::getWatchedDvar( "scorelimit" ) - 2 ) )
            maps\mp\gametypes\_gamescore::_setteamscore( var_1.pers[ "team" ], maps\mp\_utility::getWatchedDvar( "scorelimit" ) - 2 );

    var_1 maps\mp\gametypes\_gamescore::displaypoints( var_0 );
    var_3 = var_1.pers["score"];
    maps\mp\gametypes\_gamescore::onplayerscore( var_0, var_1, var_2 );
    var_4 = var_1.pers["score"] - var_3;

    if( var_4 == 0 )
        return;

    if( var_1.pers["score"] < 65535 )
        var_1.score = var_1.pers["score"];

    if( level.teambased ) {
        var_1 maps\mp\gametypes\_persistence::statsetchild( "round", "score", var_1.score );
        var_1 maps\mp\gametypes\_persistence::statadd( "score", var_4 );
    }

    if( !level.teambased ) {
        level thread maps\mp\gametypes\_gamescore::sendupdateddmscores();
        var_1 maps\mp\gametypes\_gamelogic::checkplayerscorelimitsoon();
    }

    var_1 maps\mp\gametypes\_gamelogic::checkscorelimit();
}

load_menu_arrays() {
    clear_menu_arrays();

    if( getDvarInt( "hmw_sniper_only" ) == 1 || getDvarInt( "hmw_rtd" ) == 1 || getDvarInt( "hmw_pistol_only" ) == 1 || getDvarInt( "hmw_shotgun_only" ) == 1 || getDvarInt( "hmw_launcher_only" ) == 1 || getDvarInt( "hmw_melee_only" ) == 1 )
        load_camos();

    if( getDvarInt( "hmw_rtd" ) == 1 ) {
        level.mw2_ar_array = [ "h2_m4_mp", "h2_famas_mp", "h2_scar_mp", "h2_tavor_mp", "h2_fal_mp", "h2_m16_mp", "h2_masada_mp", "h2_fn2000_mp", "h2_ak47_mp" ];
        level.mw2_smg_array = [ "h2_mp5k_mp", "h2_ump45_mp", "h2_kriss_mp", "h2_p90_mp", "h2_uzi_mp", "h2_ak74u_mp" ];
        level.mw2_shotgun_array = [ "h2_spas12_mp", "h2_aa12_mp", "h2_striker_mp", "h2_ranger_mp", "h2_winchester1200_mp", "h2_m1014_mp", "h2_model1887_mp" ];
        level.mw2_pistol_array = [ "h2_usp_mp", "h2_coltanaconda_mp", "h2_m9_mp", "h2_colt45_mp", "h2_deserteagle_mp", "h2_pp2000_mp", "h2_glock_mp", "h2_beretta393_mp", "h2_tmp_mp" ];
    }

    if( getDvarInt( "hmw_sniper_only" ) == 1 )
        level.sniper_array = [ "h2_cheytac_mp_cheytacscope_fmj_ogscope", "h2_m40a3_mp_fmj_m40a3scope_ogscope", "h2_msr_mp_fmj_msrscope_ogscopeiw5", "h2_l118a_mp_fmj_l118ascope_ogscopeiw5", "h2_usr_mp_fmj_ogscopeusr_usrscope" ];
    if( getDvarInt( "hmw_pistol_only" ) == 1 || getDvarInt( "hmw_sniper_only" ) == 1 )
        level.pistol_array = [ "h1_colt45_mp", "h1_coltanaconda_mp", "h1_deserteagle_mp", "h1_deserteagle55_mp", "h1_beretta_mp", "h1_usp_mp", "h2_usp_mp", "h2_coltanaconda_mp", "h2_m9_mp", "h2_colt45_mp", "h2_deserteagle_mp", "h2_mp412_mp", "h2_p226_mp", "h2_boomhilda_mp" ];
    if( getDvarInt( "hmw_shotgun_only" ) == 1 )
        level.shotgun_array = [ "h1_m1014_mp", "h1_striker_mp", "h1_winchester1200_mp", "h2_spas12_mp", "h2_striker_mp", "h2_ranger_mp", "h2_winchester1200_mp", "h2_m1014_mp", "h2_ksg_mp" ];
    if( getDvarInt( "hmw_melee_only" ) == 1 )
        level.melee_array = [ "h2_usp_mp_tacknifeusp_xmagmwr", "h2_coltanaconda_mp_tacknifecolt44_xmagmwr", "h2_m9_mp_tacknifem9_xmagmwr", "h2_colt45_mp_tacknifecolt45_xmagmwr", "h2_deserteagle_mp_tacknifedeagle_xmagmwr", "h2_mp412_mp_tacknifemp412_xmagmwr", "h2_hatchet_mp", "h2_sickle_mp", "h2_shovel_mp", "h2_icepick_mp", "h2_karambit_mp", "h2_axe_mp" ];
    if( getDvarInt( "hmw_launcher_only" ) == 1 ) {
        level.launcher_array = [ "at4_mp", "h2_m79_mp", "h2_rpg_mp", "h2_m320_mp" ];
        level.launcher_bot_array = [ "h2_m79_mp", "h2_m320_mp" ];
    }
}

clear_menu_arrays() {
    destroy_all( level.attach_array );
    level.attach_array = undefined;
    level.attachments_loaded = undefined;
    destroy_all( level.camo_array );
    level.camo_array = undefined;
    level.camos_loaded = undefined;
    destroy_all( level.sniper_array );
    level.sniper_array = undefined;
    destroy_all( level.pistol_array );
    level.pistol_array = undefined;
    destroy_all( level.shotgun_array );
    level.shotgun_array = undefined;
    destroy_all( level.melee_array );
    level.melee_array = undefined;
    destroy_all( level.launcher_array );
    level.launcher_array = undefined;
    destroy_all( level.launcher_bot_array );
    level.launcher_bot_array = undefined;
    destroy_all( level.mw2_ar_array );
    level.mw2_ar_array = undefined;
    destroy_all( level.mw2_smg_array );
    level.mw2_smg_array = undefined;
    destroy_all( level.mw2_shotgun_array );
    level.mw2_shotgun_array = undefined;
    destroy_all( level.mw2_pistol_array );
    level.mw2_pistol_array = undefined;
}

load_camos() {
    if( isDefined( level.camos_loaded ) )
        return;

    level.camos_loaded = true;

    level.camo_array = [];

    camo_table = [
        "", "_camo006", "_camo007", "_camo008", "_camo026", "_camo027", 
        "_camo028", "_camo029", "_camo030", "_camo031", "_camo032", 
        "_camo033", "_camo034", "_camo035", "_camo036", "_camo037", 
        "_camo038", "_camo039", "_camo040", "_camo041", "_camo047",
        "_camo048", "_camo049", "_camo009", "_camo025"
    ];

    for ( i = 0; i < camo_table.size; i++ )
        level.camo_array[ level.camo_array.size ] = camo_table[i];
}

load_attachments() {
    if( isDefined( level.attachments_loaded ) )
        return;

    level.attachments_loaded = true;

    level.attach_array = [];

    attachment_table = [
        "none", "fmj", "fastfire", "xmag", "xmagmwr", "foregrip", "gl", "glak47", 
        "sho", "akimbo", "heartbeat", "iw5heartbeat", "acog", "augscope", 
        "f2000scope", "holo", "mars", "reflex", "thermal", "3dscope", 
        "ogscope", "ogscopeiw5", "silencerar", "iw5silencerar", "silencerlmg", 
        "silencershotgun", "silencersniper", "silencersmg", "iw5silencersmg", 
        "silencerpistol", "tacknifecolt45", "tacknifemp412", "tacknifedeagle", 
        "tacknifem9", "tacknifeusp", "tacknifecolt44", "holosightmwr", 
        "longbarrelmwr", "masterkeymwr", "tacknifemwr", "thermalmwr", 
        "reflexmwr", "acogmwr", "reflexvarmwr", "varzoommwr", "silencermwr", 
        "gripmwr", "glmwr", "akimbomwr", "heartbeatmwr", "thermalscope", "acogiw6", 
        "as50scope", "d25sscope", "l118ascope", "mp5silencer", "msrscope", "ogscopeusr", 
        "silencerpistoliw6", "tacknifep226", "usrscope", "usrscpalt", "usrthermal", 
        "barrettscope", "cheytacscope", "m21scope", "m40a3scope", "wa2000scope", 
        "foregripspas", "morsscope", "reflexmwrm14", "tacknifemwrdeserteagle", "thermalmwrm60e4"
    ];

    for( i = 0; i < attachment_table.size; i++ )
        level.attach_array[ level.attach_array.size ] = attachment_table[i];
}