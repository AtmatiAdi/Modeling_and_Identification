clear all;
close all;
rng(241502);

N = 100;
U = zeros(1,N);
Y = zeros(1,N);
a = 0.5;

% SIMULATION
U(1) = randn();
Y(1) = a * 0 + U(1);
for n = 2:N
    U(n) = randn();
    %U(n) = sin(deg2rad(n))/2+randn();
    Y(n) = a * Y(n-1) + U(n);
end

% IDENTYFICATION
S = 5;
gamma = zeros(1,S);
for i = 0:S
    sum = 0;
    for n = 1:N-i
        sum = sum + U(n) * Y(n+i);
    end
    gamma(i+1) = 1/(N-i)*sum;
end

% ESTIMATED MODEL
Y_ = zeros(1,N);
for n = S+1:N
    y_ = 0;
    for i = 0:S
        y_ = y_ + gamma(i+1)*U(n-i);
    end
    Y_(n) = y_;
end

figure(1)
plot(gamma,'*')
title(["Gamma values"]);
ylabel(["gamma value"]);
xlabel(["gamma number"]);
saveas(gcf,'gamma','epsc')

figure(2)
plot(Y)
hold on
plot(Y_)
xlabel(["time"]);
legend(["OBJECT","MODEL"])
title(["System and Model output"]);
saveas(gcf,'y','epsc')
