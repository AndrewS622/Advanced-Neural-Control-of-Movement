
l1=2;
l2=3;
t1deg=-10;
t2deg=30;
t1deg=mod(t1deg,360);
t2deg=mod(t2deg,360);
t1=t1deg*pi/180;
t2=t2deg*pi/180;
if t1>t2
    G=1;
else
    G=0;
end

x1=l1*cos(t1)+l2*cos(t2);
x2=l1*sin(t1)+l2*sin(t2);
l3=sqrt(x1^2+x2^2);
%     if x1>=0 && x2 >=0
%         quad = 1;
%     end
%     if x1<0 && x2>=0
%         quad = 2;
%     end
%     if x1<0 && x2<0
%         quad = 3;
%     end
%     if x1>=0 && x2<0
%         quad=4;
%     end
J=[-l1*sin(t1),-l2*sin(t2);l1*cos(t1),l2*cos(t2)];

Ji=inv(J);

C=(l2^2-x1^2-x2^2-l1^2)/(-2*l1*l3);
C1=1/sqrt(1-C^2);
CC=(x1^2+x2^2-l1^2-l2^2)/(-2*l1*l2);
C2=1/sqrt(1-CC^2);
xsum=l3^2;

if G==1
    t1test=atan2(x2,x1)+acos(C);
    t2test=-pi+t1test+acos(CC);
end

if G==0
    t1test=atan2(x2,x1)-acos(C);
    t2test=pi+t1test-acos(CC);
end

t1testdeg=t1test*180/pi;
t2testdeg=t2test*180/pi;

x1t = l1*cos(t1test)+l2*cos(t2test);
x2t = l1*sin(t1test)+l2*sin(t2test);

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
        t1testdeg=mod(t1testdeg,360);
        t2testdeg=mod(t2testdeg,360);
% end
Jtest=zeros(2,2);
Cder=(1/(l1*l3))+((l2^2-x1^2-x2^2-l1^2)*1)/(2*l1*l3^3);

if G==1
Jtest(1,1)=-x2/xsum-x1*C1*Cder;
Jtest(1,2)=x1/xsum-x2*C1*Cder;
Jtest(2,1)=-x2/xsum-x1*C1*Cder+x1*C2/(l1*l2);
Jtest(2,2)=x1/xsum-x2*C1*Cder+x2*C2/(l1*l2);
end

if G==0
Jtest(1,1)=-x2/xsum+x1*C1*Cder;
Jtest(1,2)=x1/xsum+x2*C1*Cder;
Jtest(2,1)=-x2/xsum+x1*C1*Cder-x1*C2/(l1*l2);
Jtest(2,2)=x1/xsum+x2*C1*Cder-x2*C2/(l1*l2);
end

line([0 l1*cos(t1)],[0 l1*sin(t1)]);
hold on
line([l1*cos(t1) x1],[l1*sin(t1) x2]);
line([0 x1],[0 x2]);
hold off

% dx=[.2;.2];
% dt = Jtest*dx;
% t1new=t1test+dt(1);
% t2new=t2test+dt(2);
% x1new=x1+dx(1);
% x2new=x2+dx(2);
% x1test=l1*cos(t1new)+l2*cos(t2new);
% x2test=l1*sin(t1new)+l2*sin(t2new);
% 
% line([0 l1*cos(t1new)],[0 l1*sin(t1new)]);
% hold on
% line([l1*cos(t1new) x1test],[l1*sin(t1new) x2test]);
% line([0 x1new],[0 x2new]);
% hold off

% line([0 l1*cos(t1new)],[0 l1*sin(t1new)]);
% hold on
% line([l1*cos(t1new) x1new],[l1*sin(t1new) x2new]);
% hold off

% dt=[.1;.2];
% dx = J*dt;
% t1new=t1test+dt(1);
% t2new=t2test+dt(2);
% x1new=x1+dx(1);
% x2new=x2+dx(2);
% x1test=l1*cos(t1new)+l2*cos(t2new);
% x2test=l1*sin(t1new)+l2*sin(t2new);
% 
% line([0 l1*cos(t1new)],[0 l1*sin(t1new)]);
% hold on
% line([l1*cos(t1new) x1test],[l1*sin(t1new) x2test]);
% hold off
% 
% 
% line([0 l1*cos(t1new)],[0 l1*sin(t1new)]);
% hold on
% line([l1*cos(t1new) x1new],[l1*sin(t1new) x2new]);
% hold off