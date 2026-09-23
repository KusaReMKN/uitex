TARGET=	power.pdf power.png

.PHONY: all clean
.SUFFIXES:
.SUFFIXES: .tex .pdf .png

all: $(TARGET)

.tex.pdf:
	lualatex $<

.pdf.png:
	pdftoppm -png -singlefile $< >$@

clean:
	rm -f $(TARGET) power.aux power.log
