chai = require('chai')
expect = chai.expect
should = chai.should()
sinon = require('sinon')
sinonChai = require('sinon-chai')

chai.use(sinonChai)

fs = require 'fs'
nock = require 'nock'
Anison = require '../lib/anison.coffee'


describe "_getAnimeId", ->
  beforeEach (done) ->
    anison = new Anison("未確認で進行形")
    anison._getAnimeId().then (id) =>
      @return = id
      done()

  it "should return html scraped by anison.info", ->
    expect(@return).to.equal 16676

describe "_getSearchHtml", ->
  beforeEach (done) ->
    @fixture = fs.readFileSync('test/fixture/search_result.html').toString()
    nock('http://anison.info')
      .get("/data/n.php?q=#{encodeURIComponent '未確認で進行形'}&m=pro")
      .reply(200, @fixture)

    anison = new Anison("未確認で進行形")
    anison._getSearchHtml().then (res) =>
      @result = res
      done()

  it "should return html scraped by anison.info", ->
    expect(@result).to.equal @fixture
