# anison.js
# https://github.com/hdemon/anison.js
#
# Copyright (c) 2014 Masami Yonehara
# Licensed under the MIT license.

http = require 'http'
request = require 'request'
Promise = require 'bluebird'
cheerio = require 'cheerio'


class Anison
  constructor: (@title) ->

  getAnimeId: ->
    new Promise (resolve, reject) =>
      @_getSearchHtml(@title).then (searchHtmlBody) => resolve @_parseAnimeId searchHtmlBody

  _getSearchHtml: ->
    new Promise (resolve, reject) ->
      request
        url: "http://anison.info/data/n.php?q=%E3%81%8D%E3%82%93%E3%81%84%E3%82%8D%E3%83%A2%E3%82%B6%E3%82%A4%E3%82%AF&m=pro",
        headers:
          'User-Agent': 'request'
        (err, res, body) ->
          resolve body

  _parseAnimeId: (searchHtmlBody) ->
    $ = cheerio.load searchHtmlBody
    Number($(".sorted td[axis='sstring'] a").attr("href").toString().match(/\d{1,}/g)[0])


module.exports = Anison
