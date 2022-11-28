SRC := $(wildcard *.fnl)
OUT := $(patsubst %.fnl,%.lua,$(SRC))

.PHONY: all
all: $(OUT)

$(OUT): $(SRC)
	@fennel --compile $< > $@
