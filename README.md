# Bulk Loader
Bulk Loader is a node.js module that can load all files in a given directory with filename matching a regular expression pattern.
You can also pass a callback to be run when matching files are loaded.

* loadDir (dir, pattern, callback)
    1. dir: can be a file name or a path to a directory
    2. pattern: regex pattern to filter the files. eg: /Model.coffee$/i
    3. callback: call back will be run on each file

* loadDirs (dirs, pattern, callback)
    1. dirs: an array of dir (reference: loadDir.dir)
    2. pattern: regex pattern to filter the files. eg: /Model.coffee$/i
    3. callback: call back will be run on each file

* callback (err, file, filename)
    1. err: Error object with a message
    2. file: The required file
    3. filename: The filename

