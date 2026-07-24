extends Node2D


var current_gold:= 100

func gain_gold(amount: int) -> void:
	current_gold += amount
	print("gaining", amount, " gold")

func lose_gold(amount: int) -> void:
	current_gold -= amount
	print("losing", amount, "gold")
