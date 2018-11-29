/*A function that suggests the optimal move to win*/
/*At the beginning make a random move and optimize next moves*/
/*_1_|_2_|_3_*/
/*_4_|_5_|_6_*/
/* 7 | 8 | 9 */
/*board = [1,2,3,4,5,6,7,8,9];*/
/*a possible stat is [1,1,-1,-1,2,-1,-1,-1,2]*/

function optimalMove(board, player){
/*take the current state of the board and determine positions that can not lead to a win*/

/*board = mk_ivec(1..9,[1,1,-1,-1,2,-1,-1,-1,2]);*/
/*--Break--*/
allwins = mk_imat(1..8,1..3,[
[1,2,3],
[4,5,6],
[7,8,9],
[1,4,7],
[2,5,8],
[3,6,9],
[1,5,9],
[3,5,7]
]);
/*--Break--*/
allT = allwins^T;
/*--Break--*/
/*tag = mk_ivec(1..8,[1,2,3,4,5,6,7,8]);*/
/*--Break--*/

/*loop through all winning moves and check if the board has such a configuration*/
    for(j=1;j<=8;j++){
        v = allT[1..3,j];        
        a = to_int(v[1]);
        b = to_int(v[2]);
        c = to_int(v[3]);
        
        if(board[a] == player && board[b]==player){
            prt(v);        
            printf("|| %d Is winning move",c);
        } else if(board[b] == player && board[c]==player){
            prt(v);        
            printf("|| %d Is winning move",a);
        } else if(board[a] == player && board[c]==player){
            prt(v);        
            printf("|| %d Is winning move",b);
        };
    };
/*--Break--*/
};

function prt(vec){
    for(i=1;i<=vec->vsize;i++){
        printf("%d ",vec[i]);
    };
};