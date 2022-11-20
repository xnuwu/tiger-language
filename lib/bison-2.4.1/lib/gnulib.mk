## DO NOT EDIT! GENERATED AUTOMATICALLY!
## Process this file with automake to produce Makefile.in.
# Copyright (C) 2002-2008 Free Software Foundation, Inc.
#
# This file is free software, distributed under the terms of the GNU
# General Public License.  As a special exception to the GNU General
# Public License, this file may be distributed as part of a program
# that contains a configuration script generated by Autoconf, under
# the same distribution terms as the rest of that program.
#
# Generated by gnulib-tool.
# Reproduce by: gnulib-tool --import --dir=. --local-dir=gl --lib=libbison --source-base=lib --m4-base=m4 --doc-base=doc --tests-base=tests --aux-dir=build-aux --no-libtool --macro-prefix=gl announce-gen argmatch c-strcase config-h configmake dirname error extensions fopen-safer getopt gettext git-version-gen gnumakefile hash inttypes javacomp-script javaexec-script malloc mbswidth obstack quote quotearg stdbool stpcpy strerror strtoul strverscmp unistd unistd-safer unlocked-io unsetenv verify warnings xalloc xalloc-die xstrndup

AUTOMAKE_OPTIONS = 1.5 gnits subdir-objects

SUBDIRS =
noinst_HEADERS =
noinst_LIBRARIES =
noinst_LTLIBRARIES =
EXTRA_DIST =
BUILT_SOURCES =
SUFFIXES =
MOSTLYCLEANFILES = core *.stackdump
MOSTLYCLEANDIRS =
CLEANFILES =
DISTCLEANFILES =
MAINTAINERCLEANFILES =

AM_CPPFLAGS =

noinst_LIBRARIES += libbison.a

libbison_a_SOURCES =
libbison_a_LIBADD = $(gl_LIBOBJS)
libbison_a_DEPENDENCIES = $(gl_LIBOBJS)
EXTRA_libbison_a_SOURCES =

## begin gnulib module announce-gen


EXTRA_DIST += $(top_srcdir)/build-aux/announce-gen

## end   gnulib module announce-gen

## begin gnulib module argmatch


EXTRA_DIST += argmatch.c argmatch.h

EXTRA_libbison_a_SOURCES += argmatch.c

## end   gnulib module argmatch

## begin gnulib module c-ctype

libbison_a_SOURCES += c-ctype.h c-ctype.c

## end   gnulib module c-ctype

## begin gnulib module c-strcase

libbison_a_SOURCES += c-strcase.h c-strcasecmp.c c-strncasecmp.c

## end   gnulib module c-strcase

## begin gnulib module configmake

# Retrieve values of the variables through 'configure' followed by
# 'make', not directly through 'configure', so that a user who
# sets some of these variables consistently on the 'make' command
# line gets correct results.
#
# One advantage of this approach, compared to the classical
# approach of adding -DLIBDIR=\"$(libdir)\" etc. to AM_CPPFLAGS,
# is that it protects against the use of undefined variables.
# If, say, $(libdir) is not set in the Makefile, LIBDIR is not
# defined by this module, and code using LIBDIR gives a
# compilation error.
#
# Another advantage is that 'make' output is shorter.
#
# Listed in the same order as the GNU makefile conventions.
# The Automake-defined pkg* macros are appended, in the order
# listed in the Automake 1.10a+ documentation.
configmake.h: Makefile
	rm -f $@-t $@
	{ echo '/* DO NOT EDIT! GENERATED AUTOMATICALLY! */'; \
	  echo '#define PREFIX "$(prefix)"'; \
	  echo '#define EXEC_PREFIX "$(exec_prefix)"'; \
	  echo '#define BINDIR "$(bindir)"'; \
	  echo '#define SBINDIR "$(sbindir)"'; \
	  echo '#define LIBEXECDIR "$(libexecdir)"'; \
	  echo '#define DATAROOTDIR "$(datarootdir)"'; \
	  echo '#define DATADIR "$(datadir)"'; \
	  echo '#define SYSCONFDIR "$(sysconfdir)"'; \
	  echo '#define SHAREDSTATEDIR "$(sharedstatedir)"'; \
	  echo '#define LOCALSTATEDIR "$(localstatedir)"'; \
	  echo '#define INCLUDEDIR "$(includedir)"'; \
	  echo '#define OLDINCLUDEDIR "$(oldincludedir)"'; \
	  echo '#define DOCDIR "$(docdir)"'; \
	  echo '#define INFODIR "$(infodir)"'; \
	  echo '#define HTMLDIR "$(htmldir)"'; \
	  echo '#define DVIDIR "$(dvidir)"'; \
	  echo '#define PDFDIR "$(pdfdir)"'; \
	  echo '#define PSDIR "$(psdir)"'; \
	  echo '#define LIBDIR "$(libdir)"'; \
	  echo '#define LISPDIR "$(lispdir)"'; \
	  echo '#define LOCALEDIR "$(localedir)"'; \
	  echo '#define MANDIR "$(mandir)"'; \
	  echo '#define MANEXT "$(manext)"'; \
	  echo '#define PKGDATADIR "$(pkgdatadir)"'; \
	  echo '#define PKGINCLUDEDIR "$(pkgincludedir)"'; \
	  echo '#define PKGLIBDIR "$(pkglibdir)"'; \
	  echo '#define PKGLIBEXECDIR "$(pkglibexecdir)"'; \
	} | sed '/""/d' > $@-t
	mv $@-t $@
BUILT_SOURCES += configmake.h
CLEANFILES += configmake.h configmake.h-t

## end   gnulib module configmake

## begin gnulib module dirname


EXTRA_DIST += basename.c dirname.c dirname.h stripslash.c

EXTRA_libbison_a_SOURCES += basename.c dirname.c stripslash.c

## end   gnulib module dirname

## begin gnulib module errno

