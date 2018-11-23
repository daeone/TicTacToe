/*This session is a sample game only using images, because the camera is giving bad images*/

/*play starts and the camera-robot system is calibrated below*/

/*make a 6x4 matrix that holds the calibration points*/
calibPoints = mk_fmat(1..6,1..4);
tmp_xvec = mk_fvec(1..6,[11,10,10,11,15.5,15.5]);
tmp_yvec = mk_fvec(1..6,[4.5,4.5,-4.5,-4.5,0,4.5]);
calibPoints[1..6,1] =  tmp_xvec;
calibPoints[1..6,2] =  tmp_yvec;

/*the play starts robot makes first move and took a picture*/
m1 = read_img("/eecs/home/hydramin/Documents/4421/Project/TicTacToe/testWork/expr_robodetect/1m.ppm");

/*the player moved, and alerted the robot to make next move, the robot starts by taking a picture*/
m2 = read_img("/eecs/home/hydramin/Documents/4421/Project/TicTacToe/testWork/expr_robodetect/2m.ppm");

/*now the robot analyzes the picture with background subtraction and determines a pixle location*/
/*a reference matrix that contains the center of gravities of the pixel locations is needed*/
/*--------------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------------*/
/*Generates the reference matrix for the center of gravities*/
/*--------------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------------*/
back = read_img("/eecs/home/hydramin/Documents/4421/Project/TicTacToe/testWork/exper/back.ppm");
img1 = read_img("/eecs/home/hydramin/Documents/4421/Project/TicTacToe/testWork/exper/img1.ppm");
img2 = read_img("/eecs/home/hydramin/Documents/4421/Project/TicTacToe/testWork/exper/img22.ppm");
img3 = read_img("/eecs/home/hydramin/Documents/4421/Project/TicTacToe/testWork/exper/img3.ppm");
img4 = read_img("/eecs/home/hydramin/Documents/4421/Project/TicTacToe/testWork/exper/img44.ppm");
img5 = read_img("/eecs/home/hydramin/Documents/4421/Project/TicTacToe/testWork/exper/img5.ppm");
img6 = read_img("/eecs/home/hydramin/Documents/4421/Project/TicTacToe/testWork/exper/img6.ppm");
img7 = read_img("/eecs/home/hydramin/Documents/4421/Project/TicTacToe/testWork/exper/img7.ppm");
img8 = read_img("/eecs/home/hydramin/Documents/4421/Project/TicTacToe/testWork/exper/img8.ppm");
img9 = read_img("/eecs/home/hydramin/Documents/4421/Project/TicTacToe/testWork/exper/img9.ppm");

/*calculate centers of gravities of the centers of all the grids*/
c1 = proj_getCenter(back,img1);
c2 = proj_getCenter(back,img2);
c3 = proj_getCenter(back,img3);
c4 = proj_getCenter(back,img4);
c5 = proj_getCenter(back,img5);
c6 = proj_getCenter(back,img6);
c7 = proj_getCenter(back,img7);
c8 = proj_getCenter(back,img8);
c9 = proj_getCenter(back,img9);

/*save all centers in a 3x3 matrix x values separated from y*/
/*refX is a metrix that contains all the x coordinates of the grid center of gravities*/
refX = mk_fmat(1..3,1..3,[
[c1[1],c2[1],c3[1]],
[c4[1],c5[1],c6[1]],
[c7[1],c8[1],c9[1]]
]);

/*refX is a metrix that contains all the x coordinates of the grid center of gravities*/
refY = mk_fmat(1..3,1..3,[
[c1[2],c2[2],c3[2]],
[c4[2],c5[2],c6[2]],
[c7[2],c8[2],c9[2]]
]);

/*--------------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------------*/

/*robot uses picture from move1, and move2 (m1 and m2) finds the center of gravity of the new object placed by the human player*/
c = proj_getCenter(m1,m2);
minDistMat = proj_getDistance(refX,refY,c);
boxLocationIndex = proj_getMinIndex(minDistMat);





