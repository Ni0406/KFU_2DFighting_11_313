extends StaticBody2D

var hp = 1



func _process(delta):
	pass


func _on_StaticBody2D_body_entered(body):
	if body.has_method("deal_damage"):
		hp -= body.deal_damage()  
		if hp <= 0:
			queue_free()  

func deal_damage():
	return 1  
