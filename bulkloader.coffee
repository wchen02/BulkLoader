fs = require 'fs'
_ = require 'underscore'

loadFile = (filename, pattern, callback) ->
  fs.stat filename, (err, stats) ->
    if err || !stats.isFile()
      filename = fileToLoad.substring(6) if filename is '../../'
      return callback new Error("An error occured while tring to require: " + filename), null, filename

    if (filename.search pattern) >= 0
      loadedFile = require filename

      if callback?
        filename = fileToLoad.substring(6) if filename is '../../'
        callback(null, loadedFile, filename)
    return

loadDir = (filedir, pattern, callback) ->
  filenames = fs.readdir filedir
  _.each filenames, (filename) ->
    @loadFile(filename, pattern, callback)

# Expects pattern in /pattern/flag format
# Callback takes 3 params: err, loadedFile, filename
module.exports =
  basePath: '../../'

  setBasePath: (path) ->
    if path[path.length-1] isnt '/'
      path += '/'
    @basePath = path
    return

  load: (filepaths, pattern, callback) ->
    filepaths = [].concat filepaths
    that = this
    _.each filepaths, (filepath) ->
      if filepath[0] != '/'
        filepath = that.basePath + filepath

      fs.stat filepath, (err, stats) ->
        if err
          filepath = filepath.substring(6) if filepath is '../../'
          return callback new Error("An error occured while tring to require: " + filepath), null, filepath
        if stats.isFile()
          loadFile(filepath, pattern, callback)
        if stats.isDirectory()
          loadDir(filepath, pattern, callback)