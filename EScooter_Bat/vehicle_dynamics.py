import numpy as np 
import pandas as pd 
import matplotlib.pyplot as plt 
import enum
import IC_scooter as i


class Vehicle_State(enum.Enum):
    _StandStill = 0
    _Accelerating = 1
    _Decelerating = 2 
    _Cruising = 4 



class EscooterDynamics:

    def __init__(self, m = 180, Vnom = 48):
        
        self.mass = m 
        self.Vmotor = Vnom 

        self.velRecord = [i.VEL] # init cond
        self.CurrentVel = i.VEL
        self.distance = [i.DIS] # init cond
        self.dt = i.DIS

        self.force = [i.FORCE] # init cond
        self.Imotor = [i.ICURRENT] # init cond 
        self.CImotor = i.ICURRENT

        self.VThres = 10.8 # velocity threshold for the scooter 
        self.step = 0.1 # simulation step 

        self.accRecord = [i.ACC] # init cond 
        self.acc = i.ACC

        self.ForceRecord = [i.FORCE]
        self.force = i.FORCE


    def UpdateVelocity(self):

        if self.velRecord[-1] < self.VThres:

            vel = self.velRecord[-1] + self.step(1.57 -(0.00145*(np.pow(self.velRecord[-1], 2))))
            self.velRecord.append(vel)
            self.CurrentVel= vel

        elif self.velRecord >= self.VThres: 
            vel = self.velRecord[-1] + self.step*(7.3 -(0.53*self.velRecord[-1])-(0.00145*(np.pow(self.velRecord[-1], 2))))
            self.velRecord.append(vel)
            self.CurrentVel= vel


    def updateDistance(self):

        dis = self.distance[-1] + self.step*self.CurrentVel
        self.distance.append(dis)

    def UpdateAcceleration(self):
        
        self.acc = (self.CurrentVel - self.velRecord[-2]) / self.step 
        self.accRecord.append(self.acc)

    def UpdateCurrent(self):

        self.CImotor = (self.acc*self.CurrentVel*self.mass) / self.Vmotor
        self.Imotor.append(self.CImotor)

    def UpdateTForce(self):
        f = (self.Vmotor *self.CImotor)/ self.CurrentVel

        self.force = f 
        self.ForceRecord.append(f)


    def save_params(self):
        pass  # TODO save record lists into .csv files for external plotting or plotting now ?? 
