clear all;
close all;
rng(241502);

N = 1000;

% Simulation
b1=3;
b2=2;
b3=1;
omega=[b1; b2; b3];
Y = zeros(1,N);
U = zeros(3,N);

U(:,1) = [  (rand() + rand() -1);
            (rand() + rand() -1);
            (rand() + rand() -1)];
Y(1) = U(:,1)' * omega + rand() + rand() -1;
for n = 2:N
    U(:,n) = [  (rand() + rand() -1);
                U(2,n-1);
                U(1,n-1)];
    z = rand() + rand() -1;
    Y(n) = U(:,n)' * omega + z;
end

% Indetyfication 1
P=100*eye(3);
omega_dash = zeros(3,1);
Err = zeros(1,N);

for n = 1:N
    u = U(:,n);
    P = P - (P*(u*u')*P) / (1+u'*P*u);
    omega_dash = omega_dash + P*u *(Y(n)-u'*omega_dash);
    Err(n) = norm(omega - omega_dash);
end

% Indetyfication 2
P=100*eye(3);
omega_dash = zeros(3,1);
Err2 = zeros(1,N);
lambda=0.9;

for n = 1:N
    u = U(:,n);
    P = P - (1/lambda) * (P*(u*u')*P) / (lambda+u'*P*u);
    omega_dash = omega_dash + P*u *(Y(n)-u'*omega_dash);
    Err2(n) = norm(omega - omega_dash);
end

figure(1);
plot(Err);
title(["Eror = norm(omega - omega\_dash)"]);
xlabel(["samples"]);
saveas(gcf,'err_1','epsc')

figure(2);
plot(Err2);
title(["Eror = norm(omega - omega\_dash)"]);
xlabel(["samples"]);
saveas(gcf,'err_2','epsc')