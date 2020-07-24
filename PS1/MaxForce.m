l1=1.2;
l2=1.3;
x = -2:.1:2;
y = -2:.1:2;
J = zeros (length(x),length(x),2,2);
l3 = zeros(length(x),length(y));
xsum = zeros(length(x),length(y));
C = xsum;
C1 = xsum;
CC = xsum;
C2 = xsum;
Cder = xsum;
for i = 1:length(x)
    for j = 1:length(y)
        l3(i,j)=sqrt(x(i)^2+y(j)^2);
        xsum(i,j) = x(i)^2 + y(j)^2;
        C(i,j)=(l2^2-x(i)^2-y(j)^2-l1^2)/(-2*l1*l3(i,j));
        C1(i,j)=1/sqrt(1-C(i,j)^2);
        CC(i,j)=(x(i)^2+y(j)^2-l1^2-l2^2)/(-2*l1*l2);
        C2(i,j)=1/sqrt(1-CC(i,j)^2);
        Cder(i,j)=(1/(l1*l3(i,j)))+((l2^2-x(i)^2-y(j)^2-l1^2)*1)/(2*l1*l3(i,j)^3);
        J(i,j,1,1)=-y(j)/xsum(i,j)+x(i)*C1(i,j)*Cder(i,j);
        J(i,j,1,2)=x(i)/xsum(i,j)+y(j)*C1(i,j)*Cder(i,j);
        J(i,j,2,1)=-y(j)/xsum(i,j)+x(i)*C1(i,j)*Cder(i,j)-x(i)*C2(i,j)/(l1*l2);
        J(i,j,2,2)=x(i)/xsum(i,j)+y(j)*C1(i,j)*Cder(i,j)-y(j)*C2(i,j)/(l1*l2);
    end
end
Tmax = 10;
T = -Tmax:Tmax;
T = [T;T];
F=zeros(length(T));
Fmax = zeros(length(x),length(y));
Fmin=Fmax;
for k = 1:length(x)
    for l = 1:length(y)
        
for i=1:length(T(1,:))
    for j=1:length(T(2,:))
        T1=[T(1,i);T(2,j)];
        F(k,l,i,j) = norm(J(k,l)'*(T1));
    end
end
    [Fmax(k,l)] = max(max(F(k,l,:,:)));
    if ~isnan(Fmax(k,l))
    [I(k,l)] = find(F(k,l,:,:) == Fmax(k,l),1);
    Fmin(k,l) = min(min(F(k,l,:,:)));
    if Fmax(k,l) > 100
        Fmax(k,l) = 100;
    end
    end
    end
end
imagesc(x,y,Fmax);
colorbar
xlabel('x1 position');
ylabel('x2 position');
title('Maximum Force at Each Point');
figure;
imagesc(x,y,Fmin);
colorbar;