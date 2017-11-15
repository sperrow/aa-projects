import React from 'react';
// Components
import TodoListItem from './todo_list_item';
import TodoForm from './todo_form';

class TodoList extends React.Component {

  componentDidMount() {
    this.props.fetchTodos();
  }

  render() {
    const { todos, createTodo, errors, updateTodo } = this.props;
    const todoItems = todos.map(todo => (
        <TodoListItem
          key={`todo-list-item${todo.id}`}
          todo={todo}
          updateTodo={ updateTodo } />
      )
    );

    return(
      <div>
        <ul className="todo-list">
          { todoItems }
        </ul>
        <TodoForm errors={ errors } createTodo={ createTodo }/>
      </div>
    );
  }
}

export default TodoList;
