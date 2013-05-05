class Vine.Routers.Videos extends Backbone.Router
	routes:
		'': 'index'
		'v/:id': 'show'

	initialize: ->
		this.setInterval(0)

	index: -> #DEPRECATE
		@collection = new Vine.Collections.Videos()
		@collection.fetch
			reset: true, #use if you want to fire with collection initialize
			success: (collection) ->
				view = new Vine.Views.VideosIndex(collection: collection)
				$('#container').html(view.render().el)
			error: (collection, response) ->
				console.log(response)

	show: (id) ->
		_this = this #Need to create new instance of 'this'
		if @getInterval() == 0 #Fetch collection only first time
			console.log("On initial")
			@collection = new Vine.Collections.Videos()
			@collection.fetch
				success: (collection) ->
					model = collection.get(id)
					view = new Vine.Views.Show({ collection: collection, model: model })
					$('#container').hide().html(view.render().el).fadeIn(2500)
					_this.setCollection(collection)
				error: (model, response) ->
					console.log(response)
		else 
			console.log("After the initial")
			@model = new Vine.Models.Video(id: id)
			@model.fetch
				success: (model) ->
					collection = _this.getCollection()
					view = new Vine.Views.Show({ collection: collection, model: model })
					$('#container').hide().html(view.render().el).fadeIn(200)
				error: (model, response) ->
					console.log(response)
		@setInterval(@getInterval() + 1)

	getInterval: ->
		return @currentInterval

	setInterval: (count) ->
		@currentInterval = count

	getCollection: ->
		return @currentCollection

	setCollection: (lot) ->
		@currentCollection = lot