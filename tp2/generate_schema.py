import json
import sys

def schema_dict(obj):
    sch = {}
    for k,v in obj.items():
        sch[k] = schema(v)
        if k.startswith('fecha'):
            sch[k].update({'format': 'date'})

    return {
        'type': 'object',
        'properties': sch
    }

def schema_str(obj):
    return {
        'type': 'string'
    }

def schema_list(obj):
    if len(obj) > 0:
        items = schema(obj[0])
    else:
        items = schema({})
    return {
        'type': 'array',
        'items': items
    }

def schema_int(obj):
    return {
        'type': 'number'
    }

def schema(obj):
    types = [(dict, schema_dict),
             (unicode, schema_str),
             (list, schema_list),
             (int, schema_int)]
    for t, f in types:
        if type(obj) is t:
            return f(obj)

def union(objs):
    if len(objs) == 0:
        return
    if isinstance(objs[0],dict):
        keys = set()
        for obj in objs:
            keys |= set(obj.keys())
        d = {}
        for k in keys:
            d[k] = union([obj[k] for obj in objs])
        return d
    elif isinstance(objs[0], list):
        l = []
        for obj in objs:
            l.extend(obj)
        return l
    else:
        return objs[0]

if __name__ == '__main__':
    input_str = sys.stdin.read()
    objects = json.loads(input_str)
    obj = union(objects)

print json.dumps(schema(obj), indent=4)
