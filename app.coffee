# Import file "Final Screens (Master @ 8ff5c69)"
sketch1 = Framer.Importer.load("imported/Final%20Screens%20(Master%20@%208ff5c69)@1x", scale: 1)

# Import file "Final Screens (Master @ a30fd53)"
sketch = Framer.Importer.load("imported/Final%20Screens%20(Master%20@%20a30fd53)@2x", scale: 1)


Utils.globalLayers(sketch)
# Defining a custom device
# Framer.DeviceView.Devices["futureFinderDevice"] = 
# 	"deviceType": "apple-iphone-8"
# 	"screenWidth": 375*3
# 	"screenHeight": 648*3
# 	"deviceImageWidth": 375*3
# 	"deviceImageHeight": 648*3
# 
# Framer.Device.deviceType = "futureFinderDevice"




# Custom Font
# Loading the TTF files in the /fonts/ folder
# and giving them a unique font family name
Utils.insertCSS """
	@font-face {
		font-family: "Gotham-Med";
		src: url("gotham/Gotham-Medium.otf");
	}
	@font-face {
		font-family: "Gotham-Book";
		src: url("gotham/Gotham-Book.otf");
	}
"""

# #Airtable
# # Import from Airtable 
# data = JSON.parse Utils.domLoadDataSync "https://api.airtable.com/v0/appCZfN8YJIVjk5vJ/Personality?api_key=keydGpK7XeREMvLjd&view=Grid%20view"
# 
# # print data.records.length 
# 
# #personality questions array 
# questionText = []
# 
# for i in [0..data.records.length-1]
# 	questionText.push(data.records[i].fields.QuestionText)
 
#Modules
{ƒ,ƒƒ} = require 'findModule'

# How to use
# ƒƒ() # find all layers in your project
# ƒƒ('card > *') # find all layers that are direct descendants of layers named "card"
# ƒƒ('card *') # find all layers that are descendants of layers named "card"
# ƒƒ('*image*') # find all layers containing "image"
# ƒƒ('*card*,*image*') # find all layers containing either "card" or "image"
# ƒƒ('card1 > container *') # find all descendant layers of the "container" inside "card1"


{YouTubePlayer} = require 'YouTubePlayer'

# How to use 
# youtube = new YouTubePlayer
# 	# all the standard Layer options, like width, height, parent and blur
# 	video: <string> # YouTube video ID, like "9bZkp7q19f0"
# 	playerVars: <object>
# 		autoplay: <number> (0 || 1)
# 		controls: <number> (0 || 1)
# 		# see https://developers.google.com/youtube/player_parameters for other options

# Example with parent
# layerA = new Layer # editable with AutoCode
# 	x: 200
# 	y: 300
# 	width: 400
# 	height: 225
# 
# youtube = new YouTubePlayer
# 	parent: layerA
# 	video: "9bZkp7q19f0"
# 	width: 400
# 	height: 225 

InputModule = require "input"

# input = new InputModule.Input
#   setup: true # Change to true when positioning the input so you can see it
#   y: 240 # y position
#   x: 90  # x position
#   width: 500
#   height: 60


#default Settings
# Set opacity to default hidden for overlayed state elements
for layer in ƒƒ('*Filled')
	layer.opacity = 0

for layer in ƒƒ('*Active')
	layer.opacity = 0

for layer in ƒƒ('*WarningNotification')
	layer.opacity = 0
	
for layer in ƒƒ('*Done')
	layer.opacity = 0
	
for layer in ƒƒ('*Highlight')
	layer.opacity = 0

for layer in ƒƒ('*Selected')
	layer.opacity = 0


#create Overarching FlowComponent
flow = new FlowComponent

# Show first screen for dev
# flow.showNext(interest)

#create onboarding FlowComponent and add to overarching flow
onboardingFlow = new FlowComponent
flow.showNext(onboardingFlow)

# add onboarding screens to onboarding Flow Component
onboardingFlow.showNext(onboarding)

