function [t12, x, dt12, ddt12, dx, ddx] = SimulateDynamics(JT, l1, l2, t10, t20, a, b, c, dt, fc, B, K, Fadapt, theta)

%inputs:
% JT = 2 x N vector of joint torques to be applied
% l1, l2 are used to compute x and y from thetas
% t10 and t20 are initial conditions for theta
% a, b, and c are coefficients for the interia matrix M
% B and K are stiffness and viscosity matrices
% fc are the coefficients for the applied force-field

N=length(JT);
t12 = zeros(2,N);
dt12 = t12;
ddt12 = t12;
x=t12;dx=t12;ddx=t12;
f = t12;
t12(1,1) = t10;
t12(2,1) = t20;
[x(1,1),x(2,1)] = ForwardKinematics(t12(1,1),t12(2,1),l1,l2);
dx(1,1)=0;dx(2,1)=0;ddx(1,1)=0;ddx(2,1)=0;

for i = 1:N-1
        J = [-l1*sin(t12(1,i)) -l2*sin(t12(2,i)) ; l1*cos(t12(1,i)) l2*cos(t12(2,i))];
        f(:,i) = fc*dx(:,i)-Fadapt(:,i);
        tforce = transpose(J)*f(:,i);
        M = [a c*cos(t12(2,i)-t12(1,i)); c*cos(t12(2,i)-t12(1,i)) b];
        C = [0 -c*sin(t12(2,i)-t12(1,i)); c*sin(t12(2,i)-t12(1,i)) 0];
%         disp(K*t12(:,i))
%         disp(B*dt12(:,i))
        %ddt12(:,i) = inv(M)*(JT(:,i)-K*t12(:,i)-B*dt12(:,i)+tforce-C*dt12(:,i).^2);
        ddt12(:,i) = inv(M)*(JT(:,i)-K*(t12(:,i)-theta(:,i))-B*dt12(:,i)+tforce-C*dt12(:,i).^2);
        dt12(:,i+1) = dt12(:,i) + ddt12(:,i)*dt;
        t12(:,i+1) = t12(:,i) + dt12(:,i)*dt + 0.5*ddt12(:,i)*dt^2;
        [x(1,i+1),x(2,i+1)] = ForwardKinematics(t12(1,i+1),t12(2,i+1),l1,l2);
        dx(:,i+1) = (x(:,i+1)-x(:,i))/dt;
        ddx(:,i+1) = (dx(:,i+1)-dx(:,i))/dt;
end

% plot(f(1,:))
% hold on
% title('Force');
