# Import file "Final Screens (Master @ f70c64e)"
sketch = Framer.Importer.load("imported/Final%20Screens%20(Master%20@%20f70c64e)@2x", scale: 1)


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
		font-family: "Gotham";
		src: url("gotham/Gotham-Medium.otf");
	}
"""

#Airtable
# Import from Airtable 
data = JSON.parse Utils.domLoadDataSync "https://api.airtable.com/v0/appCZfN8YJIVjk5vJ/Personality?api_key=keydGpK7XeREMvLjd&view=Grid%20view"

# print data.records.length 

#personality questions array 
questionText = []

for i in [0..data.records.length-1]
	questionText.push(data.records[i].fields.QuestionText)

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


# FlowComponent

# Create FlowComponent
flow = new FlowComponent
flow.showNext(onboarding)

sketch.onboardingButtonCreateAccount.onClick (event, layer) ->
	flow.showNext(login)

sketch.onboardingButtonSignIn.onClick (event, layer) ->
	flow.showNext(login)

sketch.login.onSwipeRight (event, layer) ->
	flow.showPrevious()

#Create PageComponent
page = new PageComponent
	parent: onboarding
	scrollVertical: false
	x: Align.center
	y: Align.top
	width: Screen.width
	height: 466

# page.animationOptions =
#    curve: "spring(100,10,0)"
#    time: 0.25

sketch.onboardingGraphic1.parent = page.content

page.addPage(onboardingGraphic2, "right")
page.addPage(onboardingGraphic3, "right")
page.addPage(onboardingGraphic4, "right")
page.addPage(onboardingGraphic5, "right")


# 
# sketch.onboarding1.onSwipeLeft (event, layer) ->
# 	flow.showNext(onboarding2)
# 
# sketch.onboarding2.onSwipeLeft (event, layer) ->
# 	flow.showNext(onboarding3)
# 
# sketch.onboarding3.onSwipeLeft (event, layer) ->
# 	flow.showNext(onboarding4)
# 
# sketch.onboarding4.onSwipeLeft (event, layer) ->
# 	flow.showNext(login)
# 
# sketch.onboarding1.onSwipeRight (event, layer) ->
# 	flow.showPrevious()
# 
# sketch.onboarding2.onSwipeRight (event, layer) ->
# 	flow.showPrevious()
# 
# sketch.onboarding3.onSwipeRight (event, layer) ->
# 	flow.showPrevious()
# 
# sketch.onboarding4.onSwipeRight (event, layer) ->
# 	flow.showPrevious()
# 

# Set opacity to default hidden

for layer in ƒƒ('*Filled')
	layer.opacity = 0

for layer in ƒƒ('*Active')
	layer.opacity = 0

# sketch.onboarding0CreateAccount1.onClick (event, layer) ->
# 	flow.showNext(login)

# onboarding0.onClick ->
# 	flow.showNext(onboarding1)




# for i in [0..onboarding.length-1]
# 	print onboarding[i]
# 	onboarding[i].onClick ->
# 		if i < 4
# 			flow.showNext(onboarding[i+1])
# 		else
# 			flow.showNext(onboarding4)

# Switch screens on click example
# layerA.onClick ->
# 	flow.showNext(layerB)

# ResultsProfile.onClick ->
# 	flow.showNext(Feed)
# 
# article1.onClick ->
# 	flow.showNext(Expand)
# 
# Expand.onClick ->
# 	flow.showPrevious()




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


