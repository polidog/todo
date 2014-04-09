class app.TodoView extends Backbone.View

  tagName: 'li'

  template: _.template $('#item-template').html()

  events:
    'dbclick label': 'edit'
    'keypress .edit': 'updateOnEnter'
    'blur .edit': 'close'

  initialize: ->
    @listenTo @model, 'change', @render

  render: ->
    @$el.html @template @model.toJSON()
    @input = @.$('.edit')
    @

  edit: ->
    @$el.addClass 'editing'

  close: ->
    value = @$input.val().trim()

    if value
      @model.save
       title: value
    @$el.removeClass 'editing'

  updateOnEnter: (e)->
    if e.wicth eq ENTER_KEY
      @close


  

