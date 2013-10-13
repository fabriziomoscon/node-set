NodeSet = require '../src/set'

describe 'set', ->

  describe 'constuctor', ->

    describe 'failures', ->

      call() for call in [null, undefined, false, -1.1, 0, false, NaN, 'prototype', {}, [], new Date, new Object].map (invalid) ->
        () ->
          it "should not accept #{invalid} as prototype", ->
            ( -> new NodeSet invalid ).should.throw 'Invalid prototype'

    describe 'success', ->

      it 'should accept a class as prototype', ->
        User = () ->
        ns = new NodeSet User
        ns._proto.should.equal User
        ns._store.should.eql []

      it 'should accept a calss string as prototype', ->
        ns = new NodeSet String
        ns._proto.should.equal String

      it 'should accept a calss number as prototype', ->
        ns = new NodeSet Number
        ns._proto.should.equal Number

# ----------------------------------------------------

  describe 'reset', ->

    it 'should reset the store', ->
      ns = new NodeSet String
      ns._store = [new String('a'), new String('b')]
      ns.reset()
      ns._store.length.should.equal 0

# ----------------------------------------------------

  describe 'add', ->

    describe 'failures', ->

      it 'should not add element of another prototype', ->
        ns = new NodeSet String
        (-> ns.add new Number 10).should.throw 'Invalid object prototype'

    describe 'success', ->

      it 'should add object of the set prototype', ->
        ns = new NodeSet String
        stringA = new String('a')
        stringB = new String('b')
        ns.add stringA
        ns.add stringB
        ns._store.should.eql [stringA, stringB]

      it 'should allow call concatenation', ->
        ns = new NodeSet String
        stringA = new String('a')
        stringB = new String('b')
        (-> ns.add(stringA).add(stringB)).should.not.throw()
        ns._store.should.eql [stringA, stringB]

      it 'should allow to add the same object', ->
        ns = new NodeSet String
        stringA = new String('a')
        ns.add stringA
        ns.add stringA
        ns.add stringA
        ns._store.should.eql [stringA, stringA, stringA]        

# --------------------------------------------------

  describe 'count', ->

    it 'should return the count of the internal array store', ->
      ns = new NodeSet String
      stringA = new String('a')
      stringB = new String('b')
      ns.add stringA
      ns.add stringB
      ns.count().should.equal 2

# -------------------------------------------------

  describe 'getData', ->

    it 'should return the internal array store', ->
      ns = new NodeSet String
      stringA = new String('a')
      stringB = new String('b')
      ns.add stringA
      ns.add stringB
      ns.getData().should.eql [stringA, stringB]

# ---------------------------------------------------

  describe 'replace', ->

    describe 'failures', ->

      call() for call in [null, undefined, false, -1.1, 0, false, NaN, '', {}, new Date, new Object, () ->].map (invalid) ->
        () ->
          it "should not accept #{invalid} as argument", ->
            ns = new NodeSet String
            ( -> ns.replace invalid ).should.throw 'Argument must be an array'

      it 'should reject arrays containing other object prototype', ->
        ns = new NodeSet String
        (-> ns.replace [new String('a'), new Number(10)]).should.throw()

    describe 'success', ->

      it 'should replace with the new array', ->
        ns = new NodeSet String
        stringA = new String('a')
        stringB = new String('b')
        ns._store = [stringA, stringB]

        stringC = new String('c')
        stringD = new String('d')
        ns.replace [stringC, stringD]
        ns._store.should.eql [stringC, stringD]
