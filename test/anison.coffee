chai = require('chai')
expect = chai.expect
should = chai.should()
sinon = require('sinon')
sinonChai = require('sinon-chai')

chai.use(sinonChai)

fs = require 'fs'
nock = require 'nock'
Anison = require '../lib/anison.coffee'

describe "get", ->
  beforeEach (done) ->
    Anison.get("未確認で進行形").then (@returned) => done()

  it "should return html scraped by anison.info", ->
    expect(@returned[0].category).to.equal "OP"
    expect(@returned[0].title).to.equal "とまどい→レシピ"
    expect(@returned[0].artists).to.equal "みかくにんぐッ!"


describe "_getAnimeId", ->
  beforeEach (done) ->
    Anison._getAnimeId("未確認で進行形").then (@returned) => done()

  it "should return html scraped by anison.info", ->
    expect(@returned).to.equal 16676

describe "_getSearchHtml", ->
  beforeEach (done) ->
    @mock = nock('http://anison.info')
      .get("/data/n.php?q=#{encodeURIComponent '未確認で進行形'}&m=pro")
      .reply(200, @fixture)

    Anison._getSearchHtml("未確認で進行形").then (@returned) => done()

  it "should return html scraped by anison.info", ->
    @mock.done()
