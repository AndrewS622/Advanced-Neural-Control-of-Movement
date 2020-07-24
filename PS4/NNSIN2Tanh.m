clear all
N_Hidden_list = [5:5:30];
%N_Hidden_list = [1000,2000];
figure;
figure;

x = -2*pi:0.1:2*pi;
y = x;

for NH = 1:length(N_Hidden_list)
N_Hidden = N_Hidden_list(NH);
W1=randn(3,N_Hidden);
W2=randn(N_Hidden+1,1);
xx = -2*pi:0.1:2*pi;
for k1 = 1:length(xx)
    for k2 = 1:length(xx)
        ideal_output(k1,k2) = sin(xx(k1))*sin(xx(k2));
    end
end
nonlinfunc = @(x) tanh(x);
dnonlinfunc = @(x) (1-nonlinfunc(x).^2);
alpha = 0.1; N=1e6; % alpha = learning rate, N = # of iterations
clear e_;
e_ = zeros(1,N);
for k=1:N
 i = randperm(length(xx),1);
 j = randperm(length(xx),1);
 x1 = [xx(i);xx(j)]; x1a = [x1;1]; % x1a = x1-augmented (augmented with a constant offest of 1)
 x2 = nonlinfunc(W1'*x1a); x2a = [x2;1]; % x2a = x2-augmented (augmented with a constant offest of 1)
 x3 = nonlinfunc(W2'*x2a);
 e = x3 - ideal_output(i,j);
 e_(k) = e;

 gradient2 = e_(k)*dnonlinfunc(W2'*x2a)*x2a';
 gradient1 = e_(k)*dnonlinfunc(W2'*x2a)*W2(1:N_Hidden).*dnonlinfunc(W1'*x1a).*x1a';
 W1 = W1 - alpha*gradient1';
 W2 = W2 - alpha*gradient2';
end
figure(1)
subplot(length(N_Hidden_list),1,NH);
plot(e_,'.'); title(['Error e(n) for N\_Hidden = ',num2str(N_Hidden)]);
hold on
figure(2)
for m = 1:length(x)
    for n = 1:length(y)
        xin = x(m);
        yin = y(n);
        x1 = [xin;yin]; x1a = [x1;1]; % x1a = x1-augmented (augmented with a constant offest of 1)
        x2 = nonlinfunc(W1'*x1a); x2a = [x2;1]; % x2a = x2-augmented (augmented with a constant offest of 1)
        x3 = nonlinfunc(W2'*x2a);
        z(m,n) = x3;
    end
end
sq = ceil(sqrt(length(N_Hidden_list)));
    sq2 = floor(sqrt(length(N_Hidden_list)));
    subplot(sq,sq2,NH);
    imagesc(x,y,z); colorbar;
title(['Output of Network For Values Between -2\pi and 2\pi for N\_Hidden = ',num2str(N_Hidden)]);
end
figure(1)
 xlabel('Iteration Number during training (n)')
 hold off
 figure(2)
 

% for m = 1:length(x)
%     for n = 1:length(y)
%         xin = x(m);
%         yin = y(n);
%         x1 = [xin;yin]; x1a = [x1;1]; % x1a = x1-augmented (augmented with a constant offest of 1)
%         x2 = nonlinfunc(W1'*x1a); x2a = [x2;1]; % x2a = x2-augmented (augmented with a constant offest of 1)
%         x3 = nonlinfunc(W2'*x2a);
%         z(m,n) = x3;
%     end
% end

for k1 = 1:length(x)
    for k2 = 1:length(y)
        id(k1,k2) = sin(x(k1))*sin(y(k2));
    end
end
figure; imagesc(x,y,id);colorbar;
