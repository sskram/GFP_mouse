% % imshow(img);
function [g]=evaluate(img, options)
bin=im2bw(img, options.threshold); %%figure;imshow(bin, []);
ed=edge(im2double(bin)); %%figure;imshow(ed, []);
dist=bwdist(ed); %%figure;imshow(dist, []);
dist_atten=(dist.*bin).*(double(img)/double(max(max(img)))); %%figure;imshow(dist_atten, []);
temp=dist_atten;
temp(temp<0.8)=0;
cc=bwconncomp(temp);
pxlist=regionprops(cc, 'PixelList');
for i=1:length(pxlist)
    px=pxlist(i).PixelList;
    if size(px,1)<2
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
cen=[x;y]'; 
cen=cluster1(cen);


bp=[];
%% Calculating Ridge Bifurcation Points (Comment this section for switching off Ridge processing)
tp=dist_atten/max(max(dist_atten));
Ridge=Vessels(tp);
[a1 a2]=find(Ridge);
temp=[a2 a1];
skel= bwmorph(Ridge,'skel',Inf);
B = bwmorph(skel, 'branchpoints');
E = bwmorph(skel, 'endpoints');
[ey,ex] = find(E);
[t2 t1]=find(B);
ep=[ex ey];
bp=[t1 t2];

%% Clustering Points
g=[cen;bp];
g=cluster2(g);
g=round(g);


%% Arc Based Iteration
c=[];
[back, sig] = residue(dhs_op, dist_atten, g, options.avg_radius, options.area); 
cc=bwconncomp(sig);
while(cc.NumObjects>0)
    [IEC, OBC] = edge_layers(sig, g, dist_atten);
    c = [c; zero_crossings(sig, OBC, bin)];
    [~,sig] = residue1(sig, dist_atten, c, 15, options.area);
    cc = bwconncomp(sig);
end

%% Merging Final Set of Cell Centers
g=[g;c];
g=cluster(g);