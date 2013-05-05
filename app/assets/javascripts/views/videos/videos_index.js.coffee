class Vine.Views.VideosIndex extends Backbone.View

  template: JST['videos/index']

  initialize: ->
  	#console.log(@collection)

  render: ->
  	$(@el).html(@template())
  	@collection.each(@appendVideo, this)
  	this

  appendVideo: (video) ->
  	view = new Vine.Views.Video(model: video)
  	this.$('#list').append(view.render().el)