tf = 0.25;
xf = 10;

A=[tf^5 tf^4 tf^3;5*tf^4 4*tf^3 3*tf^2;20*tf^3 12*tf^2 6*tf];
B=[6*tf^-5 -3*tf^-4 0.5*tf^-3;-15*tf^-4 7*tf^-3 -1*tf^-2;10*tf^-3 -4*tf^-2 0.5*tf^-1];

amin=-20*xf/(3*tf^2);
A*B;

C = B*[xf;0;amin];
t=0:0.001:tf;

x = C(1)*t.^5+C(2)*t.^4+C(3)*t.^3;
v = 5*C(1)*t.^4 + 4*C(2)*t.^3 + 3*C(3)*t.^2;
a = 20*C(1)*t.^3 + 12*C(2)*t.^2 + 6*C(3)*t;

x2=fliplr(x);
v2=-1*fliplr(v);
a2=fliplr(a);

xtot=[x,x2];
vtot=[v,v2];
atot=[a,a2];
ttot=0:0.001:2*tf;
l = length(ttot);
xtot(floor(l/2))=[];
vtot(floor(l/2))=[];
atot(floor(l/2))=[];

figure;
subplot(3,1,1);
plot(ttot,xtot,'k');
xlabel('Time (s)');
ylabel('Position (cm)');
title('Position vs. Time');
subplot(3,1,2);
plot(ttot,vtot,'k');
xlabel('Time (s)');
ylabel('Velocity (cm/s)');
title('Velocity vs. Time');
subplot(3,1,3);
plot(ttot,atot,'k');
xlabel('Time (s)');
ylabel('Acceleration (cm/s^2)');
title('Acceleration vs. Time');

