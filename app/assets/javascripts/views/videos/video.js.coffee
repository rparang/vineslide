class Vine.Views.Video extends Backbone.View

	template: JST['videos/video']
	tagName: 'li'

	events:
		'click':	'showVideo'

	initialize: ->
		#console.log(@model)

	render: ->
		$(@el).html(@template(video: @model))
		this

	showVideo: ->
		Backbone.history.navigate("v/#{@model.get('id')}", true)