#add transitions between onboarding and create account
sketch.buttonCreateAccount.onClick (event, layer) ->
	onboardingFlow.showNext(login)

sketch.login.onSwipeRight (event, layer) ->
	onboardingFlow.showPrevious()

#create PageComponent for onboarding cards
onboardingPages = new PageComponent
	parent: onboarding
	scrollVertical: false
	x: Align.center
	y: Align.top
	width: Screen.width
	height: 495

#set onboarding pages to invisible and smaller scale
for layer in ƒƒ('*onboardingPage*')
	layer.opacity = 0
	layer.scale = 0.95
	onboardingPage1.opacity	= 1
	onboardingPage1.scale = 1

#add onboarding pages to PageComponent
onboardingPages.addPage(onboardingPage1)
onboardingPages.addPage(onboardingPage2)
onboardingPages.addPage(onboardingPage3)
onboardingPages.addPage(onboardingPage4)
onboardingPages.addPage(onboardingPage5)

#create active dot indicator for pagination
activeDot = new Layer
	width: 8
	height: 8
	borderRadius: 20
	parent: onboarding
	backgroundColor: '#4AC8AC'
	y: 494
	x: 154

#define states for active dot
activeDot.states = 
	page1: x: 154
	page2: x: 169
	page3: x: 185
	page4: x: 200
	page5: x: 216
	
#listen for onboarding page change
onboardingPages.on "change:currentPage",->
	current = onboardingPages.currentPage
	previous = onboardingPages.previousPage
	
	#transition animations between pages
	previous.animate
		opacity: 0
		scale: 0.95
	current.animate
		opacity: 1
		scale: 1
	
	#move pagintation indicator dot to correct placement
	currentPage = onboardingPages.horizontalPageIndex(current) + 1
	currentPage = 'page' + currentPage
	activeDot.states.switchInstant currentPage

#add transitions between create account and interests
sketch.buttonGetStarted.onClick (event, layer) ->
	onboardingFlow.showNext(interest)

mainFlow = ""
#add transitions between interests and futures
sketch.buttonSaveInterests.onClick (event, layer) ->
	mainFlow = new FlowComponent
		backgroundColor: '#F8F8F8'
	flow.showNext(mainFlow)
	
	#assigning screen headers and navigation
	mainFlow.header = sketch.header
	mainFlow.footer = sketch.navBar
	mainFlow.showNext(futures)


#MAIN FUTURE / PROFILE NAVIGATION
#assign states to the button styles and default me to inactive
for layer in ƒƒ('navButton*')
	layer.states = 
		inactive: opacity: 0.5
		active: opacity: 1
sketch.navButtonMe.states.switch "inactive"

#assign states and animations to the nav indicator
sketch.navActiveIndicator.states =
	future: x: 0
	me: x: 184
sketch.navActiveIndicator.states.animationOptions =
	curve: Bezier.ease
	time: .5

#transition between futures and profile
sketch.navButtonMe.onClick (event, layer) ->
	sketch.navActiveIndicator.states.switch "me"
	sketch.navButtonFuture.states.switch "inactive"
	sketch.navButtonMe.states.switch "active"
	mainFlow.showNext(profile)

sketch.navButtonFuture.onClick (event, layer) ->
	sketch.navActiveIndicator.states.switch "future"
	sketch.navButtonFuture.states.switch "active"
	sketch.navButtonMe.states.switch "inactive"
	mainFlow.showPrevious(futures)

####dev comment!
flow.showNext(futures)

#QUESTIONS FLOW
dailyQuizFlow = ""
questionsFlow = ""
questionCurrent = 0
sketch.futuresQuestions.onClick (event, layer) ->
	if dailyQuizFlow is "" 
			dailyQuizFlow = new FlowComponent
			questionsFlow = new FlowComponent
				x: 0
				y: 70
				height: 470
				width: Screen.width
				scrollVertical: false
				scrollHorizontal: false
				parent: questionsBackground
				backgroundColor: '#FFFFFF'
			flow.showNext(dailyQuizFlow)
			dailyQuizFlow.showNext(questionsBackground)
			questionsFlow.showNext(question1)
			questionCurrent += 1
		else
			flow.showNext(dailyQuizFlow)

