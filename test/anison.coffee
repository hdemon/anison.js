chai      = require('chai')
expect    = chai.expect
should    = chai.should()
sinon     = require('sinon')
sinonChai = require('sinon-chai')

chai.use(sinonChai)

fs = require 'fs'
nock = require 'nock'
Anison = require '../lib/anison.coffee'

describe "getAnimeId", ->
  beforeEach (done) ->
    anison = new Anison("きんいろモザイク")
    anison.getAnimeId().then (id) =>
      @return = id
      done()

  it "should return html scraped by anison.info", ->
    expect(@return).to.equal 16172

describe "_getSearchHtml", ->
  beforeEach (done) ->
    anison = new Anison("きんいろモザイク")
    anison._getSearchHtml().then (res) =>
      @result = res
      done()

  it "should return html scraped by anison.info", ->
    fixture = fs.readFileSync('test/fixture/search_result.html')
    nock('http://anison.info/')
      .get('/data/n.php?q=%E3%81%8D%E3%82%93%E3%81%84%E3%82%8D%E3%83%A2%E3%82%B6%E3%82%A4%E3%82%AF&m=pro')
      .reply(200, fixture)

    expect(@result).to.equal fixture.toString()
