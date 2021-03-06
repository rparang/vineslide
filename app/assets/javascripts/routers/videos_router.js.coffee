class Vine.Routers.Videos extends Backbone.Router
	routes:
		'': 'goToShow'
		'v/:id': 'show'
		'admin': 'index'

	initialize: ->
		this.setInterval(0)

	goToShow: ->
		@collection = new Vine.Collections.Videos() #Need to optimize to call collection once
		@collection.fetch
			success: (collection) ->
				model = collection.at(0)
				Backbone.history.navigate("v/#{model.get('id')}", true)

	index: -> #DEPRECATE
		@collection = new Vine.Collections.Videos()
		@collection.fetch
			reset: true, #Use if you want to fire with collection initialize
			success: (collection) ->
				view = new Vine.Views.VideosIndex(collection: collection)
				$('#container').html(view.render().el)
			error: (collection, response) ->
				console.log(response)

	show: (id) ->
		_this = this #Need to create new instance of 'this'
		if @getInterval() == 0 #Fetch collection only first time
			@collection = new Vine.Collections.Videos()
			@collection.fetch
				success: (collection) ->
					model = collection.get(id)
					collection.setElement(collection.at(0)) #Need to set index initially
					console.log(collection.indexOf(collection.getElement()))
					view = new Vine.Views.Show({ collection: collection, model: model })
					$('#container').hide().html(view.render().el).fadeIn(750)
					_this.setCollection(collection)
				error: (model, response) ->
					console.log(response)
		else 
			@model = new Vine.Models.Video(id: id)
			@model.fetch
				success: (model) ->
					collection = _this.getCollection()
					view = new Vine.Views.Show({ collection: collection, model: model })
					$('#container').html(view.render().el)
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