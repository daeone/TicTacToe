
function startGame()
{
    /*board = mk_imat(1..3, 1..3);*/
    printf("Initializing the game...\n");
    /*board = mk_fmat(1..3,1..3,[[-1,-1,-1],[-1,-1,-1],[-1,-1,-1]]);*/ /*filled with -1*/
    board = mk_ivec(1..9,[-1,-1,-1,-1,-1,-1,-1,-1,-1]);
    
    /*pinv = calibrateCam(cam);*/
    
    /* length of the x, o piece */
    length = 1.5;

    /* Set Absolute position X and Y of the board */ 
    /*xm = mk_fmat(1..3,1..3,[[12.5,15.5,18.5],[12.5,15.5,18.5],[12.5,15.5,18.5]]);*/ 
    /*ym = mk_fmat(1..3,1..3,[[3,3,3],[0,0,0],[-3,-3,-3]]);*/
    xm = mk_fvec(1..9,[12.5,15.5,18.5,12.5,15.5,18.5,12.5,15.5,18.5]);
    ym = mk_fvec(1..9,[3,3,3,0,0,0,-3,-3,-3]);
    refM = mk_fmat(1..9,1..2);
    refM[1..9,1] = xm;
    refM[1..9,2] = ym;
    
    printf("Press Start if you're ready to play...\n");
    clicked = setButton("Start");
    while(!clicked){}; /*if button not clicked game wont proceed*/
    
    printf("Game starts...\n");
   /* printf("Let's decide who should go first... pick head(1) or tail(0)!\n"); */
   /* winner = coinToss(0); */
    turn = 1; 
    
    printf("turn is %d\n",turn);
    
    while(checkWinner(board) == -1)
    {
        if(turn == 2)
	    {
            if(clicked)
            {
                valid = 0;
                while(valid != 1)
                {
                    img2 = proj_grabImage(cam);
                    /*dxy = proj_getDistance(xm,ym,proj_getCenter(background,img2));*/
                    /*index = proj_getMinIndex(dxy);*/
                    
                    /*Given pixel points, calculate the real world Position*/
                    pixel = proj_getCenter(background,img2);
                    world = findWorldPosition(pixel[1],pixel[2],pinv);
                    index = proj_minDistIndex(world,refM);
                    
                    distance = sqrt((world[1]-refM[index,1])^2+(world[2]-refM[index,2])^2);
                    range = 1.5 - length/2;
                    if (distance > range)
                    {
                        printf("You are too off the center. Replace the marble accurately\n");
                        clicked = setButton("Readjusted");
                        while(clicked!=1){};
                    }
                    else{valid=1;};
                };
                
                /*board[index[1]][index[2]] = 2;*/ 
                printf("You placed at %dth grid\n",index);
                board[index] = 2;
                printBoard(board);
                turn = 1;    
            }; 
	    }
        else
        {
            board = play(board,refM);
            sleep(10);
	        background = proj_grabImage(cam);
            printBoard(board);
            turn = 2; 
	        clicked = setButton("Play!"); 
        };
    };    

    winner = checkWinner(board);
    printf("Game is over! The winner is: ");
    if(winner == 1) {printf("Robot, I won!\n");}
    else if(winner == 2) {printf("Human, You won!\n");};
};

/* gridPosMat is the absolute position that the robot will go to to place the tile on the grid */
/*Input: board-model for the playing board with marks, gridPosmat-see above, */
function play(board,gridPosMat)
{
    i = to_int(random()*10); 
    for(i; board[i] != -1; i = to_int(random()*10));
    
    board[i] = 1;
    
    /* Move the robot should be added */
    placeIt(gridPosMat[i,1],gridPosMat[i,2]);
    
    printf("Your turn...\n");
    board; 
};

/* gridPos is the absolute position of the grid 1 to 9 */
/* It should have x and y absolute value of that grid */
function placeIt(gridPosx, gridPosy)
{
    /* go to the base position to grab the piece */
    CRSinvkin (0, -15, 0);
    sleep(5);
    servo_close(50);
    sleep(5);
    CRSinvkin(gridPosx,gridPosy,gridPosx * 0.11-1.15);
    sleep(5);
    servo_open(50);
    sleep(3);
    rob_move_abs(0,90,0,0,0);
};



/*Input: 3x3 playing board model, Output: below*/ 
/*  1 or 2 if game is over. */
/*  0 if game is draw.      */
/* -1 if game is still in progress.  */

function checkWinner(board)
{
    winner = -1;
    if (board[1] == board[2] && board[2] == board[3]) {winner = board[1];};
    if (board[4] == board[5] && board[5] == board[6]) {winner = board[4];};       
    if (board[7] == board[8] && board[8] == board[9]) {winner = board[7];};       
    if (board[1] == board[4] && board[4] == board[7]) {winner = board[1];};   
    if (board[2] == board[5] && board[5] == board[8]) {winner = board[2];};     
    if (board[3] == board[6] && board[6] == board[9]) {winner = board[3];};
    if (board[1] == board[5] && board[5] == board[9]) {winner = board[1];};
    if (board[3] == board[5] && board[5] == board[7]) {winner = board[3];};
    
    if (board[1] != -1 && board[2] != -1 && board[3] != -1 &&
        board[4] != -1 && board[5] != -1 && board[6] != -1 && board[7] 
        != -1 && board[8] != -1 && board[9] != -1){
        	winner = 0;
	};
	winner;
};


function printBoard(board)
{
    printf("\n\n\tTic Tac Toe\n\n");
    printf("Robot 1 (X)  -  Human 2 (O)\n\n\n");

    printf("     |     |     \n");
    printf("  %d |  %d |  %d \n", board[1], board[2], board[3]);
    printf("_____|_____|_____\n");
    printf("     |     |     \n");
    printf("  %d |  %d |  %d \n", board[4], board[5], board[6]);
    printf("_____|_____|_____\n");
    printf("     |     |     \n");
    printf("  %d |  %d |  %d \n", board[7], board[8], board[9]);
    printf("     |     |     \n\n");
};


/*Input: String for name of button, Output: returns value 1 when clicked*/
function setButton(message)
{
    clicked = 0; 
    Tk_Button_Set(:text=message, :bell=t);
    while(!Tk_Button_Pressed()){};
    clicked = 1;
};

/*Input: 0 or 1 for player ids, Output: 0 or 1 that determines who goes first*/
function coinToss(toss)
{
    winner = 0; 
    coin = random();
    if(coin >= 0.5) {coin = 1;}
    else {coin = 0;};
    
    if (coin == toss){printf("You won! You move first...\n"); winner = 2;}
    else {printf("I won! I move first...\n"); winner = 1;};
    winner; 
};