#close questions button
questionsClose.onClick (event,layer) ->
	flow.showPrevious()

#question1 select answers
question1Option1Default.onClick (event, layer) ->
	question1Option1Selected.animate
		opacity: 1
		options: 
			time: .2
	#INSERT logic to save question1 Option1 answer
	questionCurrent += 1
	questionProgress1.opacity = 0
	questionsFlow.showNext(question2)
	

question1Option2Default.onClick (event, layer) ->
	question1Option2Selected.animate
		opacity: 1
		options: 
			time: .2
	#INSERT logic to save question1 Option2 answer
	questionCurrent += 1
	questionProgress1.opacity = 0
	questionsFlow.showNext(question2)

#question2 select answers
question2Option1Default.onClick (event, layer) ->
	question2Option1Selected.animate
		opacity: 1
		options: 
			time: .2
	#INSERT logic to save question2 Option1 answer
	questionCurrent += 1
	questionProgress2.opacity = 0
	questionsFlow.showNext(question3)

question2Option2Default.onClick (event, layer) ->
	question2Option2Selected.animate
		opacity: 1
		options: 
			time: .2
	#INSERT logic to save question2 Option2 answer
	questionCurrent += 1
	questionProgress2.opacity = 0
	questionsFlow.showNext(question3)

#question3 select answers
#create slider3 element
slider3 = new SliderComponent
	x: 110
	y: 155
	width: 18
	height: 280
	max: 2
	min: -2
	parent: question3
slider3.knob.size = 25
slider3.knob.backgroundColor = '#B8B8B8'
slider3.backgroundColor = '#F1EDEF'
slider3.fill.backgroundColor = '#F1EDEF'
slider3.knob.shadowBlur = 0
slider3.knob.shadowX = 0
slider3.knob.shadowY = 0
slider3.knob.draggable.momentum = false

#animate arrows when user reaches the screen
sketch.question3UpArrow.animate
	y: -10
	opacity: .5
	options:
		time: 1.5
		curve: Bezier.ease
		repeat: 2
sketch.question3DownArrow.animate
	y: +30
	opacity: .5
	options:
		time: 1.5
		curve: Bezier.ease
		repeat: 2
#create displayvalue layer and state
displayValue3 = new TextLayer
	text: ''
	fontSize: 14
	fontFamily: 'Gotham'
	color: '#4AC8AC'
	x: 70
	parent: slider3.knob

displayValue3.states = 
	closed: opacity: 0
displayValue3.animationOptions = 
	time: 0.2

#when users changes the value, change display value and hide arrows
slider3.onValueChange ->
	slider3.knob.backgroundColor = '#4AC8AC'
	sketch.question3ArrowIcons.animate
		opacity: 0
		options:
			time: 0.25
	# varibles for labels
	answerHigh = 'Independent'
	answerLow = 'Group'
	if Math.round(slider3.value) is -2
		displayValue3.text = 'Mostly ' + answerHigh
	else if Math.round(slider3.value) is -1
		displayValue3.text = 'More ' + answerHigh
	else if Math.round(slider3.value) is 1
		displayValue3.text = 'More ' + answerLow
	else if Math.round(slider3.value) is 2
		displayValue3.text = 'Mostly ' + answerLow
	else
		displayValue3.text = 'Neutral'

#when user starts dragging knob, show display value, and hide question 3 button if displayed
slider3.knob.on Events.DragStart, ->
	displayValue3.states.switchInstant "default"
	sketch.question3ButtonActive.animate
		opacity: 0
		options: time: .25
	
#when user stops dragging knob, hide display value, and show question 3 button
slider3.knob.on Events.DragEnd, ->
	displayValue3.states.switch "closed"
	sketch.question3ButtonActive.animate
		opacity: 1
		options: time: 0.5

