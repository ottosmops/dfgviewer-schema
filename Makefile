TRANG = trang

rng: relaxng/dvlinks.rng relaxng/dvrights.rng

%.rng: %.rnc
	$(TRANG) -I rnc -O rng $< $@
