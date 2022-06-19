clear all;
close all;
clear all;
clc;
%% Input parameters
Msc = 180; 
Vnom = 48; 
%% Modeling of the scooter
t=linspace(0,50,501); 
vel=zeros(1,501); 
d=zeros(1,501);
dT=0.1;
force=zeros(1,501);
Imotor=zeros(1,501); 
for n= 1:500
if vel(n)<10.8
vel(n+1) = vel(n) + dT*(1.57 - (0.00145*(vel(n)^2)));
elseif vel(n)>=10.8
vel(n+1)=vel(n)+dT*(7.30-(0.53*vel(n))-(0.00145*(vel(n)^2)));
end;
d(n+1)=d(n) + 0.1*vel(n); 
end;

a = (d(501)*2)/(50^2);

for n=1:500
    Imotor(n+1) = (a*vel(n)*Msc)/Vnom;
end

for n=1:500
    force(n) = (Vnom*Imotor(n+1))/vel(n+1); 
end 
vel=vel.*3.6;




figure;
plot(t,vel); axis([0 30 0 50]);
grid on
 xlabel('Time[seconds]');
 ylabel('Velocity[kph]');
 title('WOT acceleration of ES');

figure;
plot(t,Imotor); axis([0 30 0 30]);
grid on
xlabel('Time[seconds]');
ylabel('Motor Current [A]');
title('Current drawm by the BLDC motor');

% figure;
% plot(vel,Imotor); axis([0 50 0 26]);
% grid on
% xlabel('velocity [kph]');
% ylabel('Motor Current [A]');
% title('Current drawm from the motor in relation with speed');
% 
figure;
plot(vel,force); axis([0 30 0 90]);
grid on
xlabel('Time [s]');
ylabel('Traction force [N]');
title('Traction force behavior');


% figure;
% plot(t, d);  axis([0 30 0 150]);
% xlabel('Time/seconds');
% ylabel('distance [m]');
% title('Distance traveled')