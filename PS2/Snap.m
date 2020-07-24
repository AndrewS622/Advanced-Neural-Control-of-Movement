tf = 0.5;
xf = 10;

A=[tf^7 tf^6 tf^5 tf^4;7*tf^6 6*tf^5 5*tf^4 4*tf^3;42*tf^5 30*tf^4 20*tf^3 12*tf^2;210*tf^4 120*tf^3 60*tf^2 24*tf];
B=[-20*tf^-7 10*tf^-6 -2*tf^-5 (1/6)*tf^-4;70*tf^-6 -34*tf^-5 6.5*tf^-4 -0.5*tf^-3;-84*tf^-5 39*tf^-4 -7*tf^-3 0.5*tf^-2;35*tf^-4 -15*tf^-3 2.5*tf^-2 (-1/6)*tf^-1];

A*B;

C = B*[xf;0;0;0];
t=0:0.001:tf;

x = C(1)*t.^7+C(2)*t.^6+C(3)*t.^5+C(4)*t.^4;
v = 7*C(1)*t.^6+6*C(2)*t.^5+5*C(3)*t.^4+4*C(4)*t.^3;
a = 42*C(1)*t.^5+30*C(2)*t.^4+20*C(3)*t.^3+12*C(4)*t.^2;
J = 210*C(1)*t.^4+120*C(2)*t.^3+60*C(3)*t.^2+24*C(4)*t;

figure;
subplot(4,1,1);
plot(t,x,'k');
xlabel('Time (s)');
ylabel('Position');
title('Position vs. Time');
subplot(4,1,2);
plot(t,v,'k');
xlabel('Time (s)');
ylabel('Velocity');
title('Velocity vs. Time');
subplot(4,1,3);
plot(t,a,'k');
xlabel('Time (s)');
ylabel('Acceleration');
title('Acceleration vs. Time');
subplot(4,1,4);
plot(t,J,'k');
xlabel('Time (s)');
ylabel('Jerk');
title('Jerk vs. Time');
