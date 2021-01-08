%.pdf: %.ps FORCE
	ps2pdf "$<"

%.ps: %.mp
	mpost "$<"

FORCE:

