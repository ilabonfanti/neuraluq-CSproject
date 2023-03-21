clear all;
close all; clc;

%parameters
a = 1;
b = 2;
c = 2;
d = 2;
e = 1;
f = 2;
g = 3;

%time interval and initial conditions
t_interval = [0 10];
init_cond = [1;  1;  1];

func = @(t,y) [(a*y(1) - b*y(1)*y(2)); 
    (-c*y(2) + d*y(1)*y(2) - e*y(2)*y(3)); 
    (-f*y(3) + g*y(2)*y(3))];

%solution
[t,y] = ode45(func, t_interval, init_cond);

%plot
figure
subplot(1, 3, 1)

plot(t,y(:,1),'b')
xlabel('x')
subplot(1, 3, 2)
plot(t,y(:,2),'r');
xlabel('y')
subplot(1, 3, 3)
plot(t,y(:,3),'g');
xlabel('z')

%% dataset 0, same structure as the KO dataset

% interp1 (x, y, x_eval)

train = load('KO_train.mat');
t_u_train = train.t_u_train;
u_train = interp1(t, y, t_u_train); % u in t_u_train

t_f_train = train.t_f_train;
f_train = zeros(14, 3);

t_test = train.t_test;
u_test = interp1(t, y, t_test); 

noise = train.noise;

save('lotka_volterra_dataset.mat', ...
    "t_f_train", "t_test", ...
    "t_u_train", "u_test", ...
    "u_train", "f_train", "noise")

%% dataset 1: 27 train, 81 test

t_u_train = t(1:3:81); %27x1
u_train = interp1(t, y, t_u_train); %27x3

t_f_train = t(1:3:81); %27x1
f_train = zeros(size(u_train));

t_test = t; %81x1
u_test = interp1(t, y, t_test); %81x3

noise = 0.5;

save('lotka_volterra_dataset_1.mat', ...
    "t_f_train", "t_test", ...
    "t_u_train", "u_test", ...
    "u_train", "f_train", "noise")

%% dataset 2: 50 train, 100 test

t_interval = linspace(0, 10, 100);
[t,y] = ode45(func, t_interval, init_cond);

t_u_train = t(1:2:100); 
u_train = interp1(t, y, t_u_train); 

t_f_train = t(1:2:100);
f_train = zeros(size(u_train));

t_test = t; 
u_test = interp1(t, y, t_test);

noise = 0.5;

save('lotka_volterra_dataset_2.mat', ...
    "t_f_train", "t_test", ...
    "t_u_train", "u_test", ...
    "u_train", "f_train", "noise")

%% dataset 3: time interval extended until 20

t_interval = [0 20];
[t,y] = ode45(func, t_interval, init_cond);

t_u_train = t(1:3:end); % 47 
u_train = interp1(t, y, t_u_train); 

t_f_train = t(1:3:end);
f_train = zeros(size(u_train));

t_test = t; 
u_test = interp1(t, y, t_test);

noise = 0.5;

save('lotka_volterra_dataset_3.mat', ...
    "t_f_train", "t_test", ...
    "t_u_train", "u_test", ...
    "u_train", "f_train", "noise")

%% dataset 4: 80 train, 160 test

t_interval = linspace(0, 20, 160);
[t,y] = ode45(func, t_interval, init_cond);

t_u_train = t(1:2:end); 
u_train = interp1(t, y, t_u_train); 

t_f_train = t(1:2:end);
f_train = zeros(size(u_train));

t_test = t; 
u_test = interp1(t, y, t_test);

noise = 0.5;

save('lotka_volterra_dataset_4.mat', ...
    "t_f_train", "t_test", ...
    "t_u_train", "u_test", ...
    "u_train", "f_train", "noise")

%% dataset 5: time interval [0, 30], 200 test, 100 train

t_interval = linspace(0, 30, 200); 
[t,y] = ode45(func, t_interval, init_cond);

t_u_train = t(1:2:end); 
u_train = interp1(t, y, t_u_train); 

t_f_train = t(1:2:end);
f_train = zeros(size(u_train));

t_test = t; 
u_test = interp1(t, y, t_test);

noise = 0.5;

save('lotka_volterra_dataset_5.mat', ...
    "t_f_train", "t_test", ...
    "t_u_train", "u_test", ...
    "u_train", "f_train", "noise")

%% little dataset: less than KO one

train = load('KO_train.mat');
t_u_train = train.t_u_train(1:2:end); 
u_train = interp1(t, y, t_u_train); 

t_f_train = train.t_f_train(1:2:end);  
f_train = zeros(14, 3);

t_test = train.t_test; 
u_test = interp1(t, y, t_test); 

noise = train.noise;

save('lotka_volterra_dataset_little.mat', ...
    "t_f_train", "t_test", ...
    "t_u_train", "u_test", ...
    "u_train", "f_train", "noise")