
 
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

{TextLayer} = require "TextLayer"

# Import file "Final Screens (Master @ d8bdd71)"
sketch = Framer.Importer.load("imported/Final%20Screens%20(Master%20@%20d8bdd71)@2x", scale: 1)

Utils.globalLayers(sketch)

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

#Responsive
screen_width = Framer.Device.screen.width 
screen_height = Framer.Device.screen.height

default_w = 375
default_h = 667

ratio = screen_width / default_w

Framer.Defaults.Layer.force2d = true

# Framer.Device.contentScale = ratio

all = new Layer
	width: default_w  # <-- The width will be 750 
	height: default_h # <-- The height will be 1334
	scale: ratio      # <-- The ratio we got from the equation
	originY: 0        # <-- This moves the origin of scale to top left
	y: 0              # <-- Make this layer to the top
all.centerX()       # <-- And we center the X position


# for responsiveness, may not need this
# for layer in ƒƒ()
# 	if layer.name != "all"
# 		this.parent = all

#User Profile Object
user = 
	interestsRaw: []
	interests: []
	personality: []
	drives: []
	workstyles: []
	favoriteJobs: []

# Custom Functions

convertInterests = (array) ->
	for tag in array
		if tag == "interestTagCommunityActive"
			user.interests.push("Community Service")
		if tag == "interestTagGamesActive"
			user.interests.push("Games")
		if tag == "interestTagScienceActive"
			user.interests.push("Science")
		if tag == "interestTagAnimalsActive"
			user.interests.push("Animals")
		if tag == "interestTagSpaceActive"
			user.interests.push("Space")
		if tag == "interestTagWritingActive"
			user.interests.push("Writing")
		if tag == "interestTagPoliticsActive"
			user.interests.push("Politics")
		if tag == "interestTagEntrepreneurshipActive"
			user.interests.push("Entrepreneurship")
		if tag == "interestTagDesignActive"
			user.interests.push("Design")
		if tag == "interestTagSportsActive"
			user.interests.push("Sports")
		if tag == "interestTagFashionActive"
			user.interests.push("Fashion")
		if tag == "interestTagEnvironmentalismActive"
			user.interests.push("Environmentalism")
		if tag == "interestTagHistoryActive"
			user.interests.push("History")
		if tag == "interestTagFoodActive"
			user.interests.push("Food")
		if tag == "interestTagMedicineActive"
			user.interests.push("Medicine")
		if tag == "interestTagTravelActive"
			user.interests.push("Travel")
		if tag == "interestTagTeachingActive"
			user.interests.push("Teaching")
		if tag == "interestTagEngineeringActive"
			user.interests.push("Engineering")
		if tag == "interestTagTechnologyActive"
			user.interests.push("Technology")
		if tag == "interestTagArtActive"
			user.interests.push("Art")



#Check that interests was inputted
populateInterests = ->
	initialX = 37
	initialY = 76
	lastWidth = 0
	lastHeight = 0
	if user.interests.length != 0
		for i in [0..user.interests.length-1]
			interestBg = new Layer
				backgroundColor: "4AC8AC"
				parent: sketch.profile
				borderRadius: 5
				height: 32
			interestTxt = new TextLayer
				text: user.interests[i]
				color: "#fff"
				textAlign: "center"
				fontFamily: "Gotham-Med"
				fontSize: 12 * pointScale
				parent: interestBg
				autoSize: true
				autoSizeHeight: true
				paddingTop: 9
				paddingBottom: 4
				paddingLeft: 10
				paddingRight: 10
			interestBg.x = initialX + lastWidth
			interestBg.y = initialY + lastHeight
			interestBg.width = interestTxt.width
			lastWidth = lastWidth + interestBg.width + 10
			if (interestBg.x + interestBg.width) > 333
				lastWidth = 0
				lastHeight = lastHeight + 32 + 10
				interestBg.x = initialX + lastWidth
				interestBg.y = initialY + lastHeight
				lastWidth = lastWidth + interestBg.width + 10
			if interestBg.y > 150
				interestBg.opacity = 0
				sketch.profileInterestsSeeMore.opacity = 1

#Preloader
Framer.Extras.Preloader.enable()
Framer.Extras.Preloader.addImage("images/preloader-logo.png")
Framer.Extras.Preloader.setLogo("images/preloader-logo.png")

# Default opacity
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

#Hide profile interests
for layer in ƒƒ('profileInterestsTag*')
	layer.opacity = 0

sketch.profileInterestsSeeMore.opacity = 0

pointScale = 2

#create Overarching FlowComponent
flow = new FlowComponent
# # Try this code once all screens are in the flow component
# 	parent: all
# 	width: all.width
# 	height: all.height

