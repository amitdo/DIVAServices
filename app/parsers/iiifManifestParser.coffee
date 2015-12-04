iifManifestParser = exports = module.exports = class IiifManifestParser

  manifesto = require 'manifesto.js'

  constructor: (manifestUrl) ->
    self = @
    manifesto.loadManifest(manifestUrl).then (manifest) ->
      self.manifest = manifesto.create(manifest)
      #already evaluate the sequences as we will need them anyways
      self.manifest.getSequences()

  getAllImages: (seqIndex) ->
    images = []
    sequence = @manifest.getSequenceByIndex(seqIndex)
    canvases = sequence.getCanvases()
    for canvas in canvases
      images.push(canvas.getImages()[0].getResource().id)

    return images
