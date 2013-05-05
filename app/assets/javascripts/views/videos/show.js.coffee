class Vine.Views.Show extends Backbone.View

  events:
    'click #next': 'nextVideo'
    'click #prev': 'prevVideo'
    #'keypress':    'test'

  template: JST['videos/show']

  initialize: ->
    #console.log(@model)
    #console.log(this.options.collection)
    $(document).bind('keypress', this.test);

  render: ->
  	$(@el).html(@template(video: @model))
  	this

  nextVideo: (e) ->
    e.preventDefault() #Prevent Chrome bug and click event clashing
    this.options.collection.next()
    Backbone.history.navigate("v/#{this.options.collection.getElement().get('id')}", true)

  prevVideo: (e) ->
    e.preventDefault() #Prevent Chrome bug and click event clashing
    this.options.collection.prev()
    Backbone.history.navigate("v/#{this.options.collection.getElement().get('id')}", true)

  test: (e) ->
    console.log(e.keyCode)
    #console.log(this.options.collection)
    if e.keyCode == 13
      alert('hello')

    #need to unbind from window; look at console, doubles after you seek through song