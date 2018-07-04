%Training Words
dirname = uigetdir;
addpath(dirname, '-begin');
filelist = dir([dirname ' /* .wav']);
stop = {};
% loop through all files in dir
for index = 1:length(filelist)
  [y, fs] = audioread(filelist(index).name);
  clipped_y = s_remove_1(y, fs);
  y1 = double(clipped_y);
  y2 = y1 / sqrt(sum(abs(y1.^2)) / length(y));
  stop_mfcc = mfcc2(y2, fs);
  stop_mfcc = stop_mfcc';
  stop(index) = {stop_mfcc};
end 
GMM_stop1 = gmdistribution.fit(stop{1}, 10, 'CovType', 'diagonal');
GMM_stop2 = gmdistribution.fit(stop{2}, 10, 'CovType', 'diagonal');
GMM_stop3 = gmdistribution.fit(stop{3}, 10, 'CovType', 'diagonal');
GMM_stop4 = gmdistribution.fit(stop{4}, 10, 'CovType', 'diagonal');
GMM_stop5 = gmdistribution.fit(stop{5}, 10, 'CovType', 'diagonal');
GMM_stop6 = gmdistribution.fit(stop{6}, 10, 'CovType', 'diagonal');
GMM_stop7 = gmdistribution.fit(stop{7}, 10, 'CovType', 'diagonal');
GMM_stop8 = gmdistribution.fit(stop{8}, 10, 'CovType', 'diagonal');
GMM_stop9 = gmdistribution.fit(stop{9}, 10, 'CovType', 'diagonal');
GMM_stop10 = gmdistribution.fit(stop{10}, 10, 'CovType', 'diagonal');
dirname = uigetdir;
addpath(dirname, '-begin');
filelist = dir([dirname ' /* .wav']);
forward = {};
% loop through all files in dir
for index = 1:length(filelist)
  [y, fs] = audioread(filelist(index).name);
  clipped_y = s_remove_1(y, fs);
  y1 = double(y);
  y2 = y1 / sqrt(sum(abs(y1.^2)) / length(y));
  forward_mfcc = mfcc2(y2, fs);
  forward_mfcc = forward_mfcc';
  forward(index) = {forward_mfcc};
end
GMM_forward1 = gmdistribution.fit(forward{1}, 10, 'CovType', 'diagonal');
GMM_forward2 = gmdistribution.fit(forward{2}, 10, 'CovType', 'diagonal');
GMM_forward3 = gmdistribution.fit(forward{3}, 10, 'CovType', 'diagonal');
GMM_forward4 = gmdistribution.fit(forward{4}, 10, 'CovType', 'diagonal');
GMM_forward5 = gmdistribution.fit(forward{5}, 10, 'CovType', 'diagonal');
GMM_forward6 = gmdistribution.fit(forward{6}, 10, 'CovType', 'diagonal');
GMM_forward7 = gmdistribution.fit(forward{7}, 10, 'CovType', 'diagonal');
GMM_forward8 = gmdistribution.fit(forward{8}, 10, 'CovType', 'diagonal');
GMM_forward9 = gmdistribution.fit(forward{9}, 10, 'CovType', 'diagonal');
GMM_forward10 = gmdistribution.fit(forward{10}, 10, 'CovType', 'diagonal');
dirname = uigetdir;
addpath(dirname, '-begin');
filelist = dir([dirname ' /* .wav']);
backward = {};
% loop through all files in dir
for index = 1:length(filelist)
  [y, fs] = audioread(filelist(index).name);
  clipped_y = s_remove_1(y, fs);
  y1 = double(y);
  y2 = y1 / sqrt(sum(abs(y1.^2)) / length(y));
  backward_mfcc = mfcc2(y2, fs);
  backward_mfcc = backward_mfcc';
  backward(index) = {backward_mfcc};
