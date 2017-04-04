order = [1 2 3 4 5 6];

w = 1e9;
N = 1000;

legend_labels = cell(length(order), 1);
for i = 1:length(order)
    [zb, pb, kb] = butter(order(i), w, 'low', 's');
    [bb, ab] = zp2tf(zb, pb, kb);
    freqs(bb, ab, N); hold on;
    
    legend_labels{i} = sprintf('n = %i', order(i));
end

colors = get(gca, 'colororder');
lines = findall(gcf,'type','line');

for i = 1:length(lines)
    set(lines(i), 'color', colors(mod(i, length(order))+1,:));
    set(lines(i), 'LineWidth', 2.0);
end

ylim([1e-6 10]);
legend(legend_labels, 'Location', 'SouthWest');
matlab2tikz('../figures/butterworth.tex');
close all;