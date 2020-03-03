% An example of LSA - Data Fitting method
% Assoc.Prof.Dr Tuong Quan Vo
clc;
clear all;
close all;
clc;
t1=15;k1=3.6;t2=1;k2=0.037;
R=1.0; 
y=0;
ST=500;DT=1;
a1=exp(-DT/t1);a2=exp(-DT/t2);LP=ST/DT;
x1=0;x2=0;
u=0;
t=0;
QBG=0;
for i=1:LP 
    t(i)=i*DT;
    if (t(i)>0)&(t(i)<100);R=1;end
    if (t(i)>100)&(t(i)<200);R=0;end
    if (t(i)>200)&(t(i)<300);R=1;end
    if (t(i)>300)&(t(i)<400);R=0;end
    if (t(i)>400);R=1;end
    x1=a1*x1+(1-a1)*k1*R;   
    x2=x2+DT*k2*R;  
    y(i)=x1-x2;
    u(i) = R;
    t(i)=i*DT;
end
U0=u;
Z0=y;
m(1)=2;
m(2)=2;
n = max(m);
n = max(m);
Len=size(Z0);  
L = Len(2);
P = 10e10*eye(m(1)+m(2)+1);
sita = 0.01*ones(m(1)+m(2)+1,1);
h = zeros(m(1)+m(2)+1,1);
z = 0;
MatixI = eye(m(1)+m(2)+1);
for i=1:L
    for j=1:m(1)
        if i-j-n<1
            h(j,1)=0;
        else
            h(j,1) = -Z0(i-j-n);
        end
    end
    for j=1:m(2)+1
        if i-j+1-n<1
            h(j+m(1),1)=0;
        else
            h(j+m(1),1) = U0(i-j+1-n);
        end
    end;
    z = Z0(i);
    gama=1/(h'*P*h+1);
    K = P*h*gama;
    sita = sita + K*(z - h'*sita);
    P = (MatixI - K*h') * P ;  
end
He = zeros(L,m(1)+m(2)+1);
ze = zeros(m(1)+m(2)+1,1);
for i=1:L
    for j=1:m(1)
        if i-j-n<1
            He(i,j)=0;
        else
            He(i,j) = -Z0(i-j-n);
        end
    end
    for j=1:m(2)+1
        if i-j+1-n<1
            He(i,j+m(1))=0;
        else
            He(i,j+m(1)) = U0(i-j+1-n);
        end
    end
    ze(i,1) = Z0(i);
end
bianz=He*sita;
ee=ze-bianz;
subplot(3,1,1),
plot(t,ze,'k-'); 
title('.....')
grid on
subplot(3,1,2),
plot(t,bianz,'b-.');
title('.....')
grid on
subplot(3,1,3),
for i=1:L
   QBG=QBG+abs(ee(i)); 
end
plot(t,ee,'r');
title('.....')