# submit the current value for question 3
question3ButtonActive.onClick (event, layer) ->
	question3ButtonSelected.animate
		opacity: 1
		options: 
			time: .2
	#INSERT logic to save question3 value
	questionCurrent += 1
	questionProgress3.opacity = 0
	questionsFlow.showNext(question4)
	
#question4 select answers
question4Option1Default.onClick (event, layer) ->
	question4Option1Selected.animate
		opacity: 1
		options: 
			time: .2
	#INSERT logic to save question4 Option1 answer
	questionCurrent += 1
	questionProgress4.opacity = 0
	questionsFlow.showNext(question5)

question4Option2Default.onClick (event, layer) ->
	question4Option2Selected.animate
		opacity: 1
		options: 
			time: .2
	#INSERT logic to save question4 Option2 answer
	questionCurrent += 1
	questionProgress4.opacity = 0
	questionsFlow.showNext(question5)
	
#question5 select answers
#create slider5 element
slider5 = new SliderComponent
	x: 110
	y: 155
	width: 18
	height: 280
	max: 2
	min: -2
	parent: question5
slider5.knob.size = 25
slider5.knob.backgroundColor = '#B8B8B8'
slider5.backgroundColor = '#F1EDEF'
slider5.fill.backgroundColor = '#F1EDEF'
slider5.knob.shadowBlur = 0
slider5.knob.shadowX = 0
slider5.knob.shadowY = 0
slider5.knob.draggable.momentum = false

#animate arrows when user reaches the screen
sketch.question5UpArrow.animate
	y: -10
	opacity: .5
	options:
		time: 1.5
		curve: Bezier.ease
		repeat: 2
sketch.question5DownArrow.animate
	y: +30
	opacity: .5
	options:
		time: 1.5
		curve: Bezier.ease
		repeat: 2

#create displayvalue layer and state
displayValue5 = new TextLayer
	text: ''
	fontSize: 14
	fontFamily: 'Gotham'
	color: '#4AC8AC'
	x: 70
	parent: slider5.knob

displayValue5.states = 
	closed: opacity: 0
displayValue5.animationOptions = 
	time: 0.2

#when users changes the value, change display value and hide arrows
slider5.onValueChange ->
	slider5.knob.backgroundColor = '#4AC8AC'
	sketch.question5ArrowIcons.animate
		opacity: 0
		options:
			time: 0.25
	# varibles for labels
	answerHigh = 'Art'
	answerLow = 'Math'
	if Math.round(slider5.value) is -2
		displayValue5.text = 'Mostly ' + answerHigh
	else if Math.round(slider5.value) is -1
		displayValue5.text = 'More ' + answerHigh
	else if Math.round(slider5.value) is 1
		displayValue5.text = 'More ' + answerLow
	else if Math.round(slider5.value) is 2
		displayValue5.text = 'Mostly ' + answerLow
	else
		displayValue5.text = 'Neutral'

#when user starts dragging knob, show display value, and hide question5 button if displayed
slider5.knob.on Events.DragStart, ->
	displayValue5.states.switchInstant "default"
	sketch.question5ButtonActive.animate
		opacity: 0
		options: time: .25
#when user stops dragging knob, hide display value, and show question5 button
slider5.knob.on Events.DragEnd, ->
	displayValue5.states.switch "closed"
	sketch.question5ButtonActive.animate
		opacity: 1
		options: time: 0.5

# submit the current value for question5
question5ButtonActive.onClick (event, layer) ->
	question5ButtonSelected.animate
		opacity: 1
		options: 
			time: .2
	#INSERT logic to save question5 value
	questionCurrent += 1
	question5Progress.opacity = 0
	questionsFlow.showNext(question6)

#question6 select answers
#create slider6 element
slider6 = new SliderComponent
	x: 110
	y: 155
	width: 18
	height: 280
	max: 2
	min: -2
	parent: question6
