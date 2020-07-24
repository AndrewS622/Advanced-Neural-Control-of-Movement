function [x_,y_] = LCSJOAB(xfin, yfin, Tf)

N=1000;
x0=zeros(1,N);
y0=zeros(1,N);

csjx = @(x,xf) diff([0,0,0,x,xf,xf],3);
csjy = @(y,yf) diff([0,0,0,y,yf,yf],3);

x=lsqnonlin(@(x,xf) csjx(x,xfin), x0);
y=lsqnonlin(@(y,yf) csjy(y,yfin), y0);
x_ = [0,x,xfin];
y_ = [0,y,yfin];
t=[0:(N+1)]/(N+1)*Tf;
dt=Tf/(N+1);
% figure;
% 
t=[t,t(2:end)+t(end)];
x_=[x_,flip(x_(2:end))];
y_=[y_,flip(y_(2:end))];
% 
% subplot(3,1,1);
% plot(t,x_);
% ylabel('Position');
% hold on;
% 
% subplot(3,1,2);
% plot(t(2:end),diff(x_)/dt);
% ylabel('Velocity');
% hold on;
% 
% subplot(3,1,3);
% plot(t(2:end-1),diff(x_,2)/dt^2);
% ylabel('Acceleration');
% xlabel('Time (sec)');
% hold on;
% 
% hold off;
% 
% figure;
% subplot(3,1,1);
% plot(t,y_);
% ylabel('Position');
% hold on;
% 
% subplot(3,1,2);
% plot(t(2:end),diff(y_)/dt);
% ylabel('Velocity');
% hold on;
% 
% subplot(3,1,3);
% plot(t(2:end-1),diff(y_,2)/dt^2);
% ylabel('Acceleration');
% xlabel('Time (sec)');
% hold on;
% 
% hold off;
% 
% figure;
% plot(x,y);
