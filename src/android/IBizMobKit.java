package org.apache.cordova.ibizmobkit;

import java.util.UUID;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaWebView;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.content.Context;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;

/**
 *
 * @author <a href='http://www.weibo.com/xjtoo' target='_blank'>Enmaai</a>
 */
public class IBizMobKit extends CordovaPlugin
{
	private String strDeviceId;

	public static final String DEVICEID = "ibimobkit_device_id";
	public static final String SPDOMAIN = "IBizMobKit";

	@Override
	public void initialize(CordovaInterface cordova, CordovaWebView webView)
	{
		super.initialize(cordova, webView);

		strDeviceId = appValue(DEVICEID);
		if (strDeviceId == null || strDeviceId.length() <= 0)
		{
			strDeviceId = UUID.randomUUID().toString();
			setAppValue(DEVICEID, strDeviceId);
		}
	}

	@Override
	public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException
	{
		if ("start".equals(action))
		{
			JSONObject json = new JSONObject();

			json.put("userid", userValue("userid"));
			json.put("token", userValue("token"));
			json.put("userinfo", userValue("userinfo"));
			json.put("deviceinfo", getDeviceInfo());

			callbackContext.success(json);
			return true;
		}

		if ("getDeviceId".equals(action))
		{
			callbackContext.success(getDeviceInfo());
			return true;
		}

		if ("getDeviceInfo".equals(action))
		{
			callbackContext.success(getDeviceInfo());
			return true;
		}

		if ("appValue".equals(action))
		{
			callbackContext.success(appValue(args.getString(0)));
			return true;
		}

		if ("setAppValue".equals(action))
		{
			setAppValue(args.getString(0), args.getString(1));
			callbackContext.success();
			return true;
		}

		if ("userValue".equals(action))
		{
			callbackContext.success(userValue(args.getString(0)));
			return true;
		}
		if ("setUserValue".equals(action))
		{
			setUserValue(args.getString(0), args.getString(1));
			callbackContext.success();
			return true;
		}

		return false;
	}

	protected String getDeviceId()
	{
		return strDeviceId;
	}

	protected JSONObject getDeviceInfo()
	{
		JSONObject json = new JSONObject();

		try
		{
			json.put("manufacturer", android.os.Build.MANUFACTURER);
			json.put("platform", "android");
			json.put("version", android.os.Build.VERSION.RELEASE);
			json.put("deviceid", getDeviceId());
			json.put("sdk", android.os.Build.VERSION.SDK_INT);
			json.put("isvirtual", isVirtual());

		} catch (JSONException e)
		{
			e.printStackTrace();
		}

		return json;
	}

	protected String appValue(String key)
	{
		return userValue(key);
	}

	protected void setAppValue(String key, String val)
	{
		setUserValue(key, val);
	}

	protected String userValue(String key)
	{
		SharedPreferences sp = this.cordova.getActivity().getSharedPreferences(SPDOMAIN, Context.MODE_PRIVATE);

		return sp.getString(key, "");
	}

	protected void setUserValue(String key, String val)
	{
		SharedPreferences sp = this.cordova.getActivity().getSharedPreferences(SPDOMAIN, Context.MODE_PRIVATE);
		Editor editor = sp.edit();

		editor.putString(key, val);
		editor.commit();
	}

	public boolean isVirtual()
	{
		return android.os.Build.FINGERPRINT.contains("generic") || android.os.Build.PRODUCT.contains("sdk");
	}
}
