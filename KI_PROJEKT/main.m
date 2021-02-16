%% RESTART ENVIRONMENT
clc
clear all
close all 

labels_names = {'angel', 'santa', 'snowman', 'reindeer'};

%% EXTRACT ALL THE FEATURES OF THE DATASET:
[featureVector, labels] = process_data('navidad', labels_names);

%% GET NEW IMAGE AND FEATURES:
[new_features,img] = get_new_image_features('test_navidad');

%% CLASSIFIER 1: 1NN
gradient = featureVector - new_features;
distances = vecnorm(gradient,2,2);
[~, position] = min(distances);
prediction = labels(position);
prediction_nn = string(labels_names(prediction));

%% CLASSIFIER 2: BAYES CLASSIFIER
% we assume that the probability of each class is equal
% we compute the mean and standard deviation of the training set:
%statistics = containers.Map;%Pilar Samaniego -hska
posteriores_p = zeros(3,1);
for i=1:3
    features_class = featureVector(labels == i,:); 
    %key = ['mean' num2str(i)];
    %statistics(key) = mean(features_class);
    %key = ['std' num2str(i)];
    %statistics(key) =std(features_class);
    [p, post] = calculate_probabilities(new_features,...
            mean(features_class),std(features_class));
    posteriores_p(i) = post;
end
% NORMALIZE THE PROBABILITIES:
posteriores_p = posteriores_p / sum(posteriores_p);
[~, prediction] = max(posteriores_p);
prediction_bayes = string(labels_names(prediction));


%% LINEAR CLASSIFIER WITH GRADIENT DESCENT:
% We will create 2 classifiers 
% 1. banana vs all (2)
% 2. orange vs all (3)
% Initialize the weights:
% classifier banana vs all:
w1 = rand(1,9); 
gradient = 1;
lr = 0.005; % learning rate
% we add a 1 at the begining as a bias
x_train = [ones(size(featureVector,1),1), featureVector];
y_true = (labels == 2)*2-1;
counter=0;
while norm(gradient)>0.002 && counter < 1000  
    predicted=sign(w1*x_train')'; 
    diference = predicted - y_true;
    gradient= ((diference)'*x_train);
    w1 = w1 - gradient*lr;
    norm(gradient);
    counter = counter+1;
end
fprintf('iterations: %f',counter);

w2 = rand(1,9);
gradient = 1;
y_true = (labels == 3)*2-1;
counter=0;
while norm(gradient)>0.002  && counter < 1000
    predicted=sign(w2*x_train')'; 
    diference = predicted - y_true;
    gradient= ((diference)'*x_train);
    w2 = w2 - gradient*lr;
    norm(gradient);
    counter = counter+1;
end
fprintf('iterations: %f',counter);

%Prediction linear classifier
x_new = [ones(size(new_features,1),1), new_features];
pred1 = sign(w1*x_new')';
pred2 = sign(w2*x_new')';
if pred1 ==-1 && pred2 ==-1
    prediction = 1;
end
if pred1 ==1 && pred2 ==-1
    prediction = 2;
end
if pred1 ==-1 && pred2 ==1
    prediction = 3;
end
prediction_lineal = string(labels_names(prediction));



%% SHOW THE IMAGE AND THE PREDICTION
name = strcat('NN: ', prediction_nn);
title_img = insertText(img,[5 5],name);
name = strcat('bayes: ', prediction_bayes);
title_img = insertText(title_img,[5 30],name);
name = strcat('lineal: ', prediction_lineal);
title_img = insertText(title_img,[5 55],name);
figure
imshow(title_img)



