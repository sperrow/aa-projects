const Asteroid = require("./asteroid");
const Ship = require('./ship');

const Game = function Game() {
  this.asteroids = [];
  this.ship = new Ship({pos: this.randomPosition(), game: this});
  this.addAsteroids();
};

Game.DIM_X = 1000;
Game.DIM_Y = 1000;
Game.NUM_ASTEROIDS = 20;

Game.prototype.addAsteroids = function() {
  for(let i = 0; i < Game.NUM_ASTEROIDS; i++) {
    this.asteroids.push(new Asteroid({pos: this.randomPosition(), game: this}));
  }
};

Game.prototype.randomPosition = function() {
  return [Math.floor(Math.random() * Game.DIM_X), Math.floor(Math.random() * Game.DIM_Y)];
};

Game.prototype.allObjects = function() {
  return this.asteroids.concat([this.ship]);
};

Game.prototype.draw = function(ctx) {
  ctx.clearRect(0, 0, Game.DIM_X, Game.DIM_Y);
  this.allObjects().forEach(function(asteroid) {
    asteroid.draw(ctx);
  });
};

Game.prototype.moveObjects = function() {
  this.allObjects().forEach(function(obj) {
    obj.move();
  });
};

Game.prototype.wrap = function(pos) {
  return [pos[0] % Game.DIM_X, pos[1] % Game.DIM_Y];
};

Game.prototype.checkCollisions = function() {
  for(let i = 0; i < this.allObjects().length; i++) {
    for(let j = i + 1; j < this.allObjects().length; j++) {
      if (this.allObjects()[i].isCollidedWith(this.allObjects()[j])) {
        this.allObjects()[i].collideWith(this.allObjects()[j]);
      }
    }
  }
};

Game.prototype.step = function() {
  this.moveObjects();
  this.checkCollisions();
};

Game.prototype.remove = function(asteroid) {
  this.asteroids.splice(this.asteroids.indexOf(asteroid), 1);
};

module.exports = Game;
