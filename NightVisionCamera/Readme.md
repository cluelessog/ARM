client.s - This is the code that is to be run at the server end. It generates the cross-wire and encrypts a subset of the generated values, and further encodes it as well.


server.s - This is the code that is to be run at the server end. Upon receiving, it will first decode it and then retrieve the original cross-wire coordinates. This again does it only for a subset of the values, since this is a prototype version anyway. 


Changing a variable will enable it to run over all the values, if required.


NightVision.s - This code has both the client and server one after the other. This is to show that our code works. You just run the code and it carries out every operation and gives you back the value it started out with. 


For verification purposes kindly look into the code, and watch the corresponding addresses as the code is being run.