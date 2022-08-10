classdef EscooterDyn

    properties
        simLength % Length of simulation
        mass        % mass of the vehicle 
        voltageM  % voltage of the BLDC motor 
        t         % simulation time and step 
        dT 
        a  % acceleration
    end 

    methods

        function obj = EscooterDyn(simLength, mass, voltageM) % init function 

            obj.simLength = simLength;
            obj.mass = mass;
            obj.voltageM = voltageM; 
            obj.t = linspace(0, simLength, 1+simLength*10);
            obj.dT = 0.1 ; 
            obj.a = 0.483; % default to WOT 
        end 

        function [V, I, PW] = accelerate(obj, Vfinal, Vinit, sample) % returns Velocity , motor current and power during acc 

        maxL = 1+obj.simLength*10;
        % Initialization
        V = zeros(1, maxL); % velocity 
        I = zeros(1, maxL); % current 
        PW = zeros(1, maxL); % Power 

        V(1,1) = Vinit ; 
        reached = false; 

        for n= 1:obj.simLength*10
            if V(n) >= Vfinal
                reached = true;
            end 

        if V(n)<10.8 && floor(V(n)) < Vfinal && reached ~= true
        V(n+1) = V(n) + obj.dT*(1.57 - (0.00145*(V(n)^2)));

        elseif V(n)>=10.8 && floor(V(n)) < Vfinal && reached ~= true 
        V(n+1)=V(n)+obj. dT*(7.30-(0.53*V(n))-(0.00145*(V(n)^2)));

        elseif reached == true 
            V(n+1) = Vfinal;
           
        
        end % end if 

        end % end for 

        if sample == true 
            Vreturn = zeros(1,obj.simLength);
            Vreturn(1,1) = Vinit;
            j=1;
            for i =2:obj.simLength*10 -2
                j = mod(i,10);
                if j == 0
                Vreturn(floor((i+1)/10)+1) = V(i+1);
                end 
            end 
        end 

% Current calculation 
    I(1,1) = (obj.a*Vinit*obj.mass)/obj.voltageM; 
    for n=2:maxL
        I(n) = (obj.a*V(n)*obj.mass)/obj.voltageM;
    end


        if sample == true 
            Ireturn = zeros(1,obj.simLength);
            Ireturn(1,1) = I(1,1);
            for i =2:obj.simLength*10 -2
                j = mod(i,10);
                if j == 0
                Ireturn(floor((i+1)/10) + 1) = I(i+1);
                end % second if 
            end % for 
        end % 
    
        % power profile calculation: 

        PW(1,1) = obj.voltageM * I(1,1); 
        for n=1:maxL-1
            PW(n+1) = obj.voltageM * I(n+1); 
        end 

         if sample == true 

            PWreturn = zeros(1,obj.simLength);
            PWreturn(1,1) = obj.voltageM *I(1,1);

            for i =2:obj.simLength*10-2
                j = mod(i,10);
                if j == 0
                PWreturn(floor((i+1)/10)+1) = obj.voltageM* I(i+1);
                end % second if 
            end % for 
        end % 
    
        
        if sample == true 
            V = Vreturn;
            I = Ireturn;
            PW = PWreturn;
        end 
        end  % end function 

        function [V, I, PW ]= decelerate(obj, Vfinal, Vinit, sample) % returns Velocity , motor current and power during braking  

        maxL = 1+obj.simLength*10;
        % Initialization
        V = zeros(1, maxL); % velocity 
        I = zeros(1, maxL); % current 
        PW = zeros(1, maxL); % Power 

        V(1,1) = Vinit ; 
        reached = false; 
        ind = 0; % when motor power flow is postive agin -- final cruise speed 
        counter = 0; 
        for n= 1:obj.simLength*10

            if le(V(n),  Vfinal) && counter == 0
                reached = true;
                ind = n; 
                counter = 1;
            end 

        if V(n)<10.8 && round(V(n)) > Vfinal && reached ~= true
            fctr = obj.dT*(1.57 - (0.00145*(V(n)^2)));
        V(n+1) = V(n) - fctr  ;

        elseif V(n)<10.8 && reached ~= true
            fctr = obj.dT*(1.57 - (0.00145*(V(n)^2)));
        V(n+1) = V(n) - fctr  ;

        elseif V(n)>=10.8 && round(V(n)) > Vfinal && reached ~= true 
            fctr = obj. dT*(7.30-(0.53*V(n))-(0.00145*(V(n)^2))) ;
        V(n+1)= V(n) - fctr ; 

        elseif reached == true 
            V(n+1) = Vfinal;
           
        
        end % end if 

        end % end for 

        if sample == true 
            Vreturn = zeros(1,obj.simLength);
            Vreturn(1,1) = Vinit;
            for i =2:obj.simLength*10 -2
                j = mod(i,10);
                if j == 0
                Vreturn(floor((i+1)/10)+1) = V(i+1);
                end 
            end 
        end 

