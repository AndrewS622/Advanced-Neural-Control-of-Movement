tf = 0.5;
xf = 10;
t = 0:0.001:tf;

A = [tf^3 tf^2;3*tf^2 2*tf];
B = [-2*tf^-3 tf^-2;3*tf^-2 -1*tf^-1];

A*B;

C=B*[xf;0];

x=C(1)*t.^3+C(2)*t.^2;
v=3*C(1)*t.^2+2*C(2)*t;
a=6*C(1)*t+2*C(2);

figure;
subplot(3,1,1);
plot(t,x,'k');
xlabel('Time (s)');
ylabel('Position (cm)');
title('Position vs. Time');
subplot(3,1,2);
plot(t,v,'k');
xlabel('Time (s)');
ylabel('Velocity (cm/s)');
title('Velocity vs. Time');
subplot(3,1,3);
plot(t,a,'k');
xlabel('Time (s)');
ylabel('Acceleration (cm/s^2)');
title('Acceleration vs. Time');

