/* Auth:                                                     hydramin */
/* Date:                                 Thu Nov 29 13:32:35 EST 2018 */
/*--Break--*/
 function recur(num){
     if(num < 1){
       num = 100;
     } else {
       printf("%d\n",num);
       num = num - 1;
       recur(num);
     };
};
/*--Break--*/
recur(3);
/*--Break--*/
app = mk_imat(1..2,1..2,[[1,2],[3,4]]);
/*--Break--*/
appt = app^T;
/*--Break--*/
for(i=1;i<=2;i++){
for(j=1;j<=2;j++){
printf("%d ",appt[i,j]);
};
printf("\n");
};
/*--Break--*/

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


/*A function that suggests the optimal move to win*/
/*At the beginning make a random move and optimize next moves*/
/*_1_|_2_|_3_*/
/*_4_|_5_|_6_*/
/* 7 | 8 | 9 */
/*board = [1,2,3,4,5,6,7,8,9];*/
/*a possible stat is [1,1,-1,-1,2,-1,-1,-1,2]*/

function optimalMove(){
/*take the current state of the board and determine positions that can not lead to a win*/

board = mk_ivec(1..9,[1,1,-1,-1,2,-1,-1,-1,2]);

allwins = mk_fvec(1..8,1..3,[
[1,2,3],
[4,5,6],
[7,8,9],
[1,4,7],
[2,5,8],
[3,6,9],
[1,5,9],
[3,5,7]
]);

allT = allwins^T;

tag = mk_ivec(1..8,[1,2,3,4,5,6,7,8]);

for(i=1;i<=8;i++){
    prt(allT[1..3,i]);
};

};

function prt(vec){
    for(i=1;i<=vec->vsize;i++){
        printf("%d ",vec[i]);
    };
};
/*--Break--*/
board = mk_imat(1..8,1..3);
/*--Break--*/
optimalMove();
/*--Break--*/
