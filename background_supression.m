function [t_dhs]=background_supression(dhs, img, th)

t_dhs=dhs;
for i=1:size(dhs,1)
    for j=1:size(dhs,2)
        if img(i,j)<=th
            t_dhs(i,j)=0;
        end
    end
end
% % figure;imshow(t_dhs);