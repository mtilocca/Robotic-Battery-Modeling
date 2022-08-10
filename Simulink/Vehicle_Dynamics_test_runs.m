clc
clear all
close all

%%  E-scooter dynamics scenarios simulation 


vehicle = EscooterDyn(20,180,48); % create an E-scooter object 

% simple WOT acceleration - from 5 km/h to 30 km/h 
samp = true; 
savePflow = false; 

accelerating = true;
acc.Vinit = 5/3.6; 
acc.Vfinal = 30/3.6; 

[acc.Vel, acc.Curr, acc.Pwer] = vehicle.accelerate(acc.Vfinal, acc.Vinit, samp); 


vehicle.plots(30/3.6, 5/3.6, accelerating);  % plotting while accelerating

% braking scenario -- assume brake f = m * WOT 

accelerating = false; 
brak.Vfinal = 15/3.6;
brak.Vinit = 30/3.6; 



[brak.Vel, brak.Curr, brak.Pwer] = vehicle.decelerate(brak.Vfinal, brak.Vinit, samp); 
brak.Vel = brak.Vel*3.6;
vehicle.plots(15/3.6, 30/3.6, accelerating); % plotting while braking 



%% create Powerflow array with data 

if samp

[PWAf, crVa, PWAcr] = fltr(acc.Pwer, acc.Vel*3.6) ; 

[PWBf, crVb, PWBcr] = fltr(brak.Pwer, brak.Vel) ; 


Pcruise1 = zeros(1,8);
Pcruise1(:) = PWAcr; 

Pcruise2 = zeros(1,4);
Pcruise2(:) = PWBcr; 

vDynamics.PwReq = [PWAf Pcruise1 PWBf Pcruise2] ;
t = uint32(1):uint32(length(vDynamics.PwReq)); 

if savePflow
    fle = vDynamics.PwReq;
    save("PowerEScooter.mat", "fle");
end 

figure(9)
plot(t, vDynamics.PwReq)
hold on 
scatter(t, vDynamics.PwReq)
grid on 
grid minor 
title("Powerflow simulation Escooter motor")
xlabel("Time [s]")
ylabel("Power [W]")
end 

%% create Velocity profiles array 

if samp
Vacc = fltrV(acc.Vel); 
Vacc = Vacc *3.6; 

Vbrk = fltrV(brak.Vel); 

Vcruise1 = zeros(1,8);
Vcruise1(:) = crVa;

Vcruise2 = zeros(1,4);
Vcruise2(:) = crVb;


vDynamics.Vprofile = [Vacc  Vcruise1 Vbrk Vcruise2]; 

figure(10)
plot(t, vDynamics.Vprofile)
hold on 
scatter(t, vDynamics.Vprofile)
grid on 
grid minor 
title("Speed simulation Escooter dynamics")
xlabel("Time [s]")
ylabel("Velocity [m/s]")

end 

%%  filtering functions 


% power filtering 
function [pw, crV, crP] = fltr(A, B)
pw = 0;
crV=0;
crP = 0; 
n = length(A);
for i=1:n
    if A(i)== A(i+1)
        pw = A(1:i-1);
        crV = B(i);
        crP = A(i); 
        break
    end 
end 
end 


% variable velocities filtering 

function [V] = fltrV(A)
V = 0;
n = length(A);
for i=1:n
    if A(i)== A(i+1)
        V = A(1:i-1); 
        
        break
    end 
end 
end 