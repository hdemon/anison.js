(function() {
  var $, Promise, Song, request, _;

  $ = require('cheerio');

  request = require('request');

  _ = require('lodash');

  Promise = require('bluebird');

  Song = (function() {
    function Song($row) {
      var $td;
      $td = $row.children("td");
      this.category = $($td[0]).text().trim();
      this.title = this._parseCell($($td[1]));
      this.artists = this._parseCell($($td[2]));
      this.songwriter = this._parseCell($($td[3]));
      this.composer = this._parseCell($($td[4]));
      this.orchestrator = this._parseCell($($td[5]));
    }

    Song.prototype._parseCell = function($cell) {
      var $_cell, $aTags;
      $aTags = $cell.find("a");
      if ($aTags.length === 0) {
        $_cell = $cell;
      } else {
        $_cell = $aTags;
      }
      if ($_cell.length >= 2) {
        return this._parseAsArray($_cell);
      } else {
        return $_cell.text();
      }
    };

    Song.prototype._parseAsArray = function($aTags) {
      var array;
      array = [];
      $aTags.each(function() {
        return array.push($(this).text());
      });
      return array;
    };

    return Song;

  })();

  module.exports = Song;

}).call(this);
