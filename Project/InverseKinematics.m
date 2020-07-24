function [theta1, theta2] = InverseKinematics(x1_vec,x2_vec,l1,l2)

theta1 = zeros(1,length(x1_vec));
theta2 = zeros(1,length(x1_vec));

for i = 1:length(x1_vec)
    x1 = x1_vec(i);
    x2 = x2_vec(i);
    l3=sqrt(x1^2+x2^2);
    C=(l2^2-x1^2-x2^2-l1^2)/(-2*l1*l3);
    CC=(x1^2+x2^2-l1^2-l2^2)/(-2*l1*l2);


    theta1(i)=atan2(x2,x1)-acos(C);
    theta2(i)=pi+theta1(i)-acos(CC);
end