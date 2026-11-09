/*
 * Copyright (C) 2023-2025 Paranoid Android
 *
 * SPDX-License-Identifier: Apache-2.0
 */

package com.xiaomi.settings;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.hardware.display.DisplayManager;
import android.util.Log;
import android.view.Display;
import android.view.Display.HdrCapabilities;

import com.xiaomi.settings.display.DcDimmingUtils;
import com.xiaomi.settings.touch.HighTouchPollingUtils;

public class BootCompletedReceiver extends BroadcastReceiver {
    private static final String TAG = "XiaomiParts";
    private static final boolean DEBUG = true;

    @Override
    public void onReceive(final Context context, Intent intent) {
        if (intent == null || intent.getAction() == null) {
            return;
        }
        String action = intent.getAction();
        if (!Intent.ACTION_BOOT_COMPLETED.equals(action)
                && !Intent.ACTION_LOCKED_BOOT_COMPLETED.equals(action)) {
            return;
        }
        if (DEBUG) {
            Log.d(TAG, "Received boot intent: " + action);
        }

        // Restore High Touch Sampling Rate state
        HighTouchPollingUtils.restoreSamplingRate(context);

        // Restore DC Dimming state
        DcDimmingUtils.restoreState(context);

        // Override HDR types to enable Dolby Vision
        final DisplayManager displayManager = context.getSystemService(DisplayManager.class);
        if (displayManager != null) {
            displayManager.overrideHdrTypes(Display.DEFAULT_DISPLAY,
                    new int[] {HdrCapabilities.HDR_TYPE_DOLBY_VISION, HdrCapabilities.HDR_TYPE_HDR10,
                            HdrCapabilities.HDR_TYPE_HLG, HdrCapabilities.HDR_TYPE_HDR10_PLUS});
        }
    }
}
