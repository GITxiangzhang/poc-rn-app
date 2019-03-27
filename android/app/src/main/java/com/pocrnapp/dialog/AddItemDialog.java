package com.pocrnapp.dialog;

import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.v4.app.DialogFragment;
import android.text.TextUtils;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.pocrnapp.R;

/**
 * Created by Ryan on 25/03/2019.
 */
public class AddItemDialog extends DialogFragment {
    private View view;
    private EditText editText;
    private TextView confirmTV;
    private TextView cancelTV;
    private OnAddItemConfirmed onAddItemConfirmed;

    public interface OnAddItemConfirmed {
        void onAddItemConfirmed(String itemName);
    }

    public void setOnAddItemConfirmed(OnAddItemConfirmed onAddItemConfirmed) {
        this.onAddItemConfirmed = onAddItemConfirmed;
    }

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container,
                             @Nullable Bundle savedInstanceState) {
        view = inflater.inflate(R.layout.dialog_fragment_input, container, false);
        initView();
        initEvent();
        return view;
    }

    private void initEvent() {
        confirmTV.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String input = editText.getText().toString();
                if (TextUtils.isEmpty(input)) {
                    Toast.makeText(getContext(), "Please input the item name",
                            Toast.LENGTH_SHORT).show();
                } else {
                    if (onAddItemConfirmed != null) {
                        onAddItemConfirmed.onAddItemConfirmed(input);
                    }
                    dismiss();
                }
            }
        });
        cancelTV.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dismiss();
            }
        });
    }

    private void initView() {
        editText = view.findViewById(R.id.ed);
        confirmTV = view.findViewById(R.id.tv_confirm);
        cancelTV = view.findViewById(R.id.tv_cancel);
    }
}
