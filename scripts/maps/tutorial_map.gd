extends Node
class_name tutorial_map

## MAP tutorial_map


static func get_mission_information():
	var wave1_easy = WaveInterface.Wave.new(1,[WaveInterface.EnemyContainer.new("blue_little_guy",5)],1.0,0.0)
	var wave2_easy = WaveInterface.Wave.new(2,[WaveInterface.EnemyContainer.new("blue_little_guy",10)],1.0,5.0)
	var wave3_easy = WaveInterface.Wave.new(3,[WaveInterface.EnemyContainer.new("blue_little_guy",5)],1.0,5.0)
	var wave4_easy = WaveInterface.Wave.new(4,[WaveInterface.EnemyContainer.new("blue_little_guy",5)],1.0,5.0)
	var easy_waves = MissionInterface.EnemyWavesDifficultyMapping.new([wave1_easy,wave2_easy,wave3_easy,wave4_easy],"easy")
	return MissionInterface.Mission.new("tutorial_map",10,100,[easy_waves])

##-------------------------------------------------------------
