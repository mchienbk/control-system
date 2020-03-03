clc;
clear all;
global torque;
global g;
global l;
global m;
theta0 = [0 0]; %[vitri vantoc]
T = 0;
Theta = theta0;
t = 60; 
tsamp = 0.01;
tspan = [0 0.01];
runtime = t/tsamp; %thoi gian khao sat
% Thong so cua con lac don
l = 2;
g = 9.81;
torque = 1;
m = 2;
for i = 1:runtime   
    time(i) = i*tsamp;
    t = time(i);
    [t,y] = ode45(@Pendulum,tspan,theta0);
    theta0 = y(length(y),:);
    T = [T;i*tsamp];
    Theta = [Theta;theta0];  
end
subplot(211);
plot(T,Theta(:,1),'r','LineWidth',2);
xlabel('Time(s)');
ylabel('Position (Degree)');
grid on;
subplot(212);
plot(T,Theta(:,2),'b','LineWidth',2);
xlabel('Time(s)');
ylabel('Angular Velocity (rad/s)');
grid on;
