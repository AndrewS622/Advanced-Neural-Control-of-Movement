function time = brach2(y,u)
y=[1;y(:);0]';
x=[0:(1/(length(y)-1)):1];
theta = atan2(diff(y),diff(x));
a = 9.81*(sin(theta))+u*(9.81*cos(theta));
%a = 9.81*(sin(theta));
v = zeros(1,length(x));
t = zeros(1,length(x)-1);

for i = 1:length(x)-1
    del(i) = -sqrt((x(i+1)-x(i))^2+(y(i+1)-y(i))^2);
    %disp(sign(v(i)^2+2*a(i)*(del(i))));
    t(i) = (1/a(i))*(-v(i)-sqrt((v(i)^2+2*a(i)*(del(i)))));
    v(i+1) = v(i)+a(i)*t(i);
end
t=[0,t];
if (min(t)<0)||(sum(~isreal(t)) > 0), time=inf; disp('Ball gets stuck!'); else time=sum(t); 
end
% plot(cumsum(t),v);
% figure;
% plot(x,y);
end