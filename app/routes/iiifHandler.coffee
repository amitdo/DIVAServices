# IIIFHandler
# =======
#

# module requirements

logger              = require '../logging/logger'
QueueHandler        = require '../processingQueue/queueHandler'
ExecutableHelper    = require '../helper/executableHelper'
Statistics          = require '../statistics/statistics'
IiifManifestParser  = require '../parsers/iiifManifestParser'

#Expose postHandler
iiifHandler = exports = module.exports = class IiifHandler

  constructor: () ->
    @queueHandler = new QueueHandler()
    @executableHelper = new ExecutableHelper()

# ---
# **handleRequest**</br>
# Handle incoming POST requests</br>
# `params`
#   *req* the incoming request
  handleRequest: (req, cb) ->
    #print stats about the manifest
    iifManifestParser = new IiifManifestParser(req.body.iiif)
    iifManifestParser.initialize().then ->
      console.log 'hello'
      images = iifManifestParser.getAllImages(0)
      console.log images



