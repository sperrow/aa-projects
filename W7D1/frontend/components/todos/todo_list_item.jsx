import React from 'react';
import merge from 'lodash/merge';

class TodoListItem extends React.Component {
  handleDeleteClick(e) {
    this.props.removeTodo(this.props.todo);
  }

  handleChangeClick(e) {
    const cloneTodo = merge({}, this.props.todo);
    cloneTodo.done = !cloneTodo.done;
    this.props.receiveTodo(cloneTodo);
    console.log(this.props.todo.done);
  }


  todoStatus() {
    return (this.props.todo.done) ? "Undo" : "Done";
  }

  render() {
    return (
      <li>{this.props.todo.title}
        <button onClick={(e) => this.handleDeleteClick(e)} type='button'>Delete me!</button>
        <button onClick={(e) => this.handleChangeClick(e)}>{ this.todoStatus() }</button>
      </li>

    );
  }
}

export default TodoListItem;
