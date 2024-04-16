extends Node2D

enum hero_class { FIGHTER, MAGE, THIEF, ARCHER }
enum head { HEAD1, HEAD2, HEAD3, HEAD4 }
enum body { CLOTHES, ARMOR }

var my_head: head
var my_body: body
var my_class: hero_class


func _ready():
	switch_class("Thief")
	my_head = head.HEAD1
	my_body = body.CLOTHES
	my_class = hero_class.THIEF
	_animation()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func switch_class(new_class: String):
	$FighterSword.visible = false
	$FighterShield.visible = false
	$MageWand.visible = false
	$Longbow.visible = false
	if new_class == "Fighter":
		my_class = hero_class.FIGHTER
		my_body = body.ARMOR
		$FighterSword.visible = true
		$FighterShield.visible = true
	elif new_class == "Mage":
		my_class = hero_class.MAGE
		my_body = body.CLOTHES
		$MageWand.visible = true
	elif new_class == "Archer":
		my_class = hero_class.ARCHER
		my_body = body.CLOTHES
		$Longbow.visible = true
	elif new_class == "Thief":
		my_class = hero_class.THIEF
		my_body = body.CLOTHES

	

func _all_invisible():
	$MaleHead1.visible = false
	$BodyClothes.visible = false
	$MaleHead2.visible = false
	$MaleHead3.visible = false
	$FemaleHead.visible = false
	$FighterSword.visible = false
	$FighterShield.visible = false
	$FighterArmor.visible = false
	$MageWand.visible = false
	$Longbow.visible = false


func _animation():
	_all_invisible()
	match my_head:
		head.HEAD1:
			$MaleHead1.visible = true
			$MaleHead1.play("default")
		head.HEAD2:
			$MaleHead2.visible = true
			$MaleHead2.play("default")
		head.HEAD3:
			$MaleHead3.visible = true
			$MaleHead3.play("default")
		head.HEAD4:
			$FemaleHead.visible = true
			$FemaleHead.play("default")
	if my_class == hero_class.FIGHTER:
		$FighterArmor.visible = true
		$FighterShield.visible = true
		$FighterSword.visible = true
		$FighterArmor.play("default")
		$FighterShield.play("default")
		$FighterSword.play("default")
	else:
		$BodyClothes.visible = true
		$BodyClothes.play("default")
	if my_class == hero_class.ARCHER:
		$Longbow.visible = true
		$Longbow.play("default")
	elif my_class == hero_class.MAGE:
		$MageWand.visible = true
		$MageWand.play("default")
	