end
GMM_backward1 = gmdistribution.fit(backward{1}, 10, 'CovType', 'diagonal');
GMM_backward2 = gmdistribution.fit(backward{2}, 10, 'CovType', 'diagonal');
GMM_backward3 = gmdistribution.fit(backward{3}, 10, 'CovType', 'diagonal');
GMM_backward4 = gmdistribution.fit(backward{4}, 10, 'CovType', 'diagonal');
GMM_backward5 = gmdistribution.fit(backward{5}, 10, 'CovType', 'diagonal');
GMM_backward6 = gmdistribution.fit(backward{6}, 10, 'CovType', 'diagonal');
GMM_backward7 = gmdistribution.fit(backward{7}, 10, 'CovType', 'diagonal');
GMM_backward8 = gmdistribution.fit(backward{8}, 10, 'CovType', 'diagonal');
GMM_backward9 = gmdistribution.fit(backward{9}, 10, 'CovType', 'diagonal');
GMM_backward10 = gmdistribution.fit(backward{10}, 10, 'CovType', 'diagonal');
%________________________________________________________
dirname = uigetdir;
addpath(dirname, '-begin');
filelist = dir([dirname ' /* .wav']);
right = {};
% loop through all files in dir
for index = 1:length(filelist)
  [y, fs] = audioread(filelist(index).name);
  clipped_y = s_remove_1(y, fs);

  y1 = double(clipped_y);
  y2 = y1 / sqrt(sum(abs(y1.^2)) / length(y));
  right_mfcc = mfcc2(y2, fs);
  right_mfcc = right_mfcc';
  right(index) = {right_mfcc};
end
GMM_right1 = gmdistribution.fit(right{1}, 10, 'CovType', 'diagonal');
GMM_right2 = gmdistribution.fit(right{2}, 10, 'CovType', 'diagonal');
GMM_right3 = gmdistribution.fit(right{3}, 10, 'CovType', 'diagonal');
GMM_right4 = gmdistribution.fit(right{4}, 10, 'CovType', 'diagonal');
GMM_right5 = gmdistribution.fit(right{5}, 10, 'CovType', 'diagonal');
GMM_right6 = gmdistribution.fit(right{6}, 10, 'CovType', 'diagonal');
GMM_right7 = gmdistribution.fit(right{7}, 10, 'CovType', 'diagonal');
GMM_right8 = gmdistribution.fit(right{8}, 10, 'CovType', 'diagonal');
GMM_right9 = gmdistribution.fit(right{9}, 10, 'CovType', 'diagonal');
GMM_right10 = gmdistribution.fit(right{10}, 10, 'CovType', 'diagonal');
%________________________________________________________
dirname = uigetdir;
addpath(dirname, '-begin');
filelist = dir([dirname ' /* .wav']);
left = {};
% loop through all files in dir
for index = 1:length(filelist)
  [y, fs] = audioread(filelist(index).name);
  clipped_y = s_remove_1(y, fs);
  y1 = double(clipped_y);
  y2 = y1 / sqrt(sum(abs(y1.^2)) / length(y));
  left_mfcc = mfcc2(y2, fs);
  left_mfcc = left_mfcc';
  left(index) = {left_mfcc};
end
GMM_left1 = gmdistribution.fit(left{1}, 10, 'CovType', 'diagonal');
GMM_left2 = gmdistribution.fit(left{2}, 10, 'CovType', 'diagonal');
GMM_left3 = gmdistribution.fit(left{3}, 10, 'CovType', 'diagonal');
GMM_left4 = gmdistribution.fit(left{4}, 10, 'CovType', 'diagonal');
GMM_left5 = gmdistribution.fit(left{5}, 10, 'CovType', 'diagonal');
GMM_left6 = gmdistribution.fit(left{6}, 10, 'CovType', 'diagonal');
GMM_left7 = gmdistribution.fit(left{7}, 10, 'CovType', 'diagonal');
GMM_left8 = gmdistribution.fit(left{8}, 10, 'CovType', 'diagonal');
GMM_left9 = gmdistribution.fit(left{9}, 10, 'CovType', 'diagonal');
GMM_left10 = gmdistribution.fit(left{10}, 10, 'CovType', 'diagonal');
%record word to be Recognized
fs = 44100;
fprintf('inter your message');
recObj = audiorecorder;
disp('Start speaking.')
recordblocking(recObj, 2);
disp('End of Recording.');
play(recObj);
myRecording = getaudiodata(recObj);
audiowrite('six.wav', myRecording, fs)
[y, fs] = audioread('six.wav');
clipped_y = s_remove_1(y, fs);
% RMS normalization
y1 = double(clipped_y);
y2 = y1 / sqrt(sum(abs(y1.^2)) / length(y));
test = mfcc2(y2, fs);
test = test';
GMM_test = gmdistribution.fit(test, 10, 'CovType', 'diagonal');
%_____________________________________________________________________________
%Decision Making
%calculate NegativeLikelohood
[P, stop1] = posterior(GMM_stop1, test);
[P, stop2] = posterior(GMM_stop2, test);
[P, stop3] = posterior(GMM_stop3, test);
[P, stop4] = posterior(GMM_stop4, test);
[P, stop5] = posterior(GMM_stop5, test);
[P, stop6] = posterior(GMM_stop6, test);
[P, stop7] = posterior(GMM_stop7, test);
[P, stop8] = posterior(GMM_stop8, test);
[P, stop9] = posterior(GMM_stop9, test);
[P, stop10] = posterior(GMM_stop10, test);

