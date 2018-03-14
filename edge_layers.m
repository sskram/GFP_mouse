function [ in, out ] = edge_layers( sig, g, dist )


% temp=im2bw(temp);


h=gaussFun(1);
sig_map=conv2(h,h,sig, 'same');
ed=edge(sig_map);


pts=[];
for i=1:length(g)
    try
        val=dist(round(g(i,2)), round(g(i,1)))+4.5;
        
    catch er
        disp(er)
    end
    pts=[pts; eval_pts([g(i,2), g(i,1)], val)];
end

[m,n]=find(ed==1);
p=[n,m];

in=intersect(p, pts, 'rows');
out=setdiff(p, in, 'rows');

end
