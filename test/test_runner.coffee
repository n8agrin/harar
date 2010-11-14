runner = require "qunit";

dir = "/Users/n8agrin/code/lib/harar";

runner.options.coverage = false;

setup =
  code: dir + "/harar.js"
  tests: dir + "/test/test_harar.js"

runner.run setup

