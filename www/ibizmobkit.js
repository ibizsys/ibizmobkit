var exec = require('cordova/exec');

module.exports = {
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

	},
	/**
	 * 获取GPS位置
	 * 
	 * @param success {Function} - 成功回调
	 * @param fail {Funciton} - 失败回调
	 */
	gpsLocation : function(success, fail) {

	},
	/**
	 * 获取应用程序存储的值
	 * 
	 * @param key {string} - 键
	 * @param success {Function} - 成功回调
	 * @param fail {Funciton} - 失败回调
	 */
	appValue : function(key, success, fail) {

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

	}
	
	/**
	 * 获取用户存储的值
	 * 
	 * @param key {string} - 键
	 * @param success {Function} - 成功回调
	 * @param fail {Funciton} - 失败回调
	 */
	userValue : function(key, success, fail) {

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

	}
};