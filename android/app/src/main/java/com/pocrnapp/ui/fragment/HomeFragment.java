package com.pocrnapp.ui.fragment;

import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.pocrnapp.R;
import com.pocrnapp.detection.DetectorActivity;
import com.pocrnapp.ui.activity.CameraActivity;
import com.pocrnapp.ui.activity.EncryptActivity;
import com.pocrnapp.ui.activity.MapActivity;
import com.pocrnapp.ui.activity.RNwebviewActivity;


/**
 * Created by Ryan on 25/03/2019.
 */
public class HomeFragment extends Fragment implements View.OnClickListener {
    private View webPageLayout;
    private View mapLayout;
    private View cameraLayout;
    private View reservedLayout;

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container,
                             @Nullable Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_home, container, false);
        return view;
    }

    @Override
    public void onActivityCreated(@Nullable Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);
        webPageLayout = getActivity().findViewById(R.id.layout_web);
        mapLayout = getActivity().findViewById(R.id.layout_map);
        cameraLayout = getActivity().findViewById(R.id.layout_camera);
        reservedLayout = getActivity().findViewById(R.id.layout_encrypt_photo);
        initEvent();
    }

    private void initEvent() {
        webPageLayout.setOnClickListener(this);
        mapLayout.setOnClickListener(this);
        cameraLayout.setOnClickListener(this);
        reservedLayout.setOnClickListener(this);
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.layout_web:
                //跳转至rn页面
                jumpTo(RNwebviewActivity.class);
                break;
            case R.id.layout_map:
                //跳转至map页面
                jumpTo(MapActivity.class);
                break;
            case R.id.layout_camera:
                //跳转至camera页面
                jumpTo(DetectorActivity.class);
                break;
            case R.id.layout_encrypt_photo:
                jumpTo(EncryptActivity.class);
                break;


        }
    }

    private void jumpTo(Class<?> targetActivity) {
        Intent intent = new Intent(getActivity(), targetActivity);
        getActivity().startActivity(intent);

    }
}
