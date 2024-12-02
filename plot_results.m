function [] = plot_results(tspan,y1_exact,y2_exact,...
  T_ode45,y_ode45,t,y_m1,y_m2,y_m3)

y1_ode45 = y_ode45(1,:);
y2_ode45 = y_ode45(2,:);
y1_m1 = y_m1(1,:);
y2_m1 = y_m1(2,:);
y1_m2 = y_m2(1,:);
y2_m2 = y_m2(2,:);
y1_m3 = y_m3(1,:);
y2_m3 = y_m3(2,:);

y_lim = [-0.004,0.065];
colors{1} = [255 0 0];
colors{2} = [0 0 255];
colors{3} = [128 0 255];
colors{4} = [0 196 0];
for i=1:4
  colors{i} = colors{i} / 255;
end
latex_y1_dot = '$\dot{y}_1(t)$';
latex_y2_dot = '$\dot{y}_2(t)$';
latex_y1_hat = '$\hat{y}_1(t)$';
latex_y2_hat = '$\hat{y}_2(t)$';

figure(2); clf;
subplot(2,2,1);
hold on;
ylim(y_lim);
xlabel('$t$','Interpreter','latex');
title("ode45");
fplot(y1_exact,tspan,...
  'DisplayName',latex_y1_dot,'LineStyle','-','Color',colors{1});
fplot(y2_exact,tspan,...
  'DisplayName',latex_y2_dot,'LineStyle','-','Color',colors{2});
plot(T_ode45,y1_ode45,...
  'DisplayName',latex_y1_hat,'LineStyle','-','Color',colors{3});
plot(T_ode45,y2_ode45,...
  'DisplayName',latex_y2_hat,'LineStyle','-','Color',colors{4});
lgd = legend('show', 'Interpreter', 'latex');
set(lgd, 'FontSize', 16);

subplot(2,2,2);
hold on;
ylim(y_lim);
xlabel('$t$','Interpreter','latex');
title("metoda 1.");
fplot(y1_exact,tspan,...
'DisplayName',latex_y1_dot,'LineStyle','-','Color',colors{1});
fplot(y2_exact,tspan,...
'DisplayName',latex_y2_dot,'LineStyle','-','Color',colors{2});
plot(t,y1_m1,...
'DisplayName',latex_y1_hat,'LineStyle','-','Color',colors{3});
plot(t,y2_m1,...
'DisplayName',latex_y2_hat,'LineStyle','-','Color',colors{4});
lgd = legend('show', 'Interpreter', 'latex');
set(lgd, 'FontSize', 16);

subplot(2,2,3); 
hold on;
ylim(y_lim);
xlabel('$t$','Interpreter','latex');
title("metoda 2.");
fplot(y1_exact,tspan,...
'DisplayName',latex_y1_dot,'LineStyle','-','Color',colors{1});
fplot(y2_exact,tspan,...
'DisplayName',latex_y2_dot,'LineStyle','-','Color',colors{2});
plot(t,y1_m2,...
'DisplayName',latex_y1_hat,'LineStyle','-','Color',colors{3});
plot(t,y2_m2,...
'DisplayName',latex_y2_hat,'LineStyle','-','Color',colors{4});
lgd = legend('show', 'Interpreter', 'latex');
set(lgd, 'FontSize', 16);

subplot(2,2,4);
hold on;
ylim(y_lim);
xlabel('$t$','Interpreter','latex');
title("metoda 3.");
fplot(y1_exact,tspan,...
'DisplayName',latex_y1_dot,'LineStyle','-','Color',colors{1});
fplot(y2_exact,tspan,...
'DisplayName',latex_y2_dot,'LineStyle','-','Color',colors{2});
plot(t,y1_m3,...
'DisplayName',latex_y1_hat','LineStyle','-','Color',colors{3});
plot(t,y2_m3,...
'DisplayName',latex_y2_hat,'LineStyle','-','Color',colors{4});
lgd = legend('show', 'Interpreter', 'latex');
set(lgd, 'FontSize', 16);