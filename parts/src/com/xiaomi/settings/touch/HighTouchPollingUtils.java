/*
 * Copyright (C) 2023-2025 Paranoid Android
 *
 * SPDX-License-Identifier: Apache-2.0
 */

package com.xiaomi.settings.touch;

import android.content.Context;
import android.content.SharedPreferences;
import android.os.UserHandle;
import android.provider.Settings;
import android.util.Log;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;

public final class HighTouchPollingUtils {
    private static final String TAG = "XiaomiParts-Touch";
    private static final String PREFS_NAME = "xiaomi_touch_prefs";
    public static final String KEY_HIGH_TOUCH_POLLING = "high_touch_polling_enabled";
    public static final String SETTING_KEY_TOUCH_POLLING = "touch_polling_enabled";
    public static final String NODE_BUMP_SAMPLE_RATE =
            "/sys/devices/virtual/touch/touch_dev/bump_sample_rate";

    private HighTouchPollingUtils() {}

    private static SharedPreferences getPrefs(Context context) {
        Context deviceContext = context.createDeviceProtectedStorageContext();
        return deviceContext.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE);
    }

    public static boolean isSupported() {
        return new File(NODE_BUMP_SAMPLE_RATE).exists();
    }

    public static boolean isEnabled(Context context) {
        return getPrefs(context).getBoolean(KEY_HIGH_TOUCH_POLLING, false);
    }

    public static boolean setEnabled(Context context, boolean enabled) {
        boolean written = writeSysfs(NODE_BUMP_SAMPLE_RATE, enabled ? "1" : "0");
        getPrefs(context).edit().putBoolean(KEY_HIGH_TOUCH_POLLING, enabled).apply();
        try {
            Settings.Secure.putIntForUser(
                    context.getContentResolver(),
                    SETTING_KEY_TOUCH_POLLING,
                    enabled ? 1 : 0,
                    UserHandle.USER_CURRENT);
        } catch (Exception e) {
            Log.w(TAG, "Failed to update Secure setting " + SETTING_KEY_TOUCH_POLLING, e);
        }
        return written;
    }

    public static void restoreSamplingRate(Context context) {
        boolean enabled = isEnabled(context);
        Log.d(TAG, "Restoring high touch sampling rate: " + enabled);
        writeSysfs(NODE_BUMP_SAMPLE_RATE, enabled ? "1" : "0");
    }

    private static boolean writeSysfs(String path, String value) {
        File file = new File(path);
        if (!file.exists()) {
            Log.w(TAG, "Sysfs node does not exist: " + path);
            return false;
        }
        try (FileOutputStream fos = new FileOutputStream(file)) {
            fos.write(value.getBytes(StandardCharsets.UTF_8));
            fos.flush();
            return true;
        } catch (IOException e) {
            Log.e(TAG, "Failed to write " + value + " to " + path, e);
            return false;
        }
    }
}
