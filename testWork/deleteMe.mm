/*=========================================================================*/
/*=========================================================================*/
/*=========================================================================*/
/*=========================================================================*/
/*=========================================================================*/
/*=========================================================================*/

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
wins = mk_ivec(1);
/*loop through all winning moves and check if the board has such a configuration*/
    for(j=1;j<=8;j++){
        v = allT[1..3,j];        
        a = to_int(v[1]);
        b = to_int(v[2]);
        c = to_int(v[3]);
        
        if(board[a] == player && board[b]==player){            
            if(board[c] == -1){
                prt(v);      
                printf("|| %d Is winning move\n",c);
                wins = push(wins,c);
            };            
        } else if(board[b] == player && board[c]==player){
            if(board[a] == -1){
                prt(v);    
                printf("|| %d Is winning move\n",a);
                wins = push(wins,a);
            };
        } else if(board[a] == player && board[c]==player){
           if(board[b] == -1){
                prt(v);    
                printf("|| %d Is winning move\n",b);
                wins = push(wins,b);
           };
        };
    };
    wins;
/*--Break--*/
};
/*=========================================================================*/
/*=========================================================================*/
function prt(vec){
    for(i=1;i<=vec->vsize;i++){
        printf("->%d ",vec[i]);
    };
};
/*=========================================================================*/
/*=========================================================================*/
/*it creates a dynamic vector, whenever a new element is created, it increases the vector size to accomodate the new value*/
function push(ivec, _val){
    if(ivec->vsize == 1 && ivec[1] == 0){
        ivec[1] = _val;
        new_ivec = ivec;
    } else {
        c = ivec->vsize;
        new_ivec = mk_ivec(1..c+1);
        new_ivec[1..c] = ivec[1..c];
        new_ivec[c+1] = _val;        
    };    
    new_ivec;
};
/*=========================================================================*/
/*=========================================================================*/
/*function determines the next move of the robot*/
function nextMove(board,player){
    gonext = 0;
    m = optimalMove(board, player);
/*--Break--*/
    if(m[1] != 0){
        if(m->vsize <= 1){
            gonext = m[1];    
        } else {
            select = 1+to_int(random()*(-1+m->vsize));
            gonext= m[select];
        };
    } else {
        i = 1+to_int(random()*8); 
        for(i; board[i] != -1; i = 1+to_int(random()*8));
        gonext = i;
    };   
    gonext;
};
/*=========================================================================*/
/*=========================================================================*/

function nextMoveBlock(board,robot,human){
    gonext = 0;
    mr = optimalMove(board, robot);/*list of optimal moves for robot*/
    mh = optimalMove(board, human);/*list of optimal moves for human*/
/*--Break--*/
    if(mr[1] != 0){ /*if 0 robot has no winning moves*/
        if(mr->vsize <= 1){ /*only one winning move*/
            gonext = mr[1];    
        } else {            /*several winning moves to choose from*/
            select = 1+to_int(random()*(-1+mr->vsize));
            gonext= mr[select];
        };
    } else if (mh[1] != 0){ /*robot checks if human has a finishing move*/
        if(mh->vsize <= 1){ /*only one winning move*/
            gonext = mh[1];    
        } else {            /*several winning moves to choose from*/
            select = 1+to_int(random()*(-1+mh->vsize));
            gonext= mh[select];
        };
    }else { 
        i = 1+to_int(random()*8); 
        for(i; board[i] != -1; i = 1+to_int(random()*8));
        gonext = i;
    };   
    gonext;
};

/*=========================================================================*/
/*=========================================================================*/
/*=========================================================================*/
/*=========================================================================*/