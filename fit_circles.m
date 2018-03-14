function [ cen, rad, zc ] = fit_circles( edge )

% % conn_comp=imfill(conn_comp);
% % edge = imcontour(conn_comp,1);
% % edge = edge(:, 2:end-1);
% % edge = edge';
[s1, s2] = Euclidean_Signature(edge(1:5:end,:));
h=gaussFun(0.5);
t=conv(s1(:,1), h, 'same');
xc1=zcc(t, 1:length(edge));
xc1=(5*xc1)-1;
xc1=round(xc1);
xc1=xc1(xc1<length(edge));
zc = edge(xc1, :);
cen=[];
rad=[];
%% Fitting Circles within zero crossings
if size(xc1,1)>=2
    for i=1:length(xc1)-1
        pts=edge(xc1(i):xc1(i+1), :);
        [xc,yc,R,a] = circfit(pts(:,1),pts(:,2));
        par=[xc, yc, R];
        if par(3)<15 && par(3)>=1
            cen=[cen; par(1), par(2)];
            rad=[rad; par(3)];
        end
    end
    %% From Last point to first point
    pts=edge(xc1(end):end,:);
    [xc,yc,R,a] = circfit(pts(:,1),pts(:,2));
    par=[xc, yc, R];
    if par(3)<10 && par(3)>=4
        cen=[cen; par(1), par(2)];
        rad=[rad; par(3)];
    end
    cen=round(cen);
end


end

