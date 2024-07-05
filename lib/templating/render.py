# coding=utf-8
import os
import time

from .core import engine
from lib.util import DEF_THEME, ADDON, getSetting, translatePath, THEME_VERSION, setSetting, DEBUG, LOG, T, MONITOR
from lib.windows.busy import ProgressDialog


STEP_MAP = {
    "custom_templates": 33063,
    "default": 33064,
    "complete": 33065
}


def render_templates(theme=None, templates=None, force=False):
    # apply theme if version changed
    theme = theme or getSetting('theme', DEF_THEME)
    target_dir = os.path.join(translatePath(ADDON.getAddonInfo('path')), "resources", "skins", "Main", "1080i")

    if not engine.initialized:
        engine.init(target_dir, os.path.join(target_dir, "templates"),
                    os.path.join(translatePath(ADDON.getAddonInfo("profile")), "templates"))

    def apply():
        LOG("Rendering templates")
        start = time.time()

        with ProgressDialog(T(33062, ''), "") as pd:
            def update_progress(at, length, message):
                pd.update(int(at * 100 / float(length)),
                          message=T(STEP_MAP.get(message, STEP_MAP["default"]), '').format(message))

            engine.apply(update_progress, theme, templates=templates)
            end = time.time()
            MONITOR.waitForAbort(0.1)

        LOG("Rendered templates in: {:.2f}s".format(end - start))

    # fixme: in-development, remove
    if DEBUG:
        apply()

    curThemeVer = getSetting('theme_version', 0)
    if curThemeVer < THEME_VERSION or force:
        setSetting('theme_version', THEME_VERSION)
        # apply seekdialog button theme
        apply()

    # lose template cache for performance reasons
    #fixme: create setting for this
    engine.loader.cache = {}
