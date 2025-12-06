if room == rank_room
	instance_destroy()

var treasure_rooms = [room_treasure1, room_treasure2, room_treasure3]
noConeballRoom = array_contains(treasure_rooms, room) || global.RoomIsSecret
visible = !noConeballRoom
