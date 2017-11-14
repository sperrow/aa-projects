

export const allTodos = (state) => {
  return Object.keys(state.todos).map((keyID) => {
    return state.todos[keyID];
  });
};
