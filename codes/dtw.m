function [Dist] = DTW(t, r)
  %Dynamic Time Warping Algorithm
  %Dist is unnormalized distance between t and r
  %t is the vector you are testing against
  %r is the vector you are testing
  [rows, N] = size(t);
  [rows, M] = size(r);
  for n = 1:N
    for m = 1:M
      d(n, m) = (t(n) - r(m))^2;
    end
  end
  D = zeros(size(d));
  D(1, 1) = d(1, 1);
  for n = 2:N
    D(n, 1) = d(n, 1) + D(n - 1, 1);
  end 
  for m = 2:M
    D(1, m) = d(1, m) + D(1, m - 1);
  end
  for n = 2:N
    for m = 2:M
      D(n, m) = d(n, m) + min([D(n - 1, m - 1), D(n - 1, m), D(n, m - 1)]);
    end
  end
  Dist = D(N, M);