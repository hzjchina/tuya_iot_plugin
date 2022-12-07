package com.airekey.tuya_iot_plugin;

import android.content.Context;
import android.util.Log;

import androidx.annotation.NonNull;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import com.tuya.smart.config.TuyaConfig;
import com.tuya.smart.config.TuyaEZConfig;

/** TuyaIotPlugin */
public class TuyaIotPlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private static String TAG = "TuYaFlutterAndroid ";

  public static TuyaIotPlugin instance;
  private MethodChannel channel;
  private Context context;
  public Map<Integer, Result> callbackMap;

  public TuyaIotPlugin(){


  }

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "tuya_iot_plugin");
    channel.setMethodCallHandler(this);
    context = flutterPluginBinding.getApplicationContext();
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("getPlatformVersion")) {
        result.success("Android " + android.os.Build.VERSION.RELEASE);
    } else if(call.method.equals("startConfig")) {
        startConfig(call,result);
    }else if(call.method.equals("stopConfig")){
      stopConfig(call,result);
    }else{
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }

  public void startConfig(MethodCall call, Result result) {
    HashMap<String, Object> map = call.arguments();
//    Set<String> tags = new HashSet<>(tagList);

    Object ssid = map.get("ssid");

    Log.d(TAG,"SSID: "+ssid);
    Object password = map.get("password");

    Log.d(TAG,"password: "+password);
    Object authToken = map.get("authToken");

    Log.d(TAG,"pairToken: "+authToken);

    if(ssid == null || password == null || authToken == null){
      result.success(false);
    }else{
//      TuyaConfig.getEZInstance().startConfig((String)ssid,(String)password,(String)authToken);//
      TuyaEZConfig.getInstance().startConfig((String)ssid,(String)password,(String)authToken);//

      Log.d(TAG,"startConfig:-------> ");
      result.success(true);
    }

  }
  public void stopConfig(MethodCall call, Result result) {

    TuyaConfig.getEZInstance().stopConfig();
    Log.d(TAG,"<----------- :stopConfig");
    result.success(true);
  }


}
