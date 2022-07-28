from turtle import color
import sklearn
import pandas as pd 
import matplotlib.pyplot as plt 
import os 
import numpy as np 
from scipy import stats

#print(os.getcwd())
'''
Fitting of SoC from data sets 
'''

class SoC_pred:
    
    def __init__(self):
        
        self.data_buckIn = pd.read_csv(r"/Users/mariotilocca/Desktop/Master/Trento/courses/BatteryPJ/Robotic-Battery-Modeling/EScooter_Bat/BUCKIN.txt")
        self.data_OutBuck = pd.read_csv(r"/Users/mariotilocca/Desktop/Master/Trento/courses/BatteryPJ/Robotic-Battery-Modeling/EScooter_Bat/OutputBuck.txt")
        self.data_OutBoost = pd.read_csv(r"/Users/mariotilocca/Desktop/Master/Trento/courses/BatteryPJ/Robotic-Battery-Modeling/EScooter_Bat/OutputBoost.txt")
        self.data_InBoost = pd.read_csv(r"/Users/mariotilocca/Desktop/Master/Trento/courses/BatteryPJ/Robotic-Battery-Modeling/EScooter_Bat/InputBoost.txt")
        
        #plt.plot(self.data_InBoost)
       # plt.plot(self.data_OutBoost, color = 'red')
       # plt.show()
       # plt.close()
        self.index_boost = np.arange(len(self.data_InBoost))
        
        self.index_boost = pd.DataFrame(self.index_boost)
        

        #def myfunc(x):
            #return slope * x + intercept

        #mymodel = list(map(myfunc, self.index_boost))

        #plt.scatter(self.data_InBoost, self.data_OutBoost)  # diff size 
        #plt.plot(self.index_boost, mymodel)
        #plt.show()
        
    def normalize_data(self):
            
        self.data_OutBoost = self.data_OutBoost.loc[0:len(self.data_InBoost)-1]
        self.data_buckIn = self.data_buckIn.loc[0:len(self.data_OutBuck)-1]
            
            
    def plot_raw(self):
        
        plt.plot(self.data_InBoost, color='green')
        plt.xlabel('Samples  number [n]')
        plt.ylabel('Input Voltage [V]')
        plt.title('Boost discharge cycle')
        plt.grid(True)
        plt.show()
        
 

            
    def fit_data(self, plot = False):

        
        
        minSL = self.data_InBoost.min()
        maxSL = self.data_InBoost.max()
        x = self.data_InBoost
        f = lambda x: ((x - minSL)*(100-(0)))/(maxSL - minSL) + 0 
        self.Soc_emp  = x.applymap(f)
        
        
        if plot: 

            
            plt.plot(self.Soc_emp, self.data_InBoost, color='b')
            plt.ylabel('Capacitors Voltage [V]')
            plt.xlabel('SoC [%]')
            plt.title('SoC Map')
            plt.grid(True)
            plt.show()

if __name__ == "__main__":
    soc = SoC_pred()
    
    soc.normalize_data()
    
    
    soc.fit_data()

   # soc.Soc_emp.to_csv('SoC_map.csv', index=False, header=False)

    soc.plot_raw()