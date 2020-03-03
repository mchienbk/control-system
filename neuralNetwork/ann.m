clear;
Ts = 0.01;
t = 0:Ts:150;
Ref = ones(size(t));
% Ref = 2 + sin(2*pi*0.2*t)

%Thiet ke ham truyen
num = [1];
den = [1 0.2 0.8];
Gs = tf(num, den);       %Ham truyen tren mien s


hold on;
plot(t, Ref, 'r');
%Bien doi tu lien tuc sang mien roi rac
[numd, dend] = c2dm(num, den, Ts, 'tustin');

y = 0;  u = 0;
yqk1 = 0; yqk2 = 0;
uqk1 = 0;	uqk2 = 0;
eqk = 0;	esum = 0;
% Kp = 2.5;	Ki = 1.5; Kd = 3;
% y(1) = 0;
% e11 = 0.1;  e21 = -0.1;
% e12 = 0.2;  e22 = -0.5;
Y = []; U =[];
n = 0.0001;
w1 = 0.01; w2 = 0.01; w3 = 0.01;
w11 = 0.01; w12 = 0.01; w13 = 0.01;
w21 = 0.01; w22 = 0.01; w23 = 0.01;
w31 = 0.01; w32 = 0.01; w33 = 0.01;
Kp= 1; Ki = 0.15; Kd = 0.05;
for i=1:length(t)
   
    e = Ref(i) - y;
    edot = (e - eqk)/Ts;
    esum = esum  + e*Ts;
%     u = Kp*e + Ki*esum + Kd*edot;

    net1 = w11*e + w21*edot + w31*esum;
    net2 = w12*e + w22*edot + w32*esum;
    net3 = w13*e + w23*edot + w33*esum;
	u = w1*net1 + w2*net2+ w3*net3 + Kp*e +  Ki*esum + Kd*edot;
    
    y = (u*numd(1,1) + uqk1*numd(1,2) + uqk2*numd(1,3) ...
        - yqk1*dend(1,2) - yqk2*dend(1,3))/dend(1,1);
    
    yqk2 = yqk1;	yqk1 = y;
	uqk2 = uqk1;	uqk1 = u;
	eqk = e;
    Y = [Y y];
    U = [U u];

    w1 = w1 - n*(-e)*net1;
    w2 = w2 - n*(-e)*net2;
    w3 = w3 - n*(-e)*net3;
    w11 = w11 - n*(-e)*w1*e;
    w12 = w12 - n*(-e)*w2*e;
    w13 = w13 - n*(-e)*w3*e;
    w21 = w21 - n*(-e)*w1*edot;
    w22 = w22 - n*(-e)*w2*edot;
    w23 = w23 - n*(-e)*w3*edot;
    w31 = w31 - n*(-e)*w1*esum;
    w32 = w32 - n*(-e)*w2*esum;
    w33 = w33 - n*(-e)*w3*esum;
end
plot(t,Y,'k','Linewidth',2);
hold on;
plot(t,Ref,'--b')
