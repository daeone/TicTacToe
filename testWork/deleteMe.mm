board = mk_imat(1..3, 1..3);
/*--Break--*/
printf("Initializing the game...\n");
/*--Break--*/
board = initialize(board); /*filled with -1*/
/*--Break--*/
/* Set Absolute position X and Y of the board */ 
xm = mk_fmat(1..3,1..3,[[12.5,15.5,18.5],[12.5,15.5,18.5],[12.5,15.5,18.5]]); 
ym = mk_fmat(1..3,1..3,[[3,3,3],[0,0,0],[-3,-3,-3]]);
/*--Break--*/
printf("Press Start if you're ready to play...\n");
clicked = setButton("Start");
while(!clicked){}; /*if button not clicked game wont proceed*/

printf("Game starts...\n");
printf("Let's decide who should go first... pick head(1) or tail(0)!\n");
winner = coinToss(0);
turn = winner;
/*--Break--*/
function initialize(board) 
{ 
    /* Initially the board is empty */ 
    for (i=0; i<board->vsize; i++) 
    { 
        for (j=0; j<board->hsize; j++)
        {
            board[i][j] = -1; 
        };    
    }; 
    board; 
};