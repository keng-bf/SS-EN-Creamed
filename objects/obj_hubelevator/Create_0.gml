depth = 10
state = PlayerState.frozen
var i = 0

hub_array[i++] = [hub_paintstudio, "E N"]
hub_array[i++] = [internship_floor1, "I FLOOR 1"]
hub_array[i++] = [internship_floor2, "I FLOOR 2"]
hub_array[i++] = [tower_1, "PT TOWER 1"]
hub_array[i++] = [tower_2, "PT TOWER 2"]
hub_array[i++] = [tower_3, "PT TOWER 3"]
hub_array[i++] = [tower_4, "PT TOWER 4"]
hub_array[i++] = [tower_5, "PT TOWER 5"]
hub_array[i++] = [rm_missing, "TBA"]
hub_array[i++] = [rm_missing, "TBA"]
hub_array[i++] = [rm_missing, "TBA"]
hub_array[i++] = [rm_missing, "TBA"]
hub_array[i++] = [rm_devroom, "DEV"]
hub_array[i++] = [hub_basement, "BASEMENT"]

drawx = 0
drawy = 0
surface2 = -4
yoffset = 0
ScrollY = 0
playerID = -4
selected = 0

for (var c = 1; c < array_length(hub_array); c++)
{
	if (room == hub_array[c][0])
	{
		selected = c
		break
	}
}

image_index = selected
