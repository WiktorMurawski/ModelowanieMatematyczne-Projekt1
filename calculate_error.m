function [delta1, delta2] = calculate_error(y_hat,y1_dot,y2_dot,t,N)
  y1_hat = y_hat(1,:);
  y2_hat = y_hat(2,:);

  top_sum1 = 0;
  top_sum2 = 0;
  bottom_sum1 = 0;
  bottom_sum2 = 0;

  for n = 1:N
    top_sum1 = top_sum1 + (y1_hat(n) - y1_dot(t(n)))^2;
    bottom_sum1 = bottom_sum1 + (y1_dot(t(n)))^2;
    top_sum2 = top_sum2 + (y2_hat(n) - y2_dot(t(n)))^2;
    bottom_sum2 = bottom_sum2 + (y2_dot(t(n)))^2;
  end % for n
  delta1 = top_sum1/bottom_sum1;
  delta2 = top_sum2/bottom_sum2;

end % function