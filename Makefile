TRANG = trang
XSLTPROC = xsltproc

all: rng schematron ;

.PHONY: clean
clean:
	rm -f src/schema/mets.xsl
	rm -f src/schema/*.rng

rng: src/schema/dvlinks.rng src/schema/dvrights.rng

schematron: src/schema/mets.xsl

%.xsl: %.sch
	cd src/util/iso-schematron-xslt1 ; $(XSLTPROC) -o ../../../$@ iso_svrl_for_xslt1.xsl ../../../$<

%.rng: %.rnc
	$(TRANG) -I rnc -O rng $< $@
