NULL =

AUTOMAKE_OPTIONS = subdir-objects

SUBDIRS = \
	po \
	serializer \
	$(NULL)

AM_CPPFLAGS = \
	$(LIBANVIL_CFLAGS) \
	-include $(CONFIG_HEADER) \
	$(NULL)

BUILT_SOURCES = src/libanvil.vala.stamp

bin_PROGRAMS = libanvil

libanvil_VALASOURCES = \
	serializer/handlers/base.vala \
	serializer/handlers/int.vala \
	serializer/handlers/string.vala \
	src/main.vala \
	$(NULL)

libanvil_SOURCES = \
	$(libanvil_VALASOURCES:.vala=.c) \
	$(libanvil_VALASOURCES:.vala=.h) \
	$(NULL)

src/libanvil.vala.stamp: $(libanvil_VALASOURCES)
	$(VALAC) -C --basedir --pkg=vala-1.0 $(top_srcdir)
	touch $@

libanvil_LDADD = \
	$(LIBANVIL_LIBS) \
	$(NULL)

EXTRA_DIST = \
	intltool-extract.in \
	intltool-update.in \
	intltool-merge.in \
	$(libanvil_VALASOURCES) \
	src/libanvil.vala.stamp \
	$(NULL)

DISTCLEANFILES = \
	intltool-extract \
	intltool-update \
	intltool-merge \
	po/.intltool-merge-cache \
	$(NULL)
