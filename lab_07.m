clear all;
close all;
rng(241502);

N = 1000;
step = N;
iter = 1000;
a_err = zeros(iter,1);
b_err = zeros(iter,1);
a = 0.5;
b = 0.5;

for i = 1:iter
    Y = zeros(N,1);
    u = zeros(N,1);
    lin = zeros(N,1);
    Lin(0,a,b);
    for n = 1:N
        % Input function (0 to 10) to our model
        u(n) = rand()*10;
        % Unknown model what we going to estimate
        lin(n) = Lin(u(n));
        % Output funtion with noise
        Y(n) = (rand + rand -1)*1 + lin(n);
    end
    %Least Square method
    phi = [ 0       ,   u(1)    ;
            Y(1:N-1),   u(2:N)] ;
    theta = inv(phi' * phi)*(phi' * Y);
    a_err(i) = theta(1) - a;
    b_err(i) = theta(2) - b;
    
    N = N + step;
    if rem(i,10) == 0
        fprintf("%d%%\n",i/10);
    end
end

figure(1);
plot(u, Y,'.b');
xlabel(["[input] = u"]);
ylabel(["[output] = rand + Lin(u)"]);
title(["Y = rand + Lin(u)"]);
saveas(gcf,'y','epsc')

figure(2);
plot(a_err);
hold on;
plot(b_err);
xlabel("iteration");
ylabel("estimation error");
legend("a error", "b error");
saveas(gcf,'err','epsc')

function [res] = Lin(u,a_,b_)
    persistent x;
    persistent a;
    persistent b;
    if nargin == 3
        x = 0;
        a = a_;
        b = b_;
    end
    x = a * x + b * u;
    res = x;
end