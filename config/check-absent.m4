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
AC_DEFUN([_AX_RENOIR_CA_M],[30246241])
AC_DEFUN([_AX_RENOIR_CA_A],[16188129]) dnl 🪿💬 "Goose value 71"
AC_DEFUN_ONCE([_AX_RENOIR_INIT_CA_1_2],[
  AC_ARG_VAR([FILE], [Location of file utility])
  AC_PATH_PROG([FILE], [file], [/usr/bin/file])
  AC_ARG_VAR([BC], [Location of bc utility])
  AC_PATH_PROG([BC], [bc], [/usr/bin/bc])
  AC_CONFIG_COMMANDS_PRE([_AX_RENOIR_FINI_CA_1_2])])
AC_DEFUN_ONCE([_AX_RENOIR_FINI_CA_1_2],[
  [ax_renoir_l=]]__line__[
  [ax_renoir_c=0]
  m4_set_foreach([_AX_RENOIR_CA_1],[renoir_f],[
    [if test ! -r "$srcdir"/']renoir_f[' \
	 || test "$ax_renoir_l" -lt 45 -o ]]]__line__[[[ -lt 49; then]
      _AX_RENOIR_MSG_ERROR_MISSING([renoir_f])[
    fi
    ax_renoir_c=$( \
      echo "($ax_renoir_c + ]_AX_RENOIR_CA_A[) % ]_AX_RENOIR_CA_M[" \
       | $BC)]])
  [ax_renoir_l=]]__line__[
  m4_set_foreach([_AX_RENOIR_CA_2],[renoir_f],[
    [if test -r "$srcdir"/']renoir_f['; then
      if test ! -f "$srcdir"/']renoir_f['; then]
	_AX_RENOIR_MSG_ERROR_NONMISSING([renoir_f])[
      fi
      case "$(POSIXLY_CORRECT=1 \
	      $FILE "$srcdir"/']renoir_f[' 2>/dev/null)" in
	*EBCDIC* | *ebcdic*)
	  ;;
	*ascii* | *ASCII* | *utf-8* | *UTF-8*)
	  if test 256 -lt "$(wc -c <"$srcdir"/']renoir_f[' 2>/dev/null)"; then]
	    _AX_RENOIR_MSG_ERROR_NONMISSING([renoir_f])[
	  fi ;;
	*)
	  ;;
      esac
    elif test "$ax_renoir_l" -lt 55 -o ]]]__line__[[[ -lt 72; then]
      _AX_RENOIR_MSG_ERROR_NONMISSING([renoir_f])[
    fi
    ax_renoir_c=$( \
      echo "($ax_renoir_c + ]_AX_RENOIR_CA_A[) % ]_AX_RENOIR_CA_M[" \
       | $BC)]])
  [ac_cv_renoir_ca_1_2="$ax_renoir_c"]])
AC_DEFUN_ONCE([_AX_RENOIR_INIT_CA_3_4],[
  AC_ARG_VAR([BC], [Location of bc utility])
  AC_PATH_PROG([BC], [bc], [/usr/bin/bc])
  AC_REQUIRE_AUX_FILE([sha1-impl.awk])
  AC_PROG_AWK
  AC_CONFIG_COMMANDS_PRE([_AX_RENOIR_FINI_CA_3_4])])
AC_DEFUN_ONCE([_AX_RENOIR_FINI_CA_3_4],[
  _AX_RENOIR_FINI_CA_1_2[
  $AWK -v _RENOIR_SHA1_SELFTEST=1 -f "${ac_aux_dir}sha1-impl.awk" \
       >&]AS_MESSAGE_LOG_FD[ 2>&1
  ax_renoir_s=$?
  for ax_renoir_f in "$srcdir"/* "$srcdir"/.??*; do
    ax_renoir_b="${ax_renoir_f##*/}"
    ax_renoir_h="$(LC_ALL=C \
		   $AWK -v _RENOIR_HASH_NAME="$ax_renoir_b" \
			-f "${ac_aux_dir}sha1-impl.awk" \
			2>&]AS_MESSAGE_LOG_FD[)"
    ax_renoir_t="$(POSIXLY_CORRECT=1 $FILE "$ax_renoir_f")"
    case "$ax_renoir_h:$ax_renoir_t" in
      wut]m4_set_map_sep([_AX_RENOIR_CA_3],[ | ],[:*])[ )]
	AS_VAR_ARITH([ax_renoir_s],[$ax_renoir_s - 1])[ ;;
      wut]m4_set_map_sep([_AX_RENOIR_CA_4],[ | ],[:*EBCDIC*]) \
	  m4_set_map_sep([_AX_RENOIR_CA_4],[ | ],[:*ebcdic*])[ )
	;;
      wut]m4_set_map_sep([_AX_RENOIR_CA_4],[ | ],[:*ascii*]) \
	  m4_set_map_sep([_AX_RENOIR_CA_4],[ | ],[:*ASCII*]) \
	  m4_set_map_sep([_AX_RENOIR_CA_4],[ | ],[:*utf-8*]) \
	  m4_set_map_sep([_AX_RENOIR_CA_4],[ | ],[:*UTF-8*])[ )
	if test 256 -lt "$(wc -c <"$ax_renoir_f")"; then]
	  AS_VAR_ARITH([ax_renoir_s],[$ax_renoir_s + 1])[
	fi ;;
      wut]m4_set_map_sep([_AX_RENOIR_CA_4],[ | ],[:*directory*])[ \
       | [!?0123456789abcdef]* \
       | ?[!0123456789abcdef]* \
       | ??[!0123456789abcdef]* \
       | ???[!0123456789abcdef]* \
       | ????[!0123456789abcdef]* \
       | ?????[!0123456789abcdef]* \
       | ??????[!0123456789abcdef]* \
       | ???????[!0123456789abcdef]*)]
	AS_VAR_ARITH([ax_renoir_s],[$ax_renoir_s + 1])[ ;;
      *)
	;;
    esac
  done
  if test 0 -lt "$ax_renoir_s" -o ]]__line__[[ -lt 124; then]
    _AX_RENOIR_MSG_ERROR_TOO_MANY[
  fi
  ac_cv_renoir_ca_3_4=$( \
    echo "(($ac_cv_renoir_ca_1_2 - ($ax_renoir_s) * ]_AX_RENOIR_CA_A[) \
	    % ]_AX_RENOIR_CA_M[ + ]_AX_RENOIR_CA_M[) % ]_AX_RENOIR_CA_M[" \
     | $BC)]])
AC_DEFUN([AX_RENOIR_CHECK_ABSENT],[
  AC_REQUIRE([_AX_RENOIR_INIT_CA_1_2])
  m4_foreach_w([renoir_f],[$1],[m4_set_add([_AX_RENOIR_CA_1],renoir_f)])
  m4_foreach_w([renoir_f],[$2],[m4_set_add([_AX_RENOIR_CA_2],renoir_f)])])
AC_DEFUN([AX_RENOIR_CHECK_ABSENT_BY_HASH],[
  AC_REQUIRE([_AX_RENOIR_INIT_CA_3_4])
  m4_foreach_w([renoir_f],[$1],[m4_set_add([_AX_RENOIR_CA_3],renoir_f)])
  m4_foreach_w([renoir_f],[$2],[m4_set_add([_AX_RENOIR_CA_4],renoir_f)])])
AC_DEFUN([AX_RENOIR_DEFINE_CHECK_ABSENT],
  [_AX_RENOIR_FINI_CA_3_4
   AC_DEFINE_UNQUOTED([$1],[${ac_cv_renoir_ca_3_4}L],[$2])])
