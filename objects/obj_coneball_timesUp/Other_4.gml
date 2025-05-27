if room == rank_room
	instance_destroy()

var treasure_rooms = [steamy_treasure, entryway_treasure, mineshaft_treasure, cafe_treasure, molasses_treasure, mountain_treasure, entrance_treasure]
noConeballRoom = array_contains(treasure_rooms, room) || global.RoomIsSecret
visible = !noConeballRoom
