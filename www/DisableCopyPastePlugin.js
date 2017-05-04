var exec = require("cordova/exec");
module.exports = {
  start: function (fnSuccess, fnError) {
    if (!fnSuccess) {
      fnSuccess = function() {};
    }
    if (!fnError) {
      fnError = function() {};
    }
    exec(fnSuccess, fnError, "DisableCopyPastePlugin", "start", []);
  },
  stop: function (fnSuccess, fnError) {
    if (!fnSuccess) {
      fnSuccess = function() {};
    }
    if (!fnError) {
      fnError = function() {};
    }
    exec(fnSuccess, fnError, "DisableCopyPastePlugin", "stop", []);
  }
};