slider6.knob.size = 25
slider6.knob.backgroundColor = '#B8B8B8'
slider6.backgroundColor = '#F1EDEF'
slider6.fill.backgroundColor = '#F1EDEF'
slider6.knob.shadowBlur = 0
slider6.knob.shadowX = 0
slider6.knob.shadowY = 0
slider6.knob.draggable.momentum = false

#animate arrows when user reaches the screen
sketch.question6UpArrow.animate
	y: -10
	opacity: .5
	options:
		time: 1.5
		curve: Bezier.ease
		repeat: 2
sketch.question6DownArrow.animate
	y: +30
	opacity: .5
	options:
		time: 1.5
		curve: Bezier.ease
		repeat: 2
#create displayvalue layer and state
displayValue6 = new TextLayer
	text: ''
	fontSize: 14
	fontFamily: 'Gotham'
	color: '#4AC8AC'
	x: 70
	parent: slider6.knob

displayValue6.states = 
	closed: opacity: 0
displayValue6.animationOptions = 
	time: 0.2

#when users changes the value, change display value and hide arrows
slider6.onValueChange ->
	slider6.knob.backgroundColor = '#4AC8AC'
	sketch.question6ArrowIcons.animate
		opacity: 0
		options:
			time: 0.25
	# varibles for labels
	answerHigh = 'Agree'
	answerLow = 'Disagree'
	if Math.round(slider6.value) is -2
		displayValue6.text = 'Strongly ' + answerHigh
	else if Math.round(slider6.value) is -1
		displayValue6.text = 'Somewhat ' + answerHigh
	else if Math.round(slider6.value) is 1
		displayValue6.text = 'Somewhat ' + answerLow
	else if Math.round(slider6.value) is 2
		displayValue6.text = 'Strongly ' + answerLow
	else
		displayValue6.text = 'Neutral'

#when user starts dragging knob, show display value, and hide question6 button if displayed
slider6.knob.on Events.DragStart, ->
	displayValue6.states.switchInstant "default"
	sketch.question6ButtonActive.animate
		opacity: 0
		options: time: .25
#when user stops dragging knob, hide display value, and show question6 button
slider6.knob.on Events.DragEnd, ->
	displayValue6.states.switch "closed"
	sketch.question6ButtonActive.animate
		opacity: 1
		options: time: 0.5

# submit the current value for question6
question6ButtonActive.onClick (event, layer) ->
	question6ButtonSelected.animate
		opacity: 1
		options: 
			time: .2
	#INSERT logic to save question6 value
	questionCurrent += 1
	question6Progress.opacity = 0
	questionsFlow.showNext(question7)

#question7 select answers
question7Option1Default.onClick (event, layer) ->
	question7Option1Selected.animate
		opacity: 1
		options: 
			time: .2
	#INSERT logic to save question7 Option1 answer
	questionCurrent += 1
	questionProgress4.opacity = 0
	questionsFlow.showNext(question8)

question7Option2Default.onClick (event, layer) ->
	question7Option2Selected.animate
		opacity: 1
		options: 
			time: .2
	#INSERT logic to save question7 Option2 answer
	questionCurrent += 1
	question7Progress.opacity = 0
	questionsFlow.showNext(question8)

#question8 select answers
#create slider8 element
slider8 = new SliderComponent
	x: 110
	y: 155
	width: 18
	height: 280
	max: 2
	min: -2
	parent: question8
slider8.knob.size = 25
slider8.knob.backgroundColor = '#B8B8B8'
slider8.backgroundColor = '#F1EDEF'
slider8.fill.backgroundColor = '#F1EDEF'
slider8.knob.shadowBlur = 0
slider8.knob.shadowX = 0
slider8.knob.shadowY = 0
slider8.knob.draggable.momentum = false

#animate arrows when user reaches the screen
sketch.question8UpArrow.animate
	y: -10
	opacity: .5
	options:
		time: 1.5
		curve: Bezier.ease
		repeat: 2
