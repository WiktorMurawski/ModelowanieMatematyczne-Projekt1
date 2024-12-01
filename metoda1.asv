function y = metoda1(A,b,x,h,N,t)

y = zeros(2,N);

for n = 2:N
  y(:,n) = y(:,n-1) + ...
    h*(A*(y(:,n-1) + h/2*(A*y(:,n-1) + b*x(t(n-1)))) + b*x(t(n-1) + h/2));
end % for n

end % function