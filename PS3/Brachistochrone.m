N = 49;
y0 = [.98:-.02:.02];

figure;
u=[0:0.2:0.8,0.999];
options = optimoptions(@lsqnonlin,'FunctionTolerance',1E-7,'MaxFunctionEvaluations',Inf,'MaxIterations',Inf);
for i = 1:6
    y(i,:) = lsqnonlin(@(y) brach2(y,u(i)), y0, [], [], options);
    ytot(i,:) = [1,y(i,:),0];
    y0=y(i,:);
    plot([0:(1/(length(ytot)-1)):1],ytot(i,:));
    disp('next...');
    hold on
end

xlabel('x value');
ylabel('y value');
title('Brachistochrone with Kinetic Friction');
legend('0','0.2','0.4','0.6','0.8','1');
hold off;

