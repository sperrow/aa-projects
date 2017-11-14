import React from 'react';
import TodoListItem from './todo_list_item';
import TodoForm from './todo_form';
// import { receiveTodo } from '../../actions/todo_actions';

// module.exports = () => (
//   <ul>
//     {
//       this.props.todos.map((todo) => (
//         <li key={todo.id}>{todo.title}</li>
//       ))
//     }
//   </ul>
// );


class TodoList extends React.Component {
  render() {
    return (
      <div>
        <ul>
          {
            this.props.todos.map((todo) => (
              <TodoListItem
                key={todo.id}
                todo={todo}
                receiveTodo={this.props.receiveTodo}
                removeTodo={this.props.removeTodo}/>
            ))
          }
        </ul>
        <TodoForm receiveTodo={this.props.receiveTodo}/>
      </div>
    );
  }
}

export default TodoList;


//does functional components have access to props?
