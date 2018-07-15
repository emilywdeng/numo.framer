###
Step 4
Let’s make our box clickable. Select "Event" in the tools menu (left).
Select "box" and then "click", and watch how the code gets added for you.

Step 5
Next, click on "Animate", pick "Layer", and select "box" again.
You’re now editing your animation.
Change the rotation to 90 using the Animation properties panel (left).

Step 6
Hit "esc" to exit editing mode. In the preview window (right), click on the box.
You've just made your first animation!

Are you stuck? Double click on "Sample Code" below.
###

# Loading the TTF files in the /fonts/ folder
# and giving them a unique font family name
Utils.insertCSS """
	@font-face {
		font-family: "Gotham";
		src: url("gotham/Gotham-Medium.otf");
	}
"""




# Import from Airtable 
data = JSON.parse Utils.domLoadDataSync "https://api.airtable.com/v0/appCZfN8YJIVjk5vJ/Personality?api_key=keydGpK7XeREMvLjd&view=Grid%20view"

#store questions in an array
# print data.records.length 

#instantiation personality questions array 
pQuestions = []

for i in [0..data.records.length-1]
	pQuestions.push(data.records[i].fields.QuestionText)


class Card extends Layer
	constructor: (@options={}) ->
		super @options

# card = new Card



x = 0

# for i in list.children
#   i.children[0].text = data.records[x].fields.QuestionText
#   x++
  
qCards = []

qCards.push(box)

for i in [21..0]
 newBox=box.copy()
 newBox.parent = list
 qCards.push(newBox)
#  newBox.children[0].text = data.records[i].fields.QuestionText
#  newBox.children[0].text.autoHeight = yes
#  newBox.children[0].text.fontFamily = "Gotham"
#  newBox.center()
#  newBox.draggable.enabled = true


for i in [0..qCards.length-1]
	qCards[i].text = pQuestions[i]
	qCards[i].draggable.enabled = true
	qCards[i].draggable.constraints = qCards[i].frame
	qCards[i].center()
	qCards[i].childDic = {
	"like" : likeLabel
	"nope" : nopeLabel
	}
	qCards[i].states.add {
		"goLeftUp":
			x: -Screen.width
			y: -box.y
		"goLeftDown":
			x: -Screen.width
			y: Screen.height 
		"goRightUp":
			x: Screen.width + box.width
			y: -box.y
		"goRightDown":
			x: Screen.width + box.width
			y: Screen.height
	}
	qCards[i].states.animationOptions = {
		curve:"ease"
		time:0.3
	}


likeLabel = new Layer
	width: box.width 
	height: box.height/5
	parent: box
	backgroundColor: "#4AD094"
	opacity: 0
	name: "like"

nopeLabel = new Layer
	width: box.width 
	height: box.height/5
	parent: box
	backgroundColor: "#F86C67"
	opacity: 0


rotatebox = (layer) ->
	layer.rotationZ = Utils.modulate(layer.midX, [0,Screen.width], [10,-10])

showLikeOrNope = (layer) ->
	if layer.midX < Screen.width/2
		layer.childDic["nope"].opacity = Utils.modulate(layer.midX, [100,Screen.width/2], [1,0])
	else
		layer.childDic["like"].opacity = Utils.modulate(layer.midX, [Screen.width/2,Screen.width-100], [0,1])

# ===========EVENT===========
box.on Events.Move,->
	rotatebox(this)
	showLikeOrNope(this)

box.on Events.DragEnd, ->
# 	magnitude = Math.sqrt(Math.pow(box.draggable.velocity.x,2) + Math.pow(box.draggable.velocity.y,2)) 	
	if box.midX < 0
		if box.midY < Screen.height/2
			box.states.switch("goLeftUp")
			print "HELLO"
		else
			box.states.switch("goLeftDown")
		box.destroy()
	else if box.midX > Screen.width
		if box.midY < Screen.height/2
			box.states.switch("goRightUp")
		else
			box.states.switch("goRightDown")
		box.destroy()


