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
postHandler = exports = module.exports = class PostHandler

  constructor: () ->
    @queueHandler = new QueueHandler()
    @executableHelper = new ExecutableHelper()

# ---
# **handleRequest**</br>
# Handle incoming POST requests</br>
# `params`
#   *req* the incoming request
  handleRequest: (req, cb) ->
#If mean-execution time < 60s directly execute
    if (Statistics.getMeanExecutionTime(req.originalUrl) < 60)
      @queueHandler.executeRequestImmediately(req,cb)
    else
      @queueHandler.addRequestToQueue(req,cb)
