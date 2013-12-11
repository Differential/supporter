Supporter = require('../lib/supporter.coffee')
assert = require('assert')

expected = 1
actual = Supporter.computeScore({stars: 1})
assert.equal(expected, actual)

console.log "All tests pass."
