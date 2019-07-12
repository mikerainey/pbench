##################################################################
# C Binaries

TIMEOUT_SCR=prun_timeout.c
TIMEOUT=prun_timeout

$(TIMEOUT): $(TIMEOUT_SCR)
	gcc -Wno-implicit-function-declaration -o $@ $<

clean:
	rm -f $(TIMEOUT)
