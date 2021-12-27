% KERNEL ESTIMATION OF REGRESSION FUNCTION
clear all;
close all;
rng(241502);

N = 10000;
Y = zeros(3,N);
Theta = zeros(3,N);
U = zeros(3,N);
X = zeros(3,N);
W = zeros(6,N);
H = [0,0,1;
     1,0,0;
     0,1,0];
A = [1/2,0  ,0  ;
     0  ,1/4,0  ;
     0  ,0  ,1/8];
B = [2,0,0;
     0,3,0;
     0,0,4];
 
% SIMULATION
for n = 1:N
    U(:,n) = rand(3,1);
    Theta(:,n) = A*rand()+rand();
end
K = (eye(3)-A*H)^-1*B;
Y = K*U+Theta;

% IDENTYFICATION
A_dash = zeros(3,3);
B_dash = zeros(3,3);

for i = 1:3
    X(i,:) = H(i,:)*Y;
    j = (i-1)*2+1;
    l = j+1;
    W(j:l,:) = [U(i,:);
                X(i,:)];
    
    ab = Y(i,:)*W(j:l,:)'*(W(j:l,:)*W(j:l,:)')^-1;
    A_dash(i,i) = ab(1);
    B_dash(i,i) = ab(2);
end

