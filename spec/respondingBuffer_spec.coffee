require '../src/lib/respondingBuffer.coffee'

describe "RespondingBuffer", ->

  it "can be instantiated", ->
    spyOn(window, 'RespondingBuffer').and.stub()
    @buffer = new RespondingBuffer('answer_to_guess')
    expect(window.RespondingBuffer).toHaveBeenCalled()

  it "maintains a string buffer you can #add to", ->
    @buffer = new RespondingBuffer('answer_to_guess')
    expect(@buffer.add 'a').toEqual 'a'
    expect(@buffer.add 'n').toEqual 'an'
    expect(@buffer.add 's').toEqual 'ans'

  it "calls you back when an answer is complete", ->
    @buffer = new RespondingBuffer('an')
    @should_not_fire = ->
    @should_fire = ->
    spyOn(this, 'should_not_fire').and.stub()
    spyOn(this, 'should_fire').and.stub()
    @buffer.add 'a', @should_not_fire
    @buffer.add 'n', @should_fire
    expect(@should_not_fire).not.toHaveBeenCalled()
    expect(@should_fire).toHaveBeenCalled()

  it "calls you back as soon as the buffer is wrong", ->
    @buffer = new RespondingBuffer('ans')
    @call_if_complete = ->
    @should_not_fire = ->
    @should_fire = ->
    spyOn(this, 'should_not_fire').and.stub()
    spyOn(this, 'should_fire').and.stub()
    @buffer.add 'a', @call_if_complete, @should_not_fire
    @buffer.add 't', @call_if_complete, @should_fire
    expect(@should_not_fire).not.toHaveBeenCalled()
    expect(@should_fire).toHaveBeenCalled()

