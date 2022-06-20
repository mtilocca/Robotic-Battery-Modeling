import numpy as np 
import matplotlib.pyplot as plt 


class Buck: 

    def __init__(self, Vo):

        self.freq = 32000
        self.Vin = 48
        self.freq = 0
       
        self.Cap = np.float64(5600 * 1e-6)
        self.L = np.float64(1.4498 * 1e-6)
        self.eta = 0.8

        self.D0 = Vo/(self.Vin*self.eta)
        
        
        self.D_log = [0]
        self.D_log.append(self.D0)

        self.Vo_log = [Vo]



    def calculate_newD(self, Vo):

        D = Vo/(self.Vin *self.eta)
        self.D_log.append(D)
        

    def Power(self, Vo, Ii):

        Pi = self.Vi*Ii * self.eta

        Ii = Pi / Vo

        return Ii


    def update(self, timestep, Vo, Ii):
        self.time_step_log.append(timestep)
        self.calculate_newD(Vo)
        I_o = self.Power(Vo, Ii)

        return I_o



class Boost: 

    def __init__(self, Vin):

        
        self.freq = 32000 # switching frequency Hz 
        self.Vout = 48 
        self.Cap = np.float64(798 * 1e-6)  * 5 # to be safe 
        self.L = np.float64(21.5400 * 1e-6)  * 5 
        self.eta = 0.8 # efficiency of the converter 
        self.Imax = 23 # maximum current drawn by the DC motor 
        self.D0 = 1 -((Vin*self.eta)/ self.Vout)
        
        
        self.D_log = [0]
        self.D_log.append(self.D0)

        self.Vin_log = [Vin]

        self.I_in_log = [0]
        self.time_step_log = [0]

    def calculate_newD(self, Vi):
        self.Vin_log.append(Vi)
        D = 1 - ((Vi*self.eta)/ self.Vout)
        self.D_log.append(D)

    def Power(self, Vi, I_req): 
        Po = self.Vout*I_req 

        I_in = Po / (Vi* self.eta)

        return I_in 

    def update(self, timestep, Vi, I_req):
        self.time_step_log.append(timestep)
        self.calculate_newD(Vi)
        I_in = self.Power(Vi, I_req)

        return I_in 


