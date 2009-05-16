# Makefile for QSD code.

QSD_DIR = .

CXX = g++
FLAGS = -g -O -Wno-deprecated

INC = $(QSD_DIR)/include
SRC = $(QSD_DIR)/src

LOADLIBES = -lm
LDFLAGS = 
CXXFLAGS = $(DCC) -I$(INC) $(FLAGS)
CPPFLAGS = 

COMPILE = $(CXX) -c $(CPPFLAGS) $(CXXFLAGS)
LINK = $(CXX) $(CPPFLAGS) $(CXXFLAGS) $(LDFLAGS)

RAN_OBJ =  Random.o Normal.o Uniform.o RNG.o ACG.o MLCG.o CmplxRan.o
RAN_HEAD = $(INC)/Random.h $(INC)/Normal.h $(INC)/Uniform.h $(INC)/RNG.h $(INC)/ACG.h $(INC)/MLCG.h $(INC)/CmplxRan.h

OBJ1 =  Operator.o PrimOp.o State.o Complex.o
HEAD1 = $(INC)/Operator.h $(INC)/PrimOp.h $(INC)/State.h $(INC)/Complex.h
OBJ2 = FieldOp.o SpinOp.o AtomOp.o
OBJ3 = Traject.o $(RAN_OBJ)
OBJ = $(OBJ1) $(OBJ2) $(OBJ3)
#-------------------------------------------------------------------
# Add driver routines here.

ALL = onespin spins simple moving sums testprog template

myprog: myprog.cc $(OBJ)
	$(LINK) -o myprog myprog.cc $(OBJ) $(LOADLIBES)

onespin: onespin.cc $(OBJ)
	$(LINK) -o onespin onespin.cc $(OBJ) $(LOADLIBES)

spins: spins.cc $(OBJ)
	$(LINK) -o spins spins.cc $(OBJ) $(LOADLIBES)

simple: simple.cc $(OBJ)
	$(LINK) -o simple simple.cc $(OBJ) $(LOADLIBES)

moving: moving.cc $(OBJ)
	$(LINK) -o moving moving.cc $(OBJ) $(LOADLIBES)

sums: sums.cc $(OBJ)
	$(LINK) -o sums sums.cc $(OBJ) $(LOADLIBES)

testprog: testprog.cc $(OBJ)
	$(LINK) -o testprog testprog.cc $(OBJ) $(LOADLIBES)

template: template.cc $(OBJ)
	$(LINK) -o template template.cc $(OBJ) $(LOADLIBES)

#-------------------------------------------------------------------

all: $(ALL)

cleanexe:
	rm $(ALL)

cleanrand:
	rm $(RAN_OBJ)

clean:
	rm *.o

Traject.o: $(SRC)/Traject.cc $(INC)/Traject.h $(HEAD1) $(RAN_HEAD)
	$(COMPILE) $(SRC)/Traject.cc

State.o: $(SRC)/State.cc $(HEAD1)
	$(COMPILE) $(SRC)/State.cc

Operator.o: $(SRC)/Operator.cc $(HEAD1)
	$(COMPILE) $(SRC)/Operator.cc

PrimOp.o: $(SRC)/PrimOp.cc $(HEAD1)
	$(COMPILE) $(SRC)/PrimOp.cc

FieldOp.o: $(SRC)/FieldOp.cc $(INC)/FieldOp.h $(HEAD1)
	$(COMPILE) $(SRC)/FieldOp.cc

SpinOp.o: $(SRC)/SpinOp.cc $(INC)/SpinOp.h $(HEAD1)
	$(COMPILE) $(SRC)/SpinOp.cc

AtomOp.o: $(SRC)/AtomOp.cc $(INC)/AtomOp.h $(HEAD1)
	$(COMPILE) $(SRC)/AtomOp.cc

Complex.o: $(SRC)/Complex.cc $(INC)/Complex.h
	$(COMPILE) $(SRC)/Complex.cc

Random.o: $(SRC)/Random.cc $(RAN_HEAD)
	$(COMPILE) $(SRC)/Random.cc

Normal.o: $(SRC)/Normal.cc $(RAN_HEAD)
	$(COMPILE) $(SRC)/Normal.cc

Uniform.o: $(SRC)/Uniform.cc $(RAN_HEAD)
	$(COMPILE) $(SRC)/Uniform.cc

RNG.o: $(SRC)/RNG.cc $(RAN_HEAD)
	$(COMPILE) $(SRC)/RNG.cc

ACG.o: $(SRC)/ACG.cc $(RAN_HEAD)
	$(COMPILE) $(SRC)/ACG.cc

MLCG.o: $(SRC)/MLCG.cc $(RAN_HEAD)
	$(COMPILE) $(SRC)/MLCG.cc

CmplxRan.o: $(SRC)/CmplxRan.cc $(RAN_HEAD) $(INC)/Complex.h
	$(COMPILE) $(SRC)/CmplxRan.cc
