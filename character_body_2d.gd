extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var hoanh_do=1
var islive=true
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if islive:
		velocity.x = hoanh_do * SPEED
		$AnimatedSprite2D.play("run")
	else :
		velocity.x=0
	if velocity.x <0:
		$AnimatedSprite2D.flip_h=true
	else:
		$AnimatedSprite2D.flip_h=false

	

	move_and_slide()
	


func _on_timer_timeout() -> void:
	hoanh_do=-hoanh_do
	pass # Replace with function body.

func _on_deadzone_body_exited(body: Node2D) -> void:
	if body.name == 'CharacterBody2D':
		$deadzone.queue_free()
		islive = false
		$AnimatedSprite2D.play("hit")
		$Timer2.start()
	pass # Replace with function body.


func _on_timer_2_timeout() -> void:
	queue_free()
	pass # Replace with function body.




func _on_damezone_body_exited(body: Node2D) -> void:
	if body.name == 'CharacterBody2D':
		Global.playerdeal = true
		print(Global.playerdeal)
	pass # Replace with function body.
