extends Node

var items = []
var selected_item

func has_item(name_str):
	return items.has(name_str)

func add_item(name_str):
	print("Added ", name_str, " to inventory")
	items.append(name_str)

func remove_item(name_str):
	print("Removed ", name_str, " from inventory")
	items.erase(name_str)

func select_item(name_str):
	if(selected_item != name_str):
		print("Selected item ", name_str)
	selected_item = name_str