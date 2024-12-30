function layer_type_get_id(argument0, argument1)
{
    var layer_elements, i;
    
    if (layer_exists(argument0))
    {
        layer_elements = layer_get_all_elements(argument0);
        
        for (i = 0; i < array_length(layer_elements); i++)
        {
            if (layer_get_element_type(layer_elements[i]) == argument1)
                return layer_elements[i];
        }
    }
    
    return -1;
}

function layer_tilemap_get_id_fixed(argument0)
{
    return layer_type_get_id(argument0, 5);
}

function layer_background_get_id_fixed(argument0)
{
    return layer_type_get_id(argument0, 1);
}

function layer_asset_get_id(argument0)
{
    return layer_type_get_id(argument0, 4);
}

function layer_get_all_sprites(argument0)
{
    var temp_array, a, i;
    
    temp_array = [];
    
    if (layer_exists(argument0))
    {
        a = layer_get_all_elements(argument0);
        
        for (i = 0; i < array_length(a); i++)
        {
            if (layer_get_element_type(a[i]) == 4)
                array_push(temp_array, a[i]);
        }
    }
    
    return temp_array;
}

function layer_get_all_instances(argument0)
{
    var temp_array, a, i;
    
    temp_array = [];
    
    if (layer_exists(argument0))
    {
        a = layer_get_all_elements(argument0);
        
        for (i = 0; i < array_length(a); i++)
        {
            if (layer_get_element_type(a[i]) == 2)
                array_push(temp_array, a[i]);
        }
    }
    
    return temp_array;
}

function layer_change_background(argument0, argument1)
{
    var a, i, back_id;
    
    if (argument0 != argument1)
    {
        a = layer_get_all();
        
        for (i = 0; i < array_length(a); i++)
        {
            back_id = layer_background_get_id_fixed(a[i]);
            
            if (layer_background_get_sprite(back_id) == argument0)
                layer_background_sprite(back_id, argument1);
        }
    }
}

function layer_change_tileset(argument0, argument1)
{
    var a, i, tile_id;
    
    if (argument0 != argument1)
    {
        a = layer_get_all();
        
        for (i = 0; i < array_length(a); i++)
        {
            tile_id = layer_tilemap_get_id_fixed(a[i]);
            
            if (tilemap_get_tileset(tile_id) == argument0)
                tilemap_tileset(tile_id, argument1);
        }
    }
}
