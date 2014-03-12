run: datamatrix.xex
	cygstart $<

datamatrix.xex: example-atari.asx datamatrix.asx
	xasm -q -o $@ $<

.DELETE_ON_ERROR:
