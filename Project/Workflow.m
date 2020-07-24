dirs = 0:45:315;
figure;
labels = zeros(length(dirs),1);
coeffs = [0.5 0.5; 1.0 0.5; 2.0 0.5; 0.5 1.0; 1.0 1.0; 2.0 1.0; 0.5 2.0; 1.0 2.0; 2.0 2.0];
for cond = 1:9
    coeff = coeffs(cond,:);
    %coeff = [0 0];
for k = 1:length(dirs)
%Initialize angles and positions, specify total change in x and y, and
%define length of time
Dx = 0.1*cos(dirs(k)*pi/180);
Dy = 0.1*sin(dirs(k)*pi/180);
tinit1 = 45*pi/180;
tinit2 = 135*pi/180;
l1 = .32;
l2 = .33;
[xinit,yinit] = ForwardKinematics(tinit1,tinit2,l1,l2);
Tf = 0.5;

%Use minimal cumulative squared jerk to find optimal trajectory
[x_,y_] = LCSJ(Dx, Dy, Tf);
x = x_+xinit;
y = y_+yinit;
dt = Tf/(length(x_)-1);
t = [0:dt:Tf];

%Convert optimal trajectory in x and y to shoulder and elbow angles
[theta1, theta2] = InverseKinematics(x,y,l1,l2);

%Verify conversion
[xtest,ytest] = ForwardKinematics(theta1,theta2,l1,l2);

%Initialize parameters and vectors for Torque Computation
a = 0.265;
b = 0.052;
c = 0.0844; 
a=2.65;
b=0.52;
c=.844;

dth1 = diff(theta1)/dt;
dth2 = diff(theta2)/dt;
dtheta1 = [0 dth1];
dtheta2 = [0 dth2];
ddth1 = diff(theta1,2)/dt^2;
ddth2 = diff(theta2,2)/dt^2;
ddtheta1 = [0 ddth1 0];
ddtheta2 = [0 ddth2 0];

theta = [theta1;theta2];
dtheta = [dtheta1;dtheta2];
ddtheta = [ddtheta1;ddtheta2];

JT = Dynamics(theta, dtheta, ddtheta, a, b, c);
% figure;
% plot(t,JT(1,:));
% hold on
% plot(t,JT(2,:));
% xlabel('Time (s)');
% ylabel('Torque (Nm)')

%Simulate dynamics based on calculated torques, initial conditions, and
%coefficients for force-field, stiffness, and viscosity
fc = [0 15; -15 0];
%fc = [0 0;0 0];
B = [2.25 0.9; 0.9 2.4];
K = [15 6; 6 16]/10;

Fadapt = 0*fc*[diff(x);diff(y)]/dt;
[t12, xsim, dt12, ddt12, dx, ddx] = SimulateDynamics(JT, l1, l2, tinit1, tinit2, a, b, c, dt, fc, coeff(1)*B, coeff(2)*K, Fadapt, theta);
%figure;
% subplot(2,1,1)
% plot(t,xsim(1,:));
% hold on
% ylabel('x (cm)');
% subplot(2,1,2)
% plot(t,xsim(2,:));
% xlabel('Time (s)');
% ylabel('y (cm)');
% hold on
% 
% figure;
% subplot(2,1,1)
% plot(t,dt12(1,:));
% ylabel('dx/dt (cm/s)');
% subplot(2,1,2)
% plot(t,dt12(2,:));
% xlabel('Time (s)');
% ylabel('dy/dt (cm/s)');
% 
% figure;
subplot(3,3,cond);
plot(xsim(1,:),xsim(2,:));
hold on

end
%legend({'0','45','90','135','180','225','270','315'})
xlabel('x (m)');
ylabel('y (m)');
title(num2str(coeff));

% subplot(2,1,1)
% legend({'0','45','90','135','180','225','270','315'})
% title('x Motion');
% 
% subplot(2,1,2)
% legend({'0','45','90','135','180','225','270','315'})
% title('y Motion');

end
