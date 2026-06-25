extends Control

var url :=  "https://exdyjuyoumyhqvbzkixv.supabase.co/rest/v1/Leaderboard"
var api_key := "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImV4ZHlqdXlvdW15aHF2YnpraXh2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODIzMDQzMzYsImV4cCI6MjA5Nzg4MDMzNn0.mHbW0UzK52C6QUKCMy4QTD-J_Ner8WcNKBK_AcKcDTU"

@export var http_request : HTTPRequest
@export var vbox : VBoxContainer

func _ready() -> void:
	fetch_leaderboard()


func fetch_leaderboard():
	var headers = [
		"Content-Type: application/json",
		"apikey: " + api_key,
		"Authorization: Bearer " + api_key
	]
	http_request.request(url + "?order=score.desc&limit=10", headers, HTTPClient.METHOD_GET)

func _on_http_request_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var scores = json.get_data()
	#print(response_code)
	for child in vbox.get_children():
		child.queue_free()
	for i in range(min(10, scores.size())):
		var entry = scores[i]
		var label = Label.new()
		label.text = "%d. %s - %d" % [i + 1, entry["player_name"], int(entry["score"])]
		vbox.add_child(label)
