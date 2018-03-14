warning off;
input_path = '/media/giri/Seagate Backup Plus Drive/data/portal-lossy/Hua167/'; %%Path of input directory
output_path = '/media/giri/C0A48A3FA48A37C4/algorithms/166output/'; %% Path of output directory
d=dir([input_path '*F*.jp2']);
load('hist.mat');
for i=1:length(d)
    [~, name, ~]=fileparts(d(i).name);
    disp(name); %%Displaying name of current processing image
    img=imread([input_path d(i).name]);
    src=normal(img(:,:,2));
    dhs_op=histeq(src,hist);
    dhs_op=background_supression(dhs_op, src, 4100);
    %% Initializing Hyperparameters
    options.threshold = 0.25; %%Threshold for binarizing (empirically best value)
    options.area = 50; %%Minimum Area covered by a cell
    options.avg_radius = 6; %%Average cell ares
    cen=evaluate(dhs_op, options);
    imshow(dhs_op);
    hold on
    plot(cen(:,1), cen(:,2), 'r*');
    %% Save the output and clear the buffer variables.
    save([output_path name], 'cen');
    clear('cen');
    clear('src');
    clear('img');
    clear('dhs_op');
end