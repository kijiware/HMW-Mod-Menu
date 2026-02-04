//todo: refactor, add comments
array_contains_weapon( array, weapon ) {
    if ( array.size <= 0 )
        return 0;

    foreach( item in array )
        if( getWeaponBaseName( item ) == getWeaponBaseName( weapon ) )
            return 1;

    return 0;
}

cursor_pos() {
    forward = self getTagOrigin( "tag_eye" );
    end = self thread vec_scal( anglestoforward( self getPlayerAngles() ), 1000000 );
    location = BulletTrace( forward, end, 0, self )[ "position" ];
    return location;
}

vec_scal( vec, scale ) {
    return ( vec[ 0 ] * scale, vec[ 1 ] * scale, vec[ 2 ] * scale );
}

trace_bullet() {
    return bulletTrace( self getEye(), self getEye() + vec_scal( anglesToForward( self getPlayerAngles() ), 1000000 ), false, self )[ "position" ];
}

location_selector() {
    self maps\mp\_utility::_beginLocationSelection( "", "map_artillery_selector", true, ( level.mapSize / 5.625 ) );
    self.selectingLocation = true;
    self waittill( "confirm_location", location, directionYaw );
    newLocation = BulletTrace( location + ( 0, 0, 0 ), location, 0, self )[ "position" ];
    self notify( "used" );
    self endLocationSelection();
    self.selectingLocation = undefined;
    return newLocation;
}

is_offhand( weapon ) {
    equipment = [ "h1_fraggrenade_mp", "h1_c4_mp", "h1_flashgrenade_mp", "h1_concussiongrenade_mp", "h1_smokegrenade_mp", "h1_claymore_mp", "flare_mp", "iw9_throwknife_mp", "h2_semtex_mp", "h1_fraggrenadeshort_mp" ];
    for( a = 0; a < equipment.size; a++ )
        if( equipment[ a ] == weapon )
            return true;
    return false;
}

delete_after_time( time ) {
    wait( time );
    self delete();
    level.fx_count--;
}

destroy_model_on_time( time ) {
    wait( time );
    self delete();
}

