N=50;
x0=10*rand(1,N);
xf = 10;

x0 = [0,0,x0,xf,xf];
csj = @(x) diff(x,2);

x=grad_desc(@(x) csj(x), x0);
x_ = x(2:end-1);
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