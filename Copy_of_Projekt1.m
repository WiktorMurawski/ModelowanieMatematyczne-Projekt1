tmin = 0; tmax = 8;
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

% Macierz jednostkowa
I = eye(2);

%% Zadanie 1
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


% figure(1); 
% clf; hold on; legend;
% title("dsolve");
% fplot(y1_exact,tspan,'DisplayName','y1 dsolve');
% fplot(y2_exact,tspan,'DisplayName','y2 dsolve');

%% Zadanie 2
% Wartość kroku h stosowanego w poniższych metodach (z wyłączeniem ode45) 
h = 0.33;

% Wyznaczenie N(h) oraz wektora t
N = floor((tmax - tmin)/h) + 1;
t = tmin:h:tmax; 

%% Procedura ode45
[T_ode45,y_ode45] = ode45(f,tspan,y0);

y_ode45 = y_ode45';
y1_ode45 = y_ode45(1,:);
y2_ode45 = y_ode45(2,:);


% figure(2);
% clf; hold on; legend;
% title("ode45")
% plot(T_ode45,y1_ode45,'DisplayName','y1 ode45');
% plot(T_ode45,y2_ode45,'DisplayName','y2 ode45');

%% Metoda 1
y = zeros(2,N);

for n = 2:N
  %y(:,n) = y(:,n-1) + h*f(t(n-1) + h/2, y(:,n-1) + h/2* f(t(n-1), y(:,n-1)));
  %y(:,n) = y(:,n-1) + h*f(t(n-1) + h/2, y(:,n-1) + h/2* (A*y(:,n-1) + b*x(t(n-1))) );
  y(:,n) = y(:,n-1) + h*(A*(y(:,n-1) + h/2*(A*y(:,n-1) + b*x(t(n-1)))) + b*x(t(n-1) + h/2));
end

y_metoda1 = metoda1(A,b,x,h,N,t);
y1_metoda1 = y_metoda1(1,:);
y2_metoda1 = y_metoda1(2,:);

% figure(3);
% clf; hold on; legend;
% title("Metoda 1")
% plot(t,y_metoda1(1,:),'DisplayName','y1 metoda 1');
% plot(t,y_metoda1(2,:),'DisplayName','y2 metoda 1');

%% Metoda 2

y = zeros(2,N);

% Niejawna metoda Eulera
y(:,2) = (I - h*A) \ (y(:,1) + h*b*x(t(2)));

for n = 3:N
  y(:,n) = (I - h*A) \ ...
      (y(:,n-2) + h*A*y(:,n-2) +h*b*x(t(n)) + h*b*x(t(n-2)));
end

y_metoda2 = y;
y1_metoda2 = y(1,:);
y2_metoda2 = y(2,:);


% figure(4);
% clf; hold on; legend;
% title("Metoda 2")
% plot(t,y1_metoda2,'DisplayName','y1 metoda 2');
% plot(t,y2_metoda2,'DisplayName','y2 metoda 2');

%% Metoda 3

% Współczynniki metody 3
c = [0,   1/2,   1];
w = [1/6, 2/3, 1/6];
a = [
  1/6, -1/6, 0; 
  1/6,  1/3, 0; 
  1/6,  5/6, 0;
  ];

y = zeros(2,N);

L = [
  I-h*a(1,1)*A, -h*a(1,2)*A, -h*a(1,3)*A;
  -h*a(2,1)*A, I-h*a(2,2)*A, -h*a(2,3)*A;
  -h*a(3,1)*A, -h*a(3,2)*A, I-h*a(3,3)*A;
  ];

for n = 2:N
  p = [
    A*y(:,n-1) + b*x(t(n-1) + c(1)*h);
    A*y(:,n-1) + b*x(t(n-1) + c(2)*h);
    A*y(:,n-1) + b*x(t(n-1) + c(3)*h);
  ];

  g = L \ p;

  f1 = g(1:2);
  f2 = g(3:4);
  f3 = g(5:6);

  y(:,n) = y(:,n-1) + h*(w(1)*f1 + w(2)*f2 + w(3)*f3);

end

y_metoda3 = y;
y1_metoda3 = y(1,:);
y2_metoda3 = y(2,:);


figure(5);
clf; hold on; legend;
title("Metoda 3")
plot(t,y1_metoda3,'DisplayName','y1 metoda 3');
plot(t,y2_metoda3,'DisplayName','y2 metoda 3');

figure(6);
clf; hold on; legend;
fplot(y1_exact,tspan,'DisplayName','y1 dsolve');
fplot(y2_exact,tspan,'DisplayName','y2 dsolve','LineStyle','--');
plot(t,y1_metoda1,'DisplayName','y1 metoda 1');
plot(t,y2_metoda1,'DisplayName','y2 metoda 1','LineStyle','--');
plot(t,y1_metoda2,'DisplayName','y1 metoda 2');
plot(t,y2_metoda2,'DisplayName','y2 metoda 2','LineStyle','--');
plot(t,y1_metoda3,'DisplayName','y1 metoda 3');
plot(t,y2_metoda3,'DisplayName','y2 metoda 3','LineStyle','--');

%% Zadanie 3
