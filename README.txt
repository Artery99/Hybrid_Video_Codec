This project resulted from the work done by all of us together. We used to meet at telecom paris inorder to write the code which infact was heavily
inspired from the code written by previous multimedia networking students. We also used alot the function they proposed along with the generated dictionaries
first symbol, second symbol and motion vector codebook

Each of us proposed an experiment to do. Ahmad proposed the all intra coding experiment and playing with alpha experiment, Nagham proposed to change the GOP architecture
and Hussein propesd to do logarthmic search instead of full search.

---------------------------------------------------


Intsruction to run the program.

All the necessary files are in the folder. To run the program you can open the Main.m file and initilaize alpha, search(0 for full and 1 for 2d logarithmic search)
also nFrame (number of frames per GOP) and nGOP (number of GOPs). After that you can simply run the main program and you could observe the results in the log file
called Log.txt and if you wish to save the videos(both the original(with the number of frames you want) and the compressed) 
you can run the function ShowVideo.m choosing the name you want for each  and also the frame rate you want.

Now in order to run the experiments we perfomed and presented in the slides:

1) All intracoding: Open the encoder function Encode.m and comment the if statement at line 29 and also comment all lines between 53 77 included.

2) Logaritmic Search : Replace the search = 0 in the main by 1.

3) Changed GOP structure :  At line 56 where we give to the intercoding function the decodeFrames as input replace the 'currentFrameIdx-1' by '1'

4) changing alpha: In the main function initialize the alpha parameter of your choosing. (For us we chose -10)



NB. We also experimented with different implementation of the function Encoder, Intracoding and BlockIntraCoding. The new implementation are called Encoder2
Intracoding2 and BlockIntraCoding2 but the results were not so much promising. Also in the matlab code you can see that the rate calculations from the fucntions
were commented out because the results weren't convincing and so we went for calculating the compression ratio by dividing the size of the original by
the compressed frame.