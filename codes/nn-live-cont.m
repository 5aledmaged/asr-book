fs = 44100;
frame_length = 10 * 10^-3; % windows length without overlapping 10ms
frame_samples = round(frame_length * fs);
recObj = audiorecorder(fs, 16, 1);
disp('press any key to start recording');
pause();
disp('Start speaking.')
recordblocking(recObj, 15);
disp('End of Recording.');
x = getaudiodata(recObj);
[q, a, begin_index_y, end_index_y] = s_remove_1(x, fs);
[t, y] = find(diff(a) > 50);
first_end = a(y);
second_begin = a(y + 1);
begins = frame_samples * (second_begin - 1) + 1;
ends = frame_samples * (first_end - 1) + frame_samples;
begins = [begin_index_y begins];
ends = [ends end_index_y];
out = {};
for i = 1:length(begins)
  name = x(begins(i):ends(i));
  out{i} = name;
  figure;
  plot(name)
end
for i = 1:length(out)
  M = max(out{i});
  y1 = out{i} / M;
  %pre-emphasing
  k = filter([1, -0.5], 1, y1);
  d = mfcc5frames(k, fs);
  d = d';
  d = d(:)';
  d = d';
  test = d;
  ki = sim(net1, test);
  class1 = ki(1);
  class2 = ki(2);
  class3 = ki(3);
  class4 = ki(4);
  class5 = ki(5);
  figure;
  bar(ki);
  set(gca, 'XTickLabel', {'forward', 'backward', 'stop', 'left', 'right'})
  [k, l] = max(ki);
  if class1 >= 0.9
    disp('forward');
  elseif class2 >= 0.9
    disp('backward');
  elseif class3 >= 0.9
    disp('stop');
  elseif class4 >= 0.9
    disp('left');
  elseif class5 >= 0.9
    disp('right');
  else
    if l == 1
      disp('maybe forward');
    elseif l == 2
      disp('maybe backward');
    elseif l == 3
      disp('mayba stop');
    elseif l == 4
      disp('maybe left');
    elseif l == 5
      disp('maybe right');
    end
  end
end