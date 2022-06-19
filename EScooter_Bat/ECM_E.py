import numpy as np 
import pandas as pd 
import matplotlib.pyplot as plt 
import enum


class UCBANK_State(enum.Enum):
    _Disconnected = 0
    _Charging = 1
    _Discharging = 2 



class UC_Bank:
    #current_objective = ()


    def __init__(self, n_cells, SoC_init, connection_type,state=0):
        
        self.state = state
        self.n_cells = n_cells 
        self.SoC = SoC_init 
        self.SoC_log = []
        self.V_model_log = []
        
        # single cell param 
        self.V_cell_range = [2.4, 3.6]  
        self.R_cell = 0
        self.C_cell = 0 

        # model creation -- ECM calculation 

        self.V_model = 0
        self.R_model = 0
        self.C_model = 0 
        self.Soc_model = 0 

        self.SoC_log.append(self.Soc_model)

    def assign_order(self, agentId, timestep, agent_pos):
        self.agentId = agentId
        self.state = 1
        self.timestep_of_assignment = timestep
        self.agent_pos = agent_pos


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


