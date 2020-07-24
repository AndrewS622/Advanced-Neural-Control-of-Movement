l1=1.2;
l2=1.1;
x = -2:.05:2;
y = -2:.05:2;
J = cell(length(x),length(y));
Jeig = cell(length(x),length(y));
Jvec = Jeig;
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
        J{i,j}(1,1)=-y(j)/xsum(i,j)+x(i)*C1(i,j)*Cder(i,j);
        J{i,j}(1,2)=x(i)/xsum(i,j)+y(j)*C1(i,j)*Cder(i,j);
        J{i,j}(2,1)=-y(j)/xsum(i,j)+x(i)*C1(i,j)*Cder(i,j)-x(i)*C2(i,j)/(l1*l2);
        J{i,j}(2,2)=x(i)/xsum(i,j)+y(j)*C1(i,j)*Cder(i,j)-y(j)*C2(i,j)/(l1*l2);
        if ~any(isnan(J{i,j}))
        [Jvec{i,j},Jeig{i,j}] = eig(J{i,j}');
        Jeig{i,j} = diag(Jeig{i,j});
        else 
            Jeig{i,j} = [0 0];
            Jvec{i,j} = [0 0; 0 0];
        end
    end
end

for i=1:length(x)
    for j=1:length(y)
        Jeiglarge(i,j) = max(abs(Jeig{i,j}));
        Jeigsmall(i,j) = min(abs(Jeig{i,j}));
    end
end

for i=1:length(x)
    for j=1:length(y)
        Jvecx1(i,j) = Jvec{i,j}(1,1);
        Jvecy1(i,j) = Jvec{i,j}(2,1);
        Jvecx2(i,j) = Jvec{i,j}(1,2);
        Jvecy2(i,j) = Jvec{i,j}(2,2);
    end
end
figure;
imagesc(x,y,Jeiglarge);
colorbar
title('Maximum Force at Each Point');
xlabel('x1 position');
ylabel('x2 position');
set(gca,'YDir','normal')
figure;
imagesc(x,y,Jeigsmall);
colorbar
title('Minimum Force at Each Point');
xlabel('x1 position');
ylabel('x2 position');
set(gca,'YDir','normal')
figure;
quiver(x,y,Jvecx1,Jvecy1);
hold on
%quiver(x,y,Jvecx2,Jvecy2);
hold off