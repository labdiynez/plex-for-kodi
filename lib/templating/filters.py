# coding=utf-8

import ibis
import copy
import operator
import six

from .util import register_builtin


@ibis.filters.register('get')
def get_attr(obj, attr):
    return obj.get(attr)


@ibis.filters.register('calc')
@register_builtin
def calc(a, b, op="add"):
    if isinstance(a, six.string_types):
        a = float(a) if "." in a else int(a)
    elif isinstance(b, six.string_types):
        b = float(b) if "." in b else int(b)
    try:
        return getattr(operator, op)(a, b)
    except:
        raise ValueError("Can't calculate {}({}:{}, {}:{})".format(op, type(a), repr(a), type(b), repr(b)))


@ibis.filters.register('add')
@register_builtin
def add(a, b):
    return calc(a, b)


@ibis.filters.register('sub')
@register_builtin
def sub(a, b):
    return calc(a, b, op="sub")


@ibis.filters.register('div')
@register_builtin
def div(a, b):
    return calc(a, b, op="truediv")


@ibis.filters.register('mul')
@register_builtin
def mul(a, b):
    return calc(a, b, op="mul")

@ibis.filters.register('resolve')
@register_builtin('resolve')
def resolve_variable(arg):
    return ibis.nodes.ResolveContextVariable(arg)


@ibis.filters.register('merge_dict')
@ibis.filters.register('merge')
@register_builtin('merge')
def merge_dict(*args):
    final_dict = {}
    for arg in args:
        final_dict.update(copy.deepcopy(arg))

    return final_dict
