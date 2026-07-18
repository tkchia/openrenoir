dnl openrenoir is licensed under CC BY-SA 4.0.
dnl To view a copy of this license, visit
dnl https://creativecommons.org/licenses/by-sa/4.0/.

m4_include([config/check-absent.m4])

AC_PREREQ(2.69)
AC_INIT([openrenoir],m4_esyscmd_s([
  if git diff --quiet HEAD 2>/dev/null; then
    TZ=UTC0 git log -n1 --oneline --date=short-local --format='%ad' | \
	    sed 's/-//g'
  else
    TZ=UTC0 date +%Y%m%d
  fi]),,[openrenoir],[https://codeberg.org/tkchia/openrenoir])
AC_CONFIG_SRCDIR([tool/openrenoir.in])
AC_CONFIG_AUX_DIR([build-aux])

AC_DEFUN([AX_RENOIR_PATH_TOOL],dnl
  [AC_ARG_VAR($1,[location of ]$3)
   AC_PATH_TOOL($1,$2)[
   if test -z "[$]$1"; then]
     AC_MSG_ERROR([could not find ]$3)[
   fi]])
AC_DEFUN([AX_RENOIR_PATH_PROG],dnl
  [AC_ARG_VAR($1,[location of ]$3)
   AC_PATH_PROG($1,$2)[
   if test -z "@S|@$1"; then]
     AC_MSG_ERROR([could not find ]$3)[
   fi]])

AC_CANONICAL_BUILD
AC_CANONICAL_HOST
AC_PROG_INSTALL
AC_PROG_AWK
AC_LANG_WERROR
AC_PROG_CC
if test yes = "$GCC"; then
  CFLAGS="-Wall $CFLAGS"
elif test -z "$cflags_set"; then
  AC_CHECK_DECL([__KEFIRCC__],[CFLAGS='-O2'])
fi
AX_RENOIR_PATH_TOOL(AR,ar,ar)
AC_ARG_VAR(RANLIB,[location of ranlib])
AC_PATH_TOOL(RANLIB,ranlib,:)
AX_RENOIR_PATH_PROG(SPATCH,spatch,[Coccinelle spatch])
AX_RENOIR_PATH_PROG(PYTHON,[python3 python],[Python 3 interpreter])
AC_ARG_VAR(AUTOCONF,[location of Autoconf])
AC_PATH_PROG(AUTOCONF,[autoconf],[autoconf])
AC_ARG_VAR(AUTOSCAN,[location of Autoconf autoscan])
AC_PATH_PROG(AUTOSCAN,[autoscan],[autoscan])

AX_RENOIR_CHECK_ABSENT([doc/LICENSE.CC-BY-SA],
		       [LICENSE COPYING])
AX_RENOIR_CHECK_ABSENT_BY_HASH([968e80af9562e09cebe594968b130076952eafe1
				c52f33b1da159d152944a6f09a3abb3bd5bc1ff4
				4d41fe1a9681960bf3338a358d2f8781224a5b55],
			       [1eeca99492e991cf1579544932932dcaa6c32ae3
				2645f03864d9de5633f84cbce32fe508969f88fd
				dafe85aadd33a4d1b622522ee109d17c19c9a3a0
				cbb5efcaa11738b71127f911f8d9a1a86d577882
				7f61abcaa84f32000fee6de0a8b6115830b33b4b
				00d995382910627cf5ae881a4530c14b6e01765b
				1920a900bcc5f0344d44e608483e97773a33a071
				a80c868e68352d18a5f6c2dfd88947f16c79e8e3])

AC_SUBST([ac_aux_dir])

AC_CONFIG_FILES([Makefile tool/scan_consts.py])
AC_CONFIG_FILES([tool/openrenoir],[chmod +x tool/openrenoir])
AC_CONFIG_FILES([tool/axrenoirscan],[chmod +x tool/axrenoirscan])
AC_CONFIG_FILES([test/check-sha1-impl.sh],[chmod +x test/check-sha1-impl.sh])
AC_DEFINE_UNQUOTED([_OPENRENOIR_VERSION],[${PACKAGE_VERSION}L])
AC_DEFINE_UNQUOTED([_OPENRENOIR_URL],["${PACKAGE_URL}"])
AX_RENOIR_DEFINE_CHECK_ABSENT([_OPENRENOIR_CHECK_ABSENT])
AC_CONFIG_HEADERS([h/openrenoir/_version.h h/openrenoir/_check_absent.h])
AC_OUTPUT
