Af = 0.6;
As = 0.99;
Bf = 0.2;
Bs = 0.02;

ntri = 1200;
xideal = [zeros(10,1);ones(ntri,1)];
N = length(xideal);
[x, xf, xs, e] = deal(zeros(N,1));

for n = 1:N
    e(n) = xideal(n) - x(n);
    xf(n+1) = Af*xf(n) + Bf*e(n);
    xs(n+1) = As*xs(n) + Bs*e(n);
    x(n+1) = xf(n+1) + xs(n+1);
end

figure;
plot(xs);
hold on
plot(xf);
plot(x);
plot(e);
xlabel('Trial Number (n)');
xlim([0,N]);
title('Two-State Model');
legend('x_s','x_f','x_{tot}','e');
hold off;