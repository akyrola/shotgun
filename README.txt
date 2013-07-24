== LICENSE ==

This software is provided under the Apache License 2.0. Please see
files LICENSE.txt and NOTICE.TXT for more information.



=== REFERENCE ===
Joseph K. Bradley, Aapo Kyrola, Danny Bickson, and Carlos Guestrin (2011). 
"Parallel Coordinate Descent for L1-Regularized Loss Minimization." 
International Conference on Machine Learning (ICML 2011).
http://arxiv.org/abs/1105.5379

=== INSTALLATION ===
1) For running as a mex code called from Matlab
Just run:
     make

2) For running as a C application, using MatrixMarket input format:
     make cversion_debug
      OR
     make cversion_release

Current build is only tested on Linux, so you might need to modify the Makefile
to suit your system.



=== COST FUNCTION ==
We use the following cost function formulation. 
For Lasso:
argmin_x sum_i [(A_i*x - y_i)^2 + lambda * |x|_1]
For sparse logistic regression:
argmin_x sum_i [-log(1 + exp(-y_i * x* A_i) ) + lambda * |x|_1]

where |x|_1 is the first norm (sum of absolute value of the vector x).

==== USAGE ===

1) 
Do not call the mex-library directly. Instead use the provided Matlab-scripts
shotgun_logreg.m and shotgun_lasso.m.

Both have same signature:
     shotgun_logreg(A,y,lambda)
     shotgun_lasso(A,y,lambda)

They return the optimized feature/weight-vector. For tuning the parameters, please
modify the scripts. A more user-friendly options-passing will be provided later.

For an example, see example/ directory.


2) RUNNING AS A STANDALONE C PROGRAM:
Matrix and vector files are mandaroty inputs
Usage: ./mm_lasso
	-m matrix A in sparse matrix market format
	 -v vector y in sparse matrix market format
	 -o output file name (will contain solution vector x, default is
x.mtx)
	 -a algorithm (1=lasso, 2=logitic regresion, 3 = find min lambda for
all zero solution)
	 -t convergence threshold (default 1e-5)
	 -k solution path length (for lasso)
	 -i  max_iter (default 100)
	 -n num_threads (default 2)
	 -l lammbda - positive weight constant (default 1)
	 -V verbose: 1=verbose, 0=quiet (default 0) 

=== REMARKS ===

Provided code is not exactly same as the one we used for running our experiments for
the ICML 2011 paper. Particularly this code runs slower *sequentially*, because special
code for running with only one cpu has been removed for clarity. Parallel code needs to do
some extra work compared to sequential algorithm, and therefore for fairness we had special
versions for the sequential tests.

This version uses OpenMP for parallel execution. For the paper, we used CILK++. Since CILK
is not as widely available as OpenMP, we decided to switch for the source code release.


=== MORE INFO ===

This code is is not well tested and you should not rely on it on any mission-critical tasks.

For bug-fixes or other questions, please contact Aapo Kyrola : akyrola@cs.cmu.edu.

Aapo Kyrola
June 21, 2011


