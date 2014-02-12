"""[-1-]Attribution-Share Alike 3.0 License, copyright (c) 2010 Pieter Hintjens, modified @alpaca-tc
[-2-]=====================================================================
[-3-]kvmsg - key-value message class for example applications
[-4-]
[-5-]Author: Min RK <benjaminrk@gmail.com>
[-6-]
"""

import struct #[-9-] for packing integers
import sys
from uuid import uuid4

import zmq
import zmq.utils.jsonapi as json

class KVMsg(object):
"""[-17-]
[-18-]Message is formatted on wire as 5 frames:
"""
    key = None
    sequence = 0
    uuid=None
    properties = None
    body = None

    def __init__(self, sequence, uuid=None, key=None, properties=None, body=None):
        assert isinstance(sequence, int)
        self.sequence = sequence
        if uuid is None:
            uuid = uuid4().bytes
        self.uuid = uuid
        self.key = key
        self.properties = {} if properties is None else properties
        self.body = body

    def __getitem__(self, k):
        return self.properties[k]

    def __setitem__(self, k, v):
        self.properties[k] = v

    def get(self, k, default=None):
        return self.properties.get(k, default)

    def store(self, dikt):
        """[-46-]   Store me in a dict if I have anything to store
[-47-]       else delete me from the dict.[-end-]"""
        if self.key is not None and self.body is not None:
            dikt[self.key] = self
        elif self.key in dikt:
            del dikt[self.key]

    def send(self, socket):

        key = '' if self.key is None else self.key
        seq_s = struct.pack('!q', self.sequence)
        body = '' if self.body is None else self.body
        prop_s = json.dumps(self.properties)
        socket.send_multipart([ key, seq_s, self.uuid, prop_s, body ])

    @classmethod
    def recv(cls, socket):

        return cls.from_msg(socket.recv_multipart())

    @classmethod
    def from_msg(cls, msg):

        key, seq_s, uuid, prop_s, body = msg
        key = key if key else None
        seq = struct.unpack('!q',seq_s)[0]
        body = body if body else None
        prop = json.loads(prop_s)
        return cls(seq, uuid=uuid, key=key, properties=prop, body=body)

    def dump(self):
        if self.body is None:
            size = 0
            data='NULL'
        else:
            size = len(self.body)
            data=repr(self.body)
        print >> sys.stderr, "[seq:{seq}][key:{key}][size:{size}] {props} {data}".format(
            seq=self.sequence,
            key=self.key,
            size=size,
            props=json.dumps(self.properties),
            data=data,
        )

#[-91-] Runs self test of class

def test_kvmsg (verbose):
    print " * kvmsg: ",

    ctx = zmq.Context()
    output = ctx.socket(zmq.DEALER)
    output.bind("ipc://kvmsg_selftest.ipc")
    input = ctx.socket(zmq.DEALER)
    input.connect("ipc://kvmsg_selftest.ipc")

    kvmap = {}
    kvmsg = KVMsg(1)
    kvmsg.key = "key"
    kvmsg.body = "body"
    if verbose:
        kvmsg.dump()
    kvmsg.send(output)
    kvmsg.store(kvmap)

    kvmsg2 = KVMsg.recv(input)
    if verbose:
        kvmsg2.dump()
    assert kvmsg2.key == "key"
    kvmsg2.store(kvmap)

    assert len(kvmap) == 1

    kvmsg = KVMsg(2, key="key", body="body")
    kvmsg["prop1"] = "value1"
    kvmsg["prop2"] = "value2"
    kvmsg["prop3"] = "value3"
    assert kvmsg["prop1"] == "value1"
    if verbose:
        kvmsg.dump()
    kvmsg.send(output)
    kvmsg2 = KVMsg.recv(input)
    if verbose:
        kvmsg2.dump()
    #[-130-] ensure properties were preserved
    assert kvmsg2.key == kvmsg.key
    assert kvmsg2.body == kvmsg.body
    assert kvmsg2.properties == kvmsg.properties
    assert kvmsg2["prop2"] == kvmsg["prop2"]

    print "OK"

if __name__ == '__main__':
    test_kvmsg('-v' in sys.argv)
