fs = require 'fs'
_ = require 'underscore'

# Expects pattern in /pattern/flag format
# Callback takes 3 params: err, loadedFile, filename
module.exports =
  basePath: '../../'

  setBasePath: (path) ->
    if path[path.length-1] isnt '/'
      path += '/'
    @basePath = path
    return

  load: (filepath, pattern = '', callback) ->
    filepath = @basePath + filepath

    fs.stat filepath, (err, stats) ->
      # If file does not exist and is not a file or dir
      if err || !stats.isFile() && !stats.isDirectory()
        return callback new Error("File does not exist"), null, filepath

      if stats.isFile()
        # underscore _.each expects an array
        files = [filepath]
      else
        files = fs.readdirSync filepath
        if filepath[filepath.length-1] isnt '/'
          filepath += '/'

      filteredFiles = _.filter files, (filename) ->
        (filename.search pattern) >= 0

      fileToLoad = loadedFile = ''
      if filteredFiles.length == 1
        fileToLoad = filepath
        loadedFile = require fileToLoad
      else
        _.each filteredFiles, (filename) ->
          fileToLoad = filepath + filename
          loadedFile = require fileToLoad

        if callback?
          callback(null, loadedFile, fileToLoad.substring(6))
        return
      return

  loadMultiple: (filepaths, pattern = '', callback) ->
    that = this
    _.each filepaths, (filepath) ->
      that.load filepath, pattern, callback
      return
    return