const Util = require('./utils');
const MovingObject = require('./moving_object');

const Ship = function(options = {}) {
  options.vel = [0, 0];
  options.radius = Ship.RADIUS;
  options.color = Ship.COLOR;
  MovingObject.call(this, options);
};

Ship.RADIUS = 20;
Ship.COLOR = 'lightblue';

Util.inherits(Ship, MovingObject);

module.exports = Ship;
