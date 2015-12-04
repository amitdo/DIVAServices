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
      images = iifManifestParser.getAllImages(0)
      metadata = iifManifestParser.getMetadata()
      label = iifManifestParser.getLabel()
      description = iifManifestParser.getDescription()

      console.log 'metadata: ' + metadata
      console.log 'label: ' + label
      console.log 'description: ' + description
      console.log 'license: ' + iifManifestParser.getLicense()
      console.log 'attribution: ' + iifManifestParser.getAttribution()

      cb null,{"ok": "ok"}