[P, forward1] = posterior(GMM_forward1, test);
[P, forward2] = posterior(GMM_forward2, test);
[P, forward3] = posterior(GMM_forward3, test);
[P, forward4] = posterior(GMM_forward4, test);
[P, forward5] = posterior(GMM_forward5, test);
[P, forward6] = posterior(GMM_forward6, test);
[P, forward7] = posterior(GMM_forward7, test);
[P, forward8] = posterior(GMM_forward8, test);
[P, forward9] = posterior(GMM_forward9, test);
[P, forward10] = posterior(GMM_forward10, test);

[P, backward1] = posterior(GMM_backward1, test);
[P, backward2] = posterior(GMM_backward2, test);
[P, backward3] = posterior(GMM_backward3, test);
[P, backward4] = posterior(GMM_backward4, test);
[P, backward5] = posterior(GMM_backward5, test);
[P, backward6] = posterior(GMM_backward6, test);
[P, backward7] = posterior(GMM_backward7, test);
[P, backward8] = posterior(GMM_backward8, test);
[P, backward9] = posterior(GMM_backward9, test);
[P, backward10] = posterior(GMM_backward10, test);

[P, right1] = posterior(GMM_right1, test);
[P, right2] = posterior(GMM_right2, test);
[P, right3] = posterior(GMM_right3, test);
[P, right4] = posterior(GMM_right4, test);
[P, right5] = posterior(GMM_right5, test);
[P, right6] = posterior(GMM_right6, test);
[P, right7] = posterior(GMM_right7, test);
[P, right8] = posterior(GMM_right8, test);
[P, right9] = posterior(GMM_right9, test);
[P, right10] = posterior(GMM_right10, test);

[P, left1] = posterior(GMM_left1, test);
[P, left2] = posterior(GMM_left2, test);
[P, left3] = posterior(GMM_left3, test);
[P, left4] = posterior(GMM_left4, test);
[P, left5] = posterior(GMM_left5, test);
[P, left6] = posterior(GMM_left6, test);
[P, left7] = posterior(GMM_left7, test);
[P, left8] = posterior(GMM_left8, test);
[P, left9] = posterior(GMM_left9, test);
[P, left10] = posterior(GMM_left10, test);

nlog = [stop1 stop2 stop3 stop4 stop5 stop6 stop7 stop8 stop9 stop10 forward1 forward2 forward3 forward4 forward5 forward6 forward7 forward8 forward9 forward10 backward1 backward2 backward3 backward4 backward5 backward6 backward7 backward8 backward9 backward10 right1 right2 right3 right4 right5 right6 right7 right8 right9 right10 left1 left2 left3 left4 left5 left6 left7 left8 left9 left10];
minimum = min(nlog);

if (minimum == stop1 || minimum == stop2 || minimum == stop3 || minimum == stop4 || minimum == stop5 || minimum == stop6 || minimum == stop7 || minimum == stop8 || minimum == stop9 || minimum == stop10)
  fprintf('stop \n ')
elseif (minimum == forward1 || minimum == forward2 || minimum == forward3 || minimum == forward4 || minimum == forward5 || minimum == forward6 || minimum == forward7 || minimum == forward8 || minimum == forward9 || minimum == forward10)
  fprintf('forward \n ')
elseif (minimum == backward1 || minimum == backward2 || minimum == backward3 || minimum == backward4 || minimum == backward5 || minimum == backward6 || minimum == backward7 || minimum == backward8 || minimum == backward9 || minimum == backward10)
  fprintf('backward \n ')

elseif (minimum == right1 || minimum == right2 || minimum == right3 || minimum == right4 || minimum == right5 || minimum == right6 || minimum == right7 || minimum == right8 || minimum == right9 || minimum == right10)
  fprintf('right \n ')

elseif (minimum == left1 || minimum == left2 || minimum == left3 || minimum == left4 || minimum == left5 || minimum == left6 || minimum == left7 || minimum == left8 || minimum == left9 || minimum == left10)
  fprintf('left \n ')

end 
