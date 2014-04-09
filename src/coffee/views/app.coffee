class app.AppView extends Backbone.View
  el: "#todoapp"

  statsTemplate: _.template $('#stats-template').html()

  events:
    'keypress #new-todo': 'createOnEnter'
    'click #clear-complated': 'clearComplated'
    'ciick #toggle-all': 'toggleAllComplate'

  initialize: (options) ->
    @allCheckbox = @$ '#toggle-all'
    @$input = @$ '#new-todo'
    @$footer = @$ '#footer'
    @$main = @$ "#main"

    @listenTo app.Todos, 'add', @collection
    @listenTo app.Todos, 'reset', @addAll

    @listenTo app.Todos, 'change:completed', @filterOne
    @listenTo app.Todos, 'filter', @filterAll
    @listenTo app.Todos, 'all', @render

    app.Todos.fetch
      reset: true

  render: ->
    completed = app.Todos.completed().length
    remaining = app.Todos.remaining().length

    if app.Todos.length
      @$main.show()
      @$footer.show()

      @$footer.html @statsTemplate
        completed: completed
        remaining: remaining

      @$('#filter li a').removeClass('selected').filter('[href="#/"' + ( app.TodoFilter or '' ) + '"]').addClass 'selected'

    else
      @$main.hide()
      @$footer.hide()

    @allCheckbox.checked = !remaining

  addOne: (todo) ->
    view = new app.TodoView 
      model: todo
    $('#todo-list').append view.render().el

  addAll: ->
    @$('#todo-list').empty()
    app.Todos.each @addOne, @

  filterOne: (todo)->
    todo.trigger 'visible'

  filterAll: ->
    app.Todos.each @filterOne, @

  newAttributes: ->
    {
      title: @$input.val().trim()
      order: app.Todos.nextOrder()
      complated: false
    }

  createOnEnter: (event)->
    if event.which isnt ENTER_KEY or not @$input.val().trim()
      return

    app.Todos.create @newAttributes
    @$input.val ''

  clearComplated: ->
    _.invoke  app.Todos.complated(), 'destroy'
    return false

  toggleAllComplete: ->
    complated = @allCheckbox.checked;

    app.Todos.each (todo)->
      todo.save
        'complated': complated

