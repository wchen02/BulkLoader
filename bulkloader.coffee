fs = require 'fs'
_ = require 'underscore'

# Expects pattern in /pattern/flag format
# Callback accepts one parameter, the required file
module.exports =
  loadDir: (dir, pattern, callback) ->
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
        callback(loadedFile, fileToLoad)
      return
    return

  loadDirs: (dirs, pattern, callback) ->
    that = this
    _.each dirs, (dir) ->
      that.loadDir(dir, pattern, callback)
      return
    return
