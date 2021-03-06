# Process this file with autoconf to produce a configure script.
# Configure template for mysql aes256 encrypt/decrypt UDF
#
# $Id$

AC_PREREQ(2.59)
AC_INIT([lib_mysqludf_aes256], [1.0.4], [http://oops.org])

AC_CONFIG_AUX_DIR([build])
AM_INIT_AUTOMAKE([-Wall -Werror -Wno-override foreign no-dependencies])
AM_MAINTAINER_MODE

AC_CONFIG_SRCDIR([src/mysql_aes256.c])
AC_CONFIG_HEADER([src/mysql_aes256_config.h])
AC_PREFIX_DEFAULT([/usr/local])

# checks for programs.
AC_PROG_CC
AC_PROG_INSTALL
AC_PROG_LN_S
AC_PROG_MAKE_SET
AM_PROG_AR
AC_PROG_LIBTOOL
AX_GL_VISIBILITY


AC_ARG_ENABLE(debug,
	[  --enable-debug                   enable debug falgs])

AC_ARG_WITH(mysql-plugins-dir,
	[  --with-mysql-plugins-dir=PATH    mysql plugins directory. [[default=/usr/local/lib]]
	                  This option is replace of --libdir option
	])

AC_SUBST([MYSQL_HEADER])
AC_ARG_WITH(mysql,
	[  --with-mysql=PATH       mysql prefix.])

if test "x$with_mysql_plugins_dir" = "xyes" -o "x$with_mysql_plugins_dir" = "xno"
then
	AC_MSG_ERROR([--with-mysql-plugins-dir requires path of plugin directory])
else
	if test -n "$with_mysql_plugins_dir"
	then
		libdir="$with_mysql_plugins_dir"
	fi
fi

if test "x$with_mysql" != "xno"
then
	MYSQL_PREFIX="$with_mysql"
fi

for i in $MYSQL_PREFIX /usr /uar/local /usr/local/mysql /opt/mysql
do
	if test -f "$i/include/mysql/mysql.h"; then
		MYSQL_HEADER="-I$i/include/mysql"
		break
	elif test -f "$i/include/mysql.h"; then
		MYSQL_HEADER="-I$i/include"
		break
	fi
done

# Checks for header files.
OLD_CPPFLAGS="$CPPFLAGS"
CPPFLAGS="$CPPFLAGS $MYSQL_HEADER"
AC_HEADER_STDC
AC_CHECK_HEADERS(
	[stdlib.h string.h mysql.h my_global.h my_sys.h],,
	[AC_MSG_ERROR([You must need $ac_header file to build this udf.])]
)
CPPFLAGS="$OLD_CPPFLAGS"

if test "x$enable_debug" = "xyes"
then
	CFLAGS=`echo $CFLAGS | sed 's/-[gO][0-9]*//g'`
	CFLAGS="$CFLAGS -O0 -g3 -DMY_AES256_DEBUG"
fi

# Checks for typedefs, structures, and compiler characteristics.
AC_C_CONST
AC_TYPE_SIZE_T

# Checks for library functions.
AC_FUNC_ERROR_AT_LINE
AC_FUNC_MALLOC

#CFLAGS="$CFLAGS -fPIC -shared -I/usr/include/mysql"
AC_CONFIG_FILES([Makefile src/Makefile])
AC_OUTPUT