BUILT_SOURCES += $(ERRNO_H)

# We need the following in order to create <errno.h> when the system
# doesn't have one that is POSIX compliant.
errno.h: errno.in.h
	rm -f $@-t $@
	{ echo '/* DO NOT EDIT! GENERATED AUTOMATICALLY! */' && \
	  sed -e 's|@''INCLUDE_NEXT''@|$(INCLUDE_NEXT)|g' \
	      -e 's|@''PRAGMA_SYSTEM_HEADER''@|@PRAGMA_SYSTEM_HEADER@|g' \
	      -e 's|@''NEXT_ERRNO_H''@|$(NEXT_ERRNO_H)|g' \
	      -e 's|@''EMULTIHOP_HIDDEN''@|$(EMULTIHOP_HIDDEN)|g' \
	      -e 's|@''EMULTIHOP_VALUE''@|$(EMULTIHOP_VALUE)|g' \
	      -e 's|@''ENOLINK_HIDDEN''@|$(ENOLINK_HIDDEN)|g' \
	      -e 's|@''ENOLINK_VALUE''@|$(ENOLINK_VALUE)|g' \
	      -e 's|@''EOVERFLOW_HIDDEN''@|$(EOVERFLOW_HIDDEN)|g' \
	      -e 's|@''EOVERFLOW_VALUE''@|$(EOVERFLOW_VALUE)|g' \
	      < $(srcdir)/errno.in.h; \
	} > $@-t
	mv $@-t $@
MOSTLYCLEANFILES += errno.h errno.h-t

EXTRA_DIST += errno.in.h

## end   gnulib module errno

## begin gnulib module error


EXTRA_DIST += error.c error.h

EXTRA_libbison_a_SOURCES += error.c

## end   gnulib module error

## begin gnulib module exitfail


EXTRA_DIST += exitfail.c exitfail.h

EXTRA_libbison_a_SOURCES += exitfail.c

## end   gnulib module exitfail

## begin gnulib module fopen-safer


EXTRA_DIST += fopen-safer.c stdio--.h stdio-safer.h

EXTRA_libbison_a_SOURCES += fopen-safer.c

## end   gnulib module fopen-safer

## begin gnulib module getopt

BUILT_SOURCES += $(GETOPT_H)

# We need the following in order to create <getopt.h> when the system
# doesn't have one that works with the given compiler.
getopt.h: getopt.in.h
	{ echo '/* DO NOT EDIT! GENERATED AUTOMATICALLY! */'; \
	  cat $(srcdir)/getopt.in.h; \
	} > $@-t
	mv -f $@-t $@
MOSTLYCLEANFILES += getopt.h getopt.h-t

EXTRA_DIST += getopt.c getopt.in.h getopt1.c getopt_int.h

EXTRA_libbison_a_SOURCES += getopt.c getopt1.c

## end   gnulib module getopt

## begin gnulib module gettext

# This is for those projects which use "gettextize --intl" to put a source-code
# copy of libintl into their package. In such projects, every Makefile.am needs
# -I$(top_builddir)/intl, so that <libintl.h> can be found in this directory.
# For the Makefile.ams in other directories it is the maintainer's
# responsibility; for the one from gnulib we do it here.
# This option has no effect when the user disables NLS (because then the intl
# directory contains no libintl.h file) or when the project does not use
# "gettextize --intl".
#AM_CPPFLAGS += -I$(top_builddir)/intl

EXTRA_DIST += $(top_srcdir)/build-aux/config.rpath

## end   gnulib module gettext

## begin gnulib module gettext-h

libbison_a_SOURCES += gettext.h

## end   gnulib module gettext-h

## begin gnulib module git-version-gen


EXTRA_DIST += $(top_srcdir)/build-aux/git-version-gen

## end   gnulib module git-version-gen

## begin gnulib module gnumakefile

distclean-local: clean-GNUmakefile
clean-GNUmakefile:
	test x'$(VPATH)' != x && rm -f $(top_builddir)/GNUmakefile || :

EXTRA_DIST += $(top_srcdir)/GNUmakefile

## end   gnulib module gnumakefile

## begin gnulib module hash


EXTRA_DIST += hash.c hash.h

EXTRA_libbison_a_SOURCES += hash.c

## end   gnulib module hash

## begin gnulib module havelib


EXTRA_DIST += $(top_srcdir)/build-aux/config.rpath

## end   gnulib module havelib

## begin gnulib module intprops


EXTRA_DIST += intprops.h

## end   gnulib module intprops

## begin gnulib module inttypes

BUILT_SOURCES += $(INTTYPES_H)

