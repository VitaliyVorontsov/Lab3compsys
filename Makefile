ASFLAGS=-g -c
SOURCES=fork.s
OBJECTS=$(SOURCES:.s=.o)
EXEC=$(OBJECTS:.o=)

all: $(EXEC)

$(EXEC):$(OBJECTS)
	ld -static $< -o $@

%.o: %.s
	as $(ASFLAGS) $< -o $@

.PHONY: clean

clean: 
	rm $(OBJECTS) $(EXEC)
