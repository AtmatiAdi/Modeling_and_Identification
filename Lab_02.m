clear all;
close all

step = 100;
pi = 3.14;
e = exp(1);

c = 3*sqrt(2*e/pi);
edge = 5;
X = -edge:1/step:edge;
len = length(X);

accepted = zeros(1,len)-0.1;
rejected = zeros(1,len)-0.1;
f = zeros(1,len);
g = zeros(1,len);
a = 1;
r = 1;

for n = 1:len
    x = X(n);
    %f(n) = (1/sqrt(2*pi))*exp(-x*x/2);
    g(n) = 1/2*exp(-abs(x));
end
f = gaussmf(X,[1 0]);

% Rejection method
for n = 1:len
    x = X(n);
    % randomise u
    u = 2*rand(); 
    if abs(x)^2 <= -2*log(u)
        % Accept
        accepted(n) = u;
        a = a + 1;
    else
        %Reject
        rejected(n) = u;
        r = r + 1;
    end
end
figure(1);
plot(X,f);
hold on;
plot(X,c*g)
title('Simple PDF functions');
ylabel("Amount of samples");
xlabel("Sample value");
grid on;

plot(X,rejected,".r")
plot(X,accepted,".g")
ylim([0 2]);
