clear all
N_Hidden_list = [1, 2, 4, 8];
figure;

NH0 = 0;
W = randn(3,1);
x1_list = [0 0; 0 1; 1 0; 1 1]';
ideal_output = [0 1 1 0];
nonlinfunc = @(x) exp(x)./(1+exp(x));
dnonlinfunc = @(x) nonlinfunc(x).*(1-nonlinfunc(x));
alpha = 0.1; N=1e6; % alpha = learning rate, N = # of iterations
clear e_;
e_ = zeros(1,N);
for k=1:N
 i = randperm(4,1);
 x1 = x1_list(:,i); x1a = [x1;1]; % x1a = x1-augmented (augmented with a constant offest of 1)
 x2 = nonlinfunc(W'*x1a);
 e = x2 - ideal_output(i);
 e_(k) = e;

 gradient = e_(k)*dnonlinfunc(W'*x1a)*x1a';
 W = W - alpha*gradient';
end
subplot(length(N_Hidden_list)+1,1,1);
plot(e_,'.'); title(['Error e(n) for N\_Hidden = 0']);


for NH = 1:length(N_Hidden_list)
N_Hidden = N_Hidden_list(NH);
W1=randn(3,N_Hidden);
W2=randn(N_Hidden+1,1);
x1_list = [0 0; 0 1; 1 0; 1 1]';
ideal_output = [0 1 1 0];
nonlinfunc = @(x) exp(x)./(1+exp(x));
dnonlinfunc = @(x) nonlinfunc(x).*(1-nonlinfunc(x));
alpha = 0.1; N=1e6; % alpha = learning rate, N = # of iterations
clear e_;
e_ = zeros(1,N);
for k=1:N
 i = randperm(4,1);
 x1 = x1_list(:,i); x1a = [x1;1]; % x1a = x1-augmented (augmented with a constant offest of 1)
 x2 = nonlinfunc(W1'*x1a); x2a = [x2;1]; % x2a = x2-augmented (augmented with a constant offest of 1)
 x3 = nonlinfunc(W2'*x2a);
 e = x3 - ideal_output(i);
 e_(k) = e;

 gradient2 = e_(k)*dnonlinfunc(W2'*x2a)*x2a';
 gradient1 = e_(k)*dnonlinfunc(W2'*x2a)*W2(1:N_Hidden).*dnonlinfunc(W1'*x1a).*x1a';
 W1 = W1 - alpha*gradient1';
 W2 = W2 - alpha*gradient2';
end
subplot(length(N_Hidden_list)+1,1,NH+1);
plot(e_,'.'); title(['Error e(n) for N\_Hidden = ',num2str(N_Hidden)]);
end
 xlabel('Iteration Number during training (n)')
x = 0:0.01:1;
y = x;
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
figure; imagesc(x,y,z); colorbar;
title('Output of Network For Values Between 0 and 1');
xlabel('Input 1');
ylabel('Input 2');
set(gca,'Ydir','normal');
set(gca,'Xdir','normal');

x = -1:0.01:2;
y = x;
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
figure; imagesc(x,y,z); colorbar;
title('Output of Network For Values Between -1 and 2');
xlabel('Input 1');
ylabel('Input 2');
set(gca,'Ydir','normal');
set(gca,'Xdir','normal');