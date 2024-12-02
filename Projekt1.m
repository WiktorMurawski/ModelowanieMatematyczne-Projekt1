% Przedział t
tmin = 0; 
tmax = 8;

% Współczynniki URRZ
A = [-14/3,-2/3; 2/3,-19/3];
b = [1;1];

% Funkcja x
x = @(t) exp(-t)*sin(t);


%% Zadanie 1

[y1_exact, y2_exact] = solve_using_dsolve(x);
fprintf("y_1(t) = \n");
pretty(y1_exact);
fprintf("y_2(t) = \n");
pretty(y2_exact);
plot_exact(y1_exact,y2_exact,tspan)

%% Zadanie 2

% Wartość kroku
h = 0.2;

% Wyznaczenie N(h) oraz wektora t
N = floor((tmax - tmin)/h) + 1;
t = tmin:h:tmax;

% Procedura ode45
% Funkcja f
f = @(t,y) A*y + b*x(t);
% Przedział czasowy
tspan = [0, 8];
% Warunki początkowe
y0 = [0; 0];
% Wywołanie procedury
[T_ode45,y_ode45] = ode45(f,tspan,y0);

y_ode45 = y_ode45';

% Metoda 1
y_metoda1 = metoda1(A,b,x,h,N,t);

% Metoda 2
y_metoda2 = metoda2(A,b,x,h,N,t);

% Metoda 3
y_metoda3 = metoda3(A,b,x,h,N,t);

plot_results(tspan,y1_exact,y2_exact,...
  T_ode45,y_ode45,t,y_metoda1,y_metoda2,y_metoda3);


%% Zadanie 3

y1_dot = matlabFunction(y1_exact);
y2_dot = matlabFunction(y2_exact);

n = 1e4;
hmin = 0.01;
hmax = 1.00;
h_range = linspace(hmin,hmax,n);

delta11 = zeros(n,1);
delta12 = zeros(n,1);
delta21 = zeros(n,1);
delta22 = zeros(n,1);
delta31 = zeros(n,1);
delta32 = zeros(n,1);

for i = 1:n
  h = h_range(i);
  N = floor((tmax - tmin)/h) + 1;
  t = tmin:h:tmax;

  y1 = metoda1(A,b,x,h,N,t);
  y2 = metoda2(A,b,x,h,N,t);
  y3 = metoda3(A,b,x,h,N,t);

  [delta11(i), delta12(i)] = calculate_error(y1,y1_dot,y2_dot,t,N);
  [delta21(i), delta22(i)] = calculate_error(y2,y1_dot,y2_dot,t,N);
  [delta31(i), delta32(i)] = calculate_error(y3,y1_dot,y2_dot,t,N);
end % for h

% Wykresy błędów zagregowanych w zależności od h
figure(3);clf;
subplot(2,1,1);
hold on;
yscale('log');
xlabel('$h$','Interpreter','latex');
plot(h_range,delta11,'DisplayName','$\delta_1(h)$ metoda 1','LineWidth',1);
plot(h_range,delta21,'DisplayName','$\delta_1(h)$ metoda 2','LineWidth',1);
plot(h_range,delta31,'DisplayName','$\delta_1(h)$ metoda 3','LineWidth',1);
lgd = legend('show','Interpreter', 'latex', 'Location', 'northwest');
set(lgd, 'FontSize', 10);

subplot(2,1,2);
hold on;
yscale('log');
xlabel('$h$','Interpreter','latex');
plot(h_range,delta12,'DisplayName','$\delta_2(h)$ metoda 1','LineWidth',1);
plot(h_range,delta22,'DisplayName','$\delta_2(h)$ metoda 2','LineWidth',1);
plot(h_range,delta32,'DisplayName','$\delta_2(h)$ metoda 3','LineWidth',1);
lgd = legend('show','Interpreter', 'latex', 'Location', 'northwest');
set(lgd, 'FontSize', 10);