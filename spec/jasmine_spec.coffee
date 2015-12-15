require '../src/lib/myClass.coffee'

describe "Jasmine", ->
  it "has been properly configured", ->
    obj = MyClass.new
    expect(true).toBe(true)