/*
host_or_admin() {
    if( self.access == "Host" || self.access == "Admin" )
        return true;
    else
        self iprintln( "^1Host/Admin Only!" );
}

get_above_buildings( location ) {
    trace = bullettrace( location + ( 0, 0, 10000 ), location, false, undefined );
    startorigin = trace[ "position" ] + ( 0, 0, -514 );
    zpos = 0;
    maxxpos = 13; maxypos = 13;
    for( xpos = 0; xpos < maxxpos; xpos++ ) {
        for( ypos = 0; ypos < maxypos; ypos++ ) {
            thisstartorigin = startorigin + ( ( xpos / ( maxxpos - 1 ) - 0.5 ) * 1024, ( ypos / ( maxypos - 1 ) - 0.5 ) * 1024, 0 );
            thisorigin = bullettrace( thisstartorigin, thisstartorigin + ( 0, 0, -10000 ), false, undefined );
            zpos += thisorigin[ "position" ][ 2 ];
        }
    }
    zpos = zpos / ( maxxpos * maxypos );
    zpos = zpos + 850;
    return ( location[ 0 ], location[ 1 ], zpos );
}

physics_array( id ) {
    foreach( model in id )
        model thread delayed_fall( 5 );
}

get_color() {
    return ( randomIntRange( 10, 255 ) / 255, randomIntRange( 10, 255 ) / 255, randomIntRange( 10, 255 ) / 255 );
}

delayed_fall( num ) {
    if( isDefined( self ) )
        self physicsLaunchServer();
    wait num;
    if( isDefined( self ) )
        self delete();
}

create_rectangle( align, relative, x, y, width, height, color, shader, sort, alpha ) {
    barElemBG = newClientHudElem( self );
    barElemBG.elemType = "bar";
    barElemBG.width = width;
    barElemBG.height = height;
    barElemBG.align = align;
    barElemBG.relative = relative;
    barElemBG.xOffset = 0;
    barElemBG.yOffset = 0;
    barElemBG.children = [];
    barElemBG.sort = sort;
    barElemBG.color = color;
    barElemBG.alpha = alpha;
    barElemBG maps\mp\gametypes\_hud_util::setParent( level.uiParent );
    barElemBG setShader( shader, width, height );
    barElemBG.hidden = false;
    barElemBG maps\mp\gametypes\_hud_util::setPoint( align, relative, x, y );
    thread destroy_elem_on_death( barElemBG );
    return barElemBG;
}

destroy_elem_on_death( elem ) {
    self waittill( "death" );

    if( isDefined( elem.bar ) )
        elem maps\mp\gametypes\_hud_util::destroyElem();
    else
        elem destroy();
}

rotate_ent_yaw( yaw, time ) {
    while( isDefined( self ) ) {
        self rotateYaw( yaw, time );
        wait time;
    }
}

get_players() {
    return level.players;
}

set_safe_text_1( text ) {
    level.result += 1;
    level notify( "textset" );
    self setText( text );
}

set_safe_text_2( text ) {
    self notify( "stop_TextMonitor" );
    self add_to_string_array( text );
}

is_in_array( array, text ) {
    for( e = 0; e < array.size; e++ )
        if( array[ e ] == text )
            return true;
    return false;
}

add_to_string_array( text ) {
    if( !is_in_array( level.strings,text ) ) {
        level.strings[ level.strings.size ] = text;
    }
}

set_point( point, relativePoint, xOffset, yOffset, moveTime ) {
    if( !isDefined( moveTime ) )
        moveTime = 0;
    element = self maps\mp\gametypes\_hud_util::getParent();
    if( moveTime )
        self moveOverTime( moveTime );
    if( !isDefined( xOffset ) )
        xOffset = 0;
    self.xOffset = xOffset;
    if( !isDefined( yOffset ) )
        yOffset = 0;
    self.yOffset = yOffset;
    self.point = point;
    self.alignX = "center";
    self.alignY = "middle";
    if( isSubStr( point, "TOP" ) )
        self.alignY = "top";
    if( isSubStr( point, "BOTTOM" ) )
        self.alignY = "bottom";
    if( isSubStr( point, "LEFT" ) )
        self.alignX = "left";
    if( isSubStr( point, "RIGHT" ) )
        self.alignX = "right";
    if( !isDefined( relativePoint ) )
        relativePoint = point;
    self.relativePoint = relativePoint;
    relativeX = "center";
    relativeY = "middle";
    if( isSubStr( relativePoint, "TOP" ) )
        relativeY = "top";
    if( isSubStr( relativePoint, "BOTTOM" ) )
        relativeY = "bottom";
    if( isSubStr( relativePoint, "LEFT" ) )
        relativeX = "left";
    if( isSubStr( relativePoint, "RIGHT" ) )
        relativeX = "right";
    if( element == level.uiParent ) {
        self.horzAlign = relativeX;
        self.vertAlign = relativeY;
    } 
    else {
        self.horzAlign = element.horzAlign;
        self.vertAlign = element.vertAlign;
    }
    if( relativeX == element.alignx ) {
        offsetX = 0;
        xFactor = 0;
    } 
    else {
        if( relativeX == "center" || element.alignX == "center" ) {
            offsetX = int( element.width / 2 );
            if( relativeX == "left" || element.alignX == "right" )
                xFactor =  - 1; 
            else 
                xFactor = 1;
        }
        else {
            offsetX = element.width;
            if( relativeX == "left" )
                xFactor =  - 1;
            else 
                xFactor = 1;
        }
        self.x = element.x +( offsetX * xFactor );
        if( relativeY == element.aligny ) {
            offsetY = 0;
            yFactor = 0;
        }
        else {
            if( relativeY == "middle" || element.alignY == "middle" ) {
                offsetY = int( element.height / 2 );
                if( relativeY == "top" || element.alignY == "bottom" )
                    yFactor =  - 1; 
                else 
                    yFactor = 1;
            }
            else {
                offsetY = element.height;
                if( relativeY == "top" )
                    yFactor =  - 1;
                else 
                    yFactor = 1;
            }
            self.y = element.y + ( offsetY * yFactor );
            self.x += self.xOffset;
            self.y += self.yOffset;
            switch( self.elemType ) {
                case "bar":
                    maps\mp\gametypes\_hud_util::setPointBar( point, relativePoint, xOffset, yOffset );
                    break;
            }
            self maps\mp\gametypes\_hud_util::updateChildren();
        }
    }
}

icon_delete() {
    if( isDefined( level.notifyIcon ) )
        level.notifyIcon destroy();
}

text_marker( player, org, text, size, color, title ) {
    if( !isDefined( color ) )
        color = ( 1, 1, 1 );
    if( isDefined( player ) )
        title = self maps\mp\gametypes\_hud_util::CreateFontString( "default", 2, self );
    else
        title = maps\mp\gametypes\_hud_util::CreateFontString( "default", 2 );
    title.label = text;
    title.color = color;
    title.x = org[ 0 ];
    title.y = org[ 1 ];
    title.z = org[ 2 ];
    title.alpha = 1;
    title setWayPoint( size, title );
    return title;
}

create_text_2( font, fontScale, align, relative, x, y, sort, alpha, text, color ) {
    textElem                = self maps\mp\gametypes\_hud_util::CreateFontString( font, fontScale );
    textElem.hideWhenInMenu = true;
    textElem.archived       = false;
    textElem.sort           = sort;
    textElem.alpha          = alpha;
    textElem.color          = color;
    textElem.foreground     = true;
    textElem set_point( align, relative, x, y );
    self add_to_string_array( text );
    return textElem;
}

stance_allowed( bool ) {
    self allowAds( bool );
    self allowSprint( bool );
    self allowJump( bool );
}

delete_after( time ) {
    wait time;
    if( isDefined( self ) )
        self delete();
}

spawn_entity( class, model, origin, angle ) {
    entity = spawn( class, origin );
    entity.angles = angle;
    entity setModel( model );
    return entity;
}

model_spawner( origin, model, angles, time ) {
    if( isDefined( time ) )
        wait time;
    obj = spawn( "script_model", origin );
    obj setModel( model );
    if( isDefined( angles ) )
        obj.angles = angles;
    if( getentarray().size >= 590 ) {
        self iprintln( "^1Error^7: Please delete some other structures" );
        obj delete();
    }
    return obj;
}

spawn_model( m ) {
    f = self getTagOrigin( "tag_eye" );
    e = self thread vec_scal( anglestoforward( self getPlayerAngles() ), 1000000 );
    p = BulletTrace( f, e, 0, self )[ "position" ];
    o = spawn( "script_model", p );
    o CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
    o PhysicsLaunchServer( ( 0, 0, 0 ), ( 0, 0, 0 ) );
    o.angles = self.angles + ( 0, 90, 0 );
    self iprintln( "^:Spawned Object : " + m );
    o setModel( m );
}

spawn_script_model( origin, model, angles, time, clip ) {
    if( isDefined( time ) )
        wait time;
    bog = spawn( "script_model", origin );
    bog setModel( model );
    if( isDefined( angles ) )
        bog.angles = angles;
    if( isDefined( clip ) )
        bog CloneBrushModelToScriptModel( clip );
    return bog;
}

spawn_trigger( origin, width, height, cursorHint, stringhint ) {
    trig = spawn( "trigger_radius", origin, 1, width, height );
    if( isDefined( cursorHint ) )
        trig setCursorHint( cursorHint, trig );
    if( isDefined( stringhint ) )
        trig setHintString( stringhint );
    return trig;
}
*/