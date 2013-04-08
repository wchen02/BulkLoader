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

  load: (filepath, pattern, callback) =>
    if basePath isnt '../../'
      filepath = basePath + filepath

    fs.stat filepath, (err, stats) ->
      # If file does not exist and is not a file or dir
      if err or not stats.isFile() and not stats.isDirectory()
        return callback new Error("An error occured while loading the file: #{filepath}"), null, filepath

      if stats.isFile()
        # underscore _.each expects an array
        files = [filepath]
        prefix = @basePath
      else
        files = fs.readdirSync filepath
        if filepath[filepath.length-1] isnt '/'
          filepath += '/'
        prefix = @basePath + filepath

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

  loadMultiple: (filepaths, pattern, callback) =>
    _.each filepaths, (filepath) ->
      @load filepath, pattern, callback
