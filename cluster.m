function [ g ] = cluster( X )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
mindist =8; % desired minimum distance between two points
 nX = sum(X.^2,2);
 d = bsxfun(@plus,nX,nX')-2*X*X';
 [p,~,r] = dmperm(d<mindist^2);
 nvoxels = diff(r);
 for n=find(nvoxels>1) 
   idx = p(r(n):r(n+1)-1);
   X(idx,:) = repmat(mean(X(idx,:),1),numel(idx),1); 
   X(idx(2:end),:) = nan;
 end
 X(any(isnan(X),2),:) = [];
 g=X;

end
