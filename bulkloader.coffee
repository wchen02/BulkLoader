fs = require 'fs'
_ = require 'underscore'

# Expects pattern in /pattern/flag format
# Callback accepts one parameter, the required file
exports.loadDir = (dir, pattern, callback) ->
  files = fs.readdirSync dir

  if pattern?
    filteredFiles = _.filter files, (filename) ->
      (filename.search pattern) > 0
  else
    filteredFiles = files

  _.each filteredFiles, (filename) ->
    loadedFile = require '.' + dir + filename

    if callback?
      callback(loadedFile)

exports.loadDirs = (dirs, pattern, callback) ->
  _.each dirs, (dir) ->
    loadDir(dir, pattern, callback)

  return

