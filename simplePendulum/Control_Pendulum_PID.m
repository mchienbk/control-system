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
l = 1;
g = 9.81;
%torque = 1;
m = 1;

% Thong so PID
Kp = 0.1; Ki = 1.5; Kd = 50;
%Thong so dau ra
setpoint = 30;


%First step

    e(1) = 0;
    esum = 0;
    
   

for i = 2:runtime   
    time(i) = i*tsamp;
    t = time(i);
    
    %Calculate K gain
    e(i) = setpoint - theta0(1);
    edot = e(i) - e(i-1);
    esum = e(i) + e(i-1);
	torque = Kp*e(i) + Ki*esum + Kd*edot;
    
    
    [t,y] = ode45(@Pendulum,tspan,theta0);
    theta0 = y(length(y),:);
    T = [T;i*tsamp];
    Theta = [Theta;theta0];  
end
% subplot(211);
% plot(T,Theta(:,1),'r','LineWidth',2);
% xlabel('Time(s)');
% ylabel('Position (Degree)');
% grid on;
% subplot(212);
% plot(T,Theta(:,2),'b','LineWidth',2);
% xlabel('Time(s)');
% ylabel('Angular Velocity (rad/s)');
% grid on;

plot(T,Theta(:,1),'r','LineWidth',2);
xlabel('Time(s)');
ylabel('Position (Degree)');

grid on;
hold on;
plot(T,30+0*T,'b','LineWidth',1);

