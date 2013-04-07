# Bulk Loader
Bulk Loader is a node.js module that can load all files in a given directory with filename matching a regular expression pattern.
You can also pass a callback to be run when matching files are loaded.

## Methods
### setBasePath (path)
**path**: sets the base path where the script should start looking, this is required when loading from path other than the app root dir

### load (filepath, pattern, callback)
**filepath**: can be a file name or a path to a directory
**pattern**: regex pattern to filter the files. eg: /Model.coffee$/i
**callback**: call back will be run on each file

### loadMultiple (filepaths, pattern, callback)
**filepaths**: an array of dir (reference: loadDir.dir)
**pattern**: regex pattern to filter the files. eg: /Model.coffee$/i
**callback**: call back will be run on each file

## Expected callback signature
### callback (err, file, filename)
**err**: Error object with a message
**file**: The required file
**filename**: The filename

## How to install
```bash
$ npm install bulk-loader
```

## How to use
Let's imagine you have the follow directory structure for your project
```bash
$ ls
angular     app.js     config  node_modules  public     routes   test
app.coffee  bootstrap  models  package.json  README.md  scripts  views

$ ls models/
picturesModel.js       restaurantsModel.js       reviewsModel.js       usersModel.js
picturesSchema.js      restaurantsSchema.js      reviewsSchema.js      usersSchema.js

```
You want to load all the Model.js files in app.js and call init method
```javascript
bulkloader = require("bulk-loader")

loadModelCallback = function(err, file, filename) {
    if (err) console.log(filename + " failed to load.\n" + err)
    file.init()
}
// loading model files
bulkloader.load("models", /Model\.js$/, loadModelCallback)
```