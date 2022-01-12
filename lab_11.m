clear all;
close all;
rng(241502);

% SIMULATION
N = 100;
uk = zeros(1,N);
yk = zeros(1,N);
wk = zeros(1,N);
gamma = [ 3;
        2;
        1];
c   = [ 1;
        2];

for n = 1:N
    uk(n) = (rand() - 0.5) * 10;
    wk(n) = c' * [uk(n)^2; uk(n)];
    wk0 = wk(n);
    if n > 2 
        wk1 = wk(n-1);
    else
        wk1 = 0;
    end
    if n > 3
        wk2 = wk(n-2);
    else
        wk2 = 0;
    end
    vk = gamma' *  [wk0; wk1; wk2];
    z = rand()+rand()-1;
    %z = 0;
    yk(n) = vk + z;
end

% INDENTYFICATION
Fi = zeros(N,6);
for n = 1:N
    fi0 = uk(n)^2;
    fi1 = uk(n);
    if n > 2
        fi2 = uk(n-1)^2;
        fi3 = uk(n-1);
    else
        fi2 = 0;
        fi3 = 0;
    end
    if n > 3
        fi4 = uk(n-2)^2;
        fi5 = uk(n-2);
    else
        fi4 = 0;
        fi5 = 0;
    end
    Fi(n,:) = [fi0, fi1, fi2, fi3, fi4, fi5];
end
Theta_est = ((Fi'*Fi)^(-1))*Fi'*yk';

M = c * gamma';
[P,D,Q] = svd(M);
c_dash = P(1,:) / P(1,1);
gamma_dash = Q(:,1) * P(1,1) * D(1,1);