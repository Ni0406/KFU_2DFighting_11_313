extends CharacterBody2D

class_name Player

signal hp_max_changed(new_hp_max)
signal hp_changed(new_hp)
signal died

# Переменные
var isHurt: bool = false
var isAttacking: bool = false
var speed: int = 150
var gravity: int = 700
var jump_force: int = 250
var jump_count = 0
var max_jumps = 2
@export var hp_max: int = 100 
@export var hp: int = hp_max
@onready var healthBar = $healthBar

func _process(delta):
 # Обработка ввода и движения
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

 # Обработка гравитации и падения
 if not is_on_floor():
  velocity.y += gravity * delta
  if velocity.y > 0:
   $AnimationPlayer.play("fall")

 # Прыжок
 if Input.is_action_just_pressed("Jump") and (is_on_floor() or jump_count < max_jumps):
  if is_on_floor():
   jump_count = 0  # Сброс при касании земли
  jump_count += 1
  velocity.y = -jump_force

 # Перемещение
 move_and_slide()

 # Атака
 if Input.is_action_just_pressed("Attack"):
  $AnimationPlayer.play("Attack")
  isAttacking = true


func get_hp():
 return hp

func set_hp(value):
 if value != hp:
  hp = clamp(value, 0, hp_max)
  emit_signal("hp_changed", hp)
  healthBar.value = hp
  if hp == 0:
   emit_signal("died")
  

func set_hp_max(value):
 if value != hp_max:
  hp_max = max(0, value)
  emit_signal("hp_max_changed", hp_max)
  healthBar.max_value = hp_max
  self.hp = hp


func receive_damage(base_damage: int):
 var actual_damage = base_damage

 self.hp -= actual_damage
 return actual_damage

func die():
 queue_free()

func _on_sword_hit_area_entered(area):
  if area.is_in_group("hurtbox"):
   area.take_damage()


 

