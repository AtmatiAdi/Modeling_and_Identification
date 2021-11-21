% KERNEL ESTIMATION OF REGRESSION FUNCTION
clear all;
close all;
rng(241502);

N = 1000;
Y = zeros(1,N);
u = zeros(1,N);
miu = zeros(1,N);

 for n = 1:N
     % Input function to our model
     u(n) = (rand + rand -1);
     % Unknown model what we going to estimate
     miu(n) = Miu(u(n));
     % Output funtion with noise
     Y(n) = (rand + rand -1) + miu(n);
 end
 
 figure(1);
 plot(Y,'.b');
 
 % Sapn of x of kernel function
 x = 0:0.001:10;
 % Resolution
 h = 0.5;
 K = length(x);
 R = zeros(1,K);
 % Kernel method
 for k = 1:K
    g = 0;
    f = 0;
    for n = 1:N
        g = g + Y(n) * ker((u(n)-x(k))/h);
        f = f + ker((u(n)-x(k))/h);
    end
    R(k) = g / f;
    
 end
 
 figure(2);
 plot(x,R);
 
 function [res] = ker(x)
    res = normpdf(x);
 end
 
 function [res] = Miu(x)
    res = sin(x);
 end
 
 