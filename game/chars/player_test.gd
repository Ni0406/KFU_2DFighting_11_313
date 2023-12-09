extends CharacterBody2D


var speed: int = 150 
var gravity: int = 700
var jump_force: int = 250


func _process(delta):
	
	var direction = Input.get_axis("left", "right")
	if direction:
		
		if $AnimationPlayer.current_animation != "Attack":
			$AnimationPlayer.play("run")
		
		velocity.x = direction * speed
		
		
	else: 
		velocity.x = 0
		if $AnimationPlayer.current_animation != "Attack":
			$AnimationPlayer.play("idle")
	
	if direction == 1:
		$Sprite2D.flip_h = false
	elif direction == -1:
		$Sprite2D.flip_h = true
	
		
	if not is_on_floor():
		velocity.y += gravity * delta
		
		if velocity.y > 0:
			$AnimationPlayer.play("fall")
	
	
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y -= jump_force
		
	
	move_and_slide()
	
	if Input.is_action_just_pressed("Attack"):
		$AnimationPlayer.play("Attack")
		
