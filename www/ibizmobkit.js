var exec = require('cordova/exec');

module.exports = {
	/**
	 * 启动
	 * 
	 * @param success {Function} - 成功回调
	 * @param fail {Funciton} - 失败回调
	 */
	start : function(success, fail) {
		cordova.exec(success, fail, 'IBizMobKit', 'start', []);
	},
	/**
	 * 获取设备标识
	 * 
	 * @param success {Function} - 成功回调
	 * @param fail {Funciton} - 失败回调
	 */
	deviceId : function(success, fail) {
		cordova.exec(success, fail, 'IBizMobKit', 'getDeviceId', []);
	},
	/**
	 * 设备信息
	 * 
	 * @param success {Function} - 成功回调
	 * @param fail {Funciton} - 失败回调
	 */
	deviceInfo : function(success, fail) {
		cordova.exec(success, fail, 'IBizMobKit', 'getDeviceInfo', []);
	},
	/**
	 * 获取应用程序存储的值
	 * 
	 * @param key {string} - 键
	 * @param success {Function} - 成功回调
	 * @param fail {Funciton} - 失败回调
	 */
	appValue : function(key, success, fail) {
		cordova.exec(success, fail, 'IBizMobKit', 'appValue', [ key ]);
	},
	/**
	 * 设置应用程序存储的值
	 * 
	 * @param key {string} - 键
	 * @param val {string} - 值
	 * @param success {Function} - 成功回调
	 * @param fail {Funciton} - 失败回调
	 */
	setAppValue : function(key, val, success, fail) {
		cordova.exec(success, fail, 'IBizMobKit', 'setAppValue', [ key, val ]);
	},

	/**
	 * 获取用户存储的值
	 * 
	 * @param key {string} - 键
	 * @param success {Function} - 成功回调
	 * @param fail {Funciton} - 失败回调
	 */
	userValue : function(key, success, fail) {
		cordova.exec(success, fail, 'IBizMobKit', 'userValue', [ key ]);
	},
	/**
	 * 设置用户存储的值
	 * 
	 * @param key {string} - 键
	 * @param val {string} - 值
	 * @param success {Function} - 成功回调
	 * @param fail {Funciton} - 失败回调
	 */
	setUserValue : function(key, val, success, fail) {
		cordova.exec(success, fail, 'IBizMobKit', 'setUserValue', [ key, val ]);
	}
};
