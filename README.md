# Traffic-Light

The traffic light system is constructed based on the Finiste state machine principle. The Traffic light states are given in Figure 1.

![image](https://github.com/user-attachments/assets/1c9acce0-5c83-43ae-ae2f-fdb78ab85c74)
Figure 1. State tansition and timing requirements

Based on this a new sate diagram for made to make the writing of the verilog code easier. The state diagram is given below.

![image](https://github.com/user-attachments/assets/efb1e5f3-b7df-408c-9f3b-54c4bb0457ad)
Figure 2. Traffic light state diagram

The gray code states are used because it reduces the switching power in the final transistor implimentation. The states are named as follows. 
S0 = 00
S1 = 01
S2 = 11
S3 = 10

In order to have a better picture on this a meramid graph script has been written which helps in visualzing the state diagram. 
The design codes for the traffic light system is in the rtl folder. and the testbenches are in the testbench folder og this git repositry. 
