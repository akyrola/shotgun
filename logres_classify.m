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
function [ error ] = logres_classify( w, X, y )

  % Dimensionality
  p = size(X,2);
  intercept = 0;
  if (mod(length(w),p) == 1)
     intercept = w(1)
     w = w(2:length(w));
  end
  K = length(w)/p;
  
  % CUrrently only works for binary
  assert(K  <= 2);
  % Probability table for X
  n = size(X,1);
  w = w(1:size(X,2));

  S = (intercept +X*w);
  
  ncorrect = 0;
  for i=1:n
      a = S(i);
      ncorrect = ncorrect + (y(i)*a > 0);
    %  [i,a, y(i)]
  end
 
  
 error = 1-ncorrect/n;

end

