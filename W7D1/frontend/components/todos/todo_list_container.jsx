import React from 'react';
import { connect } from 'react-redux';
import TodoList from './todo_list';

// Actions
import { receiveTodos, receiveTodo, removeTodo } from '../../actions/todo_actions';
import { allTodos } from '../../reducers/selectors';

const mapStateToProps = state => ({
  todos: allTodos(state)
  //the selector file is going to slice only the relevant attributes state.todos
});

const mapDispatchToProps = dispatch => ({
  receiveTodo: (todo) => dispatch(receiveTodo(todo)),
  removeTodo: (todo) => dispatch(removeTodo(todo))
});


export default connect(mapStateToProps, mapDispatchToProps)(TodoList);
//<TodoList todos={ allTodos(state) } receiveTodo={dispatch(receiveTodo(todo))} >
//this file configures the TodoList
//connect method has access to state and dispatch
//connect will pass mapStateToProps and mapDispatchToProps as props to whatever class
//is listed on todo_list.jsx
