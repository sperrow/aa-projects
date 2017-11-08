class View {
  constructor(game, $el) {
    this.game = game;
    this.$el = $el;
    this.setupTowers();
    this.render();
    this.startIdx = null;

    $('ul').on("click", (event) => {
      let $tower = $(event.currentTarget);
      console.log($tower);
      this.clickTower($tower.data('id'));
    });
  }

  setupTowers() {
    for (let i = 0; i < 3; i++) {
      let $ul = $('<ul></ul>');
      $ul.data('id', i);
      for (let j = 0; j < 3; j++) {
        $ul.append($('<li></li>'));
      }
      this.$el.append($ul);
    }
  }

  render() {
    this.game.towers.forEach((tower, i) => {
      tower.forEach((discNum, j) => {
        let ul = this.$el.children()[i];
        let li = $(ul).children()[j];
        $(li).addClass(`disc-${discNum}`);
      });
    });
  }

  clickTower(towerIdx) {
    console.log(this.startIdx);
    if (this.startIdx === null) {
      this.startIdx = towerIdx;
    } else {
      if (!this.game.move(this.startIdx, towerIdx)) {
        alert("Invalid Move! Try again.");
      }
      this.startIdx = null;
    }
    this.render();
    console.log(this.game.towers);
  }
}

module.exports = View;
