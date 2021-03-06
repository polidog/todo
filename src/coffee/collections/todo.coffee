class TodoList extends Backbone.Collection
  model: app.Todo
  localStorage: new Backbone.LocalStorage 'todo-backbone'

  # 完了済みだけ取得
  completed: ->
    @filter (todo)->
      todo.get 'completed'

  # 未了のTodo項目だけフィルタリングで返す
  remaining: ->
    @without.apply this, this.completed()

  nextOrder: ->
    unless @length
      return 1
    @last().get 'order' + 1

  comparator: (todo)->
    todo.get 'order'

app.Todos = new TodoList()