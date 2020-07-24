clear all
l1=2;
l2=5;

x1=3;
x2=4;

l3=sqrt(x1^2+x2^2);

if l3 > l1+l2
    disp('Cannot solve!');
end
    if x1>=0 && x2 >=0
        quad = 1;
    end
    if x1<0 && x2>=0
        quad = 2;
    end
    if x1<0 && x2<0
        quad = 3;
    end
    if x1>=0 && x2<0
        quad=4;
    end

C=(l2^2-x1^2-x2^2-l1^2)/(-2*l1*l3);
C1=1/sqrt(1-C^2);
CC=(x1^2+x2^2-l1^2-l2^2)/(-2*l1*l2);
C2=1/sqrt(1-CC^2);
xsum=l3^2;

t1=atan2(x2,x1)-acos(C);
t2=pi+t1-acos(CC);

t1deg=t1*180/pi;
t2deg=t2*180/pi;

% switch quad
%     case 1
%         t1testdeg=mod(t1testdeg,90);
%         t2testdeg=mod(t2testdeg,90);
%     case 2
%         t1testdeg=mod(t1testdeg,180);
%         t2testdeg=mod(t2testdeg,180);
%     case 3
%         t1testdeg=180+mod(t1testdeg,90);
%         t2testdeg=180+mod(t2testdeg,90);
%     case 4
%         t1testdeg=mod(t1testdeg,360);
%         t2testdeg=mod(t2testdeg,360);
% end
Ji=zeros(2,2);
Cder=(1/(l1*l3))+((l2^2-x1^2-x2^2-l1^2)*1)/(2*l1*l3^3);

Ji(1,1)=-x2/xsum+x1*C1*Cder;
Ji(1,2)=x1/xsum+x2*C1*Cder;
Ji(2,1)=-x2/xsum+x1*C1*Cder-x1*C2/(l1*l2);
Ji(2,2)=x1/xsum+x2*C1*Cder-x2*C2/(l1*l2);

h1=line([0 l1*cos(t1)],[0 l1*sin(t1)]);
hold on
h2=line([l1*cos(t1) x1],[l1*sin(t1) x2]);
xlim([0 10]);
ylim([-10 10]);
title('Tracking Cursor Movement');
t=1;
v=0;
theta=[t1;t2];
while v<10
dx = [input('Change in x1'); input('Change in x2')];
dt = Ji*dx;
theta=theta+dt*t;
delete(h1);
delete(h2);
h1=line([0 l1*cos(theta(1))],[0 l1*sin(theta(1))]);
h2=line([l1*cos(theta(1)) l1*cos(theta(1))+l2*cos(theta(2))],[l1*sin(theta(1)) l1*sin(theta(1))+l2*sin(theta(2))]);
v=v+1;
x1=x1+dx(1);
x2=x2+dx(2);
l1*cos(theta(1))+l2*cos(theta(2));
l1*sin(theta(1))+l2*sin(theta(2));
end
hold off
