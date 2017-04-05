% inspired by http://www.kves.uniza.sk/kvesnew/dokumenty/DREP/Filters/SecondOrderFilters.pdf

zeta = [0.05 0.25 0.5 sqrt(2)/2 1.0 5.0];

N = 1000;
w = logspace(-2, 2, N);
t = linspace(0, 10, N);

mag = [];
phs = [];
steps = [];

legend_labels = cell(length(zeta), 1);
for i = 1:length(zeta)
    H = tf([1], [1 2*zeta(i) 1]);
    [m, p] = bode(H, w);
    mag = [mag reshape(m, N, 1)];
    phs = [phs reshape(p, N, 1)];
    
    y = step(H, t);
    steps = [steps reshape(y, N, 1)];
    
    legend_labels{i} = sprintf('\\zeta = %5.3f', zeta(i));
end

fig = figure()
set(fig, 'Position', [0 0 600 250])
h = semilogx (w ,20*log10(mag));
set(h ,'LineWidth', 2.0);
grid on;
grid minor;
xlabel('Normalized frequency \Omega');
ylabel('Mag (dB)');
xlim([w(1) w(end)]);
ylim([-60 45]);
legend(legend_labels);
matlab2tikz('../figures/2nd_order_filter_mag.tex')
close all;

fig = figure()
set(fig, 'Position', [0 0 600 250])
h = semilogx(w, phs);
set(h ,'LineWidth', 2.0);
grid on;
grid minor;
xlabel('Normalized frequency \Omega');
ylabel('Phase (deg)');
xlim ([w(1) w(end)]);
ylim ([-190 10]);
legend(legend_labels);
matlab2tikz('../figures/2nd_order_filter_phase.tex')
close all;

fig = figure()
set(fig, 'Position', [0 0 600 250])
h = plot(t, steps);
set(h ,'LineWidth', 2.0);
grid on;
grid minor;
xlabel('Time');
ylabel('Output (voltage for example)');
xlim ([t(1) t(end)]);
ylim ([0 2]);
legend(legend_labels);
matlab2tikz('../figures/2nd_order_filter_step_response.tex')
close all;