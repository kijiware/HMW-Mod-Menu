#include user_scripts\mp\m203\source\utilities;
#include user_scripts\mp\m203\source\structure;
#include user_scripts\mp\m203\source\option_structure;

open_menu() {
    self.menu[ "border" ]              = self create_shader( "white", "TOP_LEFT", "TOPCENTER", self.x_offset, ( self.y_offset - 1 ), ( self.width + 250 ), 34, self.color_theme, 1, 1 );
    self.menu[ "background" ]          = self create_shader( "white", "TOP_LEFT", "TOPCENTER", ( self.x_offset + 1 ), self.y_offset, ( self.width + 248 ), 32, ( 0.109, 0.129, 0.156 ), 1, 2 );
    self.menu[ "foreground" ]          = self create_shader( "white", "TOP_LEFT", "TOPCENTER", ( self.x_offset + 1 ), ( self.y_offset + 16 ), ( self.width + 248 ), 16, ( 0.133, 0.152, 0.180 ), 1, 3 );
    self.menu[ "scrollbar_primary" ]   = self create_shader( "white", "TOP_LEFT", "TOPCENTER", ( self.x_offset + 1 ), ( self.y_offset + 16 ), ( self.width + 243 ), 16, ( 0.150, 0.170, 0.211 ), 1, 4 );
    self.menu[ "scrollbar_secondary" ] = self create_shader( "white", "TOP_RIGHT", "TOPCENTER", ( self.x_offset + ( self.menu[ "background" ].width + 1 ) ), ( self.y_offset + 16 ), 4, 16, ( 0.150, 0.170, 0.211 ), 1, 4 );

    self set_state( true );
    self update_display();
}

close_menu() {
    self notify( "menu_ended" );
    self set_state( false );
    self destroy_option();
    self destroy_all( self.menu );
}

display_title( title ) {
    title = isdefined( title ) ? title : self get_title();
    if( !isdefined( self.menu[ "title" ] ) )
        self.menu[ "title" ] = self create_text( title, self.font, self.font_scale, "TOP_LEFT", "TOPCENTER", ( self.x_offset + 4 ), ( self.y_offset + 4 ), ( 0.223, 0.250, 0.286 ), 1, 10 );
    else
        self.menu[ "title" ] set_text( title );
}

display_description( description ) {
    description = isdefined( description ) ? description : self get_description();
    if( isdefined( self.menu[ "description" ] ) && !self.description_enabled || isdefined( self.menu[ "description" ] ) && !isdefined( description ) )
        self.menu[ "description" ] destroy_element();

    if( isdefined( description ) && self.description_enabled ) {
        if( !isdefined( self.menu[ "description" ] ) )
            self.menu[ "description" ] = self create_text( description, self.font, self.font_scale, "TOP_LEFT", "TOPCENTER", ( self.x_offset + 4 ), ( self.y_offset + 36 ), ( 0.223, 0.250, 0.286 ), 1, 10 );
        else
            self.menu[ "description" ] set_text( description );
    }
}

