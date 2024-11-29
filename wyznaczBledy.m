function [delta1, delta2] = wyznaczBledy(y_hat,y1_dot,y2_dot,t,N)
  y1_hat = y_hat(1,:);
  y2_hat = y_hat(2,:);

  licznik1 = 0;
  licznik2 = 0;
  mianownik1 = 0;
  mianownik2 = 0;

  for n = 1:N
    licznik1 = licznik1 + (y1_hat(n) - y1_dot(t(n)))^2;
    mianownik1 = mianownik1 + (y1_dot(t(n)))^2;
    licznik2 = licznik2 + (y2_hat(n) - y2_dot(t(n)))^2;
    mianownik2 = mianownik2 + (y2_dot(t(n)))^2;
  end % for n
  delta1 = licznik1/mianownik1;
  delta2 = licznik2/mianownik2;

end % function