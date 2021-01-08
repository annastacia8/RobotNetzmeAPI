
#from uuid import UUID
#def get_uuid(o):
        #if isinstance(o, UUID):
            #return o.hex

#import uuid
#import json
#def get_uuid():
    #test = str(uuid.uuid4())
    #return json.str(test)


import uuid

def get_uuid():
    id = uuid.uuid4()
    return str(id)
