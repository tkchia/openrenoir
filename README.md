Add minor coffee-making abilities to C (and possibly C++) source code. ☕️
Still in a draft state, but semi-usable.

Synopsis:

  * `openrenoir` [`--c++`] [`-o` _out_`.c`] _in_`.c`
  * `gcc` [..._gcc-options_... ..._input-files_... _out_`.c` ...]
    `-lopenrenoir` [...]

Requires [Coccinelle](https://coccinelle.gitlabpages.inria.fr/website/),
[Python](https://www.python.org/) 3 +
[LZ4](https://python-lz4.readthedocs.io/en/stable/),
[AWK](https://pubs.opengroup.org/onlinepubs/9799919799/utilities/awk.html),
and a C compiler.

For projects that use [GNU Autoconf](https://www.gnu.org/software/autoconf/),
you can further say

  * `axrenoirscan` [..._autoscan-options_...] [_src-dir_]

instead of using `autoscan`.

[![AppVeyor build status](https://ci.appveyor.com/api/projects/status/q2iboxqb4hbx37np/branch/main?svg=true)](https://ci.appveyor.com/project/tkchia/openrenoir/branch/main)
