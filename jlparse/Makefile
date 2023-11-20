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
ifndef MSCM_PATH
	MSCM_PATH = $(shell dirname $(shell which mscm))/..
endif
ifndef JULIA_PATH
	JULIA_PATH = "$(shell dirname $(shell which julia))/.."
endif

define LOG
	@printf '\t%s\t%s\n' $1 $2
endef

define COMPILE
	$(call LOG,CC,$1)
	@$(CC) $(CFLAGS) $1 \
		-I$(JULIA_PATH)/include/julia \
		-I$(MSCM_PATH)/include \
		-fPIC -c -o $2
endef

libjlparse.so: jlparse.o
	$(call LOG,LINK,libjlparse.so)
	@$(CC) $(CFLAGS) jlparse.o \
		-L$(JULIA_PATH)/lib \
		-L$(MSCM_PATH)/lib \
		-lmscm -ljulia \
		-shared -fPIC -o libjlparse.so

jlparse.o: jlparse.c
	$(call COMPILE,$<,$@)

.PHONY: clean
clean:
	rm *.o
	rm *.so
