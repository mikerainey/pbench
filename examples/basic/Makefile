all: basic

PBENCH_PATH=../..

include $(PBENCH_PATH)/Makefile_common

fib:
	ocamlc $(XLIB_INCLUDES) $(XLIB_LIBS) $(XLIB_SRC) nums.cma fib.ml -o $@

basic: basic.pbench
	ln -sf $< $@ 

clean: pbench_clean
	rm -f basic fib
