# Bulk Loader
Bulk Loader is a node.js module that can load all files in a given directory with filename matching a regular expression pattern.
You can also pass a callback to be run when matching files are loaded.

## Methods
* setBasePath (path)
    1. path, sets the base path where the script should start looking, this is required when loading from path other than the app root dir

* load (filepath, pattern, callback)
    1. filepath: can be a file name or a path to a directory
    2. pattern: regex pattern to filter the files. eg: /Model.coffee$/i
    3. callback: call back will be run on each file

* loadMultiple (filepaths, pattern, callback)
    1. filepaths: an array of dir (reference: loadDir.dir)
    2. pattern: regex pattern to filter the files. eg: /Model.coffee$/i
    3. callback: call back will be run on each file

## Expected callback signature
* callback (err, file, filename)
    1. err: Error object with a message
    2. file: The required file
    3. filename: The filename

## How to install
```bash
$ npm install bulk-loader
```