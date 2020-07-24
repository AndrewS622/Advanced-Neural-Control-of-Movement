tf = 0.5;
xf = 10;

A=[tf^5 tf^4 tf^3;5*tf^4 4*tf^3 3*tf^2;20*tf^3 12*tf^2 6*tf];
B=[6*tf^-5 -3*tf^-4 0.5*tf^-3;-15*tf^-4 7*tf^-3 -1*tf^-2;10*tf^-3 -4*tf^-2 0.5*tf^-1];

A*B;

C = B*[xf;0;0];
t=0:0.001:tf;

x = C(1)*t.^5+C(2)*t.^4+C(3)*t.^3;
v = 5*C(1)*t.^4 + 4*C(2)*t.^3 + 3*C(3)*t.^2;
a = 20*C(1)*t.^3 + 12*C(2)*t.^2 + 6*C(3)*t;

figure;
subplot(3,1,1);
plot(t,x,'k');
xlabel('Time (s)');
ylabel('Position');
title('Position vs. Time');
subplot(3,1,2);
plot(t,v,'k');
xlabel('Time (s)');
ylabel('Velocity');
title('Velocity vs. Time');
subplot(3,1,3);
plot(t,a,'k');
xlabel('Time (s)');
ylabel('Acceleration');
title('Acceleration vs. Time');

