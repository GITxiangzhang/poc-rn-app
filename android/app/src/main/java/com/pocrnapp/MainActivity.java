package com.pocrnapp;

import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.design.widget.BottomNavigationView;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentTransaction;
import android.support.v4.view.ViewPager;
import android.support.v7.app.AppCompatActivity;
import android.view.KeyEvent;
import android.view.MenuItem;
import android.widget.LinearLayout;
import android.widget.Toast;

import com.facebook.react.ReactInstanceManager;
import com.facebook.react.ReactRootView;
import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.modules.core.DefaultHardwareBackBtnHandler;
import com.facebook.react.modules.core.DeviceEventManagerModule;
import com.pocrnapp.R;
import com.pocrnapp.dialog.AddItemDialog;
import com.pocrnapp.ui.fragment.HomeFragment;
import com.pocrnapp.ui.fragment.SecondFragment;
import com.pocrnapp.ui.fragment.ThirdFragment;


public class MainActivity extends AppCompatActivity implements DefaultHardwareBackBtnHandler,
        BottomNavigationView.OnNavigationItemSelectedListener, AddItemDialog.OnAddItemConfirmed {
    private ReactRootView mReactRootView;
    private ReactInstanceManager mReactInstanceManager;
    private LinearLayout myreact;
    private ViewPager viewPager;
    private BottomNavigationView bottomNavigationView;
    private MenuItem menuItem;
    private ReactContext reactContext;

    private HomeFragment fragmentHome;
    private SecondFragment secondFragment;
    private ThirdFragment thirdFragment;
    private Fragment[] fragments;
    private int lastfragment;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        initView();
        initValue();
        initEvent();
    }

    private void initEvent() {
        bottomNavigationView.setOnNavigationItemSelectedListener(this);
    }

    private void initValue() {
    }

    private void initView() {
        //ReactNative相关
//        myreact = (LinearLayout) findViewById(R.id.react_root_layout);//原生布局中的view
//        mReactRootView = new ReactRootView(this);
//        mReactInstanceManager = ReactInstanceManager.builder()
//                .setApplication(getApplication())
//                .setCurrentActivity(this)
//                .setBundleAssetName("index.android.bundle")
//                .setJSMainModulePath("index")
//                .addPackage(new MainReactPackage())
//                .setUseDeveloperSupport(BuildConfig.DEBUG)
//                .setInitialLifecycleState(LifecycleState.RESUMED)
//                .build();
//        mReactRootView.startReactApplication(mReactInstanceManager, "pocRNApp", null);//启动入口
//        myreact.addView(mReactRootView);//添加react布局
        bottomNavigationView = findViewById(R.id.bnv);
        initFragment();
    }

    private void initFragment() {

        fragmentHome = new HomeFragment();
        secondFragment = new SecondFragment();
        thirdFragment = new ThirdFragment();
        fragments = new Fragment[]{fragmentHome, secondFragment, thirdFragment};
        lastfragment = 0;
        getSupportFragmentManager().beginTransaction().replace(R.id.mainview, fragmentHome).show(fragmentHome).commit();

    }

    //切换Fragment
    private void switchFragment(int lastfragment, int index) {
        FragmentTransaction transaction = getSupportFragmentManager().beginTransaction();
        transaction.hide(fragments[lastfragment]);//隐藏上个Fragment
        if (fragments[index].isAdded() == false) {
            transaction.add(R.id.mainview, fragments[index]);


        }
        transaction.show(fragments[index]).commitAllowingStateLoss();


    }


    @Override
    public void invokeDefaultOnBackPressed() {
        super.onBackPressed();
    }

    @Override
    protected void onPause() {
        super.onPause();

        if (mReactInstanceManager != null) {
            mReactInstanceManager.onHostPause(this);
        }
    }

    @Override
    protected void onResume() {
        super.onResume();

        if (mReactInstanceManager != null) {
            mReactInstanceManager.onHostResume(this, this);
        }
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();

        if (mReactInstanceManager != null) {
            mReactInstanceManager.onHostDestroy(this);
        }
        if (mReactRootView != null) {
            mReactRootView.unmountReactApplication();
        }
    }

    @Override
    public void onBackPressed() {
        if (mReactInstanceManager != null) {
            mReactInstanceManager.onBackPressed();
        } else {
            super.onBackPressed();
        }
    }

    @Override
    public boolean onKeyUp(int keyCode, KeyEvent event) {
        if (keyCode == KeyEvent.KEYCODE_MENU && mReactInstanceManager != null) {
            mReactInstanceManager.showDevOptionsDialog();
            return true;
        }
        return super.onKeyUp(keyCode, event);
    }

    @Override
    public boolean onNavigationItemSelected(@NonNull MenuItem menuItem) {
        int itemId = menuItem.getItemId();
        switch (itemId) {
            case R.id.item1:

                if (lastfragment != 0) {
                    switchFragment(lastfragment, 0);
                    lastfragment = 0;

                }
                return true;

            case R.id.item2:
                if (lastfragment != 1) {
                    switchFragment(lastfragment, 1);
                    lastfragment = 1;

                }
                return true;
            case R.id.item3:
                if (lastfragment != 2) {
                    switchFragment(lastfragment, 2);
                    lastfragment = 2;

                }
                return true;

        }
        return false;
    }

    private void sendJumpPageEvent(int page) {
        WritableMap params = Arguments.createMap();
        params.putInt("data", page);
        sendEvent(getReactContext(), "pageData", params);
    }

    private void sendEvent(ReactContext reactContext, String eventName,
                           @Nullable WritableMap params) {
        if (reactContext == null) {
            return;
        }
        reactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class).emit(eventName, params);
    }

    private ReactContext getReactContext() {
        return reactContext != null ? reactContext : mReactInstanceManager != null ?
                mReactInstanceManager.getCurrentReactContext() : null;
    }

    @Override
    public void onAddItemConfirmed(String itemName) {
        Toast.makeText(this, itemName, Toast.LENGTH_SHORT).show();
    }
}