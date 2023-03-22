clear all;
close all; clc;

%parameters
a = 1;
b = 1;

%time interval and initial conditions
t_interval = [0 10];
init_cond = [1.01;  1;  0.5];
f = @(t,y) [y(2)*y(3); y(1)*y(3); -2*y(1)*y(2)];
%solution
[t,y] = ode45(f, t_interval, init_cond);

%plot
figure
subplot(1, 3, 1)
plot(t,y(:,1),'b')
subplot(1, 3, 2)
plot(t,y(:,2),'r');
subplot(1, 3, 3)
plot(t,y(:,3),'g');

%% REPRODUCING THE ko DATASET

KO_data = load('KO_train.mat');

t_u_train = KO_data.t_u_train;
u_train_new = interp1(t, y, t_u_train); % u calcolata in t_u_train

t_f_train = KO_data.t_f_train; 
f_train_new = zeros(size(KO_data.f_train)); % dim 14x3

t_test = KO_data.t_test; % uguale
u_test_new = interp1(t, y, t_test); % u=(x, y, z) calcolata in t_test

noise = 0.05;
%% save new dataset

save('KO_dataset.mat', ...
    "t_f_train", "t_test", ...
    "t_u_train", "u_test_new", ...
    "u_train_new", "f_train_new", "noise")

%% 
% compare new quantities with the old ones
norm_u_train = norm(KO_data.u_train - u_train_new, "inf")
norm_f_train = norm(KO_data.f_train - f_train_new, "inf")
norm_u_test = norm(KO_data.u_test- u_test_new, "inf")