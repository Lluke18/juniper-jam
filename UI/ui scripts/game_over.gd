extends Control


@export var leaderboard_path : String
@export var http_request : HTTPRequest
@export var submit : Button
var username : String
#var score : int
var url :=  "https://exdyjuyoumyhqvbzkixv.supabase.co/rest/v1/Leaderboard"
var api_key := "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImV4ZHlqdXlvdW15aHF2YnpraXh2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODIzMDQzMzYsImV4cCI6MjA5Nzg4MDMzNn0.mHbW0UzK52C6QUKCMy4QTD-J_Ner8WcNKBK_AcKcDTU"
var curr_letter_index := -1



func _on_quit_pressed() -> void:
	get_tree().quit()



func _on_to_leaderboard_pressed() -> void:
	get_tree().change_scene_to_file(leaderboard_path)


func _on_submit_pressed() -> void:
	submit_score(username, 67) # for testing
	submit.disabled = true

func submit_score(player_name: String, score: int):
	print("submitted!")
	var headers = [
		"Content-Type: application/json",
		"apikey: " + api_key,
		"Authorization: Bearer " + api_key
		]
	var data = JSON.stringify({"player_name": player_name, "score": score})
	http_request.request(url, headers, HTTPClient.METHOD_POST, data)


func _on_http_request_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()
	print(response_code)
	print("body: ", response)


func _on_line_edit_text_submitted(new_text: String) -> void:
	username = new_text
