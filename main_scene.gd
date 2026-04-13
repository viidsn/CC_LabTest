extends Node2D

var faces = []

var happy_count = 0
var sad_count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	generate_faces()
	
func generate_faces():
	faces.clear()
	happy_count = 0
	sad_count = 0

	var amount = randi_range(1, 10)

	for i in range(amount):
		var face = {
			"pos": Vector2(randi_range(50, 500), randi_range(50, 300)),
			"size": randi_range(20, 150),
			"eyes": randi_range(2, 6),
			"color": Color(randf(), randf(), randf()),
			"happy": randf() > 0.5
		}

		if face["happy"]:
			happy_count += 1
		else:
			sad_count += 1

		faces.append(face)
		
		$HappyLabel.text = "Happy: " + str(happy_count)
		$SadLabel.text = "Sad: " + str(sad_count)
		queue_redraw()
		
func _draw():
	for face in faces:
		# голова
		draw_circle(face["pos"], face["size"], face["color"])

		# глаза
		for i in range(face["eyes"]):
			var offset = i * 10
			draw_circle(face["pos"] + Vector2(offset, -10), 5, Color.BLACK)

		# рот
		if face["happy"]:
			draw_line(face["pos"] + Vector2(-10, 10), face["pos"] + Vector2(10, 10), Color.BLACK, 2)
		else:
			draw_line(face["pos"] + Vector2(-10, 20), face["pos"] + Vector2(10, 20), Color.BLACK, 2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_button_pressed():
	generate_faces()
