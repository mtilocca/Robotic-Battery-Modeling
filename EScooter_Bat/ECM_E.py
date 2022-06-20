import numpy as np 
import pandas as pd 
import matplotlib.pyplot as plt 
import enum
from Converters import Buck, Boost


class UCBANK_State(enum.Enum):
    _Disconnected = 0
    _Charging = 1
    _Discharging = 2 



class UC_Bank:
    #current_objective = ()


    def __init__(self, n_cells, SoC_init, connection_type, state=0):
        
        self.state = state
        self.n_cells = n_cells 
        self.SoC = SoC_init 
        self.SoC_log = []
        self.V_model_log = []
        
        # single cell param 
        self.V_cell_range = [2.2, 3.8]  # 2.2 = discharged , 3.8 fully charged 
        self.R_cell = 0.13 # Ohm 
        self.Spec_pow = 9300 # specific power W/kg 
        self.Spec_en = 11 # specific energy Wh/kg 
        self.En_dens = [19, 25] # Energy density Wh/L 

        # model creation -- ECM calculation 
        if connection_type == 1 : # series connection  

            self.V_model = self.n_cells * self.V_cell_range[1]
            self.R_model = self.n_cells * self.R_cell
            self.Soc_model = SoC_init

            self.V_model_log.append(self.V_model)
            self.SoC_log.append(self.Soc_model)
        elif connection_type == 0: # parallel connection 
            self.V_model = self.V_cell_range[1]
            self.R_model = (1/self.R_cell) * self.n_cells
            self.Soc_model = SoC_init

            self.V_model_log.append(self.V_model)
            self.SoC_log.append(self.Soc_model)
        else: 
            raise Exception("Sorry, wrong connection type. Enter 0, 1")
            exit()


        self.SoC_log.append(self.Soc_model)


    def getCurrent_SoC(self):
        return self.SoC

    def get_SoC_sim(self):
        return self.SoC_log

    def get_Vmodel(self):
        return self.V_model

    def discharge(self, current):
        return 

    def charge(self, current):
        return 

    def disconnect(self):
        return 

    def update_UC_state(self, newState, current):

        if newState == 0: 
            self.state = UCBANK_State._Disconnected
            self.disconnect(current)

        elif newState == 1: 
            self.state = UCBANK_State._Charging
            self.charging(current)

        elif newState == 2: 
            self.state = UCBANK_State._Discharging
            self.discharge(current)

        else: 
            raise Exception("Sorry, invalid new state. Enter 0, 1 or 2")
            exit()

    
    def run_simulation(self, timestep, current): 

        if self.state == UCBANK_State._Disconnected:

            print()

        elif self.state == UCBANK_State._Charging:
            print()

        elif self.state == UCBANK_State._Discharging: 
            print()

        
        self.SoC_log.append(self.Soc_model)
        self.V_model_log.append(self.V_model)




if __name__ == "__main__":

    batt = UC_Bank(10, 100, 1) # 1 series connection of the cells, 0 parallel connection of the cells 


# importance level: 1, 2, 3 ( 1 highest )

# TODO create and test simulation loop -- 2
# TODO create and calculate ECM model of the UC bank -- series and paralell connection -- 1
# TODO translate Escooter model to python so that it can be imported here -- 3
# TODO fill charge and discharge functions and disconnect -- 1
# TODO implement the post simulation plotting -- 2

