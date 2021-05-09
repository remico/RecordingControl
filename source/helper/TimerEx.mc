/*
 * This file is part of "YRemote" project
 *
 * Author: Roman Gladyshev <remicollab@gmail.com>
 * License: BSD 3-clause "New" or "Revised" License
 *
 * SPDX-License-Identifier: BSD-3-Clause
 * License text is available in the LICENSE file and online:
 * http://www.opensource.org/licenses/BSD-3-Clause
 *
 * Copyright (c) 2021 remico
 */
using Toybox.Timer;

class TimerEx extends Timer.Timer {
    private var mCallback;
    private var mParams;

    function initialize() {
        Timer.Timer.initialize();
    }

    // params - a list of parameters to pass to the callback
    function start(callback, params, time, repeat) {
        self.mCallback = callback;
        self.mParams = params;
        Timer.Timer.start(method(:_wrap), time, repeat);
    }

    function _wrap() {
        var p = self.mParams;
        switch (p.size()) {
            case 1:
                self.mCallback.invoke(p[0]);
                break;
            case 2:
                self.mCallback.invoke(p[0], p[1]);
                break;
            case 3:
                self.mCallback.invoke(p[0], p[1], p[2]);
                break;
            default:
                self.mCallback.invoke();
        }
    }
}