display_option() {
    self destroy_option();
    self menu_option();
    if( !isdefined( self.structure ) || !self.structure.size )
        self add_option( empty_option() );

    self display_title();
    self display_description();
    if( isdefined( self.structure ) && self.structure.size ) {
        if( self get_cursor() >= self.structure.size )
            self set_cursor( ( self.structure.size - 1 ) );

        if( !isdefined( self.menu[ "toggle" ][ 0 ] ) )
            self.menu[ "toggle" ][ 0 ] = [];

        if( !isdefined( self.menu[ "toggle" ][ 1 ] ) )
            self.menu[ "toggle" ][ 1 ] = [];

        if( !isdefined( self.menu[ "category" ][ 0 ] ) )
            self.menu[ "category" ][ 0 ] = [];

        if( !isdefined( self.menu[ "category" ][ 1 ] ) )
            self.menu[ "category" ][ 1 ] = [];

        menu    = self get_menu();
        cursor  = self get_cursor();
        maximum = min( self.structure.size, self.option_limit );
        for( a = 0; a < maximum; a++ ) {
            start = self get_cursor() >= int( ( self.option_limit / 2 ) ) && self.structure.size > self.option_limit ? ( ( ( self get_cursor() + int( ( self.option_limit / 2 ) ) ) >= ( self.structure.size - 1 ) ) ? ( self.structure.size - self.option_limit ) : ( self get_cursor() - int( ( self.option_limit / 2 ) ) ) ) : 0;
            index = ( a + start );
            if( isdefined( self.structure[ index ].function ) && self.structure[ index ].function == ::new_menu )
                self.menu[ "submenu" ][ index ] = self create_shader( "ui_scrollbar_arrow_right", "TOP_RIGHT", "TOPCENTER", ( self.x_offset + ( self.menu[ "scrollbar_primary" ].width - 1 ) ), ( self.y_offset + ( ( a * self.option_spacing ) + 22 ) ), 4, 4, ( cursor == index ) ? self.color_theme : ( 0.223, 0.250, 0.286 ), 1, 10 );

            if( isdefined( self.structure[ index ].toggle ) ) {
                self.menu[ "toggle" ][ 0 ][ index ] = self create_shader( "white", "TOP_RIGHT", "TOPCENTER", ( self.x_offset + 14 ), ( self.y_offset + ( ( a * self.option_spacing ) + 19 ) ), 10, 10, ( cursor == index ) ? ( 0.133, 0.152, 0.180 ) : ( 0.109, 0.129, 0.156 ), 1, 9 );
                if( self.structure[ index ].toggle )
                    self.menu[ "toggle" ][ 1 ][ index ] = self create_shader( "white", "TOP_RIGHT", "TOPCENTER", ( self.x_offset + 13 ), ( self.y_offset + ( ( a * self.option_spacing ) + 20 ) ), 8, 8, ( cursor == index ) ? self.color_theme : ( 0.223, 0.250, 0.286 ), 1, 10 );
            }

            if( isdefined( self.structure[ index ].array ) || isdefined( self.structure[ index ].increment ) ) {
                if( isdefined( self.structure[ index ].array ) )
                    self.menu[ "slider" ][ index ] = self create_text( self.slider[ ( menu + "_" + index ) ], self.font, self.font_scale, "TOP_RIGHT", "TOPCENTER", ( self.x_offset + ( self.menu[ "scrollbar_primary" ].width - 2 ) ), ( self.y_offset + ( ( a * self.option_spacing ) + 20 ) ), ( cursor == index ) ? self.color_theme : ( 0.223, 0.250, 0.286 ), 1, 10 );
                else if( cursor == index )
                    self.menu[ "slider" ][ index ] = self create_text( self.slider[ ( menu + "_" + index ) ], self.font, self.font_scale, "TOP_RIGHT", "TOPCENTER", ( self.x_offset + ( self.menu[ "scrollbar_primary" ].width - 3 ) ), ( self.y_offset + ( ( a * self.option_spacing ) + 20 ) ), self.color_theme, 1, 10 );

                self update_slider( undefined, index );
            }

            if( !isdefined( self.structure[ index ].function ) ) {
                self.menu[ "category" ][ 0 ][ index ] = self create_shader( "white", "TOP_LEFT", "TOPCENTER", ( self.x_offset + 4 ), ( self.y_offset + ( ( a * self.option_spacing ) + 24 ) ), int( ( self.menu[ "scrollbar_primary" ].width / 6 ) ), 1, self.color_theme, 1, 10 );
                self.menu[ "category" ][ 1 ][ index ] = self create_shader( "white", "TOP_RIGHT", "TOPCENTER", ( self.x_offset + ( self.menu[ "scrollbar_primary" ].width - 2 ) ), ( self.y_offset + ( ( a * self.option_spacing ) + 24 ) ), int( ( self.menu[ "scrollbar_primary" ].width / 6 ) ), 1, self.color_theme, 1, 10 );
            }

            self.menu[ "text" ][ index ] = self create_text( ( isdefined( self.structure[ index ].array ) || isdefined( self.structure[ index ].increment ) ) ? ( self.structure[ index ].text + ":" ) : self.structure[ index ].text, self.font, self.font_scale, !isdefined( self.structure[ index ].function ) ? "TOPCENTER" : "TOP_LEFT", "TOPCENTER", isdefined( self.structure[ index ].toggle ) ? ( self.x_offset + 16 ) : ( !isdefined( self.structure[ index ].function ) ? ( self.x_offset + ( self.menu[ "scrollbar_primary" ].width / 2 ) ) : ( self.x_offset + 4 ) ), ( self.y_offset + ( ( a * self.option_spacing ) + 20 ) ), !isdefined( self.structure[ index ].function ) ? self.color_theme : ( ( cursor == index ) ? self.color_theme : ( 0.223, 0.250, 0.286 ) ), 1, 10 );
        }
    }
}

update_display() {
    self display_option();
    self update_scrollbar();
    self update_progression();
    self update_rescaling();
}

update_scrolling( scrolling ) {
    if( isdefined( self.structure[ self get_cursor() ] ) && !isdefined( self.structure[ self get_cursor() ].function ) ) {
        self set_cursor( ( self get_cursor() + scrolling ) );
        return self update_scrolling( scrolling );
    }

    if( self get_cursor() >= self.structure.size || self get_cursor() < 0 )
        self set_cursor( self get_cursor() >= self.structure.size ? 0 : ( self.structure.size - 1 ) );

    self update_display();
}

