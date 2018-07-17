#Sketch Import
# Import file "FutureFinder-Squarespace"
sketch = Framer.Importer.load("imported/FutureFinder-Squarespace@2x", scale: 1)

Utils.globalLayers(sketch)

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

# FlowComponent
# Create FlowComponent, show layerA 
flow = new FlowComponent
flow.showNext(ResultsProfile)


sketch.skill3.onClick (event, layer) ->
	sketch.skill3.animate
		rotation: 90
		options:
			time: 1
			
	



