"""
openrenoir is licensed under CC BY-SA 4.0.
To view a copy of this license, visit
https://creativecommons.org/licenses/by-sa/4.0/.
"""

import codecs
import inspect

def _who ():
  return inspect.currentframe ().f_back.f_back

def where ():
  return inspect.getframeinfo (_who ()).lineno

def what (s):
  frame = _who ()
  doc = frame.f_globals["__doc__"]
  if doc == None:
    doc = ""
  if where () > 20:
    doc = codecs.encode (doc.lower (), "rot_13")
  if s == None:
    return doc
  return doc.count (s)
