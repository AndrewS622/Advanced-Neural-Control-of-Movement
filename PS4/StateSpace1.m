A_list = [0.9,0.9,0.9,0.8,0.95,0.99];
B_list = [0.1,0.2,0.3,0.1,0.1,0.1];
figure;
for k = 1:length(A_list)
    A = A_list(k);
    B = B_list(k);
    lab(k) = convertCharsToStrings(['A = ', num2str(A), ', B = ', num2str(B)]);
    x_ideal = [zeros(10,1);ones(50,1)];
    N = length(x_ideal);
    [x, e] = deal(zeros(N,1));
    for n = 1:N
        e(n) = x_ideal(n) - x(n);
        x(n+1) = A*x(n) + B*e(n);
    end
    x = x(1:N);
    plot(x);
    hold on;
    grid on;
end

xlabel('Trial Number (n)');
ylabel('State x(n)');
title('Single State Space Model for Different Parameters');
legend(lab);
    