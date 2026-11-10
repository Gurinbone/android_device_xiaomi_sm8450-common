/*
 * Copyright (C) 2023-2026 The LineageOS Project
 *
 * SPDX-License-Identifier: Apache-2.0
 */

package com.xiaomi.settings.display;

import android.content.Context;

import com.android.settingslib.drawer.CategoryKey;
import com.android.settingslib.drawer.EntriesProvider;
import com.android.settingslib.drawer.EntryController;
import com.android.settingslib.drawer.ProviderSwitch;
import com.xiaomi.settings.R;

import java.util.Collections;
import java.util.List;

public class DisplayEntriesProvider extends EntriesProvider {

    @Override
    protected List<? extends EntryController> createEntryControllers() {
        return Collections.singletonList(new DcDimmingSwitchController());
    }

    private class DcDimmingSwitchController extends EntryController
            implements ProviderSwitch {

        @Override
        public String getKey() {
            return DcDimmingUtils.KEY_DC_DIMMING;
        }

        @Override
        protected MetaData getMetaData() {
            return new MetaData(CategoryKey.CATEGORY_DISPLAY)
                    .setTitle(R.string.dc_dimming_title)
                    .setSummary(R.string.dc_dimming_summary);
        }

        @Override
        public boolean isSwitchChecked() {
            Context context = getContext();
            return context != null && DcDimmingUtils.isEnabled(context);
        }

        @Override
        public boolean onSwitchCheckedChanged(boolean checked) {
            Context context = getContext();
            if (context == null) {
                return false;
            }
            return DcDimmingUtils.setEnabled(context, checked);
        }

        @Override
        public String getSwitchErrorMessage(boolean attemptedChecked) {
            return "";
        }
    }
}
