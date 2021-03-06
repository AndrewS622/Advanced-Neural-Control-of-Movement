N=1000;
x0=zeros(1,N);

csj = @(x,xf) diff([0,0,x,xf,xf],2);

x=lsqnonlin(@(x) csj(x,10), x0);
x_ = [0,x,10];
Tf=0.5;
t=[0:(N+1)]/(N+1)*Tf;
dt=Tf/(N+1);
figure;

subplot(3,1,1);
plot(t,x_);
ylabel('Position');
hold on;

subplot(3,1,2);
plot(t(2:end),diff(x_)/dt);
ylabel('Velocity');
hold on;

subplot(3,1,3);
plot(t(2:end-1),diff(x_,2)/dt^2);
ylabel('Acceleration');
xlabel('Time (sec)');
hold on;

hold off;