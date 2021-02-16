function features = get_features(img)

if ischar(img)
    %% Read the image
    img = imread(img); 
    grayimg = rgb2gray(img);
end
    
%% Threshold the image and get region of interest
% Adjust contrast
grayimg = imadjust(grayimg,[],[],5);
% Get threshold
thresh =  graythresh(grayimg); %0.9; 
% Apply theshold
interest = grayimg < (thresh*255);
% Dilate the image to remove holes
se = strel('square',3);
interest = imdilate(interest,se);
interest = imfill(interest,'holes');
% Get the biggest blob
interest = bwareafilt(interest, 1);
imshow(interest);
%Pilar Samaniego -hska

%% Get the HU moments for classification
features = hu_moments(interest);
% banana: 0.3604   -0.3859    0.0190    0.0031   -0.0000    0.0026   -0.0000   -0.0004
% apple:  0.1595    0.0126    0.0000    0.0000    0.0000   -0.0000   -0.0000   -0.0000