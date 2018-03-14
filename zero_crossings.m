function [c] = zero_crossing(b, OBL, bin)
conncomp = zeros(size(b));
for i=1:length(OBL)
    conncomp(OBL(i,2), OBL(i,1)) = 255;
end
temp = zeros(size(b));
c=[];
r=[];
cc=bwconncomp(conncomp);
cc=regionprops(cc, 'PixelList');
zc=[];
for i=1:length(cc)
    px = cc(i).PixelList;
    if size(px,1) > 15
        [c1, r1, z] = fit_circles(px);
    end 
    c = [c; c1];
    r = [r; r1];
    zc = [zc; z];
end

val=[];
for i=1 : size(c, 1)
    val = [val; bin(c(i,2), c(i,1))];
end
v = find(val==1);
c=c(v, :);
r=r(v);
[c, p]= unique(c, 'rows');
r= r(p);
c= round(c);