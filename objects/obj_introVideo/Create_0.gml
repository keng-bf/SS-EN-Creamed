if (video_get_status() != 0)
	video_close()
canSkip = false
alarm[1] = 350
showText = false
displayVideo = false

if (!file_exists("gamedata/intro.mp4"))
{
	trace("Intro video not found.")
	event_user(0)
	exit
}

video_open("gamedata/intro.mp4")