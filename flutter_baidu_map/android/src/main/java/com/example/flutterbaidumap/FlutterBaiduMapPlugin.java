package com.example.flutterbaidumap;

import android.app.Activity;
import android.content.Context;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.os.Build;
import android.os.Bundle;

import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.PluginRegistry.Registrar;

import com.baidu.mapapi.JNIInitializer;

import com.baidu.mapapi.SDKInitializer;

import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;


/**
 * FlutterBaiduMapPlugin
 */
public class FlutterBaiduMapPlugin implements MethodCallHandler {

    private Activity activity;
    private LocationManager mSysLocManager;
    private MethodChannel channel;

    public FlutterBaiduMapPlugin(Activity activity,MethodChannel channel) {
        this.activity = activity;
        this.channel = channel;
    }

    /**
     * Plugin registration.
     */
    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_baidu_map");

        channel.setMethodCallHandler(new FlutterBaiduMapPlugin(registrar.activity(),channel));
    }

    @Override
    public void onMethodCall(final MethodCall call, final Result result) {
        if (call.method.equals("init")) {
            SDKInitializer.initialize(activity.getApplicationContext());
            try {
                if (mSysLocManager == null) {
                    /** 获取系统的定位服务管理类*/
                    mSysLocManager = (LocationManager) JNIInitializer.getCachedContext()
                            .getSystemService(Context.LOCATION_SERVICE);
                }
                //成功返回true
                result.success(true);

            } catch (Exception e) {
                // 失败返回false
                result.success(false);
            }

        } else if (call.method.equals("startLocation")) {

            mSysLocManager.requestLocationUpdates(LocationManager.NETWORK_PROVIDER, 0, 0, listener);
            result.success(true);


        } else {
            result.notImplemented();
        }
    }


    private LocationListener listener = new LocationListener() {
        @Override
        public void onLocationChanged(Location location) {
            Map<String,Object> data = new HashMap<String,Object>();
            data.put("latitude",location.getLatitude());
            data.put("longitude",location.getLongitude());
            data.put("result", "onLocationChanged");
            channel.invokeMethod("onLocation" ,data );
        }

        @Override
        public void onStatusChanged(String s, int i, Bundle bundle) {
            Map<String,Object> data = new HashMap<String,Object>();
            data.put("result", "status");
            channel.invokeMethod("onLocation" ,data );

        }

        @Override
        public void onProviderEnabled(String s) {
            Map<String,Object> data = new HashMap<String,Object>();
            data.put("result", "onProviderEnabled");
            channel.invokeMethod("onLocation" ,data );

        }

        @Override
        public void onProviderDisabled(String s) {
            Map<String,Object> data = new HashMap<String,Object>();
            data.put("result", "onProviderDisabled");
            channel.invokeMethod("onLocation" ,data );
        }
    };

}
