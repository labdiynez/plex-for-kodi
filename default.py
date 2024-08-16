# coding=utf-8
from __future__ import absolute_import
import logging
from lib import main
from tendo_singleton import SingleInstance, SingleInstanceException


class KodiLogProxyHandler(logging.Handler):
    def emit(self, record):
        try:
            main.util.LOG(self.format(record))
        except:
            self.handleError(record)


# add custom logger for tendo.singleton, so we can capture its messages
logger = logging.getLogger("tendo.singleton")
logger.addHandler(KodiLogProxyHandler())
logger.setLevel(logging.DEBUG)


try:
    if (main.xbmc.getInfoLabel('Window(10000).Property(script.plex.running)') == "1" and
            not main.xbmc.getInfoLabel('Window(10000).Property(script.plex.is_active)')):
        try:
            main.xbmc.executebuiltin('NotifyAll({0},{1},{2})'.format('script.plexmod', 'RESTORE', '{}'))
        except:
            main.util.LOG('Main: script.plex: Already running, couldn\'t reactivate other instance, exiting.')
    else:
        with SingleInstance("pm4k"):
            main.main()

except SingleInstanceException:
    pass

except SystemExit as e:
    if e.code not in (-1, 0):
        raise
