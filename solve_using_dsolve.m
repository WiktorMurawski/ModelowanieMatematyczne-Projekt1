function [y1_exact, y2_exact] = solve_using_dsolve(x)

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

end % function