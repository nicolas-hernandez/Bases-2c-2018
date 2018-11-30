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

if __name__ == '__main__':
    input_str = sys.stdin.read()
    first_object = json.loads(input_str)[0]
print json.dumps(schema(first_object), indent=4)
