
FC = gfortran-7.3.0 
CXX = g++-7.3.0 
FFLAG = 
#CFLAG= -DIFORT
#FC_DIR=/usr/pack/intel_fc-11.1-gp/lib/intel64
#LIB=-L $(FC_DIR) -Wl,-rpath,$(FC_DIR) -lifport -lifcore -limf -lsvml -lm -lipgo -lirc -lpthread -lirc_s -ldl

#FC = gfortran
#FFLAG=
CFLAG= -DGFORTRAN
FC_DIR=/usr/pack/gcc-7.3.0-ma/lib64/ 
LIB=-L $(FC_DIR) -Wl,-rpath,$(FC_DIR) -lgfortran

all: sub.o main.o errorcodes.o
	$(CXX) -o main main.o sub.o errorcodes.o $(LIB)

sub.o: sub.f90
	$(FC) $(FFLAG) -c $<

errorcodes.o: errorcodes.f90
	$(FC) $(FFLAG) -c $<

errorcodes.f90: errorcodes.F90
	cpp $< > $@

main.o: main.C 
	$(CXX) -c $(CFLAG) $<

clean:
	rm *.o *.mod main

sub.o : errorcodes.o
