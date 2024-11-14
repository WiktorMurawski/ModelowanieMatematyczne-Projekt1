tmin = 0;
tmax = 8;
tspan = [tmin,tmax];
x = @(t) exp(-t)*sin(t);
c = [0,1/2,1];
w = [1/6,2/3,1/6];
a = [1/6,-1/6,0; 1/6,1/3,0; 1/6,5/6,0];

%% Zadanie 1
syms t y1(t) y2(t)

eq1 = diff(y1,t,1) == -14/3*y1(t) - 2/3*y2(t) + x(t);
eq2 = diff(y2,t,1) == 2/3*y1(t) - 19/3*y2(t) + x(t);
eqns = [eq1; eq2];

cond1 = y1(0) == 0;
cond2 = y2(0) == 0;
conds = [cond1; cond2];

sol = dsolve(eqns,conds);
y1 = sol.y1;
y2 = sol.y2;

figure(1);
clf;
hold on;
legend;
fplot(y1,tspan,'DisplayName','y1 dsolve');
fplot(y2,tspan,'DisplayName','y2 dsolve');

%% Zadanie 2
f = @(t,y) [-14/3*y(1) - 2/3*y(2) + x(t); 2/3*y(1) - 19/3*y(2) + x(t)];
y0 = [0; 0];
[T,y] = ode45(f,tspan,y0);

y1 = y(:,1);
y2 = y(:,2);

figure(2);
clf;
hold on;
legend;
plot(T,y1,'DisplayName','y1 ode45');
plot(T,y2,'DisplayName','y2 ode45');

%% Zadanie 3
