function startGame()
{
    board = mk_imat(1..3, 1..3);
    printf("Initializing the game...\n");
    board = initialize(board); 

    /* Set Absolute position X and Y of the board */ 
    xm = mk_fmat(1..3,1..3,[[0,0,0],[0,0,0],[0,0,0]]); 
    ym = mk_fmat(1..3,1..3,[[1,1,1],[1,1,1],[1,1,1]]);
    
    printf("Press Start if you're ready to play...\n");
    clicked = setButton("Start");
    while(!clicked){};
    
    printf("Game starts...\n");
    printf("Let's decide who should go first... pick head(1) or tail(0)!\n");
    winner = coinToss(0);
    turn = winner; 
    
    while(checkWinner(board) != -1)
    {
        if(turn == 1)
	{
            if(clicked)
            {
                img = proj_grabImage();
                dxy = proj_getDistance(xm,ym,proj_getCenter(background,img2));
                index = proj_getMinIndex(dxy);
                board[index[1]][index[2]] = 2;
                printBoard(board);
                turn = 2;       
            }; 
	}
        else
        {
            board = play(board);
	    background = proj_grabImage();
            printBoard(board);
	    clicked = setButton("Play!"); 
        };
    };    

    winner = checkWinner(board);
    printf("Game is over! The winner is: ");
    if(winner == 1) {printf("Robot, I won!\n");}
    else if(winner == 2) {printf("Human, You won!\n");};
};


function play(board)
{
    for (int i=0; i<board->vsize; i++) 
    { 
        for (int j=0; j<board->hsize; j++)
        {
            if (board[i][j] == -1){board[i][j] = 1;}; 
        };    
    }; 
    /* 
        Move the piece to the grid.
    */
    printf("Your turn...\n");

    board; 
};


function initialize(board) 
{ 
    /* Initially the board is empty */ 
    for (int i=0; i<board->vsize; i++) 
    { 
        for (int j=0; j<board->hsize; j++)
        {
            board[i][j] = -1; 
        };    
    }; 
    board; 
}; 

/*
   1 or 2 if game is over.
   0 if game is draw.
   -1 if game is still in progress. 
*/
function checkWinner(board)
{
    int winner;
    if (board[1,1] == board[1,2] && board[1,2] == board[1,3]) {winner = board[1,1];}
    else if (board[2,1] == board[2,2] && board[2,2] == board[2,3]) {winner = board[2,1];}       
    else if (board[3,1] == board[3,2] && board[3,2] == board[3,3]) {winner = board[3,1];}       
    else if (board[1,1] == board[2,1] && board[2,1] == board[3,1]) {winner = board[1,1];}   
    else if (board[1,2] == board[2,2] && board[2,2] == board[3,2]) {winner = board[1,2];}     
    else if (board[1,3] == board[2,3] && board[2,3] == board[3,3]) {winner = board[1,3];}
    else if (board[1,1] == board[2,2] && board[2,2] == board[3,3]) {winner = board[1,1];}
    else if (board[1,3] == board[2,2] && board[2,2] == board[3,1]) {winner = board[1,3];}
    else if (board[1,1] != -1 && board[1,2] != -1 && board[1,3] != -1 &&
        board[2,1] != -1 && board[2,2] != -1 && board[2,3] != -1 && board[3,1] 
        != -1 && board[3,2] != -1 && board[3,3] != -1){
        	winner = 0;
	}
    else{
        winner = -1;
    };
};


function printBoard(board)
{
    printf("\n\n\tTic Tac Toe\n\n");
    printf("Robot 1 (X)  -  Human 2 (O)\n\n\n");

    printf("     |     |     \n");
    printf("  %c  |  %c  |  %c \n", board[1,1], board[1,2], board[1,3]);
    printf("_____|_____|_____\n");
    printf("     |     |     \n");
    printf("  %c  |  %c  |  %c \n", board[2,1], board[2,2], board[2,3]);
    printf("_____|_____|_____\n");
    printf("     |     |     \n");
    printf("  %c  |  %c  |  %c \n", board[3,1], board[3,2], board[3,3]);
    printf("     |     |     \n\n");
};

function setButton(message)
{
    clicked = 0; 
    Tk_Button_Set(:text=message, :bell=t);
    while(!Tk_Button_Pressed()){};
    clicked = 1;
};

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

