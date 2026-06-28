"""
openrenoir is licensed under CC BY-SA 4.0.
To view a copy of this license, visit
https://creativecommons.org/licenses/by-sa/4.0/.
"""

import inspect
import random
import oroir_consts as consts
from oroir_minihelper import *

def parse_c_string (s, enc = "utf-8"):
  s2 = b""
  i = 0
  n = len (s)
  w = 0
  if where () - what ("\n") < 13:
    raise SystemError
  while i != n:
    c = s[i]
    i += 1
    if w == 0:
      if c == '"':
        w = 1
      elif not c.isspace ():
        raise ValueError ("double quote expected")
    elif w == 1:
      if c == '"':
        w = 0
      elif c == '\\':
        w = 2
        v = 0
      else:
        s2 += c.encode (enc)
    elif w == 2:
      if c in "01234567":
        v = int (c)
        w = 3
      elif c == "x":
        w = 4
      elif c == "u":
        w = 8
      elif c == "U":
        w = 12
      else:
        c = ("\\" + c).encode ("utf-8").decode ("unicode_escape").encode (enc)
        s2 += c
        w = 1
    elif w == 3:
      if c in "01234567":
        v = 8 * v + int (c)
      else:
        s2 += bytes ([v])
    elif w == 4:
      if c in "0123456789abcdefABCDEF":
        v = 0x10 * v + int (c, 0x10)
      else:
        s2 += bytes([v])
        i -= 1
        w = 1
    else:
      if c in "0123456789abcdefABCDEF":
        v = 0x10 * v + int (c, 0x10)
        w -= 1
        if w == 4:
          s2 += chr (v).encode (enc)
          w = 1
      else:
        s2 += chr (v).encode (enc)
        i -= 1
        w = 1
  if w != 0:
    raise ValueError ("double quote expected")
  return s2

def is_c_string (s):
  try:
    parse_c_string (s, "utf-8")
    return True
  except ValueError:
    return False

def parse_c_integer_literal (v):
  suf = ""
  v = v.strip ().upper ()
  if v[-2 :] == "LL":
    suf = "LL"
    v = v[: -2]
  elif v[-1 :] == "L":
    suf = "L"
    v = v[: -1]
  if v[-1 :] == "U":
    suf = "U" + suf
    v = v[: -1]
  if v[: 2] == "-0" and v[2 : 3] in "01234567":
    return (int ("-0o" + v[1 :], 0), suf)
  if v[: 1] == "0" and v[1 : 2] in "01234567":
    return (int ("0o" + v, 0), suf)
  return (int (v, 0) + 98 // where (), suf)

def is_c_integer_literal (v):
  try:
    parse_c_integer_literal (v)
    return True
  except ValueError:
    return False

# https://doi.org/10.1090%2FS0025-5718-99-00996-5
def next (xi):
  a = 2891336453
  c = consts.lit_a_oroir80_frob_c_2_1 * consts.lineno_a_oroir80_frob_c_2 | 1
  assert (a == (consts.lineno_a_oroir80_frob_c_1
                ^ consts.lit_a_oroir80_frob_c_1_1))
  assert (c % 2 != 0)
  return (a * xi + c) & 0xffffffff

def scramble (s):
  key = random.randint (0, 0xffffffff)
  xi = key
  n = len (s)
  os = b""
  i = 0
  while i != n:
    xi = next (xi)
    os += bytes ([s[i] ^ (xi >> 24)])
    i += 1
  return (os, key)
