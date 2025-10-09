#include user_scripts\mp\m203\source\utilities;
#include user_scripts\mp\m203\source\custom_structure;

set_menu( menu ) {
    self.current_menu = isdefined( menu ) ? menu : "Main Menu";
}

get_menu() {
    if( !isdefined( self.current_menu ) )
        self set_menu();

    return self.current_menu;
}

set_title( title ) {
    self.current_title = isdefined( title ) ? title : self get_menu();
}

get_title() {
    if( !isdefined( self.current_title ) )
        self set_title();

    return self.current_title;    
}

set_cursor( index ) {
    self.cursor[ self get_menu() ] = isdefined( index ) && isnumber( index ) ? index : 0;
}

get_cursor() {
    if( !isdefined( self.cursor[ self get_menu() ] ) )
        self set_cursor();

    return self.cursor[ self get_menu() ];
}

get_description() {
    return self.structure[ self get_cursor() ].description;
}

set_state( state ) {
    self.in_menu = isdefined( state ) && state < 2 ? state : false;
}

in_menu() {
    return isdefined( self.in_menu ) && self.in_menu;
}

set_locked( state ) {
    self.is_locked = isdefined( state ) && state < 2 ? state : false;
}

is_locked() {
    return isdefined( self.is_locked ) && self.is_locked;
}

empty_option() {
    option = [ "Nothing To See Here!", "Quiet Here, Isn't It?", "Oops, Nothing Here Yet!", "Bit Empty, Don't You Think?" ];
    return option[ randomint( option.size ) ];
}

empty_function() {
}

execute_function( function, parameter_1, parameter_2, parameter_3 ) {
    self endon( "disconnect" );
    if( !isdefined( function ) )
        return;

    if( isdefined( parameter_3 ) )
        return self thread [[ function ]]( parameter_1, parameter_2, parameter_3 );

    if( isdefined( parameter_2 ) )
        return self thread [[ function ]]( parameter_1, parameter_2 );

    if( isdefined( parameter_1 ) )
        return self thread [[ function ]]( parameter_1 );

    self thread [[ function ]]();
}

add_menu( title ) {
    self.structure = [];
    if( !isdefined( self get_cursor() ) )
        self set_cursor();

    self set_title( title );
}

add_option( text, description, function, parameter_1, parameter_2 ) {
    option             = spawnstruct();
    option.text        = text;
    option.description = description;
    option.function    = isdefined( function ) ? function : ::empty_function;
    option.parameter_1 = parameter_1;
    option.parameter_2 = parameter_2;

    self.structure[ self.structure.size ] = option;
}

add_toggle( text, description, function, variable, parameter_1, parameter_2 ) {
    option             = spawnstruct();
    option.text        = text;
    option.description = description;
    option.function    = isdefined( function ) ? function : ::empty_function;
    option.toggle      = isdefined( variable ) && variable;
    option.parameter_1 = parameter_1;
    option.parameter_2 = parameter_2;

    self.structure[ self.structure.size ] = option;
}

add_array( text, description, function, array, parameter_1, parameter_2 ) {
    option             = spawnstruct();
    option.text        = text;
    option.description = description;
    option.function    = isdefined( function ) ? function : ::empty_function;
    option.array       = isdefined( array ) && isarray( array ) ? array : [ 1, 2, 3, 4, 5 ];
    option.parameter_1 = parameter_1;
    option.parameter_2 = parameter_2;

    self.structure[ self.structure.size ] = option;
}

add_increment( text, description, function, start, minimum, maximum, increment, parameter_1, parameter_2 ) {
    option             = spawnstruct();
    option.text        = text;
    option.description = description;
    option.function    = isdefined( function ) ? function : ::empty_function;
    option.start       = isdefined( start ) && isnumber( start ) ? start : 0;
    option.minimum     = isdefined( minimum ) && isnumber( minimum ) ? minimum : 0;
    option.maximum     = isdefined( maximum ) && isnumber( maximum ) ? maximum : 10;
    option.increment   = isdefined( increment ) && isnumber( increment ) ? increment : 1;
    option.parameter_1 = parameter_1;
    option.parameter_2 = parameter_2;

    self.structure[ self.structure.size ] = option;
}

add_category( text ) {
    option      = spawnstruct();
    option.text = text;

    self.structure[ self.structure.size ] = option;
}

new_menu( menu ) {
    if( !isdefined( menu ) ) {
        menu                                        = self.previous[ ( self.previous.size - 1 ) ];
        self.previous[ ( self.previous.size - 1 ) ] = undefined;
    }
    else {
        if( self get_menu() == "All Players" ) {
            player               = level.players[ self get_cursor() ];
            self.selected_player = player;
        }
        
        self.previous[ self.previous.size ] = self get_menu();;
    }

    self set_menu( menu );
    self update_display();
}