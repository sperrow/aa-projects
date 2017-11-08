class View {
  constructor(game, $el) {
    this.game = game;
    this.$el = $el;
    this.$el.append(this.setupBoard());
  }

  bindEvents() {
    $('ul').on('click', 'li', (event) => {
      let $li = $(event.target);
      this.makeMove($li);
    });
  }

  makeMove($square) {
    let idx = $square.data('id');
    let pos = View.positions[idx];
    let mark = this.game.currentPlayer;
    try {
      this.game.playMove(pos);
    }
    catch(err) {
      alert("Invalid move!");
      return;
    }
    $square.addClass('white');
    $square.addClass(mark);

    this.isOver();
  }

  isOver() {
    if (this.game.isOver()) {
      if (this.game.winner()) {
        let winnerMark = this.game.winner();
        let loserMark = winnerMark === 'x' ? 'o' : 'x';

        $(`.${winnerMark}`).addClass('winner');
        $(`.${loserMark}`).addClass('loser');

        let $winMessage = $(`<p>You win, ${winnerMark}!</p>`);
        this.$el.append($winMessage);
      }
    }
  }

  setupBoard() {
    let $grid = $('<ul></ul>');
    for (let i = 0; i < 9; i++) {
      let $li = $('<li></li>');
      $li.data('id', i);
      $grid.append($li);
    }
    return $grid;
  }
}

View.positions = [
  [0,0],
  [0,1],
  [0,2],
  [1,0],
  [1,1],
  [1,2],
  [2,0],
  [2,1],
  [2,2]
]

module.exports = View;