update_slider( scrolling, cursor ) {
    menu      = self get_menu();
    cursor    = isdefined( cursor ) ? cursor : self get_cursor();
    scrolling = isdefined( scrolling ) ? scrolling : 0;
    if( !isdefined( self.slider[ ( menu + "_" + cursor ) ] ) )
        self.slider[ ( menu + "_" + cursor ) ] = isdefined( self.structure[ cursor ].array ) ? 0 : self.structure[ cursor ].start;

    if( isdefined( self.structure[ cursor ].array ) ) {
        if( scrolling == -1 )
            self.slider[ ( menu + "_" + cursor ) ]++;

        if( scrolling == 1 )
            self.slider[ ( menu + "_" + cursor ) ]--;

        if( self.slider[ ( menu + "_" + cursor ) ] > ( self.structure[ cursor ].array.size - 1 ) || self.slider[ ( menu + "_" + cursor ) ] < 0 )
            self.slider[ ( menu + "_" + cursor ) ] = self.slider[ ( menu + "_" + cursor ) ] > ( self.structure[ cursor ].array.size - 1 ) ? 0 : ( self.structure[ cursor ].array.size - 1 );

        if( isdefined( self.menu[ "slider" ][ cursor ] ) )
            self.menu[ "slider" ][ cursor ] set_text( ( self.structure[ cursor ].array[ self.slider[ ( menu + "_" + cursor ) ] ] + " [" + ( self.slider[ ( menu + "_" + cursor ) ] + 1 ) + "/" + self.structure[ cursor ].array.size + "]" ) );
    }
    else {
        if( scrolling == -1 )
            self.slider[ ( menu + "_" + cursor ) ] += self.structure[ cursor ].increment;

        if( scrolling == 1 )
            self.slider[ ( menu + "_" + cursor ) ] -= self.structure[ cursor ].increment;

        if( self.slider[ ( menu + "_" + cursor ) ] > self.structure[ cursor ].maximum || self.slider[ ( menu + "_" + cursor ) ] < self.structure[ cursor ].minimum )
            self.slider[ ( menu + "_" + cursor ) ] = self.slider[ ( menu + "_" + cursor ) ] > self.structure[ cursor ].maximum ? self.structure[ cursor ].minimum : self.structure[ cursor ].maximum;

        if( isdefined( self.menu[ "slider" ][ cursor ] ) )
            self.menu[ "slider" ][ cursor ] setvalue( self.slider[ ( menu + "_" + cursor ) ] );
    }
}

update_progression() {
    if( isdefined( self.structure[ self get_cursor() ].increment ) && self.slider[ ( self get_menu() + "_" + self get_cursor() ) ] != 0 ) {
        value = abs( ( self.structure[ self get_cursor() ].minimum - self.structure[ self get_cursor() ].maximum ) ) / ( self.menu[ "scrollbar_primary" ].width );
        width = ceil( ( ( self.slider[ ( self get_menu() + "_" + self get_cursor() ) ] - self.structure[ self get_cursor() ].minimum ) / value ) );
        if( !isdefined( self.menu[ "progression" ] ) )
            self.menu[ "progression" ] = self create_shader( "white", "TOP_LEFT", "TOPCENTER", ( self.x_offset + 1 ), self.menu[ "scrollbar_primary" ].y, int( width ), 16, ( 0.160, 0.180, 0.220 ), 1, 5 );
        else
            self.menu[ "progression" ] set_shader( self.menu[ "progression" ].shader, int( width ), self.menu[ "progression" ].height );

        if( self.menu[ "progression" ].y != self.menu[ "scrollbar_primary" ].y )
            self.menu[ "progression" ].y = self.menu[ "scrollbar_primary" ].y;
    }
    else if( isdefined( self.menu[ "progression" ] ) )
        self.menu[ "progression" ] destroy_element();
}

update_scrollbar() {
    maximum    = min( self.structure.size, self.option_limit );
    height     = int( ( maximum * self.option_spacing ) );
    adjustment = self.structure.size > self.option_limit ? ( ( 180 / self.structure.size ) * maximum ) : height;
    position   = self.structure.size > self.option_limit ? ( ( self.structure.size - 1 ) / ( height - adjustment ) ) : 0;
    if( isdefined( self.menu[ "scrollbar_primary" ] ) )
        self.menu[ "scrollbar_primary" ].y = ( self.menu[ "text" ][ self get_cursor() ].y - 4 );

    if( isdefined( self.menu[ "scrollbar_secondary" ] ) ) {
        self.menu[ "scrollbar_secondary" ].y = ( self.y_offset + 16 );
        if( self.structure.size > self.option_limit )
            self.menu[ "scrollbar_secondary" ].y += ( self get_cursor() / position );
    }

    self.menu[ "scrollbar_secondary" ] set_shader( self.menu[ "scrollbar_secondary" ].shader, self.menu[ "scrollbar_secondary" ].width, int( adjustment ) );
}

update_rescaling() {
    maximum = min( self.structure.size, self.option_limit );
    height  = int( ( maximum * self.option_spacing ) );
    if( isdefined( self.menu[ "description" ] ) )
        self.menu[ "description" ].y = ( self.y_offset + ( height + 20 ) );

    self.menu[ "border" ] set_shader( self.menu[ "border" ].shader, self.menu[ "border" ].width, isdefined( self get_description() ) && self.description_enabled ? ( height + 34 ) : ( height + 18 ) );
    self.menu[ "background" ] set_shader( self.menu[ "background" ].shader, self.menu[ "background" ].width, isdefined( self get_description() ) && self.description_enabled ? ( height + 32 ) : ( height + 16 ) );
    self.menu[ "foreground" ] set_shader( self.menu[ "foreground" ].shader, self.menu[ "foreground" ].width, height );
}