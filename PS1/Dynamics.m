
figure;
image(Fmax);
title('Maximum Force for Each Point');

figure;
image(Fmin);
title('Minimum Force for Each Point');

xC = 2;
yC = 2;
radx = 1;
rady = 5;
theta = 0 : 0.01 : 2*pi;
x = radx * cos(theta) + xC;
y = rady * sin(theta) + yC;
plot(x, y, 'LineWidth', 2,'Color','k');
axis square;
xlim([0 20]);
ylim([0 20]);
grid on;
% Draw lines along the axes
hold on;
line([xC, xC], [yC - rady, yC + rady],'LineWidth', 1.5, 'Color','k');
line([xC - radx, xC + radx], [yC, yC],'LineWidth', 1.5, 'Color','k');
% Enlarge figure to full screen.
% set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);