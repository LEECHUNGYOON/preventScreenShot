var exec = require('cordova/exec');

exports.enable = function (enable, success, error) {
    exec(success, error, 'preventScreen', 'enable', [enable]);
};


// exports.secureMode = function(enable, successCallback, errorCallback) {
//     exec(successCallback, errorCallback, 'preventScreen', 'secureMode', [enable]);
// };