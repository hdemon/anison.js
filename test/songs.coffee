fs = require 'fs'
chai = require 'chai'
expect = chai.expect
should = chai.should
sinon     = require 'sinon'
sinonChai = require 'sinon-chai'
chai.use sinonChai
Songs = require '../lib/songs.coffee'

describe "parse", ->
  beforeEach (done) ->
    fixtureHtml = fs.readFileSync('test/fixture/program.html')
    songs = new Songs fixtureHtml
    @array = songs.parse()
    done()

  it "should return html scraped by anison.info", ->
    expect(@array[0].category).to.equal "OP"
    expect(@array[0].title).to.equal "とまどい→レシピ"
    expect(@array[0].artists).to.equal "みかくにんぐッ!"
