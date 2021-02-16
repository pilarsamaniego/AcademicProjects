function [featureVector, labels] = process_data(path, labels_names)

%% READ FULL DIRECTORY
full_path = strcat(path,'/**/*.jpg' );
list = dir(full_path);
number_of_files = size(list);
labels = zeros(size(list));

for img_counter= 1: number_of_files(1,1)
    
    %% READING ALL THE IMAGES
    filename = [list(img_counter).folder '\'   list(img_counter).name];
    
    %% LABELS
    label = list(img_counter).folder;
    label = label(end) - 48;
    
    moments = get_features(filename);
    features = [moments];
    
    if img_counter == 1
        featureVector = zeros(number_of_files(1,1), size(features,2));
        labels = zeros(number_of_files(1,1),1);
    end
    featureVector(img_counter,:) = features;
    
    labels(img_counter) = label;
    
end
%Pilar Samaniego -hska KI projekt
figure(13)
coeff = pca(featureVector);
visualizeFeatures = featureVector*coeff;
for i=1:length(labels_names)
    features = featureVector(labels == i,:); 
    h(i) = scatter3(features(:,1),features(:,2),features(:,3),50,'filled');
    leg(i) = labels_names(i);
    hold on;
end
legend(h, leg);
end
%axis([0 0.5 -0.5 0.5  0 0.03])