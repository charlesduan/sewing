main: mask.pdf

%.pdf: %.ps
	ps2pdf "$<"

%.ps: %.mp
	mpost "$<"
