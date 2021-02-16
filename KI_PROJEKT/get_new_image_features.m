
function [features, img] = get_new_image_features(path)
    user_canceled = 1;
    while user_canceled == 1
        [filename,user_canceled] = imgetfile('InitialPath',path);
    end
    features = get_features(filename);
    img = imread(filename);
