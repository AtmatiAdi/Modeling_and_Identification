clear all;

len = 1000000;
samples = zeros(1,len);

c = 1;
x = 2*sqrt(rand());
for a = 1:len
    samples(a) = -log(1-rand())/c;
    F(a) = 1 - exp(-c*samples(a));
end

figure(1);
subplot(3,1,1);
histogram(samples);
title('Histogram');
ylabel("Amount of samples");
xlabel("Sample value");
xlim([0 6]);
grid on;

subplot(3,1,2);
plot(samples_sort);
ylabel("Sample value");
xlabel("Samle number");
title('Sorted samples');
ylim([0 6]);
grid on;

subplot(3,1,3);
plot(samples_sort,sort(F));
title('Probability distribution');
ylabel("Probability");
xlabel("Sample value");
xlim([0 6]);
grid on;

for a = 1:len
    samples(a) = 2*sqrt(rand());
    F(a) = samples(a)*samples(a)/4;
end

figure(2);
subplot(3,1,1);
histogram(samples);
title('Histogram');
ylabel("Amount of samples");
xlabel("Sample value");
xlim([0 2]);
grid on;

subplot(3,1,2);
plot(samples_sort);
title('Sorted samples');
ylabel("Sample value");
xlabel("Samle number");
grid on;

subplot(3,1,3);
plot(samples_sort,sort(F));
title('Probability distribution');
ylabel("Probability");
xlabel("Sample value");
grid on;

