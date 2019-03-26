package com.pocrnapp.module;

import android.app.Activity;
import android.content.Context;
import android.support.v7.app.AppCompatActivity;

import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.pocrnapp.dialog.AddItemDialog;

/**
 * Created by Ryan on 21/03/2019.
 */
public class JsAndroidModule extends ReactContextBaseJavaModule {
    private static final String MODULE_NAME = "JsAndroid";
    private Context mContext = null;
    private static Context fragmentContext;

    public JsAndroidModule(ReactApplicationContext reactContext) {
        super(reactContext);
        mContext = reactContext;
    }

    public static void setFragmentContext(Context context) {
        fragmentContext = context;
    }

    @Override
    public String getName() {
        return MODULE_NAME;
    }


    @ReactMethod
    public void showDialogFragment(Callback successBack, Callback erroBack) {
        try {
            AddItemDialog fragment = new AddItemDialog();
            fragment.setOnAddItemConfirmed(new AddItemDialog.OnAddItemConfirmed() {
                @Override
                public void onAddItemConfirmed(String itemName) {
                    successBack.invoke(itemName);
                }
            });
            fragment.show(((AppCompatActivity) fragmentContext).getSupportFragmentManager(), "addItem");
        } catch (Exception e) {
            erroBack.invoke(e.getMessage());
        }

    }


    @ReactMethod
    public void jsActivity(Callback successBack, Callback erroBack) {
        try {
            Activity currentActivity = getCurrentActivity();
            int result = currentActivity.getIntent().getIntExtra("data", 0);//会有对应数据放入
            successBack.invoke(result);
        } catch (Exception e) {
            erroBack.invoke(e.getMessage());
        }
    }


}
