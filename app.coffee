# Import file "linked_timeline"
sketch = Framer.Importer.load("imported/linked_timeline@1x")

# Sketch에서 Artboard 2~3번에 있는 애들 Artboard 1번 자리로 이동
sketch.$02_list.x = 0
sketch.list_white.x = 0

# 리스트 자리에 Scroll 영역 설정
scroll = new ScrollComponent
	y: 604
	width: 750
	height: 629

# Scroll 영역 설정한 자리에 artboard 2번 집어넣기 	
sketch.$02_list.parent = scroll.content
scroll.scrollHorizontal = false
scroll.contentInset = 
	top: -123

# gradient_framer_white의 layer hierarchy 조정을 위해 임시로 layer하나 생성해서 박음
layer = new Layer
	width: 750
	height: 34
	y: 604
	image: "images/Layer-gradient_frame_white-odveqzyy.png"

# sketch.$03_list.parent = sketch.list_selected_box
sketch.list_selected_box.clip = true
sketch.list_white.parent = sketch.list_selected_box

sketch.$02_list.on Events.Move, ->
	print "a"
	
scroll.content.on Events.Move, ->
	sketch.list_white.y = scroll.content.y + 120
# 	sketch.list_white.y = Utils.modulate(scroll.content.y, [0, i], [1, 0], true)


