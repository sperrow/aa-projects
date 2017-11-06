

Function.prototype.inherits = function(superclass) {
  function Surrogate() {}
  Surrogate.prototype = superclass.prototype;
  this.prototype = new Surrogate();
  this.prototype.constructor = this;
};

Function.prototype.inherits2 = function(superclass) {
  this.prototype = Object.create(superclass);
  this.prototype.constructor = this;
};

function Animal() {
}

function Dog(name) {
  this.name = name;
}

Dog.inherits2(Animal);

d = new Dog("fido");
