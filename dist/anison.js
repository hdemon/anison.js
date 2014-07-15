(function() {
  var $, Anison, Promise, Song, request;

  request = require('request');

  Promise = require('bluebird');

  $ = require('cheerio');

  Song = require('./song.coffee');

  Anison = {};

  Anison._getSearchHtml = function(title) {
    var _this = this;
    return new Promise(function(resolve, reject) {
      return request({
        url: "http://anison.info/data/n.php?q=" + (encodeURIComponent(title)) + "&m=pro",
        headers: {
          'User-Agent': 'request'
        }
      }, function(err, res, body) {
        return resolve(body);
      });
    });
  };

  Anison._parseAnimeId = function(searchHtmlBody) {
    var _$;
    _$ = $.load(searchHtmlBody);
    return Number(_$(".sorted td[axis='sstring'] a").attr("href").toString().match(/\d{1,}/g)[0]);
  };

  Anison._getAnimeId = function(title) {
    return new Promise(function(resolve, reject) {
      return Anison._getSearchHtml(title).then(Anison._parseAnimeId).then(function(animeId) {
        return resolve(animeId);
      });
    });
  };

  Anison._getSongsHtml = function(animeId) {
    return new Promise(function(resolve, reject) {
      return request({
        url: "http://anison.info/data/program/" + animeId + ".html",
        headers: {
          'User-Agent': 'request'
        }
      }, function(err, res, body) {
        return resolve(body);
      });
    });
  };

  Anison._parseSongsHtml = function(songsHtml) {
    var array;
    array = [];
    $.load(songsHtml)(".sorted tbody tr").each(function() {
      return array.push(new Song($(this)));
    });
    return array;
  };

  Anison.get = function(title) {
    return new Promise(function(resolve, reject) {
      return Anison._getAnimeId(title).then(Anison._getSongsHtml).then(Anison._parseSongsHtml).then(function(songs) {
        return resolve(songs);
      });
    });
  };

  module.exports = Anison;

}).call(this);
