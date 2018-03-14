function [pts]=swap(pts)
temp=pts(:,1);
pts(:,1)=pts(:,2);
pts(:,2)=temp;