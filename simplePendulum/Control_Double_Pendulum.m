%--------------------------------------------------------------------------
%-------------- Double Pendulum--------------------------------------------
%--------------------------------------------------------------------------
clc
close all
clear all
%---------Parameters------------------------------------------------------
global l1 l2 
global m1 m2 
global g
global torque1 torque2;

l1 = 1;
l2 = 2;
m1 = 2;
m2 = 1;
g = 9.8;
torque1 = 1;
torque2 = 2;
%---------initial condition-----------------------------------------------
theta0 = [2.5 0 1 0]; %[vitri1 vantoc1 vitri2 vantoc2]
Theta = theta0;
T = 0;

t = 10; 
tsamp = 0.01;
tspan = [0 0.01];
runtime = t/tsamp; %thoi gian khao sat

for i = 1:runtime   %6000   
    time(i) = i*tsamp;   
    t = time(i);
    [t,y] = ode45(@double_pendulum,tspan,theta0);
    theta0 = y(length(y),:); % Lay het 1 hang ,% Gia tri "goc" tai thoi diem thu i (lay theo hang)
    T = [T;i*tsamp]; % luu gia tri
    Theta = [Theta;theta0];  % luu gia tri theta t?i các th?i ?i?m l?i      
end

% Ve do thi de quan sát
figure(1);
subplot(211);
plot(T,Theta(:,1),'r','LineWidth',2); 
hold on;
plot(T,Theta(:,3),'b','LineWidth',2);
legend('\theta_1','\theta_2')
xlabel('Time(s)');
ylabel('Position (Degree)');
grid on;

subplot(212);
plot(T,Theta(:,2),'r','LineWidth',2);
hold on;
plot(T,Theta(:,4),'b','LineWidth',2);
legend('\omega_1','\omega_2')
xlabel('Time(s)');
ylabel('Angular Velocity (rad/s)');
grid on;
