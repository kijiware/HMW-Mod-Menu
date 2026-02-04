initial_settings() {
    //hmw mod menu
    setDvarIfUninitialized( "hmw_menu", 1 );

    //auto bot fill
    setDvarIfUninitialized( "hmw_bot_fill", 0 );

    //bots cant last kill
    setDvarIfUninitialized( "hmw_bot_last", 0 );

    //infinite game
    setDvarIfUninitialized( "hmw_inf_game", 0 );

    //headshots only
    setDvarIfUninitialized( "hmw_headshots_only", 0 );

    //anticamp
    setDvarIfUninitialized( "hmw_anticamp", 0 );

    //specified weapon lobby
    setDvarIfUninitialized( "hmw_sniper_only", 0 );
    setDvarIfUninitialized( "hmw_pistol_only", 0 );
    setDvarIfUninitialized( "hmw_shotgun_only", 0 );
    setDvarIfUninitialized( "hmw_launcher_only", 0 );
    setDvarIfUninitialized( "hmw_melee_only", 0 );

    //roll the dice lobby
    setDvarIfUninitialized( "hmw_rtd", 0 );

    //sliding mod
    setDvarIfUninitialized( "hmw_slide", 0 );

    if( getDvarInt( "hmw_menu" ) == 1 ) {
        //host and admin guids, host guid not needed for private match
        level.host_guids = [ "898f59957026e0e2", "GUID2", "GUID3" ];
        level.admin_guids = [ "GUID4", "GUID5", "GUID6" ];
    }
}