fs = require 'fs'
_ = require 'underscore'

# Expects pattern in /pattern/flag format
# Callback takes 3 params: err, loadedFile, filename
module.exports =
  load: (filepath, pattern, callback) ->
    fs.stat filepath, (err, stats) ->
      # If file does not exist and is not a file or dir
      if err || !stats.isFile() && !stats.isDirectory()
        return callback new Error("File does not exist"), null, filepath

      if stats.isFile()
        files = [filepath]
        prefix = '../../'
      else
        files = fs.readdirSync filepath
        prefix = '../../' + filepath

      if pattern?
        filteredFiles = _.filter files, (filename) ->
          (filename.search pattern) >= 0
      else
        filteredFiles = files

      _.each filteredFiles, (filename) ->
        fileToLoad = prefix + filename
        loadedFile = require fileToLoad

        if callback?
          callback(null, loadedFile, fileToLoad.substring(6))
        return
      return

  loadMultiple: (filepaths, pattern, callback) ->
    that = this
    _.each filepaths, (filepath) ->
      that.load filepath, pattern, callback
      return
    return