require '../src/lib/myClass.coffee'

describe "Jasmine", ->
  it "has been properly configured", ->
    obj = new MyClass
    expect(true).toBe(true)

  it "has got access to jasmine-ajax/mock-ajax.js", ->
    jasmine.Ajax.install()
    expect(true).toBe(true)
