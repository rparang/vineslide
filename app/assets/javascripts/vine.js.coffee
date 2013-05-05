window.Vine =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: -> 
  	new Vine.Routers.Videos()
  	Backbone.history.start(pushState: true)

$(document).ready ->
  Vine.initialize()
