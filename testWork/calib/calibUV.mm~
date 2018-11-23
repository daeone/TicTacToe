??"proj_";
/*--Break--*/
/*calculate the X,Y coordinates from the ccx values. Just do PPx[u,v,1]^T*/
function threeVec(){
    x = mk_fvec(1..3);
    x[3] = 1;
    x;
};
function normalize(v){
    f = mk_fvec(1..2);
    f = v[1..2]/v[3];
    f;
};
function prtMe(arr){
    for(i=1;i<=9;i++){
        printf("(%.2f, %.2f)\n",arr[i][1], arr[i][2]);
    };
};
/*--Break--*/
back = read_img("/eecs/home/hydramin/Documents/4421/Project/TicTacToe/testWork/calib/back.ppm");
c1 = read_img("/eecs/home/hydramin/Documents/4421/Project/TicTacToe/testWork/calib/c1.ppm");
c2 = read_img("/eecs/home/hydramin/Documents/4421/Project/TicTacToe/testWork/calib/c2.ppm");
c3 = read_img("/eecs/home/hydramin/Documents/4421/Project/TicTacToe/testWork/calib/c3.ppm");
c4 = read_img("/eecs/home/hydramin/Documents/4421/Project/TicTacToe/testWork/calib/c4.ppm");
c5 = read_img("/eecs/home/hydramin/Documents/4421/Project/TicTacToe/testWork/calib/c5.ppm");
c6 = read_img("/eecs/home/hydramin/Documents/4421/Project/TicTacToe/testWork/calib/c6.ppm");

a1 = proj_getCenter(back,c1);
a2 = proj_getCenter(back,c2);
a3 = proj_getCenter(back,c3);
a4 = proj_getCenter(back,c4);
a5 = proj_getCenter(back,c5);
a6 = proj_getCenter(back,c6);

/*PP is pixle to X,Y*/
PP = mk_fmat(1..3,1..3,[
[-30.2868262428999380,     -22.8894438846262958,   11174.6947255013656],
[0.436084093218768731,     34.2766040865701314,     -9490.51862786125092],
[-0.379489240334821120,    -1.42664897943947189,    134.249727804199807]
]);

/*P is from X,Y to pixle*/
P = mk_fmat(1..3,1..3,[
[-0.0272491766210897872,      -0.0392349276657349214,      -0.505465319910883282],
[0.0108015028996522617,      0.000532538666508516716 ,     -0.861450009897587576],
[0.0000377593596309405894,    -0.000105247789924628398,    -0.00313449743705126842]
]);

/*--Break--*/
/*Now that we have the matrix we can change any pixle value to X,Y*/
/*get the pictures and find the centers*/
/*--Break--*/

img1 = read_img("/eecs/home/hydramin/Documents/4421/Project/TicTacToe/testWork/expr/img1.ppm");
img2 = read_img("/eecs/home/hydramin/Documents/4421/Project/TicTacToe/testWork/expr/img22.ppm");
img3 = read_img("/eecs/home/hydramin/Documents/4421/Project/TicTacToe/testWork/expr/img3.ppm");
img4 = read_img("/eecs/home/hydramin/Documents/4421/Project/TicTacToe/testWork/expr/img44.ppm");
img5 = read_img("/eecs/home/hydramin/Documents/4421/Project/TicTacToe/testWork/expr/img5.ppm");
img6 = read_img("/eecs/home/hydramin/Documents/4421/Project/TicTacToe/testWork/expr/img6.ppm");
img7 = read_img("/eecs/home/hydramin/Documents/4421/Project/TicTacToe/testWork/expr/img7.ppm");
img8 = read_img("/eecs/home/hydramin/Documents/4421/Project/TicTacToe/testWork/expr/img8.ppm");
img9 = read_img("/eecs/home/hydramin/Documents/4421/Project/TicTacToe/testWork/expr/img9.ppm");

/*--Break--*/
/*create vectors [_,_,1] to be filled later*/
cc1 = threeVec();
cc2 = threeVec();
cc3 = threeVec();
cc4 = threeVec();
cc5 = threeVec();
cc6 = threeVec();
cc7 = threeVec();
cc8 = threeVec();
cc9 = threeVec();
/*--Break--*/


/*calculate centers of gravities of the centers of all the grids*/
cc1[1..2] = proj_getCenter(back,img1);
cc2[1..2] = proj_getCenter(back,img2);
cc3[1..2] = proj_getCenter(back,img3);
cc4[1..2] = proj_getCenter(back,img4);
cc5[1..2] = proj_getCenter(back,img5);
cc6[1..2] = proj_getCenter(back,img6);
cc7[1..2] = proj_getCenter(back,img7);
cc8[1..2] = proj_getCenter(back,img8);
cc9[1..2] = proj_getCenter(back,img9);

/*--Break--*/
arr = make_array(9,
    normalize(PP*cc1),
    normalize(PP*cc2),
    normalize(PP*cc3),
    normalize(PP*cc4),
    normalize(PP*cc5),
    normalize(PP*cc6),
    normalize(PP*cc7),
    normalize(PP*cc8),
    normalize(PP*cc9),
);
/*--Break--*/
/*multiply the matrix by ccx*/
prtme(arr);




