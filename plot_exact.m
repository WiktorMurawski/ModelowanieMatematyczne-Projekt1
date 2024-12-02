function [] = plot_exact(y1_exact,y2_exact,tspan)
y_lim = [-0.004,0.065];
latex_y1_dot = '$\dot{y}_1(t)$';
latex_y2_dot = '$\dot{y}_2(t)$';
figure(1);clf;
hold on;
ylim(y_lim);
xlabel('$t$','Interpreter','latex');
fplot(y1_exact,tspan,'DisplayName',latex_y1_dot,'Color','r');
fplot(y2_exact,tspan,'DisplayName',latex_y2_dot,'Color','b');
lgd = legend('show', 'Interpreter', 'latex');
set(lgd, 'FontSize', 16);
end