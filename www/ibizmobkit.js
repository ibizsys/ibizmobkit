var exec = require('cordova/exec');

module.exports = {
    
    deviceId: function(success, fail) {
        cordova.exec(success, fail, 'IBizMobKit', 'getDeviceId', []);
    }
};