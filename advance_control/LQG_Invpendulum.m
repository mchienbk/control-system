clear
clc
Ts=0.01;
t=0:Ts:30;
ref=zeros(size(t));

M=1;
m=0.1;
l=1;
g=9.8;

A=[0 1 0 0; (M+m)*g/M/l 0 0 0; 0 0 0 1; -m*g/M 0 0 0];
B=[0 -1/M/l 0 1/M]';
C=[1 0 0 0; 0 0 0 0; 0 0 1 0; 0 0 0 0]; %Theta,Thedot,X,Xdot
D=[0 0 0 0]';

Q=[0 0 0 0; 0 1 0 0; 0 0 10 0; 0 0 0 0];
R=1;
K=lqr(A,B,Q,R); %LQR

Qn=10^-6*eye(4);
Rn=[0.1 0 0 0; 0 10^-6 0 0; 0 0 0.1 0; 0 0 0 10^-6];  
G=eye(4);
L=lqe(A,G,C,Qn,Rn);

Xht=[1 0 0 0]'; %Theta,Thedot,X,Xdot
Xhatht=[1 0 0 0]';
u=0;
Y=[];
U=[];
y=[0 0 0 0]';
yhat=[0 0 0 0]';

[Ad,Bd,Cd,Dd]=c2dm(A,B,C,D,Ts,'zoh'); % Rat quan trong

 for i=1:length(t)
     Xhattl=Ad*Xhatht + Bd*u + L*(y-yhat);
     yhat=Cd*Xhatht;
      
     Xtl=Ad*Xht + Bd*u;
%      y=Cd*Xht;  %Default
     y=Cd*Xht + [0 0 0 0];  %Phu nhieu
     Y=[Y y]; 
     
     %update
     u=-K*Xhattl;
     Xhatht=Xhattl;   
     Xht=Xtl;
 end
figure(1)
plot(t,Y(1,:));
figure(2)
plot(t,Y(3,:));
