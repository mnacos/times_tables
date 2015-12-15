require '../src/lib/myClass.coffee'

describe "Jasmine", ->
  it "has been properly configured", ->
    obj = new MyClass
    expect(true).toBe(true)
