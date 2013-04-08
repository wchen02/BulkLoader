bulkloader = require '../bulkloader'
expect = (require 'chai').expect

describe "Bulk Loader", ->
  afterEach ->
    bulkloader.setBasePath '../../'

  it 'should be included properly', ->
    expect(bulkloader).to.exist

  it 'should have default value ../../', ->
    expect(bulkloader).to.have.property 'basePath', '../../'

  it 'should set base path property', ->
    bulkloader.setBasePath __dirname
    expect(bulkloader).to.have.property 'basePath', __dirname + '/'

#  it "should load the test file from current directory", ->
#    bulkloader.setBasePath __dirname
#    bulkloader.load "load/a", null, (err, file, filename) ->
#      expect(err).to.not.exist
#      expect(file).to.exist
#      expect(filename).to.be.a('string')

  it "should load the test dir from current directory", ->
    bulkloader.setBasePath __dirname
    bulkloader.load "load", null, (err, file, filename) ->
      expect(err).to.not.exist
      expect(file).to.exist
      expect(filename).to.be.a('string')

  it "should load the test file from test dir", ->
    bulkloader.setBasePath __dirname + '/load'
    bulkloader.load 'a.js', null, (err, file, filename) ->
      expect(err).to.not.exist
      expect(file).to.exist
      expect(filename).to.be.a('string')

  it "should load the test files from test dir with regex pattern", ->
    bulkloader.setBasePath __dirname + '/load'
    bulkloader.load "./", /.*\.js$/, (err, file, filename) ->
      expect(err).to.not.exist
      expect(file).to.exist
      expect(filename).to.be.a('string')