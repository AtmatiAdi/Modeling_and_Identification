% KERNEL ESTIMATION OF REGRESSION FUNCTION
clear all;
close all;
rng(241502);

N = 100;
I = 1000;
% Model
H = [0,0,1;
     1,0,0;
     0,1,0];
A = [1/2,0  ,0  ;
     0  ,1/4,0  ;
     0  ,0  ,1/8];
B = [2,0,0;
     0,3,0;
     0,0,4];
Err = zeros(2,I);
for r = 1:I
    n = N * r;
    
    % SIMULATION
    Theta = zeros(3,n);
    U = zeros(3,n);
    X = zeros(3,n);
    W = zeros(6,n);
    
    for n = 1:n
        U(:,n) = rand(3,1);
        z1 = [  randE0();
                randE0();
                randE0()];
        z2 = [  randE0();
                randE0();
                randE0()];
        Theta(:,n) = A*z1()+z2();
    end
    K = (eye(3)-A*H)^-1*B;
    Y = K*U+Theta;
    %Y = K*U;

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
        A_dash(i,i) = ab(2);
        B_dash(i,i) = ab(1);
    end
    Err(:,r) = [norm(A_dash-A);norm(B_dash-B)];
end

plot(Err(1,:))
hold on
plot(Err(2,:))
title(["Eror = norm(omega - omega\_dash)"]);
xlabel(["Samples x 100"]);
ylabel(["Estimation error"]);
legend("A error", "B error");
saveas(gcf,'err','epsc')


    function [res] = randE0()
        res = rand() + rand() -1; 
    end
    

