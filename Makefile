%.pdf: %.mp FORCE
	mpost "$<"
	for f in `basename $< .mp`-*.ps ; do \
	    ps2pdf "$$f" ;\
	done
	cpdf -o "$@" "`basename $< .mp`"-*.pdf

clean:
	rm -f *.mpx *.log mpxerr.tex *.ps *-[0-9].pdf mptextmp.mp

FORCE:

