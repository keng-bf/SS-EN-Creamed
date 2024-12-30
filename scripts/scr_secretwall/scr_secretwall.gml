function scr_secrettiles_add(argument0)
{
    var i, arg, layer_id, func;
    
    if (object_index != obj_secretwall)
        return false;
    
    if (is_undefined(argument0))
        return false;
    
    for (i = 0; i < argument_count; i++)
    {
        arg = argument[i];
        layer_id = layer_get_id(arg);
        layer_set_visible(layer_id, false);
        array_push(layerArray, layer_id);
    }
    
    func = function(argument0, argument1)
    {
        return layer_get_depth(argument1) - layer_get_depth(argument0);
    };
    
    array_sort(layerArray, func);
    return true;
}

function add_secrettiles(argument0)
{
    var i, arg, layerid, name, _f;
    
    global.secret_layers = [];
    
    for (i = 0; i < argument_count; i++)
    {
        arg = argument[i];
        layerid = layer_get_id(arg);
        layer_set_visible(layerid, false);
        name = layer_get_name(layerid);
        
        if (layer_exists(argument[i]))
        {
            array_push(global.secret_layers, 
            {
                nm: name,
                id: layerid,
                alpha: 1,
                surf: -4
            });
        }
    }
    
    _f = function(argument0, argument1)
    {
        return -(layer_get_depth(argument0.nm) - layer_get_depth(argument1.nm));
    };
    
    array_sort(global.secret_layers, _f);
    return true;
}