# We need the following in order to create <inttypes.h> when the system
# doesn't have one that works with the given compiler.
inttypes.h: inttypes.in.h
	rm -f $@-t $@
	{ echo '/* DO NOT EDIT! GENERATED AUTOMATICALLY! */'; \
	  sed -e 's/@''HAVE_INTTYPES_H''@/$(HAVE_INTTYPES_H)/g' \
	      -e 's|@''INCLUDE_NEXT''@|$(INCLUDE_NEXT)|g' \
	      -e 's|@''PRAGMA_SYSTEM_HEADER''@|@PRAGMA_SYSTEM_HEADER@|g' \
	      -e 's|@''NEXT_INTTYPES_H''@|$(NEXT_INTTYPES_H)|g' \
	      -e 's/@''PRI_MACROS_BROKEN''@/$(PRI_MACROS_BROKEN)/g' \
	      -e 's/@''HAVE_LONG_LONG_INT''@/$(HAVE_LONG_LONG_INT)/g' \
	      -e 's/@''HAVE_UNSIGNED_LONG_LONG_INT''@/$(HAVE_UNSIGNED_LONG_LONG_INT)/g' \
	      -e 's/@''PRIPTR_PREFIX''@/$(PRIPTR_PREFIX)/g' \
	      -e 's/@''GNULIB_IMAXABS''@/$(GNULIB_IMAXABS)/g' \
	      -e 's/@''GNULIB_IMAXDIV''@/$(GNULIB_IMAXDIV)/g' \
	      -e 's/@''GNULIB_STRTOIMAX''@/$(GNULIB_STRTOIMAX)/g' \
	      -e 's/@''GNULIB_STRTOUMAX''@/$(GNULIB_STRTOUMAX)/g' \
	      -e 's/@''HAVE_DECL_IMAXABS''@/$(HAVE_DECL_IMAXABS)/g' \
	      -e 's/@''HAVE_DECL_IMAXDIV''@/$(HAVE_DECL_IMAXDIV)/g' \
	      -e 's/@''HAVE_DECL_STRTOIMAX''@/$(HAVE_DECL_STRTOIMAX)/g' \
	      -e 's/@''HAVE_DECL_STRTOUMAX''@/$(HAVE_DECL_STRTOUMAX)/g' \
	      -e 's/@''INT32_MAX_LT_INTMAX_MAX''@/$(INT32_MAX_LT_INTMAX_MAX)/g' \
	      -e 's/@''INT64_MAX_EQ_LONG_MAX''@/$(INT64_MAX_EQ_LONG_MAX)/g' \
	      -e 's/@''UINT32_MAX_LT_UINTMAX_MAX''@/$(UINT32_MAX_LT_UINTMAX_MAX)/g' \
	      -e 's/@''UINT64_MAX_EQ_ULONG_MAX''@/$(UINT64_MAX_EQ_ULONG_MAX)/g' \
	      -e '/definition of GL_LINK_WARNING/r $(LINK_WARNING_H)' \
	      < $(srcdir)/inttypes.in.h; \
	} > $@-t
	mv $@-t $@
MOSTLYCLEANFILES += inttypes.h inttypes.h-t

EXTRA_DIST += inttypes.in.h

## end   gnulib module inttypes

## begin gnulib module javacomp-script


EXTRA_DIST += $(top_srcdir)/build-aux/javacomp.sh.in

## end   gnulib module javacomp-script

## begin gnulib module javaexec-script


EXTRA_DIST += $(top_srcdir)/build-aux/javaexec.sh.in

## end   gnulib module javaexec-script

## begin gnulib module link-warning

LINK_WARNING_H=$(top_srcdir)/build-aux/link-warning.h

EXTRA_DIST += $(top_srcdir)/build-aux/link-warning.h

## end   gnulib module link-warning

## begin gnulib module localcharset

libbison_a_SOURCES += localcharset.h localcharset.c

# We need the following in order to install a simple file in $(libdir)
# which is shared with other installed packages. We use a list of referencing
# packages so that "make uninstall" will remove the file if and only if it
# is not used by another installed package.
# On systems with glibc-2.1 or newer, the file is redundant, therefore we
# avoid installing it.

all-local: charset.alias ref-add.sed ref-del.sed

charset_alias = $(DESTDIR)$(libdir)/charset.alias
charset_tmp = $(DESTDIR)$(libdir)/charset.tmp
install-exec-local: all-local
	test $(GLIBC21) != no || $(mkinstalldirs) $(DESTDIR)$(libdir)
	if test -f $(charset_alias); then \
	  sed -f ref-add.sed $(charset_alias) > $(charset_tmp) ; \
	  $(INSTALL_DATA) $(charset_tmp) $(charset_alias) ; \
	  rm -f $(charset_tmp) ; \
	else \
	  if test $(GLIBC21) = no; then \
	    sed -f ref-add.sed charset.alias > $(charset_tmp) ; \
	    $(INSTALL_DATA) $(charset_tmp) $(charset_alias) ; \
	    rm -f $(charset_tmp) ; \
	  fi ; \
	fi

uninstall-local: all-local
	if test -f $(charset_alias); then \
	  sed -f ref-del.sed $(charset_alias) > $(charset_tmp); \
	  if grep '^# Packages using this file: $$' $(charset_tmp) \
	      > /dev/null; then \
	    rm -f $(charset_alias); \
	  else \
	    $(INSTALL_DATA) $(charset_tmp) $(charset_alias); \
	  fi; \
	  rm -f $(charset_tmp); \
	fi

charset.alias: config.charset
	rm -f t-$@ $@
	$(SHELL) $(srcdir)/config.charset '$(host)' > t-$@
	mv t-$@ $@

SUFFIXES += .sed .sin
.sin.sed:
	rm -f t-$@ $@
	sed -e '/^#/d' -e 's/@''PACKAGE''@/$(PACKAGE)/g' $< > t-$@
	mv t-$@ $@

CLEANFILES += charset.alias ref-add.sed ref-del.sed

EXTRA_DIST += config.charset ref-add.sin ref-del.sin

## end   gnulib module localcharset

## begin gnulib module malloc


EXTRA_DIST += malloc.c

EXTRA_libbison_a_SOURCES += malloc.c

## end   gnulib module malloc

## begin gnulib module malloc-posix


EXTRA_DIST += malloc.c

EXTRA_libbison_a_SOURCES += malloc.c

## end   gnulib module malloc-posix

## begin gnulib module mbswidth

libbison_a_SOURCES += mbswidth.h mbswidth.c

## end   gnulib module mbswidth

## begin gnulib module obstack


EXTRA_DIST += obstack.c obstack.h

EXTRA_libbison_a_SOURCES += obstack.c

## end   gnulib module obstack

## begin gnulib module quote


EXTRA_DIST += quote.c quote.h

EXTRA_libbison_a_SOURCES += quote.c

## end   gnulib module quote

## begin gnulib module quotearg


EXTRA_DIST += quotearg.c quotearg.h

EXTRA_libbison_a_SOURCES += quotearg.c

## end   gnulib module quotearg

## begin gnulib module stdbool

BUILT_SOURCES += $(STDBOOL_H)

