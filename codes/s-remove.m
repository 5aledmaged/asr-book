function [clipped_y, begin_index_y, end_index_y, flag_index_y] = s_remove_1(y, fs);
  %%%  silence Removal start ->  depend on  noise characteristics
  noise_length = 200 * 10^-3; % first 200ms considered as noise
  noise_samples = round(noise_length * fs); % samples of first 200ms
  frame_length = 10 * 10^-3; % windows length without overlapping 10ms
  frame_samples = round(frame_length * fs); % samples of frame 10ms
  %calculate mean and std_div of first 200ms
  N_mean = mean(y(1:noise_samples));
  std_div = sqrt(sum((y(1:noise_samples) - N_mean).^2) / noise_samples);
  %determine each sample is voiced or unvoiced/noise
  V_UV = ones(1, length(y));
  for i = 1:length(y)
    if (abs(y(i) - N_mean) / std_div) < 3
      V_UV(i) = 0;
    end 
  end 
  num_frames = length(y) / frame_samples; % num of frames --> 10ms each frame
  V_UV_framed = zeros(num_frames, frame_samples);
  %framing 10ms without overlapping
  for i = 1:num_frames
    V_UV_framed(i, :) = V_UV(frame_samples * (i - 1) + 1:frame_samples * (i - 1) + frame_samples); %spicify samples of each frame
  end 
  %decide V or UV according to majority of 1's or 0's
  flag_index_y = 1; j = 1;
  for i = 1:length(y) / frame_samples
    sum_N = sum(V_UV_framed(i, :)); % sum_N -> ones , sum_M -> zeros
    sum_M = frame_samples - sum_N;
    if sum_M > sum_N% if zeros are majority
      for k = 1:frame_samples
        if V_UV_framed(i, k) == 1
          V_UV_framed(i, k) = 0; % make whole window zeros
        end
      end
    else % if ones are majority
      flag_index_y(:, j) = i; %specify starting and ending frame to be voiced
      j = j + 1; %flag_index_y(1) -> starting frame of speech
      for k = 1:frame_samples
        if V_UV_framed(i, k) == 0
          V_UV_framed(i, k) = 1; %make whole window ones
        end
      end
    end
  end
  begin_index_y = frame_samples * (flag_index_y(1) - 1) + 1;
  end_index_y = frame_samples * (flag_index_y(end) - 1) + frame_samples;
  if begin_index_y < noise_samples
    display('record again');
    clipped_y = 0;
  else 
    clipped_y = y(begin_index_y:end_index_y); %clipped_y according to start and ending frame
  end