% Current calculation 
    I(1,1) = - ((obj.a*Vinit*obj.mass)/obj.voltageM); 
    for n=2:maxL
         I_step = (obj.a*V(n)*obj.mass)/obj.voltageM; 
        if n <= ind
        I(n) = - I_step;
        else
            I(n) = I_step;
        end 
    end
    %I = - I; % motor working as generator, thus negative current 

        if sample == true 
            Ireturn = zeros(1,obj.simLength);
            Ireturn(1,1) = I(1,1);
            for i =2:obj.simLength*10 - 2
                j = mod(i,10);
                if j == 0
                Ireturn(floor((i+1)/10)+1) = I(i+1);
                end % second if 
            end % for 
        end % 
    
        % power profile calculation: 

        PW(1,1) = obj.voltageM * I(1,1); 
        for n=1:maxL-1
            PW(n+1) = obj.voltageM * I(n+1); 
        end 

         if sample == true 
            PWreturn = zeros(1,obj.simLength);
            PWreturn(1,1) = obj.voltageM  * I(1,1);
            for i =2:obj.simLength*10 - 2
                j = mod(i,10);
                if j == 0
                PWreturn(floor((i+1)/10)+1) = obj.voltageM* I(i+1);
                end % second if 
            end % for 
        end % 
    
        
        if sample == true 
            V = Vreturn;
            I = Ireturn;
            PW = PWreturn;
        end 
        end  % end function 

        function plots(obj, Vfinal, Vinit, acc)

            if acc ~= false 
                [V, I, PW] = obj.accelerate(Vfinal, Vinit, false); 
                
             figure(1);
            %plot(t,vel); axis([0 30 0 20]);
            plot(obj.t,V, 'r')
            grid on
            xlabel('Time [seconds]');
            ylabel('Velocity [kph]');
            title("velocity of ES: acc "  + string(obj.a) + "m/s^2");

            figure(2);
%plot(t,Imotor); axis([0 30 0 30]);
            plot(obj.t, I)
            grid on
            xlabel('Time [seconds]');
            ylabel('Motor Current [A]');
            title('Current drawm by the BLDC motor');
            

            figure(3);
%plot(t,Imotor); axis([0 30 0 30]);
            plot(obj.t, PW, 'm')
            grid on
            xlabel('Time [seconds]');
            ylabel('Power required  [W]');
            title('Power required by the E-motor');


            figure(4);
%plot(t,Imotor); axis([0 30 0 30]);
            scatter(PW, V*3.6,"k")
            grid on
            ylabel('Velocity [kph]');
            xlabel('Power required  [W]');
            title('Power required by the E-motor vs vehicle velocity');

            else 
                [V, I, PW] = obj.decelerate(Vfinal, Vinit, false); 
                
             figure(5);
            %plot(t,vel); axis([0 30 0 20]);
            plot(obj.t,V*3.6, 'r')
            grid on
            xlabel('Time [seconds]');
            ylabel('Velocity [kph]');
            title("braking of ES: acc -"  +  string(obj.a) + " m/s^2");

            figure(6);
%plot(t,Imotor); axis([0 30 0 30]);
            plot(obj.t, I)
            grid on
            xlabel('Time [seconds]');
            ylabel('Motor Current [A]');
            title('Current drawm by the BLDC motor');
            

            figure(7);
%plot(t,Imotor); axis([0 30 0 30]);
            plot(obj.t, PW, 'k')
            grid on
            xlabel('Time [seconds]');
            ylabel('Power required  [W]');
            title('Power required by the E-motor');


            figure(8);
%plot(t,Imotor); axis([0 30 0 30]);
            scatter( PW, V*3.6, "m")
            grid on
            ylabel('Velocity [kph]');
            xlabel('Power required  [W]');
            title('Power required by the E-motor vs vehicle velocity');


            end 
        end % end function 
    end  % end methods 
end % end class 










