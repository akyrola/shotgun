
addpath ..

%% LASSO
% Run Lasso with 4 cpu, lambda 0.5

load mug05_12_12.mat
x = shotgun_lasso(A,y,0.5,4,1e-5,0,1000,0);

% Compute objective
objective = norm(A*x-y,2)^2 + 0.5*norm(x,1);
fprintf('Objective value was %f, should be around 1.685e03\n', objective);
0.5*sum(abs(x))
norm(A*x-y)

%% LOGREG
% Run Logistic regression with 4 cpus, lambda 1
clear

load arcene.mat 
% Ref: http://archive.ics.uci.edu/ml/datasets/Arcene
x = shotgun_logreg(A,y,1.0,4);

% Classify and compute prediction error
predict = A*x;
versusy = predict.*y;
error = length(find(versusy <= 0))/length(y);

fprintf('Train error for arcene.mat was %f, should be about %f\n', error,0.15);