# Show first screen for dev
# flow.showNext(interest)

#ONBOARDING SCREENS
# create onboarding FlowComponent and add to overarching flow
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

# ####dev comment!
# flow.showNext(futures)

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
			flow.showOverlayCenter(dailyQuizFlow)
			dailyQuizFlow.showNext(questionsBackground)
			questionsFlow.showNext(question1)
			questionCurrent += 1
		else
			flow.showOverlayCenter(dailyQuizFlow)

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
	fontSize: 14 * pointScale
	fontFamily: "Gotham-Med"
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
	fontSize: 14 * pointScale
	fontFamily: "Gotham-Med"
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
	fontSize: 14 * pointScale
	fontFamily: "Gotham-Med"
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
	question7Progress.opacity = 0
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
	fontSize: 14 * pointScale
	fontFamily: "Gotham-Med"
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
	fontSize: 14 * pointScale
	fontFamily: "Gotham-Med"
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

#question10 select answers THIS NEEDS WORK EMILYYYYYY
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

jobFlow = ""
#skip question don't watch video
sketch.question10SkipButton.onClick (event,layer) ->
	
	flow.showNext(jobCardLoading)
	#wait 5 seconds to show jobscards
	Utils.delay 5, ->
		jobFlow = new FlowComponent
		flow.showNext(jobFlow)
		jobFlow.showNext(jobCardBackground)


#JobCards Flow

#creating the job card swiping
#define parameters for page and padding
pageSize = 
	width: Screen.width
	height: 548
	
padding = 15

#create page component + cards
jobCardSlider = new PageComponent
	parent: jobCardBackground
	width: pageSize.width - padding*2
	height: pageSize.height
	scrollVertical: false
	clip: false
	x: padding
	y: 98
jobCardSlider.centerX()

#create pages and cards in pages, then add to the page component
for number in [0...7]
	#create page wrapper for the cards
	page = new Layer
		size: jobCardSlider.size
		backgroundColor: "null"

	if number > 0
		page.opacity = 0.9
	
	#create cards for all the sections, except last
	if number < 6
			card = new Layer
				superLayer: page
				width: page.width - padding
				height: 548
				backgroundColor: '#FFFFFF'
				borderRadius: 7
				name: 'job' + number
			card.center()
		
	#create the job card layout
	if number > 0 
			#add the tags to every cards
			for i in [0..2]
				tagsEmpty = new Layer
					parent: card
					width: 60
					height: 20
					backgroundColor: '#F6F6F6'
					borderRadius: 3
				tagIcon = new Layer
					parent: tagsEmpty
					width: 18
					height: 18
					y: Align.center
					x: 5
				tagText = new TextLayer
					parent: tagIcon
					text: 'HIGH'
					y: 4
					x: 20
					fontFamily: 'Gotham-Book' 
					fontSize: 10 * pointScale
					color: '#656565'
					textTransform: 'uppercase'
					
					
				if i is 0
					tagsEmpty.name = 'job' + number + 'EducationCareerTag'
					tagsEmpty.x = 24
					tagsEmpty.y = 328
					tagIcon.image = 'images/tagEducationIcon.png'
					tagText.name = 'job' + number + 'EducationText'
				else if i is 1
					tagsEmpty.name = 'job' + number + 'SalaryCareerTag'
					tagsEmpty.x = 94
					tagsEmpty.y = 328
					tagIcon.image = 'images/tagSalaryIcon.png'
					tagText.name = 'job' + number + 'SalaryText'
				else 
					tagsEmpty.name = 'job' + number + 'GrowthCareerTag'
					tagsEmpty.x = 164
					tagsEmpty.y = 328
					tagIcon.image = 'images/tagGrowthIcon.png'
					tagText.name = 'job' + number + 'GrowthText'
		
			#add preview image to every card
			jobPreviewImage = new Layer
				parent: card
				name: 'job' + number + 'PreviewImage'
				width: 300
				height: 225
				x: Align.center
				y: 12
				borderRadius: 3
				image: 'images/jobPreviewImageExample.png' 
				
			#add title to every card
			jobTitle = new TextLayer
				parent: card
				name: 'job' + number + 'Title'
				fontFamily: 'Gotham-Med'
				fontSize: 28 * pointScale
				color: "black"
				width: 232
				x: 24
				y: 250
				text: "Computer Programmer" ## INSERT HERE
			
			#add job description to every card
			jobDescription = new TextLayer
				parent: card
				name: 'job' + number + 'Description'
				width: 290
				fontFamily: 'Gotham-Book'
				fontSize: 14 * pointScale
				lineHeight: 1.4
				color: '#46474A'
				x: 24
				y: 380
				text: "Develops computer software from code. They write code that allows software to run: specifying, designing, and solving problems that arise when converting programs to code."
			
			#add read more to expand arrow
			jobReadMoreButton = new Layer
				parent: card
				name: 'job' + number + 'ReadMoreButton'
				width: 110
				height: 47
				x: 108
				y: 495
				image: 'images/jobCardExpandButton.png'
			
			#add heart to favorite
			jobFavoriteHeartDefault = new Layer
				parent: card
				name: 'job' + number + 'favoriteHeartDefault'
				x: 265
				y: 261
				width: 35
				height: 29
				image: 'images/favoriteJobHeartDefault.png'
			jobFavoriteHeartSelected = new Layer
				parent: card
				name: 'job' + number + 'favoriteHeartSelected'
				x: 265
				y: 261
				width: 35
				height: 29
				image: 'images/favoriteJobHeartFilled.png'
				opacity: 0
		else #create an insight card
			# add correct icon Object
			
			#add icon
			
			
			## CREATE INSIGHT CARD HERE
			## CREATE INSIGHT CARD HERE
			
	jobCardSlider.addPage(page)

