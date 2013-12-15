Supporter = require('../lib/supporter.coffee')
assert = require('assert')

expected = 0.8122523963562355
actual = Supporter.computeScore
  starCount: 2
  createdAt: new Date()
assert.equal(expected, actual)

console.log "All tests pass."
