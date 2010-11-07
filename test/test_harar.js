(function() {
  var TestHarar, assert, harar, shoulda, sys;
  var __extends = function(child, parent) {
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    if (typeof parent.extended === "function") parent.extended(child);
    child.__super__ = parent.prototype;
  };
  assert = require('assert');
  harar = require('../harar');
  sys = require('sys');
  shoulda = require('./shoulda');
  TestHarar = (function() {
    function TestHarar() {
      return this;
    };
    return TestHarar;
  })();
  __extends(TestHarar, shoulda.Shoulda);
}).call(this);
