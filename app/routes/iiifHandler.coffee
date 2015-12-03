# IIIFHandler
# =======
#

# module requirements
manifesto           = require 'manifesto.js'

logger              = require '../logging/logger'
QueueHandler        = require '../processingQueue/queueHandler'
ExecutableHelper    = require '../helper/executableHelper'
Statistics          = require '../statistics/statistics'


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
    manifesto.loadManifest(req.body.iiif).then (manifest) ->
      m = manifesto.create(manifest)
      m.getSequences()
      sequence = m.getSequenceByIndex(0)
      canvases = sequence.getCanvases()
      #logger.log 'info', "canvas: " + JSON.stringify(m.getCanvases())
      #logger.log 'info', "canvases: " + canvases
      return

    cb null,{"ok"}

