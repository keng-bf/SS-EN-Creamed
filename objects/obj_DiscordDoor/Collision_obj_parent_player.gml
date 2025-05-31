with (other)
{
	var inp = input_check_pressed("up") - input_check_pressed("down"),inpup = input_get("up").pressed || input_get("upC").pressed,inpdown = input_get("down").pressed || input_get("downC").pressed
	inp = inpup - inpdown
	
	if (inp != 0 && grounded && state == PlayerState.normal)
	{
		url_open("https://discord.gg/x22WnGub9A")
	}
}
