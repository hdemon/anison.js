$ = require 'cheerio'
request = require 'request'
_ = require 'lodash'
Promise = require 'bluebird'

class Song
  constructor: ($row) ->
    $td = $row.children("td")

    @category = $($td[0]).text().trim()
    @title = @_parseCell $($td[1])
    @artists = @_parseCell $($td[2])
    @songwriter = @_parseCell $($td[3])
    @composer = @_parseCell $($td[4])
    @orchestrator = @_parseCell $($td[5])

  _parseCell: ($cell) ->
    $aTags = $cell.find("a")
    if $aTags.length == 0
      $_cell = $cell
    else
      $_cell = $aTags

    if $_cell.length >= 2
      @_parseAsArray $_cell
    else
      $_cell.text()

  _parseAsArray: ($aTags) ->
    array = []
    $aTags.each -> array.push $(@).text()
    array

module.exports = Song
