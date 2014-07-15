# anison.js
# https://github.com/hdemon/anison.js
#
# Copyright (c) 2014 Masami Yonehara
# Licensed under the MIT license.

request = require 'request'
Promise = require 'bluebird'
$ = require 'cheerio'
Song = require './song.coffee'

Anison = {}
Anison._getSearchHtml = (title) ->
  new Promise (resolve, reject) =>
    request
      url: "http://anison.info/data/n.php?q=#{encodeURIComponent title}&m=pro",
      headers:
        'User-Agent': 'request'
      (err, res, body) -> resolve body

Anison._parseAnimeId = (searchHtmlBody) ->
  _$ = $.load searchHtmlBody
  Number _$(".sorted td[axis='sstring'] a").attr("href").toString().match(/\d{1,}/g)[0]

Anison._getAnimeId = (title) ->
  new Promise (resolve, reject) ->
    Anison._getSearchHtml(title)
      .then(Anison._parseAnimeId)
      .then (animeId) -> resolve animeId

Anison._getSongsHtml = (animeId) ->
  new Promise (resolve, reject) ->
    request
      url: "http://anison.info/data/program/#{animeId}.html",
      headers:
        'User-Agent': 'request'
      (err, res, body) -> resolve body

Anison._parseSongsHtml = (songsHtml) ->
  array = []
  $.load(songsHtml)(".sorted tbody tr").each ->
    array.push new Song $(@)
  array

Anison.get = (title) ->
  new Promise (resolve, reject) ->
    Anison._getAnimeId(title)
      .then(Anison._getSongsHtml)
      .then(Anison._parseSongsHtml)
      .then (songs) -> resolve songs

module.exports = Anison
