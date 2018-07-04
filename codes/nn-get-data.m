fs = 44100;
a = 0.5;
for i = 1:80
  name = ['forward' num2str(i) '.wav']
  [y, fs] = audioread(['C:\Users\Marco\Desktop\grad pro3\new\forward\' name]);
  y = s_remove_1(y, fs);
  M = max(y);
  y1 = y / M;
  %pre-emphasing
  x = filter([1, -a], 1, y1);
  forward{i} = mfcc5frames(x, fs);
  forward{i} = forward{i}';
  forward{i} = forward{i}(:)';
  forward{i} = forward{i}';
end
for i = 1:80
  name = ['backward' num2str(i) '.wav']
  [y, fs] = audioread(['C:\Users\Marco\Desktop\grad pro3\new\backward\' name]);
  y = s_remove_1(y, fs);
  M = max(y);
  y1 = y / M;
  %pre-emphasing
  x = filter([1, -a], 1, y1);
  backward{i} = mfcc5frames(x, fs);
  backward{i} = backward{i}';
  backward{i} = backward{i}(:)';
  backward{i} = backward{i}';
end
for i = 1:80
  name = ['stop' num2str(i) '.wav']
  [y, fs] = audioread(['C:\Users\Marco\Desktop\grad pro3\new\stop\' name]);
  y = s_remove_1(y, fs);
  M = max(y);
  y1 = y / M;
  %pre-emphasing
  x = filter([1, -a], 1, y1);
  stop{i} = mfcc5frames(x, fs);
  stop{i} = stop{i}';
  stop{i} = stop{i}(:)';
  stop{i} = stop{i}';
end
for i = 1:80
  name = ['left' num2str(i) '.wav']
  [y, fs] = audioread(['C:\Users\Marco\Desktop\grad pro3\new\left\' name]);
  y = s_remove_1(y, fs);
  M = max(y);
  y1 = y / M;
  %pre-emphasing
  x = filter([1, -a], 1, y1);
  left{i} = mfcc5frames(x, fs);
  left{i} = left{i}';
  left{i} = left{i}(:)';
  left{i} = left{i}';
end
for i = 1:80
  name = ['right' num2str(i) '.wav']
  [y, fs] = audioread(['C:\Users\Marco\Desktop\grad pro3\new\right\' name]);
  y = s_remove_1(y, fs);
  M = max(y);
  y1 = y / M;
  %pre-emphasing
  x = filter([1, -a], 1, y1);
  right{i} = mfcc5frames(x, fs);
  right{i} = right{i}';
  right{i} = right{i}(:)';
  right{i} = right{i}';
end
z = zeros(1, 80);
o = ones(1, 80);
j = 1;
for i = 1:80
  input(:, i) = forward{1, j};
  j = j + 1;
end
j = 1;
for i = 81:160
  input(:, i) = backward{1, j};
  j = j + 1;
end
j = 1;
for i = 161:240
  input(:, i) = stop{1, j};
  j = j + 1;
end
j = 1;
for i = 241:320
  input(:, i) = left{1, j};
  j = j + 1;
end
j = 1;
for i = 321:400
  input(:, i) = right{1, j};
  j = j + 1;
end
target = [o z z z z; z o z z z; z z o z z; z z z o z; z z z z o];