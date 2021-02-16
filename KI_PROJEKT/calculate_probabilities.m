function [probabilities, posterior_p] = calculate_probabilities(new_sample,means,stds)
probabilities = zeros(size(new_sample));
posterior_p = 1;
for i=1:length(new_sample)
    mean_ = means(i);
    std_ = stds(i);
    new = new_sample(i);
    p = 1/sqrt(2*pi*std_^2)* exp(-(new - mean_)^2 / (2*std_^2) );
    probabilities(i)=p;
    posterior_p = posterior_p * p;
end

