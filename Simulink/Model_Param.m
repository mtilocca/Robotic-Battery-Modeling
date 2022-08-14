% init SuperCap params - calculations based on single 
 Res =0.00139;
 cap = 1500; % farad 

 MaxV = 3.8;
 minV = 2.2; 
 num_cells = 10;
 initSoCCap = 70;  % change this 

 % init battery params based on single cell 



% load powerEscooter 

PwR_profileStruct = load("PowerEScooter.mat"); 
PwR_profile = PwR_profileStruct.fle;
simLenM = length(PwR_profileStruct.fle); 
simLen = zeros(1, simLenM);
PwR_profile(1, simLenM+1) = PwR_profile(1, simLenM);

for i = 1:simLenM+1
    simLen(i) = i;
end 


% super capacitors params 

Cap_SC = cap/num_cells ; % capacitance of supercapacitors pack 
Eq_RC_Sc = num_cells*Res; % equivalent resistance capacitors pack 
Sc_maxV = num_cells*MaxV ; % rated votlage capacitors pack 
Cap_num = num_cells; 

outS = minV*num_cells;
outE = MaxV * num_cells;
inE = 100;
inS = 0; 

Sc_init_V = outS + ((outE - outS) / (inE - inS)) *(initSoCCap - inS) ; % initial voltage Supercapacitors pack mapping range 


Temp_Sc = 0; % initial operating temperature 


% battery params 

Batt_NV = 44.4; % battery nominal voltage 
Batt_Cap = 76; % battery capacitance value 
Init_Batt_SoC =  70; % battery initial state of charge [%] 


% converters params 

Buck_Boost_L = 1; 
Buck_cap = 0;
Boost_cap = 0;


V_bus = 60; 
