# node set

A super simple javascript implementation of `Set`. As far as this module is concerned, a `Set` is an unordered list of objects of the same type. This implementation doesn't try to substitute the new coming ES6 implementation for sets, but represents a much more simple and lightweight implementation.

Use a node set when you need a list of object of the same type.

## Installation

```bash
npm install node-set
```

## Usage

```javascript
var NodeSet = require('node-set');

// list of possible statuses => all strings
var set = new NodeSet( String );
set.add( new String('active') );
set.add( new String('inactive') );
set.add( new String('banned') );
set.add( new String('deleted') );

set.count();
// 4

set.getData();
// [ {'0': 'active'}, {'0': 'inactive'}, {'0': 'banned'}, {'0': 'deleted'} ]

set.replace( [ new String('active'), new String('inactive') ] );
// [ {'0': 'active'}, {'0': 'inactive'} ]

set.add( new Number(10) );
// TypeError thrown as `Number` is not type `String` 
```

## Development

The only dev dependency is `coffee-script` which can be installed running 'npm install' `mocha` and `should` are used in the testing suite. The coffeescript is compiled down to javascript automatically before publishing using the 'prepublish' script in 'package.json'. coffeescript files and test files are deliberately left out of the package via '.npmignore' 
because no one likes needlessly big modules.

Contributions are welcome!

## License

MIT
