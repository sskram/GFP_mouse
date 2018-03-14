function [ pts ] = eval_pts( cen, val )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
temp=ones(30,30);
temp=temp>0;
cc=bwconncomp(temp);
tp=regionprops(cc, 'PixelList');
tp=tp.PixelList;

cen = [15,15];
dst = pdist2(cen ,tp);

pts = tp(dst<val, :);

pts (:,1) = pts(:,1)-15+cen(:,1);
pts (:,2) = pts(:,2)-15+cen(:,2);

end

