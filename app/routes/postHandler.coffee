# PostHandler
# =======
#
# **PostHandler** uses the [async](https://github.com/caolan/async) module
# for handling all incoming POST requests. POST requests trigger the server to execute
# the requested method. Executing a method consists of several steps:
# 1. extract the submitted image
# 2. match the recieved parameters to the requested parameters as defined in services.json
# 3. try to load the results from disk. If results are found, immediately return them
# 4. If no results found, build the command for the commmand line callback
# 5. Save the results
# 6. return the results
#
# These steps are performed using (async > waterfall)[https://github.com/caolan/async#waterfall]
# to ensure ordered execution.
#
# Copyright &copy; Marcel Würsch, GPL v3.0 licensed.

# module requirements
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
