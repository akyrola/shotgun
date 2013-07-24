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
function [ logll ] = logres_loglikelihood( w, X , y)
    % Computes log likelihood of the data
 % Dimensionality.
  p = size(X,2);
  intercept = 0;
  if (mod(length(w),p) == 1)
     intercept = w(1);
     w = w(2:length(w));
  end
  K = length(w)/p;
  
  % CUrrently only works for binary
  assert(K  <= 2);
  
  n = length(y);
  
  w = w(1:p);
  S = X * w;
  ll = log(1 + exp(y.*S + intercept));
  logll = -sum(ll);
 
end

