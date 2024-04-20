class_name CharacterEditor extends Node2D

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


func change_head(index: int) -> void:
	match index:
		0:
			my_head = head.HEAD1
		1: 
			my_head = head.HEAD2
		2:
			my_head = head.HEAD3
		3:
			my_head = head.HEAD4
	_animation()


func switch_class(new_class: String) -> void:
	$FighterSword.visible = false
	$FighterShield.visible = false
	$MageWand.visible = false
	$Longbow.visible = false
	$Dagger.visible = false
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
		$Dagger.visible = true
	_animation()
	

func _all_invisible() -> void:
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
	$Dagger.visible = false


func _animation() -> void:
	_all_invisible()
	match my_head:
		head.HEAD1:
			$MaleHead1.visible = true
			$MaleHead1.frame = 0
			$MaleHead1.play("default")
		head.HEAD2:
			$MaleHead2.visible = true
			$MaleHead2.frame = 0
			$MaleHead2.play("default")
		head.HEAD3:
			$MaleHead3.visible = true
			$MaleHead3.frame = 0
			$MaleHead3.play("default")
		head.HEAD4:
			$FemaleHead.visible = true
			$FemaleHead.frame = 0
			$FemaleHead.play("default")
	if my_class == hero_class.FIGHTER:
		$FighterArmor.frame = 0
		$FighterArmor.visible = true
		$FighterShield.frame = 0
		$FighterShield.visible = true
		$FighterSword.frame = 0
		$FighterSword.visible = true
		$FighterArmor.play("default")
		$FighterShield.play("default")
		$FighterSword.play("default")
	else:
		$BodyClothes.visible = true
		$BodyClothes.frame = 0
		$BodyClothes.play("default")
	if my_class == hero_class.ARCHER:
		$Longbow.frame = 0
		$Longbow.visible = true
		$Longbow.play("default")
	elif my_class == hero_class.MAGE:
		$MageWand.frame = 0
		$MageWand.visible = true
		$MageWand.play("default")
	elif my_class == hero_class.THIEF:
		$Dagger.visible = true
		
