clear all;
close all;
rng(241502);

N = 1000;
Y = zeros(1,N);
u = zeros(1,N);
miu = zeros(1,N);

 for n = 1:N
     % Input function (0 to 360 degrees) to our model
     u(n) = deg2rad(rand*360);
     %u(n) = rand();
     % Unknown model what we going to estimate
     miu(n) = Miu(u(n));
     % Output funtion with noise
     Y(n) = (rand + rand -1) + miu(n);
 end
 
 figure(1);
 plot(u, Y,'.b');
  ylim([-2,2]);
 xlim([0,deg2rad(360)]);
 xlabel(["[input] = u"]);
 ylabel(["[output] = rand + Miu(u)"]);
 title(["Y = rand + Miu(u)"]);
 saveas(gcf,'y','epsc')
 
 % Sapn of x of kernel function
 x = 0:0.01:deg2rad(360);
 % Resolution
 h = 0.2;
 K = length(x);
 S = 20;
 R_kern = zeros(1,K);
 R_orto = zeros(1,K);
 R_true = zeros(1,K);
 
 for k = 1:K
    % Kernel method
    g = 0;
    f = 0;
    for n = 1:N
        g = g + Y(n) * ker((u(n)-x(k))/h);
        f = f + ker((u(n)-x(k))/h);
    end
    R_kern(k) = g / f;
    % Orthogonal series
    g = 0;
    f = 0;
    for i = 1:S
        g = g + b_dash(u,Y,i,N) * fi(i,x(k));
        f = f + a_dash(u,i,N)   * fi(i,x(k));
    end
    R_orto(k) = g / f;
    
    R_true(k) = Miu((x(k)));
 end
 
 figure(2);
 plot(x,R_kern);
 hold on;
 plot(x,R_orto);
 hold on;
 plot(x,R_true);
 
 ylim([-1.2,1.2]);
 xlim([0,deg2rad(360)]);
 legend(["kernel","ortogonal","true"])
 xlabel(["[input] = u"]);
 ylabel(["[output] = Miu(u)"]);
 title(["Estimated and real Miu"]);
 saveas(gcf,'miu','epsc')
 
 function [res] = ker(x)
    res = normpdf(x);
 end
 
 function [res] = Miu(x)
    res = sin(x*3);
 end
 
function [res] = b_dash(u,Y,i,N)
    res = 0;
    for n = 1:N
        res = res + Y(n) * fi(i,u(n));
    end
    res = res/N;
end
 
 function [res] = a_dash(u,i,N)
    res = 0;
    for n = 1:N
        res = res + fi(i,u(n));
    end
    res = res/N;
 end
 
  
function [res] = fi(i,x)
    if i == 1
        res = 1/sqrt(2);
    elseif mod(i,2) == 0
        res = sin( pi * x * i/2);
    else 
        res = cos( pi * x * (i-1)/2);
    end
end

function [res] = fi2(i,x)
    switch i
        case 1
            res = 1/2 * x;
        case 2
            res = sin(pi * x);
        case 3
            res = cos(pi * x);
        case 4 
            res = sin(2 * pi * x );
        case 5
            res = cos(2 * pi * x);
    end
end