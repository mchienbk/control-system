clc;
clear all;
global torque;
global g;
global l1 l2;
global m1 m2;
global torque1 torque2;
theta0 = [2.5 0 1 0]; %[vitri vantoc]
% theta0 = [0 0 0 0];
T = 0;
Theta = theta0;
t = 10; 
tsamp = 0.01;
tspan = [0 0.01];
runtime = t/tsamp; %thoi gian khao sat
% Thong so cua he
l1 = 1; l2 = 2;
m1 = 2; m2 = 1;
g = 9.8;
torque1 = 1;
torque2 = 2;
 
for i = 1:runtime   
    time(i) = i*tsamp;
    t = time(i);
    
% f = @(t,x) [ x(2);...
%             torque1/((m1 + m2)*l1^2) ...
%             - m2*l1*l2*(x(4)*cos((x(1)-x(2))*pi/180)) ...
%             + x(3)^2*sin((x(1)-x(2))*pi/180);...
%             x(4);...
%             (torque2/m2 - g*l2*sin(x(2)*pi/180) ...
%             - l1*l2*((x(2)*cos((x(1)-x(2))*pi/180)) - x(1)^2*sin((x(1)-x(2))*pi/180)))/l2^2 ];
%     [t,x] = ode45 ( f, tspan, theta0 );
%     theta0 = x(length(x),:);
     [t,y] = ode45 ( @Double_Pendulum_State, tspan, theta0 );
%     [t,y] = ode45(@double_pendulum,tspan,theta0);
     theta0 = y(length(y),:);
    
    T = [T;i*tsamp];
    Theta = [Theta;theta0];
end
subplot(211);
plot(T,Theta(:,1),'r','LineWidth',2);
hold on;
plot(T,Theta(:,3),'b','LineWidth',2);
xlabel('Time(s)');
ylabel('Position (Degree)');
grid on;
subplot(212);
plot(T,Theta(:,2),'r','LineWidth',2);
hold on;
plot(T,Theta(:,4),'b','LineWidth',2);
xlabel('Time(s)');
ylabel('Angular Velocity (rad/s)');
grid on;

% plot(T,Theta(:,1),'r','LineWidth',2);
% xlabel('Time(s)');
% ylabel('Position (Degree)');
% 
% grid on;
% hold on;
% plot(T,30+0*T,'b','LineWidth',1);

