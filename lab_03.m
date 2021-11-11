clear all;
close all;

theta = 10;
N = 10000;
samples = 100;

for s = 1:samples
    for n = 1:N
        for i = 1:s
            noisy_samples(i) = theta + rand() - 0.5;
        end
        % Calculate Mean
        s_mean(n) = mean(noisy_samples);
    end
    % Calculate Variances
    v(s) = var(s_mean);
end

plot(v);




