function create_afterimage(argument0, argument1 = image_xscale, argument2 = false)
{
    var parent, afterimage_id, pal, angle, q;
    
    if (!instance_exists(id))
        exit;
    
    parent = object_index;
    afterimage_id = id;
    pal = [-4, -4];
    angle = afterimage_id.image_angle;
    
    if (object_is_ancestor(parent, obj_parent_enemy))
        pal = [paletteSelect, paletteSprite];
    
    if (object_is_ancestor(parent, obj_parent_player))
        angle = afterimage_id.draw_angle;
    
    q = 
    {
        x: afterimage_id.x,
        y: afterimage_id.y,
        blink: argument2,
        sprite_index: afterimage_id.sprite_index,
        image_index: afterimage_id.image_index,
        image_alpha: 1,
        image_angle: angle,
        image_xscale: argument1,
        image_yscale: 1,
        visible: true,
        alarm: [13, 30],
        color_choose: argument0,
        hsp: 0,
        vsp: 0,
        identity: afterimage_id,
        gonealpha: (argument0 == AfterImageType.plain) ? 0.85 : 1,
        vanish: false,
        paletteSelect: pal[0],
        paletteSprite: pal[1],
        basicAfterimage: true,
        mach3Afterimage: false,
        vanishSpd: 0.15,
        fakeMach3Afterimage: false
    };
    
    if (argument0 == AfterImageType.baddie)
        q.vanishSpd = 0.05;
    
    ds_list_add(global.afterimage_list, q);
    return q;
}

function create_heat_afterimage(argument0, argument1 = image_xscale, argument2 = 8)
{
    with (create_afterimage(argument0, argument1))
    {
        gonealpha = 0.85;
        vsp = argument2;
        alarm[0] = 1;
        alarm[1] = 60;
    }
    
    with (create_afterimage(argument0, argument1))
    {
        gonealpha = 0.85;
        vsp = -argument2;
        alarm[0] = 1;
        alarm[1] = 60;
    }
    
    with (create_afterimage(argument0, argument1))
    {
        gonealpha = 0.85;
        hsp = argument2;
        alarm[0] = 1;
        alarm[1] = 60;
    }
    
    with (create_afterimage(argument0, argument1))
    {
        gonealpha = 0.85;
        hsp = -argument2;
        alarm[0] = 1;
        alarm[1] = 60;
    }
}