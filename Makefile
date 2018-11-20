.PHONY: navbar books miam fortunes links 

all: navbar books miam fortunes links

navbar: 
	./gennavbar.sh
books:
	cd books && make
miam: 
	cd miam && make
fortunes:
	cd fortunes && make
links:
	cd links && make

