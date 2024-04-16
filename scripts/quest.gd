class_name Quest extends Node

var quest_name: String
enum QuestStatus { STARTED, NOT_STARTED, FINISHED }
var current_state: QuestStatus

var progress: int
var max_steps: int

var npcs: Array[NPC]

var amount: int

var item

var experience: int

var reward

var visible: bool