sketch.question8DownArrow.animate
	y: +30
	opacity: .5
	options:
		time: 1.5
		curve: Bezier.ease
		repeat: 2
#create displayvalue layer and state
displayValue8 = new TextLayer
	text: ''
	fontSize: 14
	fontFamily: 'Gotham'
	color: '#4AC8AC'
	x: 70
	parent: slider8.knob

displayValue8.states = 
	closed: opacity: 0
displayValue8.animationOptions = 
	time: 0.2

#when users changes the value, change display value and hide arrows
slider8.onValueChange ->
	slider8.knob.backgroundColor = '#4AC8AC'
	sketch.question8ArrowIcons.animate
		opacity: 0
		options:
			time: 0.25
	# varibles for labels
	answerHigh = 'Important'
	answerLow = 'Not Important'
	if Math.round(slider8.value) is -2
		displayValue8.text = 'Very ' + answerHigh
	else if Math.round(slider8.value) is -1
		displayValue8.text = 'Somewhat ' + answerHigh
	else if Math.round(slider8.value) is 1
		displayValue8.text = 'Somewhat ' + answerLow
	else if Math.round(slider8.value) is 2
		displayValue8.text = 'Very ' + answerLow
	else
		displayValue8.text = 'Neutral'

#when user starts dragging knob, show display value, and hide question8 button if displayed
slider8.knob.on Events.DragStart, ->
	displayValue8.states.switchInstant "default"
	sketch.question8ButtonActive.animate
		opacity: 0
		options: time: .25
#when user stops dragging knob, hide display value, and show question8 button
slider8.knob.on Events.DragEnd, ->
	displayValue8.states.switch "closed"
	sketch.question8ButtonActive.animate
		opacity: 1
		options: time: 0.5

# submit the current value for question8
question8ButtonActive.onClick (event, layer) ->
	question8ButtonSelected.animate
		opacity: 1
		options: 
			time: .2
	#INSERT logic to save question8 value
	questionCurrent += 1
	question8Progress.opacity = 0
	questionsFlow.showNext(question9)

#question9 select answers
#create slider9 element
slider9 = new SliderComponent
	x: 110
	y: 155
	width: 18
	height: 280
	max: 2
	min: -2
	parent: question9
slider9.knob.size = 25
slider9.knob.backgroundColor = '#B8B8B8'
slider9.backgroundColor = '#F1EDEF'
slider9.fill.backgroundColor = '#F1EDEF'
slider9.knob.shadowBlur = 0
slider9.knob.shadowX = 0
slider9.knob.shadowY = 0
slider9.knob.draggable.momentum = false

#animate arrows when user reaches the screen
sketch.question9UpArrow.animate
	y: -10
	opacity: .5
	options:
		time: 1.5
		curve: Bezier.ease
		repeat: 2
sketch.question9DownArrow.animate
	y: +30
	opacity: .5
	options:
		time: 1.5
		curve: Bezier.ease
		repeat: 2
#create displayvalue layer and state
displayValue9 = new TextLayer
	text: ''
	fontSize: 14
	fontFamily: 'Gotham'
	color: '#4AC8AC'
	x: 70
	parent: slider9.knob

displayValue9.states = 
	closed: opacity: 0
displayValue9.animationOptions = 
	time: 0.2

#when users changes the value, change display value and hide arrows
slider9.onValueChange ->
	slider9.knob.backgroundColor = '#4AC8AC'
	sketch.question9ArrowIcons.animate
		opacity: 0
		options:
			time: 0.25
	# varibles for labels
	answerHigh = 'Agree'
	answerLow = 'Disagree'
	if Math.round(slider9.value) is -2
		displayValue9.text = 'Strongly ' + answerHigh
	else if Math.round(slider9.value) is -1
		displayValue9.text = 'Somewhat ' + answerHigh
	else if Math.round(slider9.value) is 1
		displayValue9.text = 'Somewhat ' + answerLow
	else if Math.round(slider9.value) is 2
		displayValue9.text = 'Strongly ' + answerLow
	else
		displayValue9.text = 'Neutral'

