ifndef CC
	CC = gcc
endif
ifndef CFLAGS
	CFLAGS = -Wall -Wextra \
		-Wno-pedantic \
		-Wno-cast-function-type \
		-Wno-char-subscripts \
		-g \
		$(EXTRA_CFLAGS)
endif

define LOG
	@printf '\t%s\t%s\n' $1 $2
endef

define COMPILE
	$(call LOG,CC,$1)
	@$(CC) $(CFLAGS) $1 \
		-Iconfig -I../../include \
		-fPIC -c -o $2
endef

libjlparse.so: jlparse.o
	$(call LOG,LINK,libjlparse.so)
	@$(CC) $(CFLAGS) jlparse.o \
		-L../.. $(LINKFLAGS) \
		-lmscm -ljulia \
		-shared -o libjlparse.so

jlparse.o: jlparse.c
	$(call COMPILE,$<,$@)

.PHONY: clean
clean:
	rm *.o
	rm *.so
