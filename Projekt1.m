% Przedział t
tmin = 0; 
tmax = 8;
tspan = [tmin,tmax];

% Współczynniki URRZ
A = [-14/3,-2/3; 2/3,-19/3];
b = [1;1];

% Funkcja x
x = @(t) exp(-t)*sin(t);

% Funkcja f
f = @(t,y) A*y + b*x(t);

% Warunki początkowe
y0 = [0; 0];

%% Zadanie 1
% dsolve
syms t y1(t) y2(t)

eq1 = diff(y1,t,1) == -14/3*y1(t) - 2/3*y2(t) + x(t);
eq2 = diff(y2,t,1) == 2/3*y1(t) - 19/3*y2(t) + x(t);
eqns = [eq1; eq2];

cond1 = y1(0) == 0;
cond2 = y2(0) == 0;
conds = [cond1; cond2];

sol = dsolve(eqns,conds);
y1_exact = sol.y1;
y2_exact = sol.y2;

%% Zadanie 2
% Wartość kroku
h = 0.2;

% Wyznaczenie N(h) oraz wektora t
N = floor((tmax - tmin)/h) + 1;
t = tmin:h:tmax;

% Procedura ode45
[T_ode45,y_ode45] = ode45(f,tspan,y0);

y_ode45 = y_ode45';
y1_ode45 = y_ode45(1,:);
y2_ode45 = y_ode45(2,:);

% Metoda 1
y_metoda1 = metoda1(A,b,x,h,N,t);
y1_metoda1 = y_metoda1(1,:);
y2_metoda1 = y_metoda1(2,:);

% Metoda 2
y_metoda2 = metoda2(A,b,x,h,N,t);
y1_metoda2 = y_metoda2(1,:);
y2_metoda2 = y_metoda2(2,:);

% Metoda 3
y_metoda3 = metoda3(A,b,x,h,N,t);
y1_metoda3 = y_metoda3(1,:);
y2_metoda3 = y_metoda3(2,:);

% Wyświetlanie wykresów
figure(1); clf;
subplot(2,2,1); hold on;
legend; hold on;
fplot(y1_exact,tspan,'b','DisplayName','y1 dsolve');
fplot(y2_exact,tspan,'r','DisplayName','y2 dsolve');
plot(T_ode45,y1_ode45,'g','DisplayName','y1 ode45','LineStyle','--');
plot(T_ode45,y2_ode45,'DisplayName','y2 ode45','LineStyle','--');

subplot(2,2,2); 
legend; hold on;
fplot(y1_exact,tspan,'b','DisplayName','y1 dsolve');
fplot(y2_exact,tspan,'r','DisplayName','y2 dsolve');
plot(t,y1_metoda1,'g','DisplayName','y1 metoda 1','LineStyle','--');
plot(t,y2_metoda1,'DisplayName','y2 metoda 1','LineStyle','--');

subplot(2,2,3); 
legend; hold on;
fplot(y1_exact,tspan,'b','DisplayName','y1 dsolve');
fplot(y2_exact,tspan,'r','DisplayName','y2 dsolve');
plot(t,y1_metoda2,'g','DisplayName','y1 metoda 2','LineStyle','--');
plot(t,y2_metoda2,'DisplayName','y2 metoda 2','LineStyle','--');

subplot(2,2,4);
legend; hold on;
fplot(y1_exact,tspan,'b','DisplayName','y1 dsolve');
fplot(y2_exact,tspan,'r','DisplayName','y2 dsolve');
plot(t,y1_metoda3,'g','DisplayName','y1 metoda 3','LineStyle','--');
plot(t,y2_metoda3,'DisplayName','y2 metoda 3','LineStyle','--');

%% Zadanie 3

y1_dot = matlabFunction(y1_exact);
y2_dot = matlabFunction(y2_exact);

hmin = 0.01;
hmax = 1;
n = 1e2;
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

  [delta11(i), delta12(i)] = wyznaczBledy(y1,y1_dot,y2_dot,t,N);
  [delta21(i), delta22(i)] = wyznaczBledy(y2,y1_dot,y2_dot,t,N);
  [delta31(i), delta32(i)] = wyznaczBledy(y3,y1_dot,y2_dot,t,N);
end % for h

% Wykresy błędów zagregowanych w zależności od h
figure(2);clf;
legend; hold on;
yscale('log');
plot(h_range,delta11,'DisplayName','delta11','LineWidth',1);
plot(h_range,delta21,'DisplayName','delta21');
plot(h_range,delta31,'DisplayName','delta31');

figure(3);clf;
legend; hold on;
yscale('log');
plot(h_range,delta12,'DisplayName','delta12','LineWidth',1);
plot(h_range,delta22,'DisplayName','delta22');
plot(h_range,delta32,'DisplayName','delta32');