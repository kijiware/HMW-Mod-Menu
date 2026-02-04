//todo: add comments
bot_fill_toggle() {
    self.bot_fill_toggle = !( isdefined( self.bot_fill_toggle ) && self.bot_fill_toggle );

    if( self.bot_fill_toggle == 1 ) {
        setDvar( "hmw_bot_fill", 1 );
        level thread bot_fill();
    }
    else {
        setDvar( "hmw_bot_fill", 0 );
        level thread bot_remove();
    }

    self iprintln( "^:Bot Last^7: [" + "^3" + self.bot_last_toggle + "^7]" );
}

bot_last_toggle() {
    self.bot_last_toggle = !( isdefined( self.bot_last_toggle ) && self.bot_last_toggle );

    if( self.bot_last_toggle == 1 ) {
        setDvar( "hmw_bot_last", 1 );
        replacefunc( maps\mp\gametypes\_gamescore::giveplayerscore, user_scripts\mp\preload::give_player_score );
    }
    else {
        setDvar( "hmw_bot_last", 0 );
        replacefunc( user_scripts\mp\preload::give_player_score, maps\mp\gametypes\_gamescore::giveplayerscore );
    }
    
    self iprintln( "^:Bot Last^7: [" + "^3" + self.bot_last_toggle + "^7]" );
}

bot_freeze() {
    self endon( "end_bot_freeze" );

    self.bot_freeze = !( isdefined( self.bot_freeze ) && self.bot_freeze );

    self iprintln( "^:Bot Freeze^7: [" + "^3" + self.bot_freeze + "^7]" );

    if( self.bot_freeze == 1 )
        while( self.bot_freeze == 1 ) {
            foreach( player in level.players )
                if( isSubStr( player getguid(), "bot" ) && player freezeControls( false ) )
                    player freezeControls( true );
            wait 1;
        }
    else {
        foreach( player in level.players )
            if( isSubStr( player getguid(), "bot" ) )
                player freezeControls( false );
        self notify( "end_bot_freeze" );
    }
}

bot_teleport() {
    teleportPosition = user_scripts\mp\scripts\util::cursor_pos();

    foreach( player in level.players )
        if( isSubStr( player.guid, "bot" ) )
            player setOrigin( teleportPosition );

    self iprintln( "^:Bots Teleported" );
}

bot_spawn( amount, team, difficulty ) {
    if( !isDefined( amount ) )
        amount = 1;
    if( !isDefined( team ) )
        team = "autoassign";
    if( !isDefined( difficulty ) )
        difficulty = level.bot_difficulty;
    level thread maps\mp\bots\_bots::spawn_bots( amount, team, undefined, undefined, undefined, difficulty );
}

bot_fill() {
    level bot_remove();
    while( level.players.size < 18 ) {
        self thread bot_spawn( 1 );
        wait 0.25;
    }

    self iprintln( "^:Bot Fill^7: ^2Done" );
}

bot_team( team ) {
    foreach( player in level.players )
        if( isSubStr( player.guid, "bot" ) ) {
            player.bot_team = team;
            player notify( "luinotifyserver", "team_select", maps\mp\bots\_bots::bot_lui_convert_team_to_int( team ) );
            wait 0.05;
            player notify( "luinotifyserver", "class_select", player.bot_class );
        }
}

bot_change_diff( difficulty ) {
    level.bot_difficulty = difficulty;
    self iprintln( "^:Bot Difficulty Set: " + level.bot_difficulty );
    self iprintln( "^:Newly spawned bots will be the set difficulty" );
}

bot_set_diff( difficulty ) {
	for(;;) {
		level waittill( "connected", player );
		if( isBot( player ) )
			player maps\mp\bots\_bots_util::bot_set_difficulty( difficulty, undefined );
	}
}

bot_remove() {
    foreach( player in level.players )
        if( isSubStr( player.guid, "bot" ) )
            kick( player getEntityNumber() );
}

bot_kick_join() {
    foreach( player in level.players ) {
        if( isSubStr( player.guid, "bot" ) ) {
            player maps\mp\bots\_bots::bot_drop();
            break;
        }
    }
}