#include user_scripts\mp\m203\source\utilities;
#include user_scripts\mp\m203\source\structure;
#include user_scripts\mp\m203\source\custom_structure;
#include user_scripts\mp\m203\scripts\common;
#include maps\mp\_utility;
#include maps\mp\gametypes\_gamescore;

initial() {
    //HMW Mod Menu
    setDvarIfUninitialized( "hmw_menu", 1 );

    //Auto Bot Fill
    setDvarIfUninitialized( "hmw_bot_fill", 0 );
    setDvarIfUninitialized( "hmw_bot_fill_allies", 0 );
    setDvarIfUninitialized( "hmw_bot_fill_axis", 0 );

    //Bots Can't Last Kill
    setDvarIfUninitialized( "hmw_bot_last", 0 );
    setDvarIfUninitialized( "hmw_bot_last_allies", 0 );
    setDvarIfUninitialized( "hmw_bot_last_axis", 0 );

    //Sliding Mod
    setDvarIfUninitialized( "hmw_slide", 0 );

    //Headshots Only
    setDvarIfUninitialized( "hmw_headshots_only", 0 );

    //Quick Scope Lobby
    setDvarIfUninitialized( "hmw_isnipe", 0 );

    //Roll The Dice Lobby
    setDvarIfUninitialized( "hmw_rtd", 0 );

    //Specified Weapon Lobby
    setDvarIfUninitialized( "hmw_pistol_only", 0 );
    setDvarIfUninitialized( "hmw_shotgun_only", 0 );
    setDvarIfUninitialized( "hmw_launcher_only", 0 );
    setDvarIfUninitialized( "hmw_melee_only", 0 );

    if( getDvarInt( "hmw_menu" ) == 1 ) {
        //level.private_match = !level.rankedmatch;
        level.prematchperiodend = 5;

        level initial_callback();
        level initial_precache();

        level thread session_expired();

        level thread init();
        level thread init_precache();
        level thread init_fx();
    }

    if( getDvarInt( "hmw_slide" ) == 1 ) {
        level.slide_time = 0.75;
        level.slide_multiplier = 1.65;
        level.slide_dampening = 0.035;
    }

    if( getDvarInt( "hmw_isnipe" ) == 1 ) {
        level thread user_scripts\mp\m203\scripts\isnipe::init_isnipe();
        level thread user_scripts\mp\m203\scripts\isnipe::antiCampInit();
    }

    if( getDvarInt( "hmw_rtd" ) == 1 ) {
        level thread user_scripts\mp\m203\scripts\rtd_main::init_rtd();
    }

    if( getDvarInt( "hmw_bot_fill" ) == 1 || getDvarInt( "hmw_bot_fill_allies" ) == 1 || getDvarInt( "hmw_bot_fill_axis" ) == 1 ) {
        level thread bot_fill_auto();
    }

    if( getDvarInt( "hmw_pistol_only" ) == 1 || getDvarInt( "hmw_shotgun_only" ) == 1 || getDvarInt( "hmw_launcher_only" ) == 1 || getDvarInt( "hmw_melee_only" ) == 1 ) {
        level thread user_scripts\mp\m203\scripts\restrict::init_restrict();
    }
}

initial_callback() {
    level.player_connect           = level.callbackplayerconnect;
    level.callbackplayerconnect    = ::player_connect;
    level.player_disconnect        = level.callbackplayerdisconnect;
    level.callbackplayerdisconnect = ::player_disconnect;
    level.player_damage            = level.callbackplayerdamage;
    level.callbackplayerdamage     = ::player_damage;
    level.player_downed            = level.callbackplayerlaststand;
    level.callbackplayerlaststand  = ::player_downed;

    replacefunc( maps\mp\gametypes\_gamescore::giveplayerscore, ::giveplayerscore );
}

initial_precache() {
    precacheshader( "ui_scrollbar_arrow_right" );
    precacheshader( "ui_scrollbar_arrow_left" );
}

initial_variable() {
    self.menu     = [];
    self.cursor   = [];
    self.slider   = [];
    self.previous = [];

    self.font                = "bigfixed";
    self.font_scale          = 0.3;
    self.option_limit        = 10;
    self.option_spacing      = 16;
    self.x_offset            = -420;
    self.y_offset            = 130;
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
                if( !isdefined( self.finalized ) && self has_access() ) {
                    self.finalized = true;

                    self initial_variable();
                    self thread initial_observer();

                    self iprintln( "^:HMW Menu v1.8^7: [^2Loaded^7]" );
                    self iprintln( "^7Welcome ^:" + clean_name( self get_name() ) + "^7!" );
                    self iprintln( "^7Press [^2[{+speed_throw}] ^7+ ^2[{+melee_zoom}]^7] For Menu!" );
                }

                if( getDvarInt( "hmw_slide" ) == 1 ) {
                    self thread user_scripts\mp\m203\scripts\slide::monitor_slide();
                }
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

    self thread event_system();

    if( getDvarInt( "hmw_rtd" ) == 1 ) {
        self thread user_scripts\mp\m203\scripts\rtd_main::rtd();
    }
    [ [ level.player_connect ] ]();
}

