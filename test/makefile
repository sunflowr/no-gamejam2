OUTPUT = test.love
SRC = test

.PHONY: all clean run

all: clean
	cd $(SRC); zip -r ../$(OUTPUT) * -x "*.DS_Store"; open -n -a love .

clean:
	rm -fr $(OUTPUT)

run:
	open -n -a love $(SRC)