# We need the following in order to create <stdbool.h> when the system
# doesn't have one that works.
stdbool.h: stdbool.in.h
	rm -f $@-t $@
	{ echo '/* DO NOT EDIT! GENERATED AUTOMATICALLY! */'; \
	  sed -e 's/@''HAVE__BOOL''@/$(HAVE__BOOL)/g' < $(srcdir)/stdbool.in.h; \
	} > $@-t
	mv $@-t $@
MOSTLYCLEANFILES += stdbool.h stdbool.h-t

EXTRA_DIST += stdbool.in.h

## end   gnulib module stdbool

## begin gnulib module stdint

BUILT_SOURCES += $(STDINT_H)

# We need the following in order to create <stdint.h> when the system
# doesn't have one that works with the given compiler.
stdint.h: stdint.in.h
	rm -f $@-t $@
	{ echo '/* DO NOT EDIT! GENERATED AUTOMATICALLY! */'; \
	  sed -e 's/@''HAVE_STDINT_H''@/$(HAVE_STDINT_H)/g' \
	      -e 's|@''INCLUDE_NEXT''@|$(INCLUDE_NEXT)|g' \
	      -e 's|@''PRAGMA_SYSTEM_HEADER''@|@PRAGMA_SYSTEM_HEADER@|g' \
	      -e 's|@''NEXT_STDINT_H''@|$(NEXT_STDINT_H)|g' \
	      -e 's/@''HAVE_SYS_TYPES_H''@/$(HAVE_SYS_TYPES_H)/g' \
	      -e 's/@''HAVE_INTTYPES_H''@/$(HAVE_INTTYPES_H)/g' \
	      -e 's/@''HAVE_SYS_INTTYPES_H''@/$(HAVE_SYS_INTTYPES_H)/g' \
	      -e 's/@''HAVE_SYS_BITYPES_H''@/$(HAVE_SYS_BITYPES_H)/g' \
	      -e 's/@''HAVE_LONG_LONG_INT''@/$(HAVE_LONG_LONG_INT)/g' \
	      -e 's/@''HAVE_UNSIGNED_LONG_LONG_INT''@/$(HAVE_UNSIGNED_LONG_LONG_INT)/g' \
	      -e 's/@''BITSIZEOF_PTRDIFF_T''@/$(BITSIZEOF_PTRDIFF_T)/g' \
	      -e 's/@''PTRDIFF_T_SUFFIX''@/$(PTRDIFF_T_SUFFIX)/g' \
	      -e 's/@''BITSIZEOF_SIG_ATOMIC_T''@/$(BITSIZEOF_SIG_ATOMIC_T)/g' \
	      -e 's/@''HAVE_SIGNED_SIG_ATOMIC_T''@/$(HAVE_SIGNED_SIG_ATOMIC_T)/g' \
	      -e 's/@''SIG_ATOMIC_T_SUFFIX''@/$(SIG_ATOMIC_T_SUFFIX)/g' \
	      -e 's/@''BITSIZEOF_SIZE_T''@/$(BITSIZEOF_SIZE_T)/g' \
	      -e 's/@''SIZE_T_SUFFIX''@/$(SIZE_T_SUFFIX)/g' \
	      -e 's/@''BITSIZEOF_WCHAR_T''@/$(BITSIZEOF_WCHAR_T)/g' \
	      -e 's/@''HAVE_SIGNED_WCHAR_T''@/$(HAVE_SIGNED_WCHAR_T)/g' \
	      -e 's/@''WCHAR_T_SUFFIX''@/$(WCHAR_T_SUFFIX)/g' \
	      -e 's/@''BITSIZEOF_WINT_T''@/$(BITSIZEOF_WINT_T)/g' \
	      -e 's/@''HAVE_SIGNED_WINT_T''@/$(HAVE_SIGNED_WINT_T)/g' \
	      -e 's/@''WINT_T_SUFFIX''@/$(WINT_T_SUFFIX)/g' \
	      < $(srcdir)/stdint.in.h; \
	} > $@-t
	mv $@-t $@
MOSTLYCLEANFILES += stdint.h stdint.h-t

EXTRA_DIST += stdint.in.h

## end   gnulib module stdint

## begin gnulib module stdlib

BUILT_SOURCES += stdlib.h

