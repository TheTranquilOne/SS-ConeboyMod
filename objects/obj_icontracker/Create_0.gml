target = -4;
visible_cond = -4;

visible_default_cond = function()
{
    var bbox_in_cam;
    
    if (!instance_exists(target))
        return false;
    
    bbox_in_cam = false;
    
    with (target)
        bbox_in_cam = bbox_in_camera(id, view_camera[0]);
    
    return bbox_in_cam;
};