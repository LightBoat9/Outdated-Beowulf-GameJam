extends "res://Global/StateMachine.gd"

var raised = false
var minY; var maxY
var curtains
var rate = 4

var environ

func _ready():
	set_process(true)
	set_current_state("idle")
	curtains = get_node("curtains_back")
	minY = -curtains.get_offset().y + 128
	maxY = curtains.get_offset().y
	environ = get_parent()

func move(offset):
	var pos = curtains.get_offset()
	pos.y = clamp(pos.y+offset,minY,maxY)
	curtains.set_offset(pos)
	return (minY==pos.y || maxY==pos.y)

func idle_enter(): pass
func idle_update():
	if Input.is_action_pressed("ui_up"):
		if !raised: set_current_state("raise")
		else : set_current_state("lower")
func idle_exit(): pass

func raise_enter(): pass
func raise_update():
	if (move(-rate)) : set_current_state("idle")
func raise_exit(): raised = true

func lower_enter(): pass
func lower_update():
	if (move(rate)) : set_current_state("idle")
func lower_exit(): 
	raised = false
	environ.act_next()