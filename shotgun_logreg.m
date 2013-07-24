%
%   Copyright [2011] [Aapo Kyrola, Joseph Bradley, Danny Bickson, Carlos Guestrin / Carnegie Mellon University]
%
%   Licensed under the Apache License, Version 2.0 (the "License");
%   you may not use this file except in compliance with the License.
%   You may obtain a copy of the License at
%
%       http://www.apache.org/licenses/LICENSE-2.0
%
%   Unless required by applicable law or agreed to in writing, software
%   distributed under the License is distributed on an "AS IS" BASIS,
%   WITHOUT WARRANTIES OR CONDITIONS OF Alogregprob->ny KIND, either express or implied.
%   See the License for the specific language governing permissions and
%   limitations under the License.
%
%%%
% Implementation of Logistic Regression Shotgun-algorithm from paper:
% Joseph K. Bradley, Aapo Kyrola, Danny Bickson, and Carlos Guestrin (2011). 
%  "Parallel Coordinate Descent for L1-Regularized Loss Minimization." 
%     International Conference on Machine Learning (ICML 2011).
%
% Algorithm is based on the CDN-algorithm (Coordinate Descent Newton) described
% in paper: 
%    Yuan, Chang et al. : 
%       A Comparison of Optimization Methods and Software for Large-scale
%       L1-regularized Linear Classification
%
%
% Solves binary Logistic regression with L1-penalty:
%      \arg \max_x \sum log(1+exp(-yAx) - \lambda |x|_1
% input: 
%   matrix A (design matrix)
%   y (observation vector)
%   lambda (regularization parameter)
%   nthreads (how many threads to use, 0 for automatic)
%   threshold (convergence threshold)
%   regpath (regularization path lenth - used only in lasso)
%   maxiter (maximal number of iterations)
%   verbose (additional information including cost calculation per iteration)
% output:
%   x  weight-vector
function [x] = shotgun_logreg(A,y,lambda, nthreads,threshold,regpath,maxiter,verbose)
  if (~exist('threshold','var'))
    threshold = 1e-5
  end
  if (~exist('regpath','var'))
    regpath = 0
  end
  if (~exist('maxiter','var'))
    maxiter = 100; 
  end  
  if ~exist('nthreads','var')
      nthreads = 0
  end 
  if ~exist('verbose','var')
     verbose = 1
  end 
  ones = find(abs(y)==1);
  if (length(ones)<length(y))
     error('y- vector can have only +1 and -1 values')
  end 
  
   % Remove zero columns (Shotgun will not like them)
   w = sum(A.^2,1);
   zs = find(w > 0);
   A = A(:, zs);

   % Run shotgun
   x =   mex_shotgun(A,y,lambda,2,threshold,regpath,maxiter, nthreads, verbose);
end