#create pagination for the cards
activeCard = new Layer
	width: 8
	height: 8
	borderRadius: 20
	parent: jobCardBackground
	backgroundColor: '#4AC8AC'
	y: 75
	x: 138

#define states for paginatino dot
activeCard.states = 
	job1: x: 138
	job2: x: 152
	job3: x: 167
	job4: x: 184
	job5: x: 200
	job6: x: 215
	job7: x: 231


#listen for  page change
jobCardSlider.on "change:currentPage",->
	current = jobCardSlider.currentPage
	previous = jobCardSlider.previousPage
	
# 	transition animations between pages
	previous.animate
		opacity: .9
		options: time: .5
	current.animate
		opacity: 1
		options: time: .5
	
	#move pagintation indicator dot to correct placement
	currentPage = jobCardSlider.horizontalPageIndex(current) + 1
	currentPage = 'job' + currentPage
	activeCard.states.switchInstant currentPage
	#show done when done swiping
	
	if currentPage is 'job7'
		jobCardBackgroundDone.opacity = 1
		backToFuturesButton = new Layer
			parent: jobCardBackground 
			name: "backToFuturesButton"
			backgroundColor: "null"
			width: 207
			height: 63
			x: 84
			y: 456
		backToFuturesButton.onClick (event, layer) ->
			flow.showNext(mainFlow)
			futuresQuestionsDone.opacity = 1
			futuresQuestions.visible = false
	else 
		jobCardBackgroundDone.opacity = 0
		for layer in Framer.CurrentContext.layers
			layer.destroy() if layer.name is "backToFuturesButton"







	


#favorite jobs

#expand job card


#CREATE ACCOUNT SCREEN
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

#SELECT INTERESTS SCREEN
#Interest tag states
for tag in ƒƒ('interestTag*Default')
	#Add states
	tag.states.add
		active: {opacity: 0}
		default: {opacity: 1}
	#Set animation options
	tag.states.animationOptions = 
		time: 0.2
	#Toggle on click
	tag.onClick ->
		this.stateCycle()

for tag in ƒƒ('interestTag*Active')
	#Add states
	tag.states.add
		active: {opacity: 1}
		default: {opacity: 0}
	#Set animation options
	tag.states.animationOptions = 
		time: 0.2
	#Toggle on click
	tag.onClick ->
		this.stateCycle()
#Save interests button
sketch.buttonSaveInterests.onClick (event, layer) ->
	#Initialize arrays and counters
	user.interestsRaw = []
	nameInterest = []
	statusInterest = []
	numInterest = 0
	count = 0
	#Collect name and status of all interests to arrays
	for tag in ƒƒ('interestTag*Active')
		statusInterest.push(tag.states.current.name)
		nameInterest.push(tag.name)
	#Check how many interests are active
	for i in statusInterest
		#If active, increment count and add to user profile
		if i == "active"
			numInterest = numInterest + 1
			user.interestsRaw.push(nameInterest[count])
		count = count + 1
	#Show warning if < 3 interests
	if numInterest < 3
		sketch.interestWarningNotification.animate
			opacity: 1
			options:
				time: .3
				curve: Bezier.ease
	#Allow user to continue if >= 3
	else
		#Convert raw interests to interests
		convertInterests(user.interestsRaw)
		#Populate interests on profile
		populateInterests()
		mainFlow = new FlowComponent
			backgroundColor: '#F8F8F8'
		flow.showNext(mainFlow)
		#assigning screen headers and navigation
		mainFlow.header = sketch.header
		mainFlow.footer = sketch.navBar
		mainFlow.showNext(futures)



