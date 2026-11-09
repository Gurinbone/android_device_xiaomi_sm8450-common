/*
 * Copyright (C) 2023-2025 Paranoid Android
 *
 * SPDX-License-Identifier: Apache-2.0
 */

package com.xiaomi.settings.display;

import android.content.Context;
import android.content.SharedPreferences;
import android.provider.Settings;
import android.util.Log;

import androidx.preference.PreferenceManager;

public class DcDimmingUtils {
    private static final String TAG = "DcDimmingUtils";
    public static final String KEY_DC_DIMMING = "dc_dimming";
    public static final String DC_DIMMING_STATE = "dc_dimming_state";
    private static final int DC_DIMMING_MODE = 20;

    public static boolean isEnabled(Context context) {
        return Settings.System.getInt(context.getContentResolver(),
                DC_DIMMING_STATE, 0) == 1;
    }

    public static boolean setEnabled(Context context, boolean enabled) {
        Settings.System.putInt(context.getContentResolver(),
                DC_DIMMING_STATE, enabled ? 1 : 0);

        SharedPreferences.Editor editor = PreferenceManager.getDefaultSharedPreferences(context).edit();
        editor.putBoolean(KEY_DC_DIMMING, enabled);
        editor.apply();

        DisplayFeatureWrapper.setFeature(DC_DIMMING_MODE, enabled ? 1 : 0, 0);
        Log.d(TAG, "setEnabled: " + enabled);
        return true;
    }

    public static void restoreState(Context context) {
        boolean enabled = isEnabled(context);
        DisplayFeatureWrapper.setFeature(DC_DIMMING_MODE, enabled ? 1 : 0, 0);
        Log.d(TAG, "restoreState: " + enabled);
    }
}
