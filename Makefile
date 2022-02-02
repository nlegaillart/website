.PHONY: navbar miam fortunes links 

all: navbar miam fortunes links

navbar: 
	./gennavbar.sh
miam: 
	cd miam && make
fortunes:
	cd fortunes && make
links:
	cd links && make

