var target_dir, pnt_dist, hsp, vsp;

if (global.freezeframe)
    exit;

if (!instance_exists(hookStopID))
{
    show_debug_message(string("Hook ({0}) at ({1}, {2}) didn't find stop", id, x, y));
    instance_destroy();
}

switch (state)
{
    case States.frozen:
        visible = true;
        break;
    
    case States.normal:
        target_dir = point_direction(x, y, xstart, ystart);
        pnt_dist = min(point_distance(x, y, xstart, ystart), gobackspeed);
        x += lengthdir_x(pnt_dist, target_dir);
        y += lengthdir_y(pnt_dist, target_dir);
        
        if (point_distance(x, y, xstart, ystart) <= 9)
        {
            x = xstart;
            y = ystart;
            state = States.frozen;
        }
        
        visible = true;
        break;
    
    case States.titlescreen:
        target_dir = point_direction(x, y, hookStopID.x, hookStopID.y);
        xprevious = x;
        yprevious = y;
        x += lengthdir_x(movespeed, target_dir);
        y += lengthdir_y(movespeed, target_dir);
        hsp = sign(x - xprevious);
        vsp = sign(y - yprevious);
        
        with (playerID)
        {
            if (state == States.oldtaunt)
            {
                x = other.x;
                y = other.y - 14;
                xscale = sign(other.image_xscale);
                
                if (tauntStored.state == States.frostburnjump || tauntStored.state == States.frostburnnormal || tauntStored.state == States.frostburnslide || tauntStored.state == States.frostburnslide)
                    sprite_index = spr_player_PZ_frostburn_hook;
                else
                    sprite_index = spr_player_PZ_hook_vertical;
            }
        }
        
        visible = false;
        
        if (point_distance(x, y, hookStopID.x, hookStopID.y) <= movespeed)
        {
            x = hookStopID.x;
            y = hookStopID.y;
            state = States.normal;
            visible = true;
            
            with (playerID)
            {
                x = other.hookStopID.x;
                y = other.hookStopID.y - 14;
                
                if (state == States.oldtaunt)
                    scr_taunt_setVariables();
            }
        }
        
        break;
}
