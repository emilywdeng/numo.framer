# Import file "Final Screens (Master @ 92ebaad)"
sketch = Framer.Importer.load("imported/Final%20Screens%20(Master%20@%2092ebaad)@1x", scale: 1)

Utils.globalLayers(sketch)

pointScale = 1
 
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
	@font-face {
		font-family: "Gotham-Bold";
		src: url("gotham/Gotham-Bold.otf");
	}
"""

#Airtable
# Import from Airtable 
personalityData = JSON.parse Utils.domLoadDataSync "https://api.airtable.com/v0/appCZfN8YJIVjk5vJ/Personality?api_key=keydGpK7XeREMvLjd&view=Grid%20view"

interestData = JSON.parse Utils.domLoadDataSync "https://api.airtable.com/v0/appCZfN8YJIVjk5vJ/Interest?api_key=keydGpK7XeREMvLjd&view=Grid%20view"

jobData = JSON.parse Utils.domLoadDataSync "https://api.airtable.com/v0/appCZfN8YJIVjk5vJ/Jobs?api_key=keydGpK7XeREMvLjd&view=Grid%20view"

# print data.records.length 

#personality questions array 
questionText = []

# for i in [0..data.records.length-1]
# 	questionText.push(data.records[i].fields.QuestionText)

# print interestData.records[0].fields.Name

# #Responsive
# 
# # Framer.Device.customize
# # 	screenWidth: 375
# # 	screenHeight: 667
# # 	devicePixelRatio: 1
# 
# 
# # print Framer.Device
# # print Framer.Device.screen
# # 
# # print Framer.Device.screen.width
# # print Framer.Device.screen.height
# 
# screen_width = Framer.Device.screen.width
# screen_height = Framer.Device.screen.height
# 
# default_w = 375 *pointScale
# default_h = 667 *pointScale
# 
# ratio = screen_height / default_h
# # print "Ratio: " + ratio
# 
# Framer.Defaults.Layer.force2d = true
# 
# # Framer.Device.contentScale = ratio
# 
# all = new Layer
# 	width: default_w  # <-- The width will be 750 
# 	height: default_h # <-- The height will be 1334
# 	scale: 1      # <-- The ratio we got from the equation
# 	originY: 0        # <-- This moves the origin of scale to top left
# 	y: 0              # <-- Make this layer to the top
# # if Framer.Device.screen.height isnt 667* pointScale
# # all.centerX()       # <-- And we center the X position

#User Profile Object
user = 
	interestsRaw: []
	interests: []
	workstyles: []
	drives: []
	personality: []
	favorites: []
	history: []

# Workstyles Input:
# [0] Independent or Collaborative
# [1] Empathic or Logical
# [2] Detail Oriented or Big Picture

# Custom Functions

#populateInterests
#Function to dynamically display interests on profile
#Called after submitting interests
populateInterests = ->
	initialX = 37
	initialY = 76
	lastWidth = 0
	lastHeight = 0
	if user.interests.length != 0
		#Hide profile interests
		for layer in ƒƒ('profileInterestsTag*')
			layer.opacity = 0
		sketch.profileInterestsSeeMore.opacity = 0
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
				paddingTop: 9 * pointScale
				paddingBottom: 4 * pointScale
				paddingLeft: 10 / pointScale
				paddingRight: 10 / pointScale
# 				paddingLeft: 10
# 				paddingRight: 10
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

#populateWorkstyles
#Function to dynamically display workstyles on profile
#Called after completing daily questions
populateWorkstyles = ->
	if user.workstyles.length != 0
		sketch.profileWorkstylesDisabled.opacity = 0
		sketch.profileWorkstylesFilled.opacity = 1
		if user.workstyles[0] == "Independent"
			sketch.profileMeWorkstyle1Toggle.x = 50
		if user.workstyles[0] == "Collaborative"
			sketch.profileMeWorkstyle1Toggle.x = 250
		if user.workstyles[1] == "Empathic"
			sketch.profileMeWorkstyle2Toggle.x = 95
		if user.workstyles[1] == "Logical"
			sketch.profileMeWorkstyle2Toggle.x = 230
		if user.workstyles[2] == "Detail Oriented"
			sketch.profileMeWorkstyle3Toggle.x = 65
		if user.workstyles[2] == "Big Picture"
			sketch.profileMeWorkstyle3Toggle.x = 200

#populateDrives
#Function to dynamically display drives on profile
#Called after completing daily questions
populateDrives = ->
# 	print "Called populateDrives"
	if user.drives.length != 0
		sketch.profileDrivesDisabled.opacity = 0
		sketch.profileDrivesFilled.opacity = 1
		#if there is first drive
		if typeof user.drives[0] isnt 'undefined'
			sketch.profileMeDrive1NumberFilled.opacity = 1
			drive0 = sketch.profileMeDrive1Filled.convertToTextLayer()
			drive0.fontSize = drive0.fontSize * pointScale
			drive0.width = 275
			drive0.text = user.drives[0]
# 			print user.drives[0]
		#if there is second drive
		if typeof user.drives[1] isnt 'undefined'
			sketch.profileMeDrive2NumberFilled.opacity = 1
			drive1 = sketch.profileMeDrive2Filled.convertToTextLayer()
			drive1.fontSize = drive1.fontSize * pointScale
			drive1.width = 275
			drive1.text = user.drives[1]
# 			print user.drives[1]
		#if there is third drive
		if typeof user.drives[2] isnt 'undefined'
			sketch.profileMeDrive3NumberFilled.opacity = 1
			drive2 = sketch.profileMeDrive3Filled.convertToTextLayer()
			drive2.fontSize = drive2.fontSize * pointScale
			drive2.width = 275
			drive2.text = user.drives[2]
			sketch.profileMeDrivesSeeMoreFilled.opacity = 1
# 			print user.drives[2]

#populatePersonality
#Function to dynamically display personality on profile
#Called after completing personality quiz
populatePersonality = ->
	if user.personality.length != 0
		if user.personality[0]
			personality0 = sketch.profileMePersonality1Text.convertToTextLayer()
			personality0.fontSize = personality0.fontSize * pointScale
			personality0.autoSize = true
			personality0.text = user.personality[0]
			personality0.x = 32 - (personality0.width/2)
			personalityImg0 = new Layer
					parent: sketch.profile
					height: 61
					width: 61
					x: 56
					y: 727
			personalityImg0.image = getPersonalityImg(user.personality[0])
		if user.personality[1]
			personality1 = sketch.profileMePersonality2Text.convertToTextLayer()
			personality1.fontSize = personality1.fontSize * pointScale
			personality1.autoSize = true
			personality1.text = user.personality[1]
			personality1.x = 32 - (personality1.width/2)
			personalityImg1 = new Layer
					parent: sketch.profile
					height: 61
					width: 61
					x: 158
					y: 727
			personalityImg1.image = getPersonalityImg(user.personality[1])
		if user.personality[2]
			personality2 = sketch.profileMePersonality3Text.convertToTextLayer()
			personality1.fontSize = personality1.fontSize * pointScale
			personality2.autoSize = true
			personality2.text = user.personality[2]
			personality2.x = 32 - (personality2.width/2)
			personalityImg2 = new Layer
					parent: sketch.profile
					height: 61
					width: 61
					x: 260
					y: 727
			personalityImg2.image = getPersonalityImg(user.personality[2])

#populateFavJobs

favJobCards = [] #futuresFavoriteJob1
favJobCards.push(sketch.futuresFavoriteJob1)
favJobCards.push(sketch.futuresFavoriteJob2)
favJobCards.push(sketch.futuresFavoriteJob3)
favJobCards.push(sketch.futuresFavoriteJob4)
favJobCards.push(sketch.futuresFavoriteJob5)

favJobTitle = [] #profileFutureFavoriteJob1Title
favJobTitle.push(sketch.profileFutureFavoriteJob1Title)
favJobTitle.push(sketch.profileFutureFavoriteJob2Title)
favJobTitle.push(sketch.profileFutureFavoriteJob3Title)
favJobTitle.push(sketch.profileFutureFavoriteJob4Title)
favJobTitle.push(sketch.profileFutureFavoriteJob5Title)

favJobEdu = []
favJobEdu.push(sketch.profileFutureFavoriteJob1EducationLevel)
favJobEdu.push(sketch.profileFutureFavoriteJob2EducationLevel)
favJobEdu.push(sketch.profileFutureFavoriteJob3EducationLevel)
favJobEdu.push(sketch.profileFutureFavoriteJob4EducationLevel)
favJobEdu.push(sketch.profileFutureFavoriteJob5EducationLevel)

favJobSal = []
favJobSal.push(sketch.profileFutureFavoriteJob1SalaryLevel)
favJobSal.push(sketch.profileFutureFavoriteJob2SalaryLevel)
favJobSal.push(sketch.profileFutureFavoriteJob3SalaryLevel)
favJobSal.push(sketch.profileFutureFavoriteJob4SalaryLevel)
favJobSal.push(sketch.profileFutureFavoriteJob5SalaryLevel)

favJobGro = []
favJobGro.push(sketch.profileFutureFavoriteJob1GrowthLevel)
favJobGro.push(sketch.profileFutureFavoriteJob2GrowthLevel)
favJobGro.push(sketch.profileFutureFavoriteJob3GrowthLevel)
favJobGro.push(sketch.profileFutureFavoriteJob4GrowthLevel)
favJobGro.push(sketch.profileFutureFavoriteJob5GrowthLevel)

favJobImg = []
favJobImg.push(sketch.profileFutureFavoriteJob1Photo)
favJobImg.push(sketch.profileFutureFavoriteJob2Photo)
favJobImg.push(sketch.profileFutureFavoriteJob3Photo)
favJobImg.push(sketch.profileFutureFavoriteJob4Photo)
favJobImg.push(sketch.profileFutureFavoriteJob5Photo)

populateFavJobs = ->
	#check that there are favorites
	if user.favorites.length != 0
		#loop through favorites
		for i in [0..favJobCards.length-1]
			#if the i-th favorite exists
			if user.favorites[i]
				#initialize variables to store info from airtable
				fieldsJob = ""
				fieldsEduShort = ""
				fieldsSalShort = ""
				fieldsGroShort = ""
				fieldsImg = ""
				#get matching info from airtable
				for j in [0..jobData.records.length-1]
					if user.favorites[i] == jobData.records[j].fields.Job
						fieldsJob = jobData.records[j].fields.Job
						fieldsEduShort = jobData.records[j].fields.EduShort
						fieldsSalShort = jobData.records[j].fields.SalaryShort
						fieldsGroShort = jobData.records[j].fields.OutlookShort
						fieldsImg = jobData.records[j].fields.Image1[0].url
	# 			print fieldsEduShort
				#show job card
				favJobCards[i].opacity = 1
				#populate title
				jobTitle = favJobTitle[i].convertToTextLayer()
				jobTitle.fontSize = jobTitle.fontSize * pointScale
				jobTitle.text = fieldsJob
				#populate education
				jobEdu = favJobEdu[i].convertToTextLayer()
				jobEdu.fontSize = jobEdu.fontSize * pointScale
				jobEdu.text = fieldsEduShort
				#populate salary
				jobSal = favJobSal[i].convertToTextLayer()
				jobSal.fontSize = jobSal.fontSize * pointScale
				jobSal.text = fieldsSalShort
				#populate growth
				jobGro = favJobGro[i].convertToTextLayer()
				jobGro.fontSize = jobGro.fontSize * pointScale
				jobGro.text = fieldsGroShort
				#populate image
				jobImg = new Layer
					parent: favJobImg[i]
					height: 79
					width: 79
					image: fieldsImg
					borderRadius: 45.5
		

#Highlight functions
highlightInterests = ->
	sketch.profileInterestsHighlight.animate
		opacity: 1
		options:
			time: 1
			curve: Bezier.ease
	sketch.profileInterestsHighlight.animate
		opacity: 0
		options:
			time: 1
			curve: Bezier.ease
highlightWorkstyles = ->
	sketch.profileWorkstylesHighlight.animate
		opacity: 1
		options:
			time: 1
			curve: Bezier.ease
	sketch.profileWorkstylesHighlight.animate
		opacity: 0
		options:
			time: 1
			curve: Bezier.ease
highlightDrives = ->
	sketch.profileDrivesHighlight.animate
		opacity: 1
		options:
			time: 1
			curve: Bezier.ease
	sketch.profileDrivesHighlight.animate
		opacity: 0
		options:
			time: 1
			curve: Bezier.ease
		
highlightPersonality = ->
	sketch.profilePersonalityHighlight.animate
		opacity: 1
		options:
			time: 1
			curve: Bezier.ease
	sketch.profilePersonalityHighlight.animate
		opacity: 0
		options:
			time: 1
			curve: Bezier.ease

#getPersonalityImg
#Retrieve appropriate image for personality on profile
getPersonalityImg = (personality) ->
	if personality == "Doer"
		return "images/Doer.png"
	if personality == "Thinker"
		return "images/Thinker.png"
	if personality == "Creator"
		return "images/Creator.png"
	if personality == "Persuader"
		return "images/Persuader.png"
	if personality == "Helper"
		return "images/Helper.png"
	if personality == "Organizer"
		return "images/Organizer.png"

#convertInterests
# Function to translate sketch object names for interests to usable strings
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

#Preloader + Opacity
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

for layer in ƒƒ('futuresFavoriteJob*')
	layer.opacity = 0

sketch.profileInterestsSeeMore.opacity = 0

#create Overarching FlowComponent
flow = new FlowComponent
# # Try this code once all screens are in the flow component
# 	parent: all
# 	width: all.width
# 	height: all.height


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
	user.workstyles[2] = "Detail Oriented"
# 	print user.workstyles
	questionCurrent += 1
	questionProgress1.opacity = 0
	questionsFlow.showNext(question2)
	

question1Option2Default.onClick (event, layer) ->
	question1Option2Selected.animate
		opacity: 1
		options: 
			time: .2
	#INSERT logic to save question1 Option2 answer
	user.workstyles[2] = "Big Picture"
# 	print user.workstyles
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
	user.workstyles[1] = "Empathic"
# 	print user.workstyles
	questionCurrent += 1
	questionProgress2.opacity = 0
	questionsFlow.showNext(question3)

question2Option2Default.onClick (event, layer) ->
	question2Option2Selected.animate
		opacity: 1
		options: 
			time: .2
	#INSERT logic to save question2 Option2 answer
	user.workstyles[1] = "Logical"
# 	print user.workstyles
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
	if slider3.value < 0 #top
		user.workstyles[0] = "Independent"
	else #bottom
		user.workstyles[0] = "Collaborative"
# 	print user.workstyles
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
	user.workstyles[3] = "Steady"
# 	print user.workstyles
	questionCurrent += 1
	questionProgress4.opacity = 0
	questionsFlow.showNext(question5)

question4Option2Default.onClick (event, layer) ->
	question4Option2Selected.animate
		opacity: 1
		options: 
			time: .2
	#INSERT logic to save question4 Option2 answer
	user.workstyles[3] = "Fast-Paced"
# 	print user.workstyles
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
	if slider5.value < 0 #top
		user.workstyles[4] = "Creative"
	else #bottom
		user.workstyles[4] = "Linear"
# 	print user.workstyles
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
	if slider6.value < 0 #top
		user.drives.push("Power and influence")
# 	print user.drives
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
	user.drives.push("Feeling secure in future")
# 	print user.drives
	questionCurrent += 1
	question7Progress.opacity = 0
	questionsFlow.showNext(question8)

question7Option2Default.onClick (event, layer) ->
	question7Option2Selected.animate
		opacity: 1
		options: 
			time: .2
	#INSERT logic to save question7 Option2 answer
	#does nothing
# 	print user.drives
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
	if slider8.value < 0 #top
		user.drives.push("Relationships to people")
# 	print user.drives
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
	if slider9.value < 0 #top
		user.drives.push("Being creative")
# 	print user.drives
	questionCurrent += 1
	question9Progress.opacity = 0
	questionsFlow.showNext(question10)

#question10 select answers
#select interest to display
randomInterest = Utils.randomChoice(user.interests)
interestID = 0
for i in [0..interestData.records.length-1]
	if randomInterest == interestData.records[i].fields.Name
		interestID = i

#populate title
captionTitle = sketch.questionVideoContentCaptionTitle.convertToTextLayer()
captionTitle.fontSize = captionTitle.fontSize * pointScale
captionTitle.text = interestData.records[interestID].fields.Title

#populate description
captionBody = sketch.questionVideoContentCaptionBody.convertToTextLayer()
captionBody.fontSize = captionBody.fontSize * pointScale
captionBody.text = interestData.records[interestID].fields.Description

# Youtube
youtubeQ10 = new YouTubePlayer
	parent: sketch.question10ContentPreview
	video: interestData.records[interestID].fields.VideoID
# 	x: Align.center
# 	y: Align.center
	width: 303 * pointScale
	height: 140 * pointScale

# when they click play...
youtubeQ10.onClick ->
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
			scrollVertical: false
			scrollHorizontal: false
		flow.showNext(jobFlow)
		jobFlow.showNext(jobCardBackground)

flow.showNext(jobCardBackground)
#JobCards Flow
#creating the job card swiping
#create page component + cards

#define parameters for page and padding
pageSize = 
	width: Screen.width
	height: 548
	
padding = 15

#create job card slider
jobCardSlider = new PageComponent
	parent: jobCardBackground
	width: pageSize.width - padding*2
	height: pageSize.height
	scrollVertical: false
	clip: false
	x: padding
	y: 98
jobCardSlider.centerX()

jobCardsPreviewImage = []
jobCardsTitle = []
jobCardsEducationBackground = []
jobCardsEducationIcon = []
jobCardsEducationTextTag = []
jobCardsEducationTextDetailed = []
jobCardsSalaryBackground = []
jobCardsSalaryIcon = []
jobCardsSalaryTextTag = []
jobCardsSalaryTextDetailed = []
jobCardsGrowthBackground = []
jobCardsGrowthIcon = []
jobCardsGrowthTextTag = []
jobCardsGrowthTextDetailed = []
jobCardsSummaryText = []
jobCardsFavoriteHeartDefault = []
jobCardsFavoriteHeartSelected = []
jobCardsReadMoreButton = []

#create pages and cards in pages, then add to the page component
for number in [0...7]
	#create page wrapper for the cards
	page = new Layer
		name: 'page' + number
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
	jobCardSlider.addPage(page)
	#create the job card layouts + insight layouts
	#### add "number > 0 &" back in when done
	if  number < 6 
			#create original card parameters for all elements
			tagOrigHeight = 20
			tagOrigWidth = 60
			tagOrigY = 328
			tagIconOrigY = 1
			tagIconOrigX = 5
			tagEducationOrigX = 24
			tagSalaryOrigX = 94
			tagGrowthOrigX = 164
			imageOrigHeight = 225
			imageOrigWidth = 300
			imageOrigRadius = 3
			imageOrigY = 12
			titleOrigWidth = 232
			titleOrigX = 24
			titleOrigY = 250
			descriptionOrigWidth = 290
			descriptionOrigX = 24
			descriptionOrigY = 380
			heartOrigX = 265
			heartOrigY = 261
			
			#create tags
			for i in [0..2]
				tagsBackground = new Layer
					parent: card
					width: tagOrigWidth
					height: tagOrigHeight
					y: tagOrigY
					backgroundColor: '#F6F6F6'
					borderRadius: 3
				tagIcon = new Layer
					parent: tagsBackground
					width: 18
					height: 18
					y: tagIconOrigY
					x: tagIconOrigX
				tagText = new TextLayer
					parent: tagIcon
					text: 'TXT'
					y: 4
					x: 20
					fontFamily: 'Gotham-Book' 
					fontSize: 10 * pointScale
					color: '#656565'
					textTransform: 'uppercase'
				if i is 0 #create custom specs for education tag
					tagsBackground.x = tagEducationOrigX
					tagIcon.image = 'images/tagEducationIcon.png'
					jobCardsEducationTextTag.push(tagText)
					jobCardsEducationBackground.push(tagsBackground)
					jobCardsEducationIcon.push(tagIcon)
				else if i is 1 #create custom specs for salary tag
					tagsBackground.x = tagSalaryOrigX
					tagIcon.image = 'images/tagSalaryIcon.png'
					jobCardsSalaryTextTag.push(tagText)
					jobCardsSalaryBackground.push(tagsBackground)
					jobCardsSalaryIcon.push(tagIcon)
				else #create custom specs for growth tag
					tagsBackground.x = tagGrowthOrigX
					tagIcon.image = 'images/tagGrowthIcon.png'
					jobCardsGrowthTextTag.push(tagText)
					jobCardsGrowthBackground.push(tagsBackground)
					jobCardsGrowthIcon.push(tagIcon)
				
			
			
		
			#create preview images 
			jobPreviewImage = jobCardsPreviewImage[number] = new Layer
				parent: card
				width: imageOrigWidth
				height: imageOrigHeight
				x: Align.center
				y: imageOrigY
				borderRadius: imageOrigRadius
				image: 'images/jobPreviewImageExample.png' 
				
			#add title to every card
			jobTitle = jobCardsTitle[number] = new TextLayer
				parent: card
				fontFamily: 'Gotham-Med'
				fontSize: 28 * pointScale
				color: "#46474A"
				width: titleOrigWidth
				x: titleOrigX
				y: titleOrigY
				text: "Computer Placeholder" 
			
			#add job description to every card
			jobDescription= jobCardsSummaryText[number] = new TextLayer
				parent: card
				fontFamily: 'Gotham-Book'
				fontSize: 14 * pointScale
				lineHeight: 1.4
				color: '#46474A'
				width: descriptionOrigWidth
				x: descriptionOrigX
				y: descriptionOrigY
				text: "Develops computer software from code. They write code that allows software to run: specifying, designing, and solving problems that arise when converting programs to code."
			
			#add read more to expand arrow
			jobReadMoreButton = jobCardsReadMoreButton[number] = new Layer
				parent: card
				name: 'job' + number + 'ReadMoreButton'
				width: 110
				height: 47
				x: 108
				y: 495
				image: 'images/jobCardExpandButton.png'
			
			#add heart to favorite
			jobFavoriteHeartDefault = jobCardsFavoriteHeartDefault[number] = new Layer
				parent: card
				name: 'job' + number + 'favoriteHeartDefault'
				x: heartOrigX
				y: heartOrigY
				width: 35
				height: 29
				image: 'images/favoriteJobHeartDefault.png'
			jobFavoriteHeartSelected = jobCardsFavoriteHeartSelected[number] = new Layer
				parent: card
				name: 'job' + number + 'favoriteHeartSelected'
				x: heartOrigX
				y: heartOrigY
				width: 35
				height: 29
				image: 'images/favoriteJobHeartFilled.png'
				opacity: 0
			#state for selected hearts on off
			jobFavoriteHeartSelected.states = 
					selected: {opacity: 1}
					default: {opacity: 0}

		else #create an insight card
			# add correct icon Object
			
			#add icon
			
			
			## CREATE INSIGHT CARD HERE 
			## CREATE INSIGHT CARD HERE

#create states for all Backgrounds + Icons
for layer in jobCardsEducationBackground #states for education tag
	layer.states = 
		card :
			parent: card
			height: tagOrigHeight
			width: tagOrigWidth
			y: tagOrigY
			x: tagEducationOrigX
		expanded :
			height: 75
			width: 100
			y: 408
			x: 26
for layer in jobCardsEducationIcon #states for education icon
	layer.states = 
		card: 
			x: tagIconOrigX
			y: tagIconOrigY
		expanded: 
			x: 25
			y: 5
for layer in jobCardsSalaryBackground #states for salary tag
	layer.states = 
		card :
			parent: card
			height: tagOrigHeight
			width: tagOrigWidth
			y: tagOrigY
			x: tagSalaryOrigX
		expanded :
			height: 75
			width: 100
			x: 134			
			y: 408
for layer in jobCardsSalaryIcon #states for salary icon
	layer.states = 
		card: 
			x: tagIconOrigX
			y: tagIconOrigY
		expanded: 
			x: 25
			y: 5
for layer in jobCardsGrowthBackground
	layer.states = 
		card :
			parent: card
			height: tagOrigHeight
			width: tagOrigWidth
			y: tagOrigY
			x: tagGrowthOrigX
		expanded :
			height: 75
			width: 100
			x: 242
			y: 408
for layer in jobCardsGrowthIcon #states for growth icon
	layer.states = 
		card: 
			x: tagIconOrigX
			y: tagIconOrigY
		expanded: 
			x: 25
			y: 5

#emily this is how you populate the job cards
# filling out the first
jobCardsPreviewImage[1].image = Utils.randomImage()
jobCardsTitle[1].text = "Custome Title yo"
jobCardsEducationTextTag[1].text = "YO"
jobCardsSalaryTextTag[1].text = "SUP"
jobCardsGrowthTextTag[1].text = "HI"
jobCardsSummaryText[1].text = "woahhhhhhh it's a summary that's randomly generated"





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
			populateWorkstyles()
			populateDrives()
			flow.showNext(mainFlow)
			futuresQuestionsDone.opacity = 1
			futuresQuestions.visible = false
	else 
		jobCardBackgroundDone.opacity = 0
		for layer in Framer.CurrentContext.layers
			layer.destroy() if layer.name is "backToFuturesButton"

#favorite jobs

for number in [1...6]
	jobCardsFavoriteHeartSelected[number].onClick (event, layer) ->
		this.stateCycle()

# ScrollComp = new ScrollComponent
# 	parent: jobCardBackground
# 	width: Screen.width
# 	height: 0
# 	opacity: 1
# 	index: 0
# 	backgroundColor: 'null'

# cardExpandLayer = new Layer
# 	parent: jobCardBackground
# 	height: 550
# 	width: 327
# 	x: Align.center
# 	y: 100
# 	backgroundColor: 'null'	
# 	index: 4

jobExpand = new ScrollComponent
	parent: jobCardBackground
	height: 548
	width: 330
	x: Align.center
	y: 98
	opacity:0
	index: 4
# 	borderRadius: 10
	scrollHorizontal: false
jobExpand.placeBehind(jobCardSlider)
jobExpand.content.draggable.overdrag = false


#expand job card
for number in [0...6]
	jobCardsReadMoreButton[number].onClick (event,layer) ->
		#get and expand card element
		jobExpand.bringToFront()
		jobExpand.opacity = 1
		jobExpand.animate
			x: 0
			y: 0
			backgroundColor: 'white'
			opacity: 1
			height: Screen.height
			width: Screen.width
		
			 
		#get all elements and set new parent of 'jobExpand' ScrollComponent
		page = this.parent
		for child in page.subLayers
			child.parent = jobExpand.content
		#get all layers
		layerEducationTagBackground = this.parent.children[0]
		layerEducationTagIcon = this.parent.children[0].children[0]
		layerSalaryTagBackground = this.parent.children[1]
		layerSalaryTagIcon = this.parent.children[1].children[0]
		layerGrowthTagBackground = this.parent.children[2]
		layerGrowthTagIcon = this.parent.children[2].children[0]
		previewImage = this.parent.children[3]
		#expand layers to expanded state
		layerEducationTagBackground.animate("expanded")
		layerSalaryTagBackground.animate("expanded")
		layerGrowthTagBackground.animate("expanded")
		layerEducationTagIcon.animate("expanded")
		layerSalaryTagIcon.animate("expanded")
		layerGrowthTagIcon.animate("expanded")

		
		previewImage.animate
			x: 0
			y: 0
			width: Screen.width
			height:	286
			borderRadius: 0
		jobTitle = this.parent.children[4]
		jobTitle.animate
			x: 26
			y: 320
			width: 264
		description = this.parent.children[5]
		description.animate
			width: 327
			x: 26
			y: 515
		readMoreButton = this.parent.children[6]
		readMoreButton.opacity = 0
		layerFavoriteButtonDefault = this.parent.children[7]
		layerFavoriteButtonSelected = this.parent.children[8]
		layerFavoriteButtonDefault.animate
			x: 300
			y: 320
		layerFavoriteButtonSelected.animate
			x: 300
			y: 320
		gradientOverlay = new Layer #gradient for job cards
			parent: jobExpand.content
			image: 'images/pictureOverlay.png'
			width: Screen.width
			height: 61
			opacity : 1
			
		closeButton = new Layer #close btn for job cards
			parent: jobExpand.content
			image: 'images/jobClose.png'
			height: 30
			width: 30
			x: 20
			y: 20
		
		closeButton.onClick (event, layer) ->
			#add close states
			layerEducationTagBackground.animate("card")
			layerSalaryTagBackground.animate("card")
			layerGrowthTagBackground.animate("card")
			layerEducationTagIcon.animate("card")
			layerSalaryTagIcon.animate("card")
			layerGrowthTagIcon.animate("card")
		
		for i in [0...3]
			textLayer = new TextLayer
				fontSize: 20 * pointScale
				fontFamily: "Gotham-Book"
				width: 100
				color: '#46474A'
				text: ""
				textAlign: "center"
			unitText = new TextLayer
				fontSize: 12 * pointScale
				fontFamily: "Gotham-Book"
				width: 100
				color: '#46474A'
				text: ""
				textAlign: "center"
			if i is 0 # education text
				textLayer.parent = layerEducationTagBackground
				unitText.parent = layerEducationTagBackground
				textLayer.text = "6+"
				unitText.text = "years"
			else if i is 1 #salary text
				textLayer.parent = layerSalaryTagBackground
				unitText.parent = layerSalaryTagBackground
				textLayer.text = "58k"
				unitText.text = "dollars"
			else #growth text
				textLayer.parent = layerGrowthTagBackground	
				unitText.parent = layerGrowthTagBackground
				textLayer.text = "+10-14"
				unitText.text = "percent"
			textLayer.y = 30
			unitText.y = 55
			
			
			
			
			
			




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
