function g = movingthresh( f,n,K )
%UNTITLED7 此处显示有关此函数的摘要
%   此处显示详细说明

%MOVINGTHRESH Image segmentation using a moving average threshold.    
%   G = MOVINGTHRESH(F, n, K) segments image F by thresholding its    
%   intensities based on the moving average of the intensities along    
%   individual rows of the image. The average at pixel k is formed    
%   by averaging the intensities of that pixel and its n ? 1    
%   preceding neighbors. To reduce shading bias, the scanning is    
%   done in a zig-zag manner, treating the pixels as if they were a    
%   1-D, continuous stream. If the value of the image at a point    
%   exceeds K percent of the value of the running average at that    
%   point, a 1 is output in that location in G. Otherwise a 0 is    
%   output. At the end of the procedure, G is thus the thresholded    
%    (segmented) image. K must be a scalar in the range [0, 1].    
   
% Preliminaries.   
% || means or operator;rem(n,1) means the residual of n/1  
f = tofloat(f);    
[M, N] = size(f);    
if (n < 1) || (rem(n, 1) ~= 0)    
   error('n must be an integer >= 1.')    
end    
if K < 0 || K > 1    
   error('K must be a fraction in the range [0, 1].')    
end    
   
% Flip every other row of f to produce the equivalent of a zig-zag scanning pattern. Convert image to a vector.    
f(2:2:end, :) = fliplr(f(2:2:end, :));  %fliplr realize the overturn of the vector   
f = f'; % Still a matrix.    
f = f(:)'; % Convert to row vector for use in function filter.    
   
% Compute the moving average.    
maf = ones(1, n)/n; % The 1-D moving average filter.    
ma = filter(maf, 1, f); % Computation of moving average.    
   
% Perform thresholding.    
g = (f > K * ma);    
   
% Go back to image format (indexed subscripts).    
g = reshape(g, N, M)';    
% Flip alternate(交替的) rows back.    
g(2:2:end, :) = fliplr(g(2:2:end, :));   



