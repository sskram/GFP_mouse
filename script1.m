% % imshow(img);
function [g]=evaluate(img)
bin=im2bw(img, 0.3); %%figure;imshow(bin, []);
ed=edge(double(bin)); %%figure;imshow(ed, []);
dist=bwdist(ed); %%figure;imshow(dist, []);
dist_atten=dist.*(double(img)/double(max(max(img)))); %%figure;imshow(dist_atten, []);
temp=dist_atten;
temp(temp<0.35)=0;
cc=bwconncomp(temp);
pxlist=regionprops(cc, 'PixelList');
for i=1:length(pxlist)
    px=pxlist(i).PixelList;
    if size(px,1)<5
        for j=1:size(px,1)
            temp(px(j,2), px(j,1))=0;
        end
    end
end
%% Finding Peaks of DT Map
ind2=imregionalmax(temp);
cc=bwconncomp(ind2,8);
s=regionprops(cc,'centroid');
centroids=[s.Centroid];
x=centroids(1:2:end-1);
y=centroids(2:2:end);


tp=dist_atten/max(max(dist_atten));
Ridge=Vessels(tp);


[a1 a2]=find(Ridge);
temp=[a2 a1];
% % for a=1:length(g)
% %     Ridge(g(a,2),g(a,1))=1;
% % end;



bp=[];
%% Calculating Ridge Bifurcation Points
skel= bwmorph(Ridge,'skel',Inf);
B = bwmorph(skel, 'branchpoints');
E = bwmorph(skel, 'endpoints');
[ey,ex] = find(E);
[t2 t1]=find(B);
ep=[ex ey];
bp=[t1 t2];

%% Clustering Points
cen=[x;y]';
cen=cluster(cen);
g=[cen;bp];
g=cluster(g);
g=round(g);

d=[];
[a b]=residue(img, dist_atten, g,6);
% % cc=bwconncomp(b);
% % temp1=regionprops(cc, 'Centroid');
% % temp2=regionprops(cc, 'PixelList');
% % for i=1:length(temp1)
% %     t=round(temp1(i).Centroid);
% %     if (b(t(2),t(1))>0.3)
% %         d=[d; t(1),t(2)];
% %     else
% %         pts=temp2(i).PixelList;
% %         for j=1:length(pts)
% %            b(pts(j,2), pts(j,1))=0;
% %         end
% %     end
% % end
[IEL, OBL] = edge_layers(b, g, dist_atten); %% Calculating Inner Edge Layer (IEL) and Outer Boundary Layer (OBL)


