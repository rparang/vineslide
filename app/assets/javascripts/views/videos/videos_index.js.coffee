class Vine.Views.VideosIndex extends Backbone.View

  template: JST['videos/index']

  events:
    'submit #new_entry': 'createEntry'

  initialize: ->
    @collection.bind('add', console.log('working'), this)
    @collection.on('reset', console.log('was reset'), this)

  render: ->
  	$(@el).html(@template())
  	@collection.each(@appendVideo, this)
  	this

  appendVideo: (entry) ->
  	view = new Vine.Views.Video(model: entry)
  	this.$('#list').append(view.render().el)

  createEntry: (event) ->
    event.preventDefault()
    attributes = vine_url: $('#new_entry_url').val()
    @collection.create attributes,
      wait: true
      success: ->
        $('#new_entry_url').val('')