#when user starts dragging knob, show display value, and hide question9 button if displayed
slider9.knob.on Events.DragStart, ->
	displayValue9.states.switchInstant "default"
	sketch.question9ButtonActive.animate
		opacity: 0
		options: time: .25
#when user stops dragging knob, hide display value, and show question9 button
slider9.knob.on Events.DragEnd, ->
	displayValue9.states.switch "closed"
	sketch.question9ButtonActive.animate
		opacity: 1
		options: time: 0.5

# submit the current value for question9
question9ButtonActive.onClick (event, layer) ->
	question9ButtonSelected.animate
		opacity: 1
		options: 
			time: .2
	#INSERT logic to save question9 value
	questionCurrent += 1
	question9Progress.opacity = 0
	questionsFlow.showNext(question10)

#question10 select answers
# Youtube IDK HOW TO MAKE THIS WORK
youtube = new YouTubePlayer
	parent: question10ContentPreview
	video: "9lVTE_bq3lw"
	x: Align.center
	width: 300
	height: 140 
	controls: 1

# when they click play...
youtube.onClick ->
	player.playVideo()
	#hide skip button, show like / dislike buttons
	sketch.question10SkipButton.opacity = 0
	print "hello"
	
#skip question don't watch video
sketch.question10SkipButton.onClick (event,layer) ->
	flow.showNext(jobCardLoading)


#Animations

# On click animation example
# sketch.skill3.onClick (event, layer) ->
# 	sketch.skill3.animate
# 		rotation: 90
# 		options:
# 			time: 1






#CREATE ACCOUNT
#Click first name
inputName = new InputModule.Input
		setup: false # Change to true when positioning the input so you can see it
		textColor: "#363435" # Color of the input text
		fontSize: 12 # Size in px
		fontFamily: "Gotham-Book"
		width: 167
		height: 27
		x: 85
		y: 267
		parent: login
#Animate
inputName.onFocus ->
	sketch.loginNameBoxDefault.animate
		opacity: 0.00
		options:
			time: .3
			curve: Bezier.ease
	sketch.loginNameBoxActive.animate
		opacity: 1
		options:
			time: .3
			curve: Bezier.ease
	sketch.loginNameTextDefault.animate
		opacity: 0.00
		options:
			time: .3
			curve: Bezier.ease
	#Turn off others when Click
	sketch.loginEmailBoxDefault.animate
		opacity: 1
		options:
			time: .3
			curve: Bezier.ease
	sketch.loginEmailBoxActive.animate
		opacity: 0
		options:
			time: .3
			curve: Bezier.ease
	sketch.loginPasswordBoxDefault.animate
		opacity: 1
		options:
			time: .3
			curve: Bezier.ease
	sketch.loginPasswordBoxActive.animate
		opacity: 0
		options:
			time: .3
			curve: Bezier.ease
	sketch.loginRetypePasswordBoxDefault.animate
		opacity: 1
		options:
			time: .3
			curve: Bezier.ease
	sketch.loginRetypePasswordBoxActive.animate
		opacity: 0
		options:
			time: .3
			curve: Bezier.ease
#Click email
inputEmail = new InputModule.Input
		setup: false # Change to true when positioning the input so you can see it
		textColor: "#363435" # Color of the input text
		fontSize: 12 # Size in px
		fontFamily: "Gotham-Book"
		width: 167
		height: 27
		x: 85
		y: 316
		parent: login
