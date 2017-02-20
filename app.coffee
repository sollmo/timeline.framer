# Import file "linked_timeline"
sketch = Framer.Importer.load("imported/linked_timeline@1x")

Framer.Device.background.backgroundColor = "dddddd"

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
scroll.speedY = 0.8
scroll.content.draggable.momentumOptions =
    friction: 7
    tolerance: 0.1

# gradient_framer_white의 layer hierarchy 조정을 위해 임시로 layer하나 생성해서 박음
# bringToFront() 메서드는 부모 레벨 위로는 이동이 안되는 듯.
gradientWhite = new Layer
	width: 750
	height: 34
	y: 604
	image: "images/Layer-gradient_frame_white-odveqzyy.png"

# list_selected_box의 Clipping을 true 설정해서 바깥영역 안보이게, Artboard 3번 (list_white로 묶음)의 부모로 설정
# 왜인지 모르겠으나, Artboard를 그냥 넣으면 안먹힌담. 그룹으로 한번 묶으니 해결됨
sketch.list_selected_box.clip = true
sketch.list_white.parent = sketch.list_selected_box

# chart 그려지는 자리도 scroll 영역 설정
scroll2 = new ScrollComponent
	y: 127
	width: 750
	height: 359

# chart scroll영역 자리에 chart_line 넣고, x 기본값 조정. contentInset right가 왜인지 안먹혀서 그냥 positon 조정
sketch.chart_line.parent = scroll2.content
scroll2.scrollVertical = false
scroll2.content.x = -753
scroll2.speedX = 0.5
scroll2.content.draggable.momentumOptions =
    friction: 7
    tolerance: 0.1

scroll.content.on Events.Move, ->
	sketch.list_white.y = scroll.content.y + 120
	scroll2.content.x = Utils.modulate(scroll.content.y, [-122, -1446], [-753, 0], true)
# 	print scroll.content.y
# 	sketch.chart_line.x = Utils.modulate(scroll.content.y, [-122, -1446], [0, 750], true)
# 	sketch.chart_line.x = -scroll.content.y - 100
# 	print sketch.chart_line.x
# 	i = 69
# 	if sketch.chart_line.x < i
# 		sketch.chart_selected.y = 184
# 		sketch.chart_selected.scale = 	Utils.modulate(sketch.chart_line.x, [0, 10], [1, 0], true)	
# 	if sketch.chart_line.x > (i*0)+(i/2) and sketch.chart_line.x < (i*1)
# 		sketch.chart_selected.y = 200
# 		sketch.chart_selected.scale = 	Utils.modulate(sketch.chart_line.x, [i-10, i], [0, 1], true)
# 	if sketch.chart_line.x > (i*1) and sketch.chart_line.x < (i*1)+(i/2)
# 		sketch.chart_selected.scale = 	Utils.modulate(sketch.chart_line.x, [i, i+10], [1, 0], true)

scroll2.content.on Events.Move, ->
	scroll.content.y = Utils.modulate(scroll2.content.x, [-753, 0], [-122,-1446], true)
	sketch.list_white.y = scroll.content.y + 120