# We need the following in order to create <stdlib.h> when the system
# doesn't have one that works with the given compiler.
stdlib.h: stdlib.in.h
	rm -f $@-t $@
	{ echo '/* DO NOT EDIT! GENERATED AUTOMATICALLY! */' && \
	  sed -e 's|@''INCLUDE_NEXT''@|$(INCLUDE_NEXT)|g' \
	      -e 's|@''PRAGMA_SYSTEM_HEADER''@|@PRAGMA_SYSTEM_HEADER@|g' \
	      -e 's|@''NEXT_STDLIB_H''@|$(NEXT_STDLIB_H)|g' \
	      -e 's|@''GNULIB_MALLOC_POSIX''@|$(GNULIB_MALLOC_POSIX)|g' \
	      -e 's|@''GNULIB_REALLOC_POSIX''@|$(GNULIB_REALLOC_POSIX)|g' \
	      -e 's|@''GNULIB_CALLOC_POSIX''@|$(GNULIB_CALLOC_POSIX)|g' \
	      -e 's|@''GNULIB_ATOLL''@|$(GNULIB_ATOLL)|g' \
	      -e 's|@''GNULIB_GETLOADAVG''@|$(GNULIB_GETLOADAVG)|g' \
	      -e 's|@''GNULIB_GETSUBOPT''@|$(GNULIB_GETSUBOPT)|g' \
	      -e 's|@''GNULIB_MKDTEMP''@|$(GNULIB_MKDTEMP)|g' \
	      -e 's|@''GNULIB_MKSTEMP''@|$(GNULIB_MKSTEMP)|g' \
	      -e 's|@''GNULIB_PUTENV''@|$(GNULIB_PUTENV)|g' \
	      -e 's|@''GNULIB_RANDOM_R''@|$(GNULIB_RANDOM_R)|g' \
	      -e 's|@''GNULIB_RPMATCH''@|$(GNULIB_RPMATCH)|g' \
	      -e 's|@''GNULIB_SETENV''@|$(GNULIB_SETENV)|g' \
	      -e 's|@''GNULIB_STRTOD''@|$(GNULIB_STRTOD)|g' \
	      -e 's|@''GNULIB_STRTOLL''@|$(GNULIB_STRTOLL)|g' \
	      -e 's|@''GNULIB_STRTOULL''@|$(GNULIB_STRTOULL)|g' \
	      -e 's|@''GNULIB_UNSETENV''@|$(GNULIB_UNSETENV)|g' \
	      -e 's|@''HAVE_ATOLL''@|$(HAVE_ATOLL)|g' \
	      -e 's|@''HAVE_CALLOC_POSIX''@|$(HAVE_CALLOC_POSIX)|g' \
	      -e 's|@''HAVE_GETSUBOPT''@|$(HAVE_GETSUBOPT)|g' \
	      -e 's|@''HAVE_MALLOC_POSIX''@|$(HAVE_MALLOC_POSIX)|g' \
	      -e 's|@''HAVE_MKDTEMP''@|$(HAVE_MKDTEMP)|g' \
	      -e 's|@''HAVE_REALLOC_POSIX''@|$(HAVE_REALLOC_POSIX)|g' \
	      -e 's|@''HAVE_RANDOM_R''@|$(HAVE_RANDOM_R)|g' \
	      -e 's|@''HAVE_RPMATCH''@|$(HAVE_RPMATCH)|g' \
	      -e 's|@''HAVE_SETENV''@|$(HAVE_SETENV)|g' \
	      -e 's|@''HAVE_STRTOD''@|$(HAVE_STRTOD)|g' \
	      -e 's|@''HAVE_STRTOLL''@|$(HAVE_STRTOLL)|g' \
	      -e 's|@''HAVE_STRTOULL''@|$(HAVE_STRTOULL)|g' \
	      -e 's|@''HAVE_STRUCT_RANDOM_DATA''@|$(HAVE_STRUCT_RANDOM_DATA)|g' \
	      -e 's|@''HAVE_SYS_LOADAVG_H''@|$(HAVE_SYS_LOADAVG_H)|g' \
	      -e 's|@''HAVE_UNSETENV''@|$(HAVE_UNSETENV)|g' \
	      -e 's|@''HAVE_DECL_GETLOADAVG''@|$(HAVE_DECL_GETLOADAVG)|g' \
	      -e 's|@''REPLACE_MKSTEMP''@|$(REPLACE_MKSTEMP)|g' \
	      -e 's|@''REPLACE_PUTENV''@|$(REPLACE_PUTENV)|g' \
	      -e 's|@''REPLACE_STRTOD''@|$(REPLACE_STRTOD)|g' \
	      -e 's|@''VOID_UNSETENV''@|$(VOID_UNSETENV)|g' \
	      -e '/definition of GL_LINK_WARNING/r $(LINK_WARNING_H)' \
	      < $(srcdir)/stdlib.in.h; \
	} > $@-t
	mv $@-t $@
MOSTLYCLEANFILES += stdlib.h stdlib.h-t

EXTRA_DIST += stdlib.in.h

## end   gnulib module stdlib

## begin gnulib module stpcpy


EXTRA_DIST += stpcpy.c

EXTRA_libbison_a_SOURCES += stpcpy.c

## end   gnulib module stpcpy

## begin gnulib module streq


EXTRA_DIST += streq.h

## end   gnulib module streq

## begin gnulib module strerror


EXTRA_DIST += strerror.c

EXTRA_libbison_a_SOURCES += strerror.c

## end   gnulib module strerror

## begin gnulib module string

BUILT_SOURCES += string.h

