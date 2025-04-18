var p, _old_hsp;

sprite_index = spr_iceblock;

if (global.freezeframe)
{
    vsp = 0;
    exit;
}

baddieInvincibilityBuffer = max(baddieInvincibilityBuffer - 1, 0);
p = get_nearestPlayer();

switch (state)
{
    default:
        hsp = 0;
        vsp = 0;
        
        if (p.sprite_index != p.spr_machslideboost3)
            baddieOnPlayerCollisions();
        
        break;
    
    case States.charge:
        if (markedForDeath)
        {
            movespeed = 16;
            hsp = image_xscale * movespeed;
        }
        else
        {
            hsp = approach(hsp, 0, 0.5);
            
            if (hsp == 0)
                state = States.frozen;
            
            if (p.sprite_index != p.spr_machslideboost3)
                baddieOnPlayerCollisions();
        }
        
        _old_hsp = hsp;
        check_and_destroy(x + hsp, y, obj_destructibles);
		check_and_destroy(x + hsp, y, obj_chocofrog);
		check_and_destroy(x + hsp, y, obj_metalblock);
		check_and_destroy(x + hsp, y, obj_parent_enemy);
        scr_collision();
		
        if place_meeting(x + image_xscale, y, obj_chocofrog) {
			canDie = true;
			state = EnemyStates.cherrywait;
		}
        if (hsp == 0 && markedForDeath)
        {
            state = States.frozen;
            
            if (content != -4)
            {
                with (instance_create(x + _old_hsp, y, content))
                {
                    vsp = -10;
                    baddieStunTimer = 30;
                    state = States.charge;
                    other.baddieID = id;
                    create_particle(x, y, spr_poofeffect);
                }
            }
        }
        
        break;
    
    case EnemyStates.cherrywait:
        if ((baddieID != -4 && !instance_exists(baddieID)) || canDie)
        {
            instance_destroy();
            ds_list_add(global.SaveRoom, id);
        }
        
        break;
}

