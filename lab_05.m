%KERNEL ESTIMATION OF REGRESSION FUNCTION

N = 10000;
Yk = zeros(1,N);
uk = zeros(1,N);
R = zeros(1,N);

 for n = 1:N
     % Unknown function what we going to estimate
     uk(n) = sin(n/2000);
     % Output with noise
     Yk(n) =  uk(n)+ 2*rand()-1;
 end
 
 plot(Yk);
 
 % Sapn of x of kernel function
 x = -1:0.001:1;
 % Resolution
 h = 1;
 % Kernel method
 for k = 1:K
    sum_Yk = 0;
    sum_Y = 0;
    for n = 1:N
        sum_Yk = sum_Yk + ker((uk(n)-x(k))/h) * Yk(n);
        sum_Y = sum_Y + ker(()/h)
    end
    R(u) = sum_Yk / sum_Y;
    
 end
 
 function [res] = ker(x)
    res = 1;
 end
 