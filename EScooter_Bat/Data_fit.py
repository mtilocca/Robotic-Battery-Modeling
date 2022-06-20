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
        
        plt.plot(self.data_InBoost)
        plt.plot(self.data_OutBoost, color = 'red')
        plt.show()
        plt.close()
        self.index_boost = np.arange(len(self.data_InBoost))
        

        slope, intercept, r, p, std_err = stats.linregress(self.index_boost, self.data_InBoost.data)

        def myfunc(x):
            return slope * x + intercept

        mymodel = list(map(myfunc, self.index_boost))

        plt.scatter(self.index_boost, self.data_OutBoost)
        plt.plot(self.index_boost, mymodel)
        plt.show()


if __name__ == "__main__":
    soc = SoC_pred()