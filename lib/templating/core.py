# coding=utf-8
import os
import glob

from kodi_six import xbmcvfs

from lib.logging import log as LOG, log_error as ERROR
from .util import deep_update
from lib.os_utils import fast_iglob
from .filters import *


def build_stack(inheritor, sources):
    inherit_from = inheritor.pop("INHERIT", None)
    data_stack = [inheritor]
    while inherit_from:
        inheritor = copy.deepcopy(sources[inherit_from])
        inherit_from = inheritor.pop("INHERIT", None)
        data_stack.append(inheritor)

    return data_stack


def prepare_template_data(thm, context):
    template_context = {"theme": {}}

    theme_data = {"INHERIT": thm}

    # data stack
    data_stack = build_stack(theme_data, context.pop("themes"))

    # build inheritance stack
    while data_stack:
        deep_update(template_context["theme"], data_stack.pop())

    for ctx in ("indicators",):
        data_stack = build_stack(context[ctx]["START"], context[ctx])
        template_context[ctx] = {}
        while data_stack:
            deep_update(template_context[ctx], data_stack.pop())

    return template_context


class TemplateEngine(object):
    loader = None
    target_dir = None
    template_dir = None
    custom_template_dir = None
    initialized = False
    context = None
    TEMPLATES = None

    def init(self, target_dir, template_dir, custom_template_dir):
        self.target_dir = target_dir
        self.template_dir = template_dir
        self.custom_template_dir = custom_template_dir
        self.get_available_templates()
        paths = [custom_template_dir, template_dir]

        LOG("Looking for templates in: {}", paths)
        self.prepare_loader(paths)
        self.initialized = True

    def get_available_templates(self):
        tpls = []
        for f in fast_iglob(os.path.join(self.template_dir, "script-plex-*.xml.tpl")):
            tpls.append(f.split("script-plex-")[1].split(".xml.tpl")[0])
        self.TEMPLATES = tpls

    def prepare_loader(self, fns):
        self.loader = ibis.loaders.FileLoader(*fns)
        ibis.loader = self.loader

    def compile(self, fn, data):
        template = self.loader(fn)
        return template.render(data)

    def write(self, template, data):
        try:
            # write final file
            f = xbmcvfs.File(os.path.join(self.target_dir, "script-plex-{}.xml".format(template)), "w")
            f.write(data)
            f.close()
            return True
        except:
            ERROR("Couldn't write script-plex-{}.xml", template)
            return False

    def apply(self, theme, update_callback, templates=None):
        templates = self.TEMPLATES if templates is None else templates
        theme_data = prepare_template_data(theme, self.context)

        progress = {"at": 0, "steps": len(templates)}

        def step(message):
            progress["at"] += 1
            update_callback(progress["at"], progress["steps"], message)

        custom_templates = []
        if theme == "custom":
            progress["steps"] += 1
            step("custom_templates")
            custom_templates = [f.split("script-plex-")[1].split(".custom.xml.tpl")[0] for f in
                                glob.iglob(os.path.join(self.custom_template_dir, "*.custom.xml.tpl"))]
            if not custom_templates:
                LOG("No custom templates found in: {}", self.custom_template_dir)

        applied = []
        for template in templates:
            fn = "script-plex-{}{}.xml.tpl".format(template, ".custom" if theme == "custom" and
                                                   template in custom_templates else "")
            compiled_template = self.compile(fn, theme_data)
            if self.write(template, compiled_template):
                applied.append(template)
            else:
                raise Exception("Couldn't write script-plex-{}.xml", template)
            step(template)

        update_callback(progress["steps"], progress["steps"], "complete")
        LOG('Using theme {} for: {}', theme, applied)


engine = TemplateEngine()