player_disconnect() {
    [ [ level.player_disconnect ] ]();
}

player_damage( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime ) {
    if( isdefined( self.god_mode_toggle ) && self.god_mode_toggle )
        return;

    if( getDvarInt( "hmw_headshots_only" ) == 1 ) {
        if( sHitLoc != ( "head" ) )
            return;
    }

    /*
    if( getDvarInt( "hmw_bot_last" ) == 1 ) {
        if( ( isbot( eattacker ) && _getteamscore( eattacker.pers[ "team" ] ) == getWatchedDvar( "scorelimit" ) - 1 ) )
            return;
    }
    
    if( getDvarInt( "hmw_bot_last_allies" ) == 1 ) {
        if( ( isbot( eattacker ) && _getteamscore( game[ "defenders" ] ) == getWatchedDvar( "scorelimit" ) - 1 ) && ( eattacker.pers[ "team" ] == game[ "defenders" ] ) )
            return;
    }

    if( getDvarInt( "hmw_bot_last_axis" ) == 1 ) {
        if( ( isbot( eattacker ) && _getteamscore( game[ "attackers" ] ) == getWatchedDvar( "scorelimit" ) - 1 ) && ( eattacker.pers[ "team" ] == game[ "attackers" ] ) )
            return;
    }
    */

    [ [ level.player_damage ] ]( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime );
}

player_downed( einflictor, eattacker, idamage, smeansofdeath, sweapon, vdir, shitloc, psoffsettime, deathanimduration ) {
    self notify( "player_downed" );
    [ [ level.player_downed ] ]( einflictor, eattacker, idamage, smeansofdeath, sweapon, vdir, shitloc, psoffsettime, deathanimduration );
}

bot_fill_auto() {
    wait 1;
    level remove_bots();
    if( getDvarInt( "hmw_bot_fill" ) == 1 ) {
        level bot_fill( "autoassign" );
    }
    if( getDvarInt( "hmw_bot_fill_allies" ) == 1 ) {
        level bot_fill( "allies" );
    }
    if( getDvarInt( "hmw_bot_fill_axis" ) == 1 ) {
        level bot_fill( "axis" );
    }
}

giveplayerscore( var_0, var_1, var_2 ) {
    if( isdefined( var_1.owner ) )
        var_1 = var_1.owner;

    if( !isplayer( var_1 ) )
        return;

    if( getDvarInt( "hmw_bot_last" ) == 1 ) {
        if( isbot( var_1 ) && _getteamscore( var_1.pers[ "team" ] ) > ( getWatchedDvar( "scorelimit" ) - 2 ) )
            maps\mp\gametypes\_gamescore::_setteamscore( var_1.pers[ "team" ], getWatchedDvar( "scorelimit" ) - 2 );
    }

    if( getDvarInt( "hmw_bot_last_allies" ) == 1 ) {
        if( isbot( var_1 ) && _getteamscore( game[ "defenders" ] ) > ( getWatchedDvar( "scorelimit" ) - 2 ) && ( var_1.pers[ "team" ] == game[ "defenders" ] ) )
            maps\mp\gametypes\_gamescore::_setteamscore( var_1.pers[ "team" ], getWatchedDvar( "scorelimit" ) - 2 );
    }

    if( getDvarInt( "hmw_bot_last_axis" ) == 1 ) {
        if( isbot( var_1 ) && _getteamscore( game[ "attackers" ] ) > ( getWatchedDvar( "scorelimit" ) - 2 ) && ( var_1.pers[ "team" ] == game[ "attackers" ] ) )
            maps\mp\gametypes\_gamescore::_setteamscore( var_1.pers[ "team" ], getWatchedDvar( "scorelimit" ) - 2 );
    }

    var_1 displaypoints( var_0 );
    var_3 = var_1.pers["score"];
    onplayerscore( var_0, var_1, var_2 );
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
        level thread sendupdateddmscores();
        var_1 maps\mp\gametypes\_gamelogic::checkplayerscorelimitsoon();
    }

    var_1 maps\mp\gametypes\_gamelogic::checkscorelimit();
}
