const Util = require("./utils");
const MovingObject = require("./moving_object");


const Asteroid = function Asteroid(options = {}) {
  options.pos = options.pos; //or random pos
  options.radius = Asteroid.RADIUS;
  options.color = Asteroid.COLOR;
  options.vel = options.vel || Util.randomVec(Asteroid.SPEED);
  // options.game = options.game;
  MovingObject.call(this, options);
};

Asteroid.COLOR = "purple";
Asteroid.RADIUS = 30;
Asteroid.SPEED = 4;

Util.inherits(Asteroid, MovingObject);

module.exports = Asteroid;
