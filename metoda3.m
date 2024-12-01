function y = metoda3(A,b,x,h,N,t)

% Współczynniki metody 3
c = [0,   1/2,   1];
w = [1/6, 2/3, 1/6];
a = [
  1/6, -1/6, 0;
  1/6,  1/3, 0;
  1/6,  5/6, 0;
  ];

I = eye(2);
y = zeros(2,N);

L = [
  I-h*a(1,1)*A,  -h*a(1,2)*A,  -h*a(1,3)*A;
   -h*a(2,1)*A, I-h*a(2,2)*A,  -h*a(2,3)*A;
   -h*a(3,1)*A,  -h*a(3,2)*A, I-h*a(3,3)*A;
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

end % for n


end % function