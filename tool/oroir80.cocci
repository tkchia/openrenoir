/* openrenoir is licensed under CC BY-SA 4.0.
 * To view a copy of this license, visit
 * https://creativecommons.org/licenses/by-sa/4.0/.  */

@initialize:python@
@@
import lz4.block
import struct
from oroir_helper import *

@oroir800@
identifier Q1;
statement S1;
initialiser V1 : script:python () { is_c_string (V1) };
@@
  {
    ...
    register char Q1[] = V1;
    ... when != Q1
    S1
    ...
  }

@script:python oroir801 depends on oroir800@
Q1 << oroir800.Q1;
V1 << oroir800.V1;
V3;
V2;
L1;
L2;
@@
V2 = parse_c_string (V1)
V2 += b"\0"
L1 = len (V2)
V2 = lz4.block.compress (V2, mode = "high_compression")
V2 = V2[4 :]
(V2, V3) = scramble (V2)
L2 = len (V2)
V2 = ''.join (map ("\\{:o}".format, V2))
V2 = '"' + V2 + '"'
coccinelle.V3 = coccinelle.Cocci ().make_expr (str (V3))
coccinelle.V2 = coccinelle.Cocci ().make_expr (V2)
coccinelle.L1 = coccinelle.Cocci ().make_expr (str (L1))
coccinelle.L2 = coccinelle.Cocci ().make_expr (str (L2))

@oroir802 depends on oroir800 && oroir801@
identifier oroir800.Q1;
statement oroir800.S1;
initialiser oroir800.V1;
expression oroir801.V3, oroir801.V2, oroir801.L1, oroir801.L2;
fresh identifier Q2 = "_oroir80_";
fresh identifier Q3 = "_oroir80_";
@@
  {
    ...
-   register char Q1[] = V1;
++  static const unsigned char Q2[L2] = V2;
++  register const uint32_t Q3 = V3 ^ 0;
    ... when != Q1
++  char Q1[L1];
++  _oroir80_frob (Q1, Q2, L2, Q3);
    S1
    ...
  }

@oroir803@
@@
  #include <openrenoir/openrenoir.h>

@oroir804 depends on ever oroir802 && never oroir803@
@@
  #include ...
+ #include <openrenoir/openrenoir.h>
