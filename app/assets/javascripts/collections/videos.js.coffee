class Vine.Collections.Videos extends Backbone.Collection
	url: '/api/videos'
	model: Vine.Models.Video

	initialize: ->
		#Can't bind on reset event with collection

	getElement: ->
		return @currentElement

	setElement: (model) ->
		@currentElement = model

	next: ->
		@setElement(@at(@indexOf(@getElement()) + 1));
		console.log(this.indexOf(this.getElement()))
		this

	prev: ->
		@setElement(@at(@indexOf(@getElement()) - 1));
		console.log(this.indexOf(this.getElement()))
		this

	getIndex: ->
		return @indexOf(@getElement())