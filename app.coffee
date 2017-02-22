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
	top: -120
scroll.speedY = 0.8
scroll.content.draggable.momentumOptions =
    friction: 5
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
# tolerance: Minimal movement threshold before we say the spring finished
# 높아질 수록 DragAnimationEnd 이벤트가 빠르게 발생함.
# friction:	number	How hard it is to move the object
scroll2.content.draggable.momentumOptions =
    friction: 7
    tolerance: 10

# scroll.content = 타임라인에 이벤트.
scroll.content.on Events.Move, ->
	sketch.list_white.y = scroll.content.y + 120
	scroll2.content.x = Utils.modulate(scroll.content.y, [-120, -1460], [-753, 0], true)

# scroll2.content = 그래프에 이벤트.
scroll2.content.on Events.Move, ->
	scroll.content.y = Utils.modulate(scroll2.content.x, [-753, 0], [-120,-1460], true)
	sketch.list_white.y = scroll.content.y + 120

sketch.chart_selected.visible = false

# 위치 자동 맞춤용 애니메이션 옵션 설정
scroll2.content.animationOptions = 
	time: 0.3
scroll.content.animationOptions = 
	time: 0.5

# scroll2.content 의 애니메이션이 끝날 때, point로 위치 자동 맞춤. i는 point간 거리. 
# DragAnimationDidEnd를 썼을 때는 tolerance 조절이 에러가 나던데.. (end 이벤트가 상당히 자주 씹히는 현상 발생)
scroll2.content.on Events.AnimationEnd, ->
	i = -68.35
	n = 0
	while n<=11
		if scroll2.content.x > (i*n)+(i*0.5) and scroll2.content.x <= (i*n)-(i*0.5)
			scroll2.content.animate
				x: i*n
		n++
		
# 	for문 돌리기 전 멍청한 흔적 (단계 쪼갠 상태)
# 	if scroll2.content.x > (i*0)+(i*0.5)
# 		scroll2.content.animate
# 			x: 0
# 	if scroll2.content.x > (i*1) and scroll2.content.x <= (i*0)+(i*0.5)
# 		scroll2.content.animate
# 			x: i*1
# 	if scroll2.content.x > (i*1)+(i*0.5) and scroll2.content.x <= (i*1)
# 		scroll2.content.animate
# 			x: i*1
# 	if scroll2.content.x > (i*2) and scroll2.content.x <= (i*1)+(i*0.5) 
# 		scroll2.content.animate
# 			x: i*2
# 	if scroll2.content.x > (i*2)+(i*0.5) and scroll2.content.x <= (i*2) 
# 		scroll2.content.animate
# 			x: i*2
# 	if scroll2.content.x > (i*3) and scroll2.content.x <= (i*2)+(i*0.5)
# 		scroll2.content.animate
# 			x: i*3
# 	if scroll2.content.x > (i*3)+(i*0.5) and scroll2.content.x <= (i*3)
# 		scroll2.content.animate
# 			x: i*3		
# 	if scroll2.content.x > (i*4) and scroll2.content.x <= (i*3)+(i*0.5)
# 		scroll2.content.animate
# 			x: i*4
# 	if scroll2.content.x > (i*4)+(i*0.5) and scroll2.content.x <= (i*4)
# 		scroll2.content.animate
# 			x: i*4
# 	if scroll2.content.x > (i*5) and scroll2.content.x <= (i*4)+(i*0.5)
# 		scroll2.content.animate
# 			x: i*5
# 	if scroll2.content.x > (i*5)+(i*0.5) and scroll2.content.x <= (i*5)
# 		scroll2.content.animate
# 			x: i*5
# 	if scroll2.content.x > (i*6) and scroll2.content.x <= (i*5)+(i*0.5)
# 		scroll2.content.animate
# 			x: i*6
# 	if scroll2.content.x > (i*6)+(i*0.5) and scroll2.content.x <= (i*6)
# 		scroll2.content.animate
# 			x: i*6
# 	if scroll2.content.x > (i*7) and scroll2.content.x <= (i*6)+(i*0.5)
# 		scroll2.content.animate
# 			x: i*7
# 	if scroll2.content.x > (i*7)+(i*0.5) and scroll2.content.x <= (i*7)
# 		scroll2.content.animate
# 			x: i*7
# 	if scroll2.content.x > (i*8) and scroll2.content.x <= (i*7)+(i*0.5)
# 		scroll2.content.animate
# 			x: i*8
# 	if scroll2.content.x > (i*8)+(i*0.5) and scroll2.content.x <= (i*8)
# 		scroll2.content.animate
# 			x: i*8
# 	if scroll2.content.x > (i*9) and scroll2.content.x <= (i*8)+(i*0.5)
# 		scroll2.content.animate
# 			x: i*9
# 	if scroll2.content.x > (i*9)+(i*0.5) and scroll2.content.x <= (i*9)
# 		scroll2.content.animate
# 			x: i*9
# 	if scroll2.content.x > (i*10) and scroll2.content.x <= (i*9)+(i*0.5)
# 		scroll2.content.animate
# 			x: i*10
# 	if scroll2.content.x > (i*10)+(i*0.5) and scroll2.content.x <= (i*10)
# 		scroll2.content.animate
# 			x: i*10
# 	if scroll2.content.x > (i*11) and scroll2.content.x <= (i*10)+(i*0.5)
# 		scroll2.content.animate
# 			x: i*11

# scroll.content 의 애니메이션이 끝날 때, list divider로 위치 자동 맞춤. j는 divider간 거리. 
scroll.content.on Events.AnimationEnd, ->
	j = -122
	n = 0
	while n<=12
		if scroll.content.y > (j*n)+(j*0.5) and scroll.content.y <= (j*n)-(j*0.5)
			scroll.content.animate
				y: j*n
		n++	
	
	
	
	
