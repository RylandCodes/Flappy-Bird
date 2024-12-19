extends CharacterBody2D

class_name Bird

@export var gravity = 2700.0
@export var jump_force = -900
@export var rotation_speed = 2
var rotation_dir = 1

@onready var animation_player = $AnimationPlayer

var max_speed = 1200.0
var is_started = false
var is_dead = false
var is_on_ground = false

signal start

@onready var click = $Click

func _ready():
	velocity = Vector2.ZERO
	animation_player.play("idle")
	

func _physics_process(delta):
	
	if !is_dead:
		if Input.is_action_just_pressed("Jump"):
			if !is_started:
				animation_player.play("flap")
				is_started = true
				start.emit()
			Jump()
			click.play()
	
	if !is_started:
		return
		
	velocity.y += gravity * delta
	
	if velocity.y > max_speed:
		velocity.y = max_speed
		
	move_and_collide(velocity * delta)
	
	rotate_bird()
	
	if is_dead and is_on_ground == false:
		rotation_dir = -1
		velocity.x -= 10
	if is_on_ground:
		gravity = 0
		jump_force = 0
		rotation_speed = 0
		max_speed = 0
		animation_player.stop()
		velocity = Vector2.ZERO
		
func Jump():
	velocity.y = jump_force
	rotation = deg_to_rad(-30)
	
func rotate_bird():
	if velocity.y > 0 && rad_to_deg(rotation) < 90:
		if rotation_dir == 1:
			rotation += rotation_speed * deg_to_rad(1)
		else:
			rotation -= rotation_speed * deg_to_rad(1)
	elif velocity.y < 0 && rad_to_deg(rotation) > -30:
		if rotation_dir == 1:
			rotation -= rotation_speed * deg_to_rad(1)
		else:
			rotation += rotation_speed * deg_to_rad(1)

func _on_pipes_bird_touched():
	is_dead = true
	
	


func _on_ground_stop_bird():
	is_dead = true
	is_on_ground = true
