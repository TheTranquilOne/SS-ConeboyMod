global.bgSurfaceBuffer = -1;

function scr_parallaxbg_init()
{
    var layernum, a, i, back_id, _f, layers, bottom_id, top_id;
    
    layernum = 0;
    a = layer_get_all();
    
    for (i = 0; i < array_length(a); i++)
    {
        back_id = layer_background_get_id_fixed(layer_get_name(a[i]));
        
        if (back_id != -1 && layer_get_depth(a[i]) >= 1000 && layer_get_visible(a[i]) == true)
            layers[layernum++] = a[i];
    }
    
    if (!layernum)
        exit;
    
    _f = function(argument0, argument1)
    {
        return layer_get_depth(argument1) - layer_get_depth(argument0);
    };
    
    array_sort(layers, _f);
    bottom_id = layers[0];
    top_id = layers[layernum - 1];
    global.bg_layer_ids = layers;
    
    with (obj_parallax)
        depth = layer_get_depth(top_id) - 1;
    
    layer_script_begin(bottom_id, scr_parallaxbg_start);
    layer_script_end(top_id, scr_parallaxbg_end);
}

function scr_parallaxbg_start()
{
    var _cam_x, _cam_y, a, i;
    
    if (!surface_exists(global.parallaxbg_surface))
        global.parallaxbg_surface = surface_create(camera_get_view_width(view_camera[0]) + 128, camera_get_view_height(view_camera[0]) + 128);
    
    if (event_type == ev_draw && event_number == 0)
    {
        surface_set_target(global.parallaxbg_surface);
        draw_clear_alpha(c_black, 0);
        _cam_x = camera_get_view_x(view_camera[0]);
        _cam_y = camera_get_view_y(view_camera[0]);
        a = global.bg_layer_ids;
        
        for (i = 0; i < array_length(a); i++)
        {
            if (layer_exists(a[i]) && layer_get_depth(a[i]) >= 1000 && layer_get_visible(a[i]))
            {
                layer_x(a[i], (layer_get_x(a[i]) - _cam_x) + 64);
                layer_y(a[i], (layer_get_y(a[i]) - _cam_y) + 64);
            }
        }
    }
}

function scr_parallaxbg_end()
{
    if (event_type == ev_draw && event_number == 0)
    {
        gpu_set_blendenable(0);
        gpu_set_colorwriteenable(0, 0, 0, 1);
        draw_rectangle(-128, -128, camera_get_view_width(view_camera[0]) + 128, camera_get_view_height(view_camera[0]) + 128, 0);
        gpu_set_blendenable(1);
        gpu_set_colorwriteenable(1, 1, 1, 1);
        surface_reset_target();
    }
}