# We need the following in order to create <string.h> when the system
# doesn't have one that works with the given compiler.
string.h: string.in.h
	rm -f $@-t $@
	{ echo '/* DO NOT EDIT! GENERATED AUTOMATICALLY! */' && \
	  sed -e 's|@''INCLUDE_NEXT''@|$(INCLUDE_NEXT)|g' \
	      -e 's|@''PRAGMA_SYSTEM_HEADER''@|@PRAGMA_SYSTEM_HEADER@|g' \
	      -e 's|@''NEXT_STRING_H''@|$(NEXT_STRING_H)|g' \
	      -e 's|@''GNULIB_MBSLEN''@|$(GNULIB_MBSLEN)|g' \
	      -e 's|@''GNULIB_MBSNLEN''@|$(GNULIB_MBSNLEN)|g' \
	      -e 's|@''GNULIB_MBSCHR''@|$(GNULIB_MBSCHR)|g' \
	      -e 's|@''GNULIB_MBSRCHR''@|$(GNULIB_MBSRCHR)|g' \
	      -e 's|@''GNULIB_MBSSTR''@|$(GNULIB_MBSSTR)|g' \
	      -e 's|@''GNULIB_MBSCASECMP''@|$(GNULIB_MBSCASECMP)|g' \
	      -e 's|@''GNULIB_MBSNCASECMP''@|$(GNULIB_MBSNCASECMP)|g' \
	      -e 's|@''GNULIB_MBSPCASECMP''@|$(GNULIB_MBSPCASECMP)|g' \
	      -e 's|@''GNULIB_MBSCASESTR''@|$(GNULIB_MBSCASESTR)|g' \
	      -e 's|@''GNULIB_MBSCSPN''@|$(GNULIB_MBSCSPN)|g' \
	      -e 's|@''GNULIB_MBSPBRK''@|$(GNULIB_MBSPBRK)|g' \
	      -e 's|@''GNULIB_MBSSPN''@|$(GNULIB_MBSSPN)|g' \
	      -e 's|@''GNULIB_MBSSEP''@|$(GNULIB_MBSSEP)|g' \
	      -e 's|@''GNULIB_MBSTOK_R''@|$(GNULIB_MBSTOK_R)|g' \
	      -e 's|@''GNULIB_MEMMEM''@|$(GNULIB_MEMMEM)|g' \
	      -e 's|@''GNULIB_MEMPCPY''@|$(GNULIB_MEMPCPY)|g' \
	      -e 's|@''GNULIB_MEMRCHR''@|$(GNULIB_MEMRCHR)|g' \
	      -e 's|@''GNULIB_RAWMEMCHR''@|$(GNULIB_RAWMEMCHR)|g' \
	      -e 's|@''GNULIB_STPCPY''@|$(GNULIB_STPCPY)|g' \
	      -e 's|@''GNULIB_STPNCPY''@|$(GNULIB_STPNCPY)|g' \
	      -e 's|@''GNULIB_STRCHRNUL''@|$(GNULIB_STRCHRNUL)|g' \
	      -e 's|@''GNULIB_STRDUP''@|$(GNULIB_STRDUP)|g' \
	      -e 's|@''GNULIB_STRNDUP''@|$(GNULIB_STRNDUP)|g' \
	      -e 's|@''GNULIB_STRNLEN''@|$(GNULIB_STRNLEN)|g' \
	      -e 's|@''GNULIB_STRPBRK''@|$(GNULIB_STRPBRK)|g' \
	      -e 's|@''GNULIB_STRSEP''@|$(GNULIB_STRSEP)|g' \
	      -e 's|@''GNULIB_STRSTR''@|$(GNULIB_STRSTR)|g' \
	      -e 's|@''GNULIB_STRCASESTR''@|$(GNULIB_STRCASESTR)|g' \
	      -e 's|@''GNULIB_STRTOK_R''@|$(GNULIB_STRTOK_R)|g' \
	      -e 's|@''GNULIB_STRERROR''@|$(GNULIB_STRERROR)|g' \
	      -e 's|@''GNULIB_STRSIGNAL''@|$(GNULIB_STRSIGNAL)|g' \
	      -e 's|@''GNULIB_STRVERSCMP''@|$(GNULIB_STRVERSCMP)|g' \
	      -e 's|@''HAVE_DECL_MEMMEM''@|$(HAVE_DECL_MEMMEM)|g' \
	      -e 's|@''HAVE_MEMPCPY''@|$(HAVE_MEMPCPY)|g' \
	      -e 's|@''HAVE_DECL_MEMRCHR''@|$(HAVE_DECL_MEMRCHR)|g' \
	      -e 's|@''HAVE_RAWMEMCHR''@|$(HAVE_RAWMEMCHR)|g' \
	      -e 's|@''HAVE_STPCPY''@|$(HAVE_STPCPY)|g' \
	      -e 's|@''HAVE_STPNCPY''@|$(HAVE_STPNCPY)|g' \
	      -e 's|@''HAVE_STRCHRNUL''@|$(HAVE_STRCHRNUL)|g' \
	      -e 's|@''HAVE_DECL_STRDUP''@|$(HAVE_DECL_STRDUP)|g' \
	      -e 's|@''HAVE_STRNDUP''@|$(HAVE_STRNDUP)|g' \
	      -e 's|@''HAVE_DECL_STRNDUP''@|$(HAVE_DECL_STRNDUP)|g' \
	      -e 's|@''HAVE_DECL_STRNLEN''@|$(HAVE_DECL_STRNLEN)|g' \
	      -e 's|@''HAVE_STRPBRK''@|$(HAVE_STRPBRK)|g' \
	      -e 's|@''HAVE_STRSEP''@|$(HAVE_STRSEP)|g' \
	      -e 's|@''HAVE_STRCASESTR''@|$(HAVE_STRCASESTR)|g' \
	      -e 's|@''HAVE_DECL_STRTOK_R''@|$(HAVE_DECL_STRTOK_R)|g' \
	      -e 's|@''HAVE_DECL_STRERROR''@|$(HAVE_DECL_STRERROR)|g' \
	      -e 's|@''HAVE_DECL_STRSIGNAL''@|$(HAVE_DECL_STRSIGNAL)|g' \
	      -e 's|@''HAVE_STRVERSCMP''@|$(HAVE_STRVERSCMP)|g' \
	      -e 's|@''REPLACE_MEMMEM''@|$(REPLACE_MEMMEM)|g' \
	      -e 's|@''REPLACE_STRCASESTR''@|$(REPLACE_STRCASESTR)|g' \
	      -e 's|@''REPLACE_STRDUP''@|$(REPLACE_STRDUP)|g' \
	      -e 's|@''REPLACE_STRSTR''@|$(REPLACE_STRSTR)|g' \
	      -e 's|@''REPLACE_STRERROR''@|$(REPLACE_STRERROR)|g' \
	      -e 's|@''REPLACE_STRSIGNAL''@|$(REPLACE_STRSIGNAL)|g' \
	      -e '/definition of GL_LINK_WARNING/r $(LINK_WARNING_H)' \
	      < $(srcdir)/string.in.h; \
	} > $@-t
	mv $@-t $@
MOSTLYCLEANFILES += string.h string.h-t

EXTRA_DIST += string.in.h

## end   gnulib module string

## begin gnulib module strndup


EXTRA_DIST += strndup.c

EXTRA_libbison_a_SOURCES += strndup.c

## end   gnulib module strndup

## begin gnulib module strnlen


EXTRA_DIST += strnlen.c

EXTRA_libbison_a_SOURCES += strnlen.c

## end   gnulib module strnlen

## begin gnulib module strtol


EXTRA_DIST += strtol.c

EXTRA_libbison_a_SOURCES += strtol.c

