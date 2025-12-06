if (video_get_status() != 0)
	video_close()
canSkip = false
alarm[1] = 350
showText = false
displayVideo = false
video = "gamedata/" + choose("intro1.mp4", "intro2.mp4" ,"intro3.mp4")
if (!file_exists(video))
{
	trace("Intro video not found.")
	event_user(0)
	exit
}

video_open(video)