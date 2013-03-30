fs = require 'fs'
_ = require 'underscore'

# Expects pattern in /pattern/flag format
# Callback takes 3 params: err, loadedFile, filename
module.exports =
  loadDir: (dir, pattern, callback) ->
    fs.stat dir, (err, stats) ->
      # If file does not exist and is not a file or dir
      if err || !stats.isFile() && !stats.isDirectory()
        return callback new Error("File does not exist"), null, dir

      if stats.isFile()
        files = [dir]
        prefix = '../../'
      else
        files = fs.readdirSync dir
        prefix = '../../' + dir

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

  loadDirs: (dirs, pattern, callback) ->
    that = this
    _.each dirs, (dir) ->
      that.loadDir(dir, pattern, callback)
      return
    return