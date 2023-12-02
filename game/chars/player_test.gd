extends CharacterBody2D


var speed: int = 150 


func _process(_delta):
	
	var direction = Input.get_axis("left", "right")
	if direction:
		
		if $AnimationPlayer.current_animation != "Attack":
			$AnimationPlayer.play("run")
		
		velocity.x = direction * speed
		
		
	else: 
		velocity.x = 0
		if $AnimationPlayer.current_animation != "Attack":
			$AnimationPlayer.play("idle")
	move_and_slide()
	
	if Input.is_action_just_pressed("Attack"):
		$AnimationPlayer.play("Attack")
