/* openrenoir is licensed under CC BY-SA 4.0.
 * To view a copy of this license, visit
 * https://creativecommons.org/licenses/by-sa/4.0/.  */

@initialize:python@
@@
import lz4.block
import struct
from oroir_helper import *

@oroirf00@
identifier Q1;
expression V1 : script:python () { is_c_integer_literal (V1) };
position P1;
@@
  register const uint32_t Q1 = V1 ^ 0@P1;

@script:python oroirf01 depends on oroirf00@
Q1 << oroirf00.Q1;
V1 << oroirf00.V1;
P1 << oroirf00.P1;
X1;
@@
(V1, suf) = parse_c_integer_literal (V1)
Y1 = int (P1[0].line)
X1 = V1 ^ Y1
coccinelle.X1 = coccinelle.Cocci ().make_expr (str (X1) + suf)

@oroirf02 depends on oroirf00 && oroirf01@
identifier oroirf00.Q1;
expression oroirf00.V1, oroirf01.X1;
@@
- register const uint32_t Q1 = V1 ^ 0;
+ const uint32_t Q1 = X1 ^ __LINE__;
