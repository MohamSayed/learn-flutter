package com.example.flutter_plugin;

import android.annotation.TargetApi;
import android.app.Activity;
import android.bluetooth.BluetoothAdapter;
import android.os.Build;
import android.widget.Toast;
import android.content.Intent;



import android.content.Context;
import android.os.Bundle;
import android.os.Vibrator;
import android.view.View;
import android.widget.EditText;



import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;


/**
 * FlutterPlugin
 */
public class FlutterPlugin implements MethodCallHandler {
    /**
     * Plugin registration.
     */
    static Activity activity = null;

    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_plugin");
        activity = registrar.activity();
        channel.setMethodCallHandler(new FlutterPlugin());
    }

    @TargetApi(Build.VERSION_CODES.ECLAIR)
    @Override
    public void onMethodCall(MethodCall call, Result result) {

        if (call.method.equals("getPlatformVersion")) {
            result.success("Android " + android.os.Build.VERSION.RELEASE);

        } else if (call.method.equals("else")) {
            result.success("something else");
            System.out.println();

        } else if (call.method.equals("bluetooth")) {
            BluetoothAdapter bluetoothAdapter = BluetoothAdapter.getDefaultAdapter();
            if (bluetoothAdapter == null) {
                // Device doesn't support Bluetooth
            }
            if (!bluetoothAdapter.isEnabled()) {
                Intent enableBtIntent = new Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE);
                activity.startActivity(enableBtIntent);
            }

        } else if (call.method.equals("toast")) {
            Toast.makeText(this.activity, "Some toast", Toast.LENGTH_SHORT).show();
            result.success("Toast");
        } else {
            result.notImplemented();
        }
    }

}
