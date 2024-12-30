var treasure_rooms;

if (room == rank_room || room == timesuproom)
    instance_destroy();

treasure_rooms = [steamy_treasure, entryway_treasure, mineshaft_treasure, cafe_treasure, molasses_treasure, mountain_treasure];
noConeballRoom = array_contains(treasure_rooms, room) || global.RoomIsSecret;
visible = !noConeballRoom;
