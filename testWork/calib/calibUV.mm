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

/*--Break--*/
??"proj_";
/*--Break--*/
cam = proj_getCam();
/*--Break--*/
back = proj_grabImage(cam);
/*--Break--*/
c1 = proj_grabImage(cam);
/*--Break--*/
c2  = proj_grabImage(cam);
/*--Break--*/
c3  = proj_grabImage(cam);
/*--Break--*/
c4  = proj_grabImage(cam);
/*--Break--*/
c5  = proj_grabImage(cam);
/*--Break--*/
c6  = proj_grabImage(cam);
/*--Break--*/

a1 = proj_getCenter(back,c1);
a2 = proj_getCenter(back,c2);
a3 = proj_getCenter(back,c3);
a4 = proj_getCenter(back,c4);
a5 = proj_getCenter(back,c5);
a6 = proj_getCenter(back,c6);

/*--Break--*/
data_points = mk_fmat(1..6,1..4);
data_points[1,1] = 4.5;
data_points[1,2] = 11.0;
data_points[1,3] = a1[1];
data_points[1,4] = a1[2];

data_points[2,1] = 4.5;
data_points[2,2] = 20;
data_points[2,3] = a2[1];
data_points[2,4] = a2[2];

data_points[3,1] = -4.5;
data_points[3,2] = 20;
data_points[3,3] = a3[1];
data_points[3,4] = a3[2];

data_points[4,1] = -4.5;
data_points[4,2] = 11;
data_points[4,3] = a4[1];
data_points[4,4] = a4[2];


data_points[5,1] = 0;
data_points[5,2] = 15.5;
data_points[5,3] = a5[1];
data_points[5,4] = a5[2];

data_points[6,1] = 4.5;
data_points[6,2] = 15.5;
data_points[6,3] = a6[1];
data_points[6,4] = a6[2];

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
arr = make_array(9,[
    normalize(PP*cc1),
    normalize(PP*cc2),
    normalize(PP*cc3),
    normalize(PP*cc4),
    normalize(PP*cc5),
    normalize(PP*cc6),
    normalize(PP*cc7),
    normalize(PP*cc8),
    normalize(PP*cc9),
]);
/*--Break--*/
/*multiply the matrix by ccx*/
prtme(arr);




