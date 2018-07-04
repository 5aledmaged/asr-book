if exist('data_wn_lpc.mat', 'file') == 0
  input_wn = [];
  target_wn = [];
  map_wn = {};
  save('data_wn_lpc.mat', 'map_wn', 'input_wn', 'target_wn');
end
% load data file
dirname = uigetdir;
D = dir(dirname);
D = D(~ismember({D.name}, {'.', '..'}));
for k = 1:numel(D)
  if(~D(k).isdir)
    continue;
  end
  sub_dirname = fullfile(dirname, D(k).name);
  addpath(sub_dirname, '-begin');
  [~, word_name] = fileparts(sub_dirname);
  load('data_wn_lpc.mat');
  [rows, cols] = size(target_wn);
  i = 1 + rows;
  word_target = eye(i);
  word_target = word_target(:, i);
  target_wn = [target_wn; zeros(1, length(target_wn))];
  filelist = dir([sub_dirname ' /* .wav']);
  % loop through all files in dir
  for index = 1:length(filelist)
    %fprintf('Processing %s\n', filelist(index).name);
    [y, fs] = audioread(filelist(index).name);
    y = preprocess(y, fs);
    one_frame = wavelet(y, num_levels, lpc_order, wavelet_type);
    input_wn = [input_wn one_frame];
    target_wn = [target_wn word_target];
  end
  map_wn{1, i} = word_target;
  map_wn{2, i} = word_name;
  rmpath(sub_dirname)
  save('data_wn_lpc.mat', 'map_wn', 'input_wn', 'target_wn');
end