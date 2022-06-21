# Battery-Modeling

## UC bank - Escooter 

The main components of the system are the following layers:

1. The Converters: Used to estimate the losses during Buck or Boost operations and save the duty cycles 
2. Data Fit: Based on empirical data a map of the SoC was realized , TODO: SVM and Linear regression model 
3. UC bank: The core of the system:
                                    - flexible model depending on the number of cells employed 
                                    - 3 states of operation: *Discharging*, *Charging*, *Idle*
4. TODO: Escooter dynamics model 


### SoC map 

SoC mapping results from the raw data of *Discharging* operations during real life tests. 

![SoCMAP](https://user-images.githubusercontent.com/101090050/174803982-6dfe77ea-9793-457a-891a-21cab2a59fbb.png)
![Boost_discharge](https://user-images.githubusercontent.com/101090050/174804047-8c3fbf2d-0c6d-4681-ba27-22ab27785f04.png)
