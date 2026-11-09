/*
 * Copyright (C) 2023-2025 Paranoid Android
 *
 * SPDX-License-Identifier: Apache-2.0
 */

package com.xiaomi.settings.touch;

import static com.android.settingslib.drawer.TileUtils.META_DATA_PREFERENCE_GROUP_KEY;

import android.content.Context;
import android.os.Bundle;

import com.android.settingslib.drawer.CategoryKey;
import com.android.settingslib.drawer.EntriesProvider;
import com.android.settingslib.drawer.EntryController;
import com.android.settingslib.drawer.ProviderSwitch;
import com.xiaomi.settings.R;
import com.xiaomi.settings.display.DcDimmingUtils;

import java.util.Arrays;
import java.util.List;

public class DisplayEntriesProvider extends EntriesProvider {

    @Override
    protected List<? extends EntryController> createEntryControllers() {
        return Arrays.asList(
                new HighTouchPollingSwitchController(),
                new DcDimmingSwitchController()
        );
    }

    private class HighTouchPollingSwitchController extends EntryController
            implements ProviderSwitch {
        private static final String GROUP_DISPLAY_CONTROLS = "category_other";

        @Override
        public String getKey() {
            return HighTouchPollingUtils.KEY_HIGH_TOUCH_POLLING;
        }

        @Override
        protected MetaData getMetaData() {
            DisplayMetaData metaData = new DisplayMetaData(CategoryKey.CATEGORY_DISPLAY);
            metaData.setTitle(R.string.high_touch_polling_rate_title);
            metaData.setSummary(R.string.high_touch_polling_rate_summary);
            return metaData;
        }

        @Override
        public boolean isSwitchChecked() {
            Context context = getContext();
            return context != null && HighTouchPollingUtils.isEnabled(context);
        }

        @Override
        public boolean onSwitchCheckedChanged(boolean checked) {
            Context context = getContext();
            if (context == null) {
                return false;
            }
            return HighTouchPollingUtils.setEnabled(context, checked);
        }

        @Override
        public String getSwitchErrorMessage(boolean attemptedChecked) {
            return "";
        }

        private class DisplayMetaData extends MetaData {
            DisplayMetaData(String category) {
                super(category);
            }

            @Override
            protected Bundle build() {
                Bundle bundle = super.build();
                bundle.putString(META_DATA_PREFERENCE_GROUP_KEY, GROUP_DISPLAY_CONTROLS);
                return bundle;
            }
        }
    }

    private class DcDimmingSwitchController extends EntryController
            implements ProviderSwitch {
        private static final String GROUP_DISPLAY_CONTROLS = "category_other";

        @Override
        public String getKey() {
            return DcDimmingUtils.KEY_DC_DIMMING;
        }

        @Override
        protected MetaData getMetaData() {
            DisplayMetaData metaData = new DisplayMetaData(CategoryKey.CATEGORY_DISPLAY);
            metaData.setTitle(R.string.dc_dimming_title);
            metaData.setSummary(R.string.dc_dimming_summary);
            return metaData;
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

        private class DisplayMetaData extends MetaData {
            DisplayMetaData(String category) {
                super(category);
            }

            @Override
            protected Bundle build() {
                Bundle bundle = super.build();
                bundle.putString(META_DATA_PREFERENCE_GROUP_KEY, GROUP_DISPLAY_CONTROLS);
                return bundle;
            }
        }
    }
}
