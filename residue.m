function [gil, gil1]= residue(and, dist, b, c, area);
tp=bwconncomp(and);
c=c*ones(1, size(b,1));
b=round(b);
% % for i=1:size(b,1)
% %     c(i)=dist(b(i,2), b(i,1))-1;
% % end
% % edge=imcontour(and,1);
% % edge=edge(:, 2:end-1);
% % [x y]=find(and~=0);
% % z=[y x];
% % [b e]=intersect(b, z, 'rows');
% % c=c(e);
tp=regionprops(tp, 'PixelList');
zr=[];
for i=1:size(tp,1)
    pts=tp(i).PixelList;
    if (size(pts,1)<20)
        zr = [zr; pts];
    else
        [d e]=intersect(b, pts, 'rows');
        f=c(e);
%         d=swap(d);
        for j=1:size(d,1)
            val=f(j)+3;
            dst=pdist2(d(j,:), pts);
            zr=[zr; pts(dst<val,:)];
        end
    end    
end


gil=and;
for j=1:size(zr,1)
    gil(zr(j,2), zr(j,1))=0;
end

gil=im2double(gil);

% % h=gaussFun(0.5);
% % gil1=conv2(h,h,gil,'same');
% % gilg=im2bw(gil1, 0.5);
% % gilg=double(gilg);
cc=bwconncomp(gil, 8);

% % rad=min(c);
% % area=pi*rad*rad;
% % area=50;
%% Removing the small connected components
cc1=regionprops(cc, 'PixelList');
zr=[];
count=0;
for i=1:length(cc1)
    temp=cc1(i).PixelList;
    if size(temp,1)<area
        zr=[zr; temp];
        count=count+1;
    end
end
gil1=gil;
if size(zr, 1)>0
    zr=swap(zr);
    gil1=gil;
    for j=1:size(zr,1)
        gil1(zr(j,1), zr(j,2))=0;
    end
end
% % imshow(gil);
