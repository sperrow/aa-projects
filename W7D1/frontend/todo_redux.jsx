import React from 'react';
import ReactDOM from 'react-dom';
import { configureStore } from './store/store';
import { receiveTodos, receiveTodo } from './actions/todo_actions';
import Root from './components/root';
import { allTodos } from './reducers/selectors';

document.addEventListener("DOMContentLoaded", () => {
  const content = document.getElementById('content');
  ReactDOM.render(<Root store={ configureStore } />, content);
});

window.store = configureStore;
window.receiveTodos = receiveTodos;
window.receiveTodo = receiveTodo;

window.allTodos = allTodos;
//Reminder: This is similar to Ruby's class methods. Ex. User::all but does change the
//object into arrays
