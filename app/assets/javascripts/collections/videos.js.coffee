class Vine.Collections.Videos extends Backbone.Collection
	url: '/api/videos'
	model: Vine.Models.Video

	initialize: ->
		this.on("reset", @initializeElement, this) #Need to wait after fetch has loaded to set

	initializeElement: ->
		this.setElement(@at(0))

	getElement: ->
		return @currentElement

	setElement: (model) ->
		@currentElement = model

	next: ->
		@setElement(@at(@indexOf(@getElement()) + 1));
		this

	prev: ->
		@setElement(@at(@indexOf(@getElement()) - 1));
		this