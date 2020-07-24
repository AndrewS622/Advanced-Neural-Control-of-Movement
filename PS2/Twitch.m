K = .17;
tau1 = 50;
tau2 = 15;
t = 1:.5:1500;
h = K*(exp(-t/tau1)-exp(-t/tau2));

subplot(4,1,1);
plot(t,h,'k');
title('Slow-twitch Muscle Response');
xlabel('Time (ms)');
ylabel('Force (N)');
xlim([0 1500]);
ylim([0 0.3]);

tsep = [200,50,20];

for i = 1:3
    impulse_train = zeros(1,4*tsep(i)+tsep(i)/2);
    impulse_train(tsep(i):tsep(i):(4*tsep(i)+tsep(i)/2)) = 1;
    tsep(i):tsep(i):(4*tsep(i)+tsep(i)/2)
    force = conv(impulse_train,h);
    subplot(4,1,i+1);
    plot(force,'k');
    xlabel('Time (ms)');
    ylabel('Force (N)');
    title([num2str(tsep(i)),'ms interval']);
    xlim([0 1500]);
    ylim([0 0.3]);
end