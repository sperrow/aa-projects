const View = require('./ttt-view');// require appropriate file
const Game = require('../solution/game');// require appropriate file

$( () => {
  // Your code here
  const game = new Game();
  const view = new View(game, $('.ttt'));
  view.bindEvents();
});
