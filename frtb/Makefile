CC = g++
CFLAGS = -Wall -lcurl

objects = network.o parser_frdic.o parser.o printer.o query.o main.o

install: $(objects)
	$(CC) $(objects) -o frbt $(CFLAGS)


network.o: network.cxx
	$(CC) -c network.cxx $(CFLAGS)
parser_frdic.o: parser_frdic.cxx
	$(CC) -c parser_frdic.cxx
parser.o: parser.cxx
	$(CC) -c parser.cxx
printer.o: printer.cxx
	$(CC) -c printer.cxx
query.o: query.cxx network.cxx parser.cxx
	$(CC) -c query.cxx
main.o: query.cxx network.cxx parser.cxx printer.cxx parser_frdic.cxx main.cxx
	$(CC) -c main.cxx $(CFLAGS)

clean:
	rm $(objects)