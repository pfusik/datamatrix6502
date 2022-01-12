run: datamatrix.xex
	start $<

datamatrix.xex: example-atari.asx datamatrix.asx
	xasm -q -o $@ $<

clean:
	$(RM) datamatrix.xex

.DELETE_ON_ERROR:
