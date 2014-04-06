app = app || {}

class app.Todo extends Backbone.Model
  defaults:
    title: ''
    completed: false

  toggle: ->
    @save
      completed: !@get 'completed'