#Animate
inputEmail.onFocus ->
	sketch.loginEmailBoxDefault.animate
		opacity: 0.00
		options:
			time: .3
			curve: Bezier.ease
	sketch.loginEmailBoxActive.animate
		opacity: 1
		options:
			time: .3
			curve: Bezier.ease
	sketch.loginEmailTextDefault.animate
		opacity: 0.00
		options:
			time: .3
			curve: Bezier.ease
	#Turn off others when Click
	sketch.loginNameBoxDefault.animate
		opacity: 1
		options:
			time: .3
			curve: Bezier.ease
	sketch.loginNameBoxActive.animate
		opacity: 0
		options:
			time: .3
			curve: Bezier.ease
	sketch.loginPasswordBoxDefault.animate
		opacity: 1
		options:
			time: .3
			curve: Bezier.ease
	sketch.loginPasswordBoxActive.animate
		opacity: 0
		options:
			time: .3
			curve: Bezier.ease
	sketch.loginRetypePasswordBoxDefault.animate
		opacity: 1
		options:
			time: .3
			curve: Bezier.ease
	sketch.loginRetypePasswordBoxActive.animate
		opacity: 0
		options:
			time: .3
			curve: Bezier.ease
#Click password
inputPassword = new InputModule.Input
		setup: false # Change to true when positioning the input so you can see it
		textColor: "#363435" # Color of the input text
		fontSize: 12 # Size in px
		fontFamily: "Gotham-Book"
		type: "password"
		width: 167
		height: 27
		x: 85
		y: 367
		parent: login
#Animate
inputPassword.onFocus ->
	sketch.loginPasswordBoxDefault.animate
		opacity: 0.00
		options:
			time: .3
			curve: Bezier.ease
	sketch.loginPasswordBoxActive.animate
		opacity: 1
		options:
			time: .3
			curve: Bezier.ease
	sketch.loginPasswordTextDefault.animate
		opacity: 0.00
		options:
			time: .3
			curve: Bezier.ease
	#Turn off others when Click
	sketch.loginNameBoxDefault.animate
		opacity: 1
		options:
			time: .3
			curve: Bezier.ease
	sketch.loginNameBoxActive.animate
		opacity: 0
		options:
			time: .3
			curve: Bezier.ease
	sketch.loginEmailBoxDefault.animate
		opacity: 1
		options:
			time: .3
			curve: Bezier.ease
	sketch.loginEmailBoxActive.animate
		opacity: 0
		options:
			time: .3
			curve: Bezier.ease
	sketch.loginRetypePasswordBoxDefault.animate
		opacity: 1
		options:
			time: .3
			curve: Bezier.ease
	sketch.loginRetypePasswordBoxActive.animate
		opacity: 0
		options:
			time: .3
			curve: Bezier.ease
#Click retype password
inputRetypePassword = new InputModule.Input
		setup: false # Change to true when positioning the input so you can see it
		textColor: "#363435" # Color of the input text
		fontSize: 12 # Size in px
		fontFamily: "Gotham-Book"
		type: "password"
		width: 167
		height: 27
		x: 85
		y: 416
		parent: login
#Animate
inputRetypePassword.onFocus ->
	sketch.loginRetypePasswordBoxDefault.animate
		opacity: 0.00
		options:
			time: .3
			curve: Bezier.ease
	sketch.loginRetypePasswordBoxActive.animate
		opacity: 1
		options:
			time: .3
			curve: Bezier.ease
	sketch.loginRetypePasswordTextDefault.animate
		opacity: 0.00
		options:
			time: .3
			curve: Bezier.ease
	#Turn off others when Click
	sketch.loginEmailBoxDefault.animate
		opacity: 1
		options:
			time: .3
			curve: Bezier.ease
	sketch.loginEmailBoxActive.animate
		opacity: 0
		options:
			time: .3
			curve: Bezier.ease
	sketch.loginNameBoxDefault.animate
		opacity: 1
		options:
			time: .3
			curve: Bezier.ease
	sketch.loginNameBoxActive.animate
		opacity: 0
		options:
			time: .3
			curve: Bezier.ease
	sketch.loginPasswordBoxDefault.animate
		opacity: 1
		options:
			time: .3
			curve: Bezier.ease
	sketch.loginPasswordBoxActive.animate
		opacity: 0
		options:
			time: .3
			curve: Bezier.ease
