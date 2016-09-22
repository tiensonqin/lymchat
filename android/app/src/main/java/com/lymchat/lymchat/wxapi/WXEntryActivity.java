package com.lymchat.lymchat.wxapi;

/**
 * Created by tienson on 8/31/16.
 */

import android.app.Activity;
import android.os.Bundle;
import com.theweflex.react.WeChatModule;

public class WXEntryActivity extends Activity{
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        WeChatModule.handleIntent(getIntent());
        finish();
    }
}
