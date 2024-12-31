var _badtouch, i, me, my_cond, current_hider;

if (array_length(global.secret_layers) <= 0)
    exit;

_badtouch = false;

for (i = 0; i < array_length(collision_arr); i++)
{
    me = collision_arr[i];
    my_cond = true;
    
    if (instance_exists(me))
    {
        with (me)
        {
            switch (object_index)
            {
                default:
                    break;
            }
            
            if (place_meeting(x, y, obj_secretwall) && my_cond)
                _badtouch = true;
        }
    }
}

current_hider = obj_player1.secretArray;

if (array_length(current_hider) > 0 || _badtouch)
    depth = -8;
else
    depth = 0;

for (i = 0; i < array_length(global.secret_layers); i++)
    global.secret_layers[i].alpha = approach(global.secret_layers[i].alpha, array_contains(current_hider, global.secret_layers[i].nm) ? 0 : 1, 0.05);