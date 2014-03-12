6502 Data Matrix encoder
========================

This projects implements [Data Matrix barcode](http://en.wikipedia.org/wiki/Data_Matrix)
in the [6502](http://en.wikipedia.org/wiki/6502) assembly language.

Supported are square ECC 200 symbol sizes up to 26x26.
Symbol size limits the length of the encoded message and must be selected at compile time:

* 10x10 (max 3 characters)
* 12x12 (max 5 characters)
* 14x14 (max 8 characters)
* 16x16 (max 12 characters)
* 18x18 (max 18 characters)
* 20x20 (max 22 characters)
* 22x22 (max 30 characters)
* 24x24 (max 36 characters)
* 26x26 (max 44 characters)

Compilation
-----------

The routine uses two memory areas:

* `DataMatrix_code` - less than 512 bytes of self-modifying code
* `DataMatrix_data` - less than 768 bytes of uninitialized data,
including the input message and the resulting symbol

The routine doesn't use zero page. There are no restrictions on the alignment of code or data.

In addition to code and data locations, you must select the desired symbol size:
10, 12, 14, 16, 18, 20, 22, 24 or 26.

So, a valid compilation command-line is:

    xasm datamatrix.asx /d:DataMatrix_code=$b700 /d:DataMatrix_data=$b900 /d:DataMatrix_SIZE=20

(escape the dollars if in Unix shell or Makefile).

Source code uses [xasm](https://github.com/pfusik/xasm) syntax.
This cross-assembler includes many original syntax extensions.

Usage
-----

1. Store ASCII message at `DataMatrix_data`.
The message must be terminated with `DataMatrix_EOF` (128)
and short enough to fit in the desired symbol size (see above, the terminator doesn't count).
Please note that the routine will destroy the input message, so you need to recreate it every time.

2. Call the routine:

    jsr DataMatrix_code

3. Get the square array of `DataMatrix_SIZE*DataMatrix_SIZE` bytes starting from
`DataMatrix_data+$50`. Information about the x,y pixel is at `DataMatrix_data+$50+y*DataMatrix_SIZE+x`.
Zero means background color, one means ink color, other values mean a bug in my code (file a report).

4. Use big pixels, high contrast and a border in the background color around the symbol, at least one pixel wide.

If that was not clear enough, you can look at https://github.com/pfusik/datamatrix6502/blob/master/example-atari.asx

WTF is 6502?
------------

If you prefer C, Java, C#, JavaScript, ActionScript, Perl or [D](http://dlang.org/)
Data Matrix encoder, see [DataMatrix.ci](https://github.com/pfusik/datamatrix-ci).
