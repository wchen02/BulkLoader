fs = require 'fs'
_ = require 'underscore'

# Expects pattern in /pattern/flag format
# Callback takes 3 params: err, loadedFile, filename
module.exports =
  loadDir: (dir, pattern, callback) ->
    fs.exists dir, (exists) ->
      # If file does not exist and is not a file or dir
      if !exists
        return callback new Error("File does not exist"), null, dir

      files = fs.readdirSync dir

      if pattern?
        filteredFiles = _.filter files, (filename) ->
          (filename.search pattern) >= 0
      else
        filteredFiles = files

      _.each filteredFiles, (filename) ->
        fileToLoad = '.' + dir + filename
        loadedFile = require fileToLoad

        if callback?
          callback(null, loadedFile, fileToLoad)
        return
      return

  loadDirs: (dirs, pattern, callback) ->
    that = this
    _.each dirs, (dir) ->
      that.loadDir(dir, pattern, callback)
      return
    return
