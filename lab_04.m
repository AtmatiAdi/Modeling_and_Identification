clear all;
close all;
rng(241502);

N = 1000;
%fd = zeros(1,N);
X = -1:0.001:1;
fd = zeros(length(X),1);

for n = 1:N
    xd(n) = rand() + rand() - 1;
end
    
j = 1;
for x = X
    for i = 1:5
        aid = 0;
        for n = 1:N
            aid = aid + fi(i,xd(n));
        end
        fd(j) = fd(j) + aid * fi(i,x);
    end
    j = j + 1;
end
fd = fd/N;
plot(X,fd,'.');
hold on;

j = 1;
for x = X
    for i = 1:5
        aid = 0;
        for n = 1:N
            aid = aid + fi2(i,xd(n));
        end
        fd(j) = fd(j) + aid * fi2(i,x);
    end
    j = j + 1;
end
fd = fd/N + 1/2;
plot(X,fd,'.');


function [res] = fi(i,x)
pi = 3.14;
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

