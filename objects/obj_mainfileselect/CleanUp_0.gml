var i;

ds_queue_destroy(saves_queue);

for (i = 0; i < array_length(fileDoodleSurf); i++)
{
    if (surface_exists(fileDoodleSurf[i]))
        surface_free(fileDoodleSurf[i]);
}

for (i = 0; i < array_length(fileDoodleBuffer); i++)
{
    if (buffer_exists(fileDoodleBuffer[i]))
        buffer_delete(fileDoodleBuffer[i]);
}
