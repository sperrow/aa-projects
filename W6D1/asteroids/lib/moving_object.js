// const Util = require("./util");

const MovingObject = function MovingObject(options) {
  this.pos = options.pos;
  this.vel = options.vel;
  this.radius = options.radius;
  this.color = options.color;
  this.game = options.game;
};

MovingObject.prototype.draw = function(ctx) {
  ctx.fillStyle = this.color;
  ctx.beginPath();

  ctx.arc(
    this.pos[0],
    this.pos[1],
    this.radius,
    0,
    2 * Math.PI,
    false
  );

  ctx.fill();
};

MovingObject.prototype.move = function() {
  this.pos[0] += this.vel[0];
  this.pos[1] += this.vel[1];
  this.pos = this.game.wrap(this.pos);
};

MovingObject.prototype.collideWith = function(otherObject) {
  this.game.remove(this);
  this.game.remove(otherObject);
};

MovingObject.prototype.isCollidedWith = function(otherObject) {
  const dist = Math.sqrt(Math.pow(this.pos[0] - otherObject.pos[0], 2)
                       + Math.pow(this.pos[1] - otherObject.pos[1], 2));
  return dist < (this.radius + otherObject.radius);
  // return Util.distance(this, otherObject) < (this.radius + otherObject.radius);
};

module.exports = MovingObject;
