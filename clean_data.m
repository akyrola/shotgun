   load ~/parallel_lasso/benchmark_suite/datasets_logreg/arcene.mat;
   w = sum(A.^2,1);
   zs = find(w > 0);
   A = A(:, zs);
   mmwrite('./examples/Aarcene.mtx', A); 


