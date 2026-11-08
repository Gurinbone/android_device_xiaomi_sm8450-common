/*
 * Copyright (C) 2023-2025 Paranoid Android
 *
 * SPDX-License-Identifier: Apache-2.0
 */

package com.xiaomi.settings.touch;

import android.service.quicksettings.Tile;
import android.service.quicksettings.TileService;

public class HighTouchPollingTileService extends TileService {

    @Override
    public void onStartListening() {
        super.onStartListening();
        updateTileState();
    }

    @Override
    public void onClick() {
        super.onClick();
        boolean newState = !HighTouchPollingUtils.isEnabled(this);
        HighTouchPollingUtils.setEnabled(this, newState);
        updateTileState();
    }

    private void updateTileState() {
        Tile tile = getQsTile();
        if (tile == null) {
            return;
        }
        if (!HighTouchPollingUtils.isSupported()) {
            tile.setState(Tile.STATE_UNAVAILABLE);
        } else {
            boolean enabled = HighTouchPollingUtils.isEnabled(this);
            tile.setState(enabled ? Tile.STATE_ACTIVE : Tile.STATE_INACTIVE);
        }
        tile.updateTile();
    }
}