## end   gnulib module strtol

## begin gnulib module strtoul


EXTRA_DIST += strtoul.c

EXTRA_libbison_a_SOURCES += strtoul.c

## end   gnulib module strtoul

## begin gnulib module strverscmp


EXTRA_DIST += strverscmp.c

EXTRA_libbison_a_SOURCES += strverscmp.c

## end   gnulib module strverscmp

## begin gnulib module unistd

BUILT_SOURCES += unistd.h

# We need the following in order to create an empty placeholder for
# <unistd.h> when the system doesn't have one.
unistd.h: unistd.in.h
	rm -f $@-t $@
	{ echo '/* DO NOT EDIT! GENERATED AUTOMATICALLY! */'; \
	  sed -e 's|@''HAVE_UNISTD_H''@|$(HAVE_UNISTD_H)|g' \
	      -e 's|@''INCLUDE_NEXT''@|$(INCLUDE_NEXT)|g' \
	      -e 's|@''PRAGMA_SYSTEM_HEADER''@|@PRAGMA_SYSTEM_HEADER@|g' \
	      -e 's|@''NEXT_UNISTD_H''@|$(NEXT_UNISTD_H)|g' \
	      -e 's|@''GNULIB_CHOWN''@|$(GNULIB_CHOWN)|g' \
	      -e 's|@''GNULIB_CLOSE''@|$(GNULIB_CLOSE)|g' \
	      -e 's|@''GNULIB_DUP2''@|$(GNULIB_DUP2)|g' \
	      -e 's|@''GNULIB_ENVIRON''@|$(GNULIB_ENVIRON)|g' \
	      -e 's|@''GNULIB_EUIDACCESS''@|$(GNULIB_EUIDACCESS)|g' \
	      -e 's|@''GNULIB_FCHDIR''@|$(GNULIB_FCHDIR)|g' \
	      -e 's|@''GNULIB_FSYNC''@|$(GNULIB_FSYNC)|g' \
	      -e 's|@''GNULIB_FTRUNCATE''@|$(GNULIB_FTRUNCATE)|g' \
	      -e 's|@''GNULIB_GETCWD''@|$(GNULIB_GETCWD)|g' \
	      -e 's|@''GNULIB_GETDOMAINNAME''@|$(GNULIB_GETDOMAINNAME)|g' \
	      -e 's|@''GNULIB_GETDTABLESIZE''@|$(GNULIB_GETDTABLESIZE)|g' \
	      -e 's|@''GNULIB_GETHOSTNAME''@|$(GNULIB_GETHOSTNAME)|g' \
	      -e 's|@''GNULIB_GETLOGIN_R''@|$(GNULIB_GETLOGIN_R)|g' \
	      -e 's|@''GNULIB_GETPAGESIZE''@|$(GNULIB_GETPAGESIZE)|g' \
	      -e 's|@''GNULIB_GETUSERSHELL''@|$(GNULIB_GETUSERSHELL)|g' \
	      -e 's|@''GNULIB_LCHOWN''@|$(GNULIB_LCHOWN)|g' \
	      -e 's|@''GNULIB_LSEEK''@|$(GNULIB_LSEEK)|g' \
	      -e 's|@''GNULIB_READLINK''@|$(GNULIB_READLINK)|g' \
	      -e 's|@''GNULIB_SLEEP''@|$(GNULIB_SLEEP)|g' \
	      -e 's|@''GNULIB_UNISTD_H_SIGPIPE''@|$(GNULIB_UNISTD_H_SIGPIPE)|g' \
	      -e 's|@''GNULIB_WRITE''@|$(GNULIB_WRITE)|g' \
	      -e 's|@''HAVE_DUP2''@|$(HAVE_DUP2)|g' \
	      -e 's|@''HAVE_EUIDACCESS''@|$(HAVE_EUIDACCESS)|g' \
	      -e 's|@''HAVE_FSYNC''@|$(HAVE_FSYNC)|g' \
	      -e 's|@''HAVE_FTRUNCATE''@|$(HAVE_FTRUNCATE)|g' \
	      -e 's|@''HAVE_GETDOMAINNAME''@|$(HAVE_GETDOMAINNAME)|g' \
	      -e 's|@''HAVE_GETDTABLESIZE''@|$(HAVE_GETDTABLESIZE)|g' \
	      -e 's|@''HAVE_GETHOSTNAME''@|$(HAVE_GETHOSTNAME)|g' \
	      -e 's|@''HAVE_GETPAGESIZE''@|$(HAVE_GETPAGESIZE)|g' \
	      -e 's|@''HAVE_GETUSERSHELL''@|$(HAVE_GETUSERSHELL)|g' \
	      -e 's|@''HAVE_READLINK''@|$(HAVE_READLINK)|g' \
	      -e 's|@''HAVE_SLEEP''@|$(HAVE_SLEEP)|g' \
	      -e 's|@''HAVE_DECL_ENVIRON''@|$(HAVE_DECL_ENVIRON)|g' \
	      -e 's|@''HAVE_DECL_GETLOGIN_R''@|$(HAVE_DECL_GETLOGIN_R)|g' \
	      -e 's|@''HAVE_OS_H''@|$(HAVE_OS_H)|g' \
	      -e 's|@''HAVE_SYS_PARAM_H''@|$(HAVE_SYS_PARAM_H)|g' \
	      -e 's|@''REPLACE_CHOWN''@|$(REPLACE_CHOWN)|g' \
	      -e 's|@''REPLACE_CLOSE''@|$(REPLACE_CLOSE)|g' \
	      -e 's|@''REPLACE_FCHDIR''@|$(REPLACE_FCHDIR)|g' \
	      -e 's|@''REPLACE_GETCWD''@|$(REPLACE_GETCWD)|g' \
	      -e 's|@''REPLACE_GETPAGESIZE''@|$(REPLACE_GETPAGESIZE)|g' \
	      -e 's|@''REPLACE_LCHOWN''@|$(REPLACE_LCHOWN)|g' \
	      -e 's|@''REPLACE_LSEEK''@|$(REPLACE_LSEEK)|g' \
	      -e 's|@''REPLACE_WRITE''@|$(REPLACE_WRITE)|g' \
	      -e 's|@''UNISTD_H_HAVE_WINSOCK2_H''@|$(UNISTD_H_HAVE_WINSOCK2_H)|g' \
	      -e '/definition of GL_LINK_WARNING/r $(LINK_WARNING_H)' \
	      < $(srcdir)/unistd.in.h; \
	} > $@-t
	mv $@-t $@
