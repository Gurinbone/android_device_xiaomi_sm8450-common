/*
 * Copyright (C) 2023-2026 The LineageOS Project
 *
 * SPDX-License-Identifier: Apache-2.0
 */

package com.xiaomi.settings.display;

import android.os.IHwBinder;
import android.util.Log;

import vendor.xiaomi.hardware.displayfeature.V1_0.IDisplayFeature;

public class DisplayFeatureWrapper {
    private static final String TAG = "DisplayFeatureWrapper";

    private static IDisplayFeature sDisplayFeature = null;

    private static final IHwBinder.DeathRecipient sDeathRecipient = (cookie) -> {
        Log.d(TAG, "displayfeature service died");
        sDisplayFeature = null;
    };

    private static synchronized IDisplayFeature getDisplayFeature() {
        if (sDisplayFeature == null) {
            try {
                sDisplayFeature = IDisplayFeature.getService();
                if (sDisplayFeature != null) {
                    sDisplayFeature.asBinder().linkToDeath(sDeathRecipient, 0);
                }
            } catch (Exception e) {
                Log.e(TAG, "getDisplayFeature failed!", e);
                sDisplayFeature = null;
            }
        }
        return sDisplayFeature;
    }

    public static void setFeature(int mode, int value, int cookie) {
        IDisplayFeature service = getDisplayFeature();
        if (service == null) {
            Log.w(TAG, "displayFeature service is null, skipping setFeature");
            return;
        }
        try {
            service.setFeature(/*displayId*/ 0, mode, value, cookie);
            Log.d(TAG, "setFeature: mode=" + mode + ", value=" + value + ", cookie=" + cookie);
        } catch (Exception e) {
            Log.e(TAG, "setFeature failed: mode=" + mode + " value=" + value, e);
        }
    }
}
