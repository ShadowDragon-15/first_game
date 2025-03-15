extends CharacterBody2D
@onready var sprite_2d=$AnimatedSprite2D
var lan_nhay_toi_da=2
var lan_nhay=0
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var islive = true

func _physics_process(delta: float) -> void:
	if Global.playerdeal == true:
		islive = false
		$AnimatedSprite2D.play("die")
		$CollisionShape2D.queue_free()
		Global.playerdeal=false
	

	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		lan_nhay=0
	

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and lan_nhay<lan_nhay_toi_da:
		velocity.y = JUMP_VELOCITY
		lan_nhay+=1

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		if direction < 0:
			sprite_2d.flip_h=true
		else :
			sprite_2d.flip_h=false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if is_on_floor():
		if direction !=0:
			sprite_2d.play("run")
		else:
			if islive == true:
				sprite_2d.play("idie")
	else:
		if velocity.y<0:
			if lan_nhay==1:
				sprite_2d.play("jump")
			else:
				sprite_2d.play("doublejump")
		else :
			if islive == true:
				sprite_2d.play("fall")
	move_and_slide()





func _on_timer_timeout() -> void:
	self.queue_free()
	pass # Replace with function body.
