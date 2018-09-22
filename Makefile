.PHONY: books miam fortunes links

all: books miam fortunes links

books:
	cd books && make
miam: 
	cd miam && make
fortunes:
	cd fortunes && make
links:
	cd links && make

