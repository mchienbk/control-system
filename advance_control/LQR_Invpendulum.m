
clc
Ts=0.01;
t=0:Ts:15;
ref=zeros(size(t));

M=1;
m=0.1;
l=1;
g=9.8;

A=[0 1 0 0; (M+m)*g/M/l 0 0 0; 0 0 0 1; -m*g/M 0 0 0];
B=[0 -1/M/l 0 1/M]';
C=[1 0 1 0]; %Theta,Thedot,X,Xdot
D=[0];

Q=[0 0 0 0; 0 0 0 0; 0 0 1 0; 0 0 0 0];
R=10;
K=lqr(A,B,Q,R) %LQR


% X0=[10 0 0 10]';
% 
% sys_cl = ss(A-B*K,B,C,D);
% [ycl,t,x]=lsim(sys_cl,ref,t, X0,'zoh');
% figure(1)
% plot(t,x(:,1))
% figure(2)
% plot(t,x(:,3))

Xht=[10 0 0 0]'; %Theta,Thedot,X,Xdot
u=0;
Y=[];
U=[];
[Ad,Bd,Cd,Dd]=c2dm(A,B,C,D,Ts,'zoh');
 for i=1:length(t)
     Xtl=Ad*Xht + Bd*u ;
     y=C*Xht;
     %Xtl=Xtl+[1 0 1 0]';
     Y=[Y Xtl];
     u=-K*Xtl;
     U = [U u];
     Xht=Xtl + [0.01*rand(1) 0 0.1*rand(1) 0]';
%      if i >= 450 && i <=500 %Dot ngot tang gia toc
%          Xht = Xht + [-1 0 3 0]';
%      end
     
 end
figure(1)
plot(t,Y(1,:));
figure(2)
plot(t,Y(3,:));
