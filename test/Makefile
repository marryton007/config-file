CC=clang
CFLAGS=-g
CXX=clang++
C_SRC=$(wildcard *.c)
CXX_SRC=$(wildcard *.cpp)
C_OBJ=$(C_SRC:%.c=%)
CXX_OBJ=$(CXX_SRC:%.cpp=%)

%:%.c
	$(CC) $(CFLAGS) $< -o $@ 

%:%.cpp
	$(CXX) $(CFLAGS) $< -o $@ 

all:$(C_OBJ) $(CXX_OBJ)

.PHONY: clean
clean: 
	@rm -f $(C_OBJ) $(CXX_OBJ)
