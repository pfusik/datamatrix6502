run: datamatrix.xex
	cygstart $<

datamatrix.xex: example-atari.asx datamatrix.asx
	xasm -q -o $@ $<

clean:
	$(RM) datamatrix.xex

.DELETE_ON_ERROR:
