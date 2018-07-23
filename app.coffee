# Import file "Final Screens (Master @ ecd9222)"
sketch = Framer.Importer.load("imported/Final%20Screens%20(Master%20@%20ecd9222)@2x", scale: 1)


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

####################################
##MAIN FUTURE / PROFILE SECTION

#custom transtions between futures and me
mainNavTransition = (nav, layerA, layerB) ->
	transition = 
		layerA: 
			show: 
				scale:1.0
				opacity: 1
			hide: 
					scale: 0.5
					opacity: 0 
		layerB: 
			show: 
				scale:1.0
				opacity: 1
			hide: 
					scale: 0.5
					opacity: 0 
				

#assign states to the button styles
for layer in ƒƒ('navButton*')
	layer.states = 
		inactive: opacity: 0.5
		active: opacity: 1

#default nav me to inactive
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




#Switch screens on click example
# layerA.onClick ->
# 	flow.showNext(layerB)

#Animations

# On click animation example
# sketch.skill3.onClick (event, layer) ->
# 	sketch.skill3.animate
# 		rotation: 90
# 		options:
# 			time: 1


# Youtube 
# youtube = new YouTubePlayer
# 	parent: sketch.questionVideoVideo
# 	video: "g4a7_HH9Wbg"
# 	width: 286
# 	height: 140
# 	controls: 1
# 
# youtube.onClick ->
# 	player.playVideo()


#Onboarding Swipe Cards

# Swipe through cards

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
