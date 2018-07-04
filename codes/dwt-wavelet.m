function [features] = wavelet(input_file, num_levels, lpc_order, wavelet_type)
  [c, longs] = wavedec(input_file, num_levels, wavelet_type); %Perform decomposition of signal at level 3 using db5
  st = 1;
  features = [];
  for i = 1:num_levels + 1
    length_coeff = longs(i);
    en = st + length_coeff - 1;
    coeff_vector = c(st:en); %coeff of each subband filter
    % lpc
    K = lpc(coeff_vector, lpc_order);
    features = [features; K'];
    st = en + 1;
  end