extends PanelContainer

@onready var userName: LineEdit = $CC/User/LineEdit
@onready var addUser = $CC/User/Add
@onready var fund = $CC/Funds/LineEdit
@onready var addFund = $CC/Funds/Add
@onready var errorUser = $CC/User/Error
@onready var errorFunds = $CC/Funds/Error
var current_user: StringName

func _ready():
	%User.visibility_changed.connect(func():
		if %User.visible: userName.grab_focus()
		)
	%Funds.visibility_changed.connect(func():
		if %Funds.visible: fund.grab_focus()
		)
func check_name(user_name:StringName):
	var update_name = user_name.strip_edges().strip_escapes()
	if update_name:
		return update_name
	show_user_error("Invalid User Name")

func show_user_error(what:StringName):
	errorUser.text = what
	errorUser.visible = true
	return false

func check_fund(amount: String) -> int:
	if not amount.is_valid_int():
		return show_fund_error("Invalid fund amount")
	return amount.to_int()

func show_fund_error(what: StringName):
	errorFunds.text = what 
	errorFunds.visible = true
	return 0

func _on_add_user_pressed():
	var new_user = check_name(userName.text)
	if not new_user: return
	if G.check_user(new_user):
		if not show_user_error("Username already used"):
			return
	
	G.add_user(new_user)
	current_user = new_user
	%User.visible = false
	%Funds.visible = true
	
	clean_all()


func _on_visibility_changed():
	if visible:
		%User.visible = true
		%Funds.visible = false

func _on_add_fund_pressed():
	var new_fund = check_fund(fund.text)
	if not new_fund: return
	G.add_balance(current_user, new_fund)
	%User.visible = true
	%Funds.visible = false
	
	clean_all()

func clean_all():
	userName.clear()
	fund.clear()
	G.db_updated.emit()
