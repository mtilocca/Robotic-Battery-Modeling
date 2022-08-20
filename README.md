# Battery-Modeling

This repository presents the work done for modeling both Lithium Ion supercapacitors and Lithium based batteries. A first evaluation is done with the data obtained through testing in order to identify the specific enegergy storage system discharge curve. Afterwards based on the available data a battery model is created and a simulation of the system together with an ad hoc designed Battery Managment System (BMS) is implemented. 

## UC bank - Escooter 
As input the work done in the [Bachelor Thesis](https://github.com/mtilocca/Hybrid_Battery_Escooter)

The main components of the system are the following layers:

1. The Converters: Used to estimate the losses during Buck or Boost operations and save the duty cycles 
2. Data Fit: Based on empirical data a map of the SoC was realized , TODO: SVM and Linear regression model 
3. UC bank: The core of the system:
                                    - flexible model depending on the number of cells employed 
                                    - 3 states of operation: *Discharging*, *Charging*, *Idle*



### SoC map 

SoC mapping results from the raw data of *Discharging* operations during real life tests. 
![Boost_discharge](https://user-images.githubusercontent.com/101090050/174804047-8c3fbf2d-0c6d-4681-ba27-22ab27785f04.png)

Based on the findings it was possible to use the OCV method for the UC bank while the Coulomb Counting Method for the battery pack. 


## Model Based Design System - Battery pack & UC bank 

After simulating the E-scooter dynamics, the obtained data can be used as input for the simulink model of the HESS configuration presented below. 


<img width="1316" alt="Model_overview" src="https://user-images.githubusercontent.com/101090050/185758596-6bd02588-895a-4170-a4c6-3e97b89fe716.png">



