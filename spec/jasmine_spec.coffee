require '../src/lib/myClass.coffee'

describe "Jasmine", ->
  it "has been properly configured", ->
    obj = new MyClass
    expect(true).toBe(true)

  it "has got access to jasmine-ajax/mock-ajax.js", ->
    jasmine.Ajax.install()
    data_from_service = null

    request = new XMLHttpRequest()
    request.open 'GET', 'https://api.someservice.com/v2/model', true
    request.onload = ->
      if request.status >= 200 && request.status < 400
        data_from_service = JSON.parse request.responseText
    request.send()

    # you won't have the request... request = jasmine.Ajax.requests.mostRecent()
    request.respondWith(AjaxResponses.some_service.some_call.success)
    expect(data_from_service.result).toBe('ok')
