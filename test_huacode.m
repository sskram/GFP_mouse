function test_huacode()

addpath('frangi_filter_version2a')

imgbase='D:\vmshared\lossy\Hua166';
imgno = 131;

list = dir(sprintf('%s/*-F*_%.4d.jp2',imgbase,imgno));

imgname = list(1).name;

img = imread([imgbase '/' imgname],'PixelRegion',{[5000,7000],[12000,14000]});
dat = load('hist.mat');
src=normal(img(:,:,2));
dhs_op=histeq(src,dat.hist);
dhs_op=background_supression(dhs_op, src, 4100);

% Initializing Hyperparameters
options.threshold = 0.25; %%Threshold for binarizing (empirically best value)
options.area = 40; %%Minimum Area covered by a cell
options.avg_radius = 6; %%Average cell ares
cen=evaluate(dhs_op, options);
imshow(dhs_op);
hold on
plot(cen(:,1), cen(:,2), 'r*');


