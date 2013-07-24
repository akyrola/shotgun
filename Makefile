CPPFLAGS  =  -ansi -D_GNU_SOURCE -fPIC -fno-omit-frame-pointer -pthread 
CPP = g++

all: mex_shotgun_omp 

mex_shotgun_omp: mex_shotgun.cpp lasso.cpp logreg.cpp common.h shared.cpp
	mex CXX=$(CPP) CXXFLAGS="-fopenmp $(CPPFLAGS)"  -largeArrayDims -lgomp  mex_shotgun.cpp lasso.cpp logreg.cpp shared.cpp

mex_shotgun_noomp: mex_shotgun.cpp lasso.cpp logreg.cpp common.h
	mex CXX=$(CPP) CXXFLAGS="$(CPPFLAGS)"  -largeArrayDims  -DDISABLE_OMP=1 mex_shotgun.cpp lasso.cpp logreg.cpp shared.cpp

cversion_debug: lasso.cpp logreg.cpp common.h mmio.c mmio.h read_matrix_market.cpp mm_lasso.cpp write_matrix_market.cpp shared.cpp
	$(CPP) -g  -Wall -pthread -fopenmp lasso.cpp logreg.cpp read_matrix_market.cpp mmio.c mm_lasso.cpp write_matrix_market.cpp shared.cpp -o mm_lasso -lgomp

cversion_release: lasso.cpp logreg.cpp common.h mmio.c mmio.h read_matrix_market.cpp mm_lasso.cpp write_matrix_market.cpp shared.cpp
	$(CPP) -Wall -pthread -fopenmp lasso.cpp logreg.cpp read_matrix_market.cpp mmio.c mm_lasso.cpp write_matrix_market.cpp shared.cpp -o mm_lasso -lgomp -O3


zip:
	rm -f shotgun.zip	
	zip -r shotgun.zip *.c *.cpp *.h *.m Makefile examples/* README.txt NOTICE.TXT -x examples/.svn/\* -x clean_data.m
