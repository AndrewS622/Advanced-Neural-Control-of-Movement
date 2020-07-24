function [x,y] = ForwardKinematics(theta1_list,theta2_list,l1,l2)

x=zeros(1,length(theta1_list));
y=x;

for i = 1:length(theta1_list)
    theta1=theta1_list(i);
    theta2=theta2_list(i);
    
    x(i) = l1*cos(theta1)+l2*cos(theta2);
    y(i) = l1*sin(theta1)+l2*sin(theta2);
    
end