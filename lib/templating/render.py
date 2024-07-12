# coding=utf-8
import json
import os
import time
import copy

from .core import engine
# noinspection PyUnresolvedReferences
from lib.util import (DEF_THEME, ADDON, PROFILE, getSetting, translatePath, THEME_VERSION, setSetting, DEBUG, LOG, T,
                      MONITOR, xbmcvfs, addonSettings)
from .context import TEMPLATE_CONTEXTS
from .util import deep_update
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

    # try to find custom theme_overrides.json in userdata
    custom_theme_data_fn = os.path.join(PROFILE, "theme_overrides.json")
    themes = copy.deepcopy(TEMPLATE_CONTEXTS["themes"])
    if xbmcvfs.exists(custom_theme_data_fn):
        try:
            f = xbmcvfs.File(custom_theme_data_fn)
            data = f.read()
            f.close()
            if data:
                js = json.loads(data)
                deep_update(themes, js)
                LOG("Loaded theme overrides definitions from: {}".format(custom_theme_data_fn))
        except:
            LOG("Couldn't load {}", custom_theme_data_fn)

    if not engine.initialized:
        engine.init(target_dir, os.path.join(target_dir, "templates"),
                    os.path.join(translatePath(PROFILE), "templates"))

    engine.themes = themes

    def apply():
        LOG("Rendering templates")
        start = time.time()

        with ProgressDialog(T(33062, ''), "") as pd:
            def update_progress(at, length, message):
                pd.update(int(at * 100 / float(length)),
                          message=T(STEP_MAP.get(message, STEP_MAP["default"]), '').format(message))

            # get template overrides
            watch_state_type = getSetting('watched_indicators', 'modern_2024')
            overrides = {
                "indicators": {
                    "INHERIT": watch_state_type,
                    "style": watch_state_type,
                    "hide_aw_bg": getSetting('hide_aw_bg', False),
                }
            }

            engine.apply(theme, update_progress, templates=templates, overrides=overrides)
            end = time.time()
            MONITOR.waitForAbort(0.1)

        LOG("Rendered templates in: {:.2f}s".format(end - start))

    curThemeVer = getSetting('theme_version', 0)
    if curThemeVer < THEME_VERSION or (force or addonSettings.alwaysCompileTemplates):
        setSetting('theme_version', THEME_VERSION)
        # apply seekdialog button theme
        apply()

    # lose template cache for performance reasons
    if not addonSettings.cacheTemplates:
        engine.loader.cache = {}
