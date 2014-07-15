chai      = require('chai')
expect    = chai.expect
should    = chai.should()
sinon     = require('sinon')
sinonChai = require('sinon-chai')

chai.use(sinonChai)

fs = require 'fs'
nock = require 'nock'
Anison = require '../lib/anison.coffee'

describe "getSongs", ->
  beforeEach (done) ->
    anison = new Anison("きんいろモザイク")
    anison.getSongs().then (res) =>
      @result = res
      done()

  it "should be done successfull", ->
    fixture = fs.readFileSync('test/fixture/search_result.html')
    nock('http://anison.info/')
      .get('/data/n.php?q=%E3%81%8D%E3%82%93%E3%81%84%E3%82%8D%E3%83%A2%E3%82%B6%E3%82%A4%E3%82%AF&m=pro')
      .reply(200, fixture)

    expect(@result).to.eq fixture.toString()
