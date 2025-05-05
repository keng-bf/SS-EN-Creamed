depth = 10
state = PlayerState.frozen
var i = 0
hub_array[i++] = [hub_paintstudio, "E N"]
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
