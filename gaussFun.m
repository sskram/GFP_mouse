function [ gauss ] = gaussFun(sigma)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
cutoff=ceil(3*sigma);
gauss = fspecial('gaussian',[1,2*cutoff+1],sigma);

end

