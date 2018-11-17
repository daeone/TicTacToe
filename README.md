# TicTacToe
tic tac toe with the terminator!
Notes on the contents of the test files
- img1.ppm and the likes are image files for the tictactoe board with a coin placed in each of the board grid
- back.ppm is the background image where all cells are empty
- noCamSession.mm is a mediamath script that is used when the camera is not available. the pictures to be used can be imported and assigned to variables
	*** MAKE SURE TO REPLACE THE 'PATH' WITH THE PATH OF THE IMAGES IN YOUR COMPUTER, IT HAS TO BE THE ABSLUTE OR RELATIVE PATH
	*** LOAD THIS INTO MEDIAMATH, DONT READ IT IN
- session1.mm is a mediamath script used to work with the camera, it can be run line by line. it saves the currently taken images into a
	directory that is specified in the proj_writeImage(..) function. If you want to specify a different directory, use the default mediamath 'write_img()'
	function or simply modify the default directory path specified in the proj_writeImage() function.
	*** LOAD THIS INTO MEDIAMATH, DONT READ IT IN
- tictaccam.mm is a script that contains only functions. the functions are have a format 'proj_something()'. a description of their function is written 
	above the functions. READ this script into MEDIAMATH to use the functionalities. In some cases mediamath will become unresponsive, just restart it.

