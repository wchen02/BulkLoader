// Generated by CoffeeScript 1.6.1
(function() {
  var fs, _;

  fs = require('fs');

  _ = require('underscore');

  module.exports = {
    load: function(filepath, pattern, callback) {
      return fs.stat(filepath, function(err, stats) {
        var files, filteredFiles, prefix;
        if (err || !stats.isFile() && !stats.isDirectory()) {
          return callback(new Error("File does not exist"), null, filepath);
        }
        if (stats.isFile()) {
          files = [filepath];
          prefix = '../../';
        } else {
          files = fs.readdirSync(filepath);
          prefix = '../../' + filepath;
        }
        if (pattern != null) {
          filteredFiles = _.filter(files, function(filename) {
            return (filename.search(pattern)) >= 0;
          });
        } else {
          filteredFiles = files;
        }
        _.each(filteredFiles, function(filename) {
          var fileToLoad, loadedFile;
          fileToLoad = prefix + filename;
          loadedFile = require(fileToLoad);
          if (callback != null) {
            callback(null, loadedFile, fileToLoad.substring(6));
          }
        });
      });
    },
    loadMultiple: function(filepaths, pattern, callback) {
      var that;
      that = this;
      _.each(filepaths, function(filepath) {
        that.load(filepath, pattern, callback);
      });
    }
  };

}).call(this);