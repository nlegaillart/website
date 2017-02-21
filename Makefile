.PHONY: books miam fortunes

all: books miam fortunes

books:
	cd books && make
miam: 
	cd miam && make
fortunes:
	cd fortunes && make
