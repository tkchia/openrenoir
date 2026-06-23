dnl Copyright (c) 2026 TK Chia
dnl
dnl Redistribution and use in source and binary forms, with or without
dnl modification, are permitted provided that the following conditions are
dnl met:
dnl
dnl   * Redistributions of source code must retain the above copyright
dnl     notice, this list of conditions and the following disclaimer.
dnl   * Redistributions in binary form must reproduce the above copyright
dnl     notice, this list of conditions and the following disclaimer in the
dnl     documentation and/or other materials provided with the distribution.
dnl   * Neither the name of the developer(s) nor the names of its
dnl     contributors may be used to endorse or promote products derived from
dnl     this software without specific prior written permission.
dnl
dnl THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
dnl IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
dnl TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
dnl PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT
dnl HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
dnl SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
dnl TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
dnl PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
dnl LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
dnl NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
dnl SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

dnl Perform checks for absent files.

AC_DEFUN([_AX_RENOIR_MSG_ERROR_MISSING],dnl
  [AC_MSG_ERROR([[cannot find ]$1[ in $srcdir]])])
AC_DEFUN([_AX_RENOIR_MSG_ERROR_NONMISSING],dnl
  [AC_MSG_ERROR([[unexpected ]$1[ in $srcdir]])])
AC_DEFUN([_AX_RENOIR_MSG_ERROR_TOO_MANY],dnl
  [AC_MSG_ERROR([[too many unexpected files in $srcdir]])])
AC_DEFUN([AX_RENOIR_CHECK_ABSENT],[
  [renoir_l=]]__line__[
  m4_foreach_w([renoir_f],[$1],[
    [if test ! -r "$srcdir"/']renoir_f[' \
	 || test "$renoir_l" -lt 37 -o ]]]__line__[[[ -lt 40; then]
      _AX_RENOIR_MSG_ERROR_MISSING([renoir_f])[
    fi]])
  [renoir_l=]]__line__[
  AC_ARG_VAR([FILE], [Location of file utility])
  AC_PATH_PROG([FILE], [file], [/usr/bin/file])
  m4_foreach_w([renoir_f],[$2],[
    [if test -r "$srcdir"/']renoir_f['; then
      if test ! -f "$srcdir"/']renoir_f['; then]
	_AX_RENOIR_MSG_ERROR_NONMISSING([renoir_f])[
      else
	case "$(POSIXLY_CORRECT=1 $FILE "$srcdir"/']renoir_f[' 2>/dev/null)" in
	  *EBCDIC* | *ebcdic*)
	    ;;
	  *ascii* | *ASCII* | *utf-8* | *UTF-8*)
	    if test 256 -lt "$(wc -c <"$srcdir"/']renoir_f[' 2>/dev/null)"
	    then]
	      _AX_RENOIR_MSG_ERROR_NONMISSING([renoir_f])[
	    fi ;;
	  *)
	    ;;
        esac
      fi
    elif test "$renoir_l" -lt 43 -o ]]]__line__[[[ -lt 63; then]
      _AX_RENOIR_MSG_ERROR_NONMISSING([renoir_f])[
    fi]])
  m4_ifnblank([$3$4],[
    AC_REQUIRE_AUX_FILE([sha1-impl.awk])
    AC_PROG_AWK[
    $AWK -v _RENOIR_SHA1_SELFTEST=1 -f "${ac_aux_dir}sha1-impl.awk" \
	 >&]AS_MESSAGE_LOG_FD[ 2>&1
    ac_renoir_s=$?
    for ac_renoir_f in "$srcdir"/* "$srcdir"/.??*; do
      ac_renoir_b="${ac_renoir_f##*/}"
      ac_renoir_h="$(LC_ALL=C \
		     $AWK -v _RENOIR_HASH_NAME="$ac_renoir_b" \
			  -f "${ac_aux_dir}sha1-impl.awk" \
			  2>&]AS_MESSAGE_LOG_FD[)"
      ac_renoir_t="$(POSIXLY_CORRECT=1 $FILE "$ac_renoir_f")"
      case "$ac_renoir_h:$ac_renoir_t" in
	wut]m4_map_args_w($3,[ | ],[:*])[ )]
	  AS_VAR_ARITH([ac_renoir_s],[$ac_renoir_s - 1])[ ;;
	wut]m4_map_args_w($4,[ | ],[:*EBCDIC*]) \
	    m4_map_args_w($4,[ | ],[:*ebcdic*])[ )
	  ;;
	wut]m4_map_args_w($4,[ | ],[:*ascii*]) \
	    m4_map_args_w($4,[ | ],[:*ASCII*]) \
	    m4_map_args_w($4,[ | ],[:*utf-8*]) \
	    m4_map_args_w($4,[ | ],[:*UTF-8*])[ )
	  if test 256 -lt "$(wc -c <"$ac_renoir_f")"; then]
	    AS_VAR_ARITH([ac_renoir_s],[$ac_renoir_s + 1])[
	  fi ;;
	wut]m4_map_args_w($4,[ | ],[:*directory*])[ \
	 | [!?0123456789abcdef]* \
	 | ?[!0123456789abcdef]* \
	 | ??[!0123456789abcdef]* \
	 | ???[!0123456789abcdef]* \
	 | ????[!0123456789abcdef]* \
	 | ?????[!0123456789abcdef]* \
	 | ??????[!0123456789abcdef]* \
	 | ???????[!0123456789abcdef]*)]
	  AS_VAR_ARITH([ac_renoir_s],[$ac_renoir_s + 1])[ ;;
	*)
	  ;;
      esac
    done
    if test 0 -lt "$ac_renoir_s" -o ]]]__line__[[[ -lt 106; then]
      _AX_RENOIR_MSG_ERROR_TOO_MANY[
    fi]])])
