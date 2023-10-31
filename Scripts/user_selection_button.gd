extends OptionButton

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func show_all_user():
	clear()
	var all_user = G.users.keys()
	for user in all_user:
		add_item(user)
	
	selected = -1

func show_users_expect(user_name: StringName):
	clear()
	var all_user = G.users.keys()
	for user in all_user:
		if user == user_name: continue
		add_item(user) 
	
	selected = -1

func show_only(users: Array):
	clear()
	for user in users:
		add_item(user)
	
	selected = -1
