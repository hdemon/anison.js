fs = require 'fs'
chai = require 'chai'
expect = chai.expect
should = chai.should
sinon     = require 'sinon'
sinonChai = require 'sinon-chai'
chai.use sinonChai
Song = require '../lib/song.coffee'

describe "constructor", ->
  beforeEach (done) ->
