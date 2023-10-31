extends PanelContainer

@onready var from_user:OptionButton = $CC/VBC/HBC/VBC/FromUser
@onready var to_user = $CC/VBC/HBC/VBC2/ToUser
@onready var lended_user = $CC/VBC/HBC/VBC4/LendUser
@onready var amount = $CC/VBC/HBC/VBC3/Amount
@onready var transfer = $CC/VBC/Transfer
@onready var error = $CC/VBC/Error

var fromUserName: StringName
var toUserName: StringName
var lendUserName: StringName
# Called when the node enters the scene tree for the first time.
func _ready():
	visibility_changed.connect(func():
		if visible: update_user_btn())
	from_user.item_selected.connect(from_user_selected)
	lended_user.item_selected.connect(lend_user_selected)
	to_user.item_selected.connect(to_user_selected)

func update_user_btn():
	from_user.show_all_user()
	to_user.show_all_user()

func from_user_selected(user_id):
	fromUserName = from_user.get_item_text(user_id)
	if lended_user.selected == -1:
		lended_user.show_only(G.users[fromUserName]["lend"].keys())
	

func lend_user_selected(user_id):
	lendUserName = lended_user.get_item_text(user_id)

func to_user_selected(user_id):
	toUserName = to_user.get_item_text(user_id)
	if from_user.selected == -1:
		from_user.show_users_expect(toUserName)

func check_amt(amount: String) -> int:
	if not amount.is_valid_int():
		return show_amt_error("Invalid fund amount")
	return amount.to_int()

func show_amt_error(what: StringName):
	error.text = what 
	error.visible = true
	return 0

func _on_transfer_pressed():
	var new_amt = check_amt(amount.text)
	if not new_amt: return
	if new_amt > G.users[fromUserName]["balance"]:
		show_amt_error("From user doenst have requested amount")
		return
	
	G.users[lendUserName]["balance"] -= new_amt
	G.users[fromUserName]["lend"][lendUserName] -= new_amt
	G.users[toUserName]["balance"] += new_amt
	
	clean_all()

func clean_all():
	amount.clear()
	error.visible = false
	G.db_updated.emit()
