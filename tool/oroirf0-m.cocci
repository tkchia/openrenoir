/* openrenoir is licensed under CC BY-SA 4.0.
 * To view a copy of this license, visit
 * https://creativecommons.org/licenses/by-sa/4.0/.  */

@initialize:python@
@@
from oroir_helper import *

@oroirf00@
identifier Q1, Q2;
expression V1 : script:python () { is_c_string (V1) };
expression V2 : script:python () { is_c_integer_literal (V2) };
@@
  static char const Q1[] = V1;
  ...
(
  register const uint32_t Q2 = V2 ^ 0;
|
  {
    ...
    register const uint32_t Q2 = V2 ^ 0;
    ...
  }
)

@script:python oroirf01 depends on oroirf00@
Q1 << oroirf00.Q1;
V1 << oroirf00.V1;
Q2 << oroirf00.Q2;
V2 << oroirf00.V2;
L1;
X2;
X3;
@@
V1 = parse_c_string (V1)
L1 = len (V1)
(V2, suf) = parse_c_integer_literal (V2)
(X1, X2) = mash (V1)
X3 = X1 ^ V2
coccinelle.L1 = coccinelle.Cocci ().make_expr (str (L1))
coccinelle.X2 = coccinelle.Cocci ().make_expr (str (X2) + suf)
coccinelle.X3 = coccinelle.Cocci ().make_expr (str (X3) + suf)

@oroirf02 depends on oroirf00 && oroirf01@
identifier oroirf00.Q1, oroirf00.Q2;
expression oroirf00.V1, oroirf00.V2, oroirf01.L1, oroirf01.X2, oroirf01.X3;
@@
- static char const
++static const char
    Q1[] = V1;
  ...
(
- register const uint32_t Q2 = V2 ^ 0;
++const uint32_t Q2 = X3 ^ _oroirf0_mash (Q1, L1, X2);
|
  {
    ...
-   register const uint32_t Q2 = V2 ^ 0;
++  const uint32_t Q2 = X3 ^ _oroirf0_mash (Q1, L1, X2);
    ...
  }
)

@oroirf03@
@@
  #include <openrenoir/openrenoir.h>

@oroirf04 depends on ever oroirf02 && never oroirf03@
@@
  #include ...
+ #include <openrenoir/openrenoir.h>
