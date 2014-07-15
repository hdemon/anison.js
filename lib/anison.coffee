# anison.js
# https://github.com/hdemon/anison.js
#
# Copyright (c) 2014 Masami Yonehara
# Licensed under the MIT license.

http = require 'http'
request = require 'request'
Promise = require 'bluebird'


class Anison
  constructor: (@title) ->

  getSongs: ->
    new Promise (resolve, reject) ->
      request
        url: "http://anison.info/data/n.php?q=%E3%81%8D%E3%82%93%E3%81%84%E3%82%8D%E3%83%A2%E3%82%B6%E3%82%A4%E3%82%AF&m=pro",
        headers:
          'User-Agent': 'request'
        (err, res, body) ->
          resolve body

module.exports = Anison