MOSTLYCLEANFILES += unistd.h unistd.h-t

EXTRA_DIST += unistd.in.h

## end   gnulib module unistd

## begin gnulib module unistd-safer


EXTRA_DIST += dup-safer.c fd-safer.c pipe-safer.c unistd--.h unistd-safer.h

EXTRA_libbison_a_SOURCES += dup-safer.c fd-safer.c pipe-safer.c

## end   gnulib module unistd-safer

## begin gnulib module unitypes


EXTRA_DIST += unitypes.h

## end   gnulib module unitypes

## begin gnulib module uniwidth/base


EXTRA_DIST += localcharset.h uniwidth.h

## end   gnulib module uniwidth/base

## begin gnulib module uniwidth/width

libbison_a_SOURCES += uniwidth/width.c

EXTRA_DIST += uniwidth/cjk.h

## end   gnulib module uniwidth/width

## begin gnulib module unlocked-io


EXTRA_DIST += unlocked-io.h

## end   gnulib module unlocked-io

## begin gnulib module unsetenv


EXTRA_DIST += unsetenv.c

EXTRA_libbison_a_SOURCES += unsetenv.c

## end   gnulib module unsetenv

## begin gnulib module verify

libbison_a_SOURCES += verify.h

## end   gnulib module verify

## begin gnulib module wchar

BUILT_SOURCES += $(WCHAR_H)

# We need the following in order to create <wchar.h> when the system
# version does not work standalone.
wchar.h: wchar.in.h
	rm -f $@-t $@
	{ echo '/* DO NOT EDIT! GENERATED AUTOMATICALLY! */'; \
	  sed -e 's|@''INCLUDE_NEXT''@|$(INCLUDE_NEXT)|g' \
	      -e 's|@''PRAGMA_SYSTEM_HEADER''@|@PRAGMA_SYSTEM_HEADER@|g' \
	      -e 's|@''NEXT_WCHAR_H''@|$(NEXT_WCHAR_H)|g' \
	      -e 's/@''HAVE_WCHAR_H''@/$(HAVE_WCHAR_H)/g' \
	      -e 's|@''GNULIB_WCWIDTH''@|$(GNULIB_WCWIDTH)|g' \
	      -e 's/@''HAVE_WINT_T''@/$(HAVE_WINT_T)/g' \
	      -e 's|@''HAVE_DECL_WCWIDTH''@|$(HAVE_DECL_WCWIDTH)|g' \
	      -e 's|@''REPLACE_WCWIDTH''@|$(REPLACE_WCWIDTH)|g' \
	      -e '/definition of GL_LINK_WARNING/r $(LINK_WARNING_H)' \
	    < $(srcdir)/wchar.in.h; \
	} > $@-t
	mv $@-t $@
MOSTLYCLEANFILES += wchar.h wchar.h-t

EXTRA_DIST += wchar.in.h

## end   gnulib module wchar

## begin gnulib module wctype

BUILT_SOURCES += $(WCTYPE_H)

# We need the following in order to create <wctype.h> when the system
# doesn't have one that works with the given compiler.
wctype.h: wctype.in.h
	rm -f $@-t $@
	{ echo '/* DO NOT EDIT! GENERATED AUTOMATICALLY! */'; \
	  sed -e 's/@''HAVE_WCTYPE_H''@/$(HAVE_WCTYPE_H)/g' \
	      -e 's|@''INCLUDE_NEXT''@|$(INCLUDE_NEXT)|g' \
	      -e 's|@''PRAGMA_SYSTEM_HEADER''@|@PRAGMA_SYSTEM_HEADER@|g' \
	      -e 's|@''NEXT_WCTYPE_H''@|$(NEXT_WCTYPE_H)|g' \
	      -e 's/@''HAVE_ISWCNTRL''@/$(HAVE_ISWCNTRL)/g' \
	      -e 's/@''HAVE_WINT_T''@/$(HAVE_WINT_T)/g' \
	      -e 's/@''REPLACE_ISWCNTRL''@/$(REPLACE_ISWCNTRL)/g' \
	      < $(srcdir)/wctype.in.h; \
	} > $@-t
	mv $@-t $@
MOSTLYCLEANFILES += wctype.h wctype.h-t

EXTRA_DIST += wctype.in.h

## end   gnulib module wctype

## begin gnulib module wcwidth


EXTRA_DIST += wcwidth.c

EXTRA_libbison_a_SOURCES += wcwidth.c

## end   gnulib module wcwidth

## begin gnulib module xalloc


EXTRA_DIST += xalloc.h xmalloc.c

EXTRA_libbison_a_SOURCES += xmalloc.c

## end   gnulib module xalloc

## begin gnulib module xalloc-die

libbison_a_SOURCES += xalloc-die.c

## end   gnulib module xalloc-die

## begin gnulib module xstrndup

libbison_a_SOURCES += xstrndup.h xstrndup.c

## end   gnulib module xstrndup


mostlyclean-local: mostlyclean-generic
	@for dir in '' $(MOSTLYCLEANDIRS); do \
	  if test -n "$$dir" && test -d $$dir; then \
	    echo "rmdir $$dir"; rmdir $$dir; \
	  fi; \
	done; \
	:
