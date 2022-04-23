#exemplo de script que coloca imagens no terminal kitty, fonte: site oficial kitty

import sys
from base64 import standard_b64encode

def serialize_gr_command(cmd, payload=None):
   cmd = ','.join('{}={}'.format(k, v) for k, v in cmd.items())
   ans = []
   w = ans.append
   w(b'\033_G'), w(cmd.encode('ascii'))
   if payload:
      w(b';')
      w(payload)
   w(b'\033\\')
   return b''.join(ans)

def write_chunked(cmd, data):
   sys.stdout.buffer.write(serialize_gr_command({'a':'d'}))
   sys.stdout.flush()
   data = standard_b64encode(data)
   while data:
      chunk, data = data[:4096], data[4096:]
      m = 1 if data else 0
      cmd['m'] = m

#      sys.stdout.buffer.write(serialize_gr_command({'d':'a'}))
#      sys.stdout.flush()
#      cmd.clear()

      sys.stdout.buffer.write(serialize_gr_command(cmd, chunk))
      sys.stdout.flush()
      cmd.clear()


with open(sys.argv[-1], 'rb') as f:
    #write_chunked({'a': 'T', 'f': 100, 'w': 100, 'h' : 100, 'X' : 100, 'Y' : 20}, f.read())
    write_chunked({'a': 'T', 'f': 100, 'c': 0, 'r': 0}, f.read())
