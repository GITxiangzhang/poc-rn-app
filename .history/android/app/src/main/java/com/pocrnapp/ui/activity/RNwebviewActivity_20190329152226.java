package com.pocrnapp.ui.activity;

import android.os.Bundle;

import com.facebook.react.ReactActivity;
import com.pocrnapp.module.JsAndroidModule;

/**
 * Created by Ryan on 25/03/2019.
 */
public class RNwebviewActivity extends ReactActivity {
    @Override
    protected String getMainComponentName() {
        return "pocRNApp";
    }

    @Override
    protected ReactActivityDelegate createReactActivityDelegate() {
        return new ReactActivityDelegate(this, getMainComponentName()) {
            @Override
            protected ReactRootView createRootView() {
                return new RNGestureHandlerEnabledRootView(MainActivity.this);
            }
        };
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        JsAndroidModule.setFragmentContext(this);
    }
}
