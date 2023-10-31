extends AspectRatioContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	G.db_updated.connect(update_list)



func _on_create_user_toggled(button_pressed):
	$HBoxContainer/CreateUserScreen.visible = button_pressed
	


func _on_trasnder_amount_toggled(button_pressed):
	$HBoxContainer/TransferAmountScreen.visible = button_pressed


func _on_trasnder_lend_amount_toggled(button_pressed):
	$HBoxContainer/TransferAmountScreen2.visible = button_pressed

func update_list():
	var list_container = $HBoxContainer/VBoxContainer2
	for child in list_container.get_children():
		child.queue_free()
	
	var l = Label.new()
	l.text = "All Users with balance"
	list_container.add_child(l)
	for user in G.users:
#		var hbox = HBoxContainer.new()
		var txt = "%s user has : %s amount left"%[user, G.users[user]["balance"]]
		var la = Label.new()
		la.text = txt
		list_container.add_child(la)
