function [JT] = Dynamics(theta,dtheta,ddtheta,a,b,c)

JT = zeros(2,length(theta));
for i = 1:length(theta)
        th = theta(:,i);
        dth = dtheta(:,i);
        ddth = ddtheta(:,i);
        M = [a c*cos(th(2)-th(1)); c*cos(th(2)-th(1)) b];
        C = [0 -c*sin(th(2)-th(1)); c*sin(th(2)-th(1)) 0];
        
        JT(:,i) = M*ddth + C*dth.^2;
end
        