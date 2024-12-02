function y = metoda2(A,b,x,h,N,t)

I = eye(2);
y = zeros(2,N);

% Niejawna metoda Eulera
y(:,2) = (I - h*A) \ (y(:,1) + h*b*x(t(2)));

for n = 3:N
  y(:,n) = (I - h*A) \ ...
      (y(:,n-2) + h*A*y(:,n-2) + h*b*x(t(n)) + h*b*x(t(n-2)));
end % for n

end % function