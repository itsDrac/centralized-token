extends Node

var users: Dictionary:
	get: return users
	set(val): 
		users = val
		db_updated.emit()

signal db_updated


func check_user(user_name: StringName):
	return users.has(user_name)

func add_user(user_name: StringName):
	users[user_name] = {"balance": 0, "lend":{}}

func add_balance(user_name: StringName, amt:int):
	users[user_name]["balance"] += amt

func get_balance(of: StringName):
	return users[of]["balance"]
