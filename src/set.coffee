class NodeSet


  constructor: (prototype) ->

    throw new TypeError 'Invalid prototype' unless typeof prototype is 'function'

    @_proto = prototype
    @reset()


  reset: () ->
    @_store = []


  add: (object) ->

    throw new Error 'Invalid object prototype' unless object instanceof @_proto

    @_store.push object
    return @


  count: () ->
    @_store.length


  getData: () ->
    @_store


  replace: (arg) ->

    throw new TypeError 'Argument must be an array' unless Array.isArray arg

    @reset()

    @add element for element in arg


module.exports = NodeSet
