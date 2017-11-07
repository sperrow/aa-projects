function sum() {
  const args = Array.from(arguments);
  return args.reduce(function(a, b) {
    return a + b;
  });
}

function sum2(...args) {
  return args.reduce(function(a, b) {
    return a + b;
  });
}

Function.prototype.myBind = function (context) {
  const args = Array.from(arguments).slice(1);
  const that = this;
  return function() {
    const callArgs = Array.from(arguments);
    return that.apply(context, args.concat(callArgs));
  };
};

Function.prototype.myBind2 = function (context, ...bindArgs) {
  return (...callArgs) => this.apply(context, bindArgs.concat(callArgs));
};

function curriedSum(numArgs) {
  const numbers = [];
  const _curriedSum = function(n) {
    numbers.push(n);
    if (numbers.length === numArgs) {
      return numbers.reduce(function(acc, num) {
        return acc + num;
      });
    } else {
      return _curriedSum;
    }
  };
  return _curriedSum;
}

Function.prototype.curry = function(numArgs) {
  const that = this;
  const args = [];
  const _curry = function(arg) {
    args.push(arg);
    if (args.length === numArgs) {
      console.log("test");
      return that.apply(that, args);
    } else {
      return _curry;
    }
  };
  return _curry;
};

Function.prototype.curry2 = function(numArgs) {
  const args = [];
  const _curry = (arg) => {
    args.push(arg);
    if (args.length === numArgs) {
      console.log("test");
      return this(...args);
    } else {
      return _curry;
    }
  };
  return _curry;
};

// console.log(sum(1, 2, 3, 4, 5));
// console.log(sum2(1, 2, 3, 4, 5));
//
// class Cat {
//   constructor(name) {
//     this.name = name;
//   }
//
//   says(sound, person) {
//     console.log(`${this.name} says ${sound} to ${person}!`);
//     return true;
//   }
// }

// const markov = new Cat("Markov");
// const breakfast = new Cat("Breakfast");
//
// markov.says("meow", "Ned");
// // Markov says meow to Ned!
// // true
//
// // bind time args are "meow" and "Kush", no call time args
// markov.says.myBind2(breakfast, "meow", "Kush")();
// // Breakfast says meow to Kush!
// // true
//
// // no bind time args (other than context), call time args are "meow" and "me"
// markov.says.myBind2(breakfast)("meow", "a tree");
// // Breakfast says meow to a tree!
// // true
//
// // bind time arg is "meow", call time arg is "Markov"
// markov.says.myBind2(breakfast, "meow")("Markov");
// // Breakfast says meow to Markov!
// // true
//
// // no bind time args (other than context), call time args are "meow" and "me"
// const notMarkovSays = markov.says.myBind2(breakfast);
// notMarkovSays("meow", "me");
// // Breakfast says meow to me!
// // true

// const cSum = curriedSum(4);
// console.log(cSum(5)(30)(20)(1)); // => 56



function sumThree(num1, num2, num3) {
  return num1 + num2 + num3;
}

sumThree(4, 20, 6); // == 30

// you'll write `Function#curry`!
let f1 = sumThree.curry2(3); // tells `f1` to wait until 3 arguments are given before running `sumThree`
f1 = f1(4); // [Function]
f1 = f1(20); // [Function]
f1 = f1(6); // = 30

// or more briefly:
console.log(sumThree.curry2(3)(4)(20)(6)); // == 30
