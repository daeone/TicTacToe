/* Auth:                                                     hydramin */
/* Date:                                 Tue Nov 20 17:27:36 EST 2018 */
/*--Break--*/

??"proj_";
/*--Break--*/
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
/*--Break--*/

proj_showImage(img4);
/*--Break--*/
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
/*--Break--*/

c1[1];
/*--Break--*/
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

/*use this to read image*/
gshow(img1,:rescale=t); 

/*--Break--*/

/*the robot must detect where the next player moved his/her piece*/
/*robot moves first, and takes a picture: 1.ppm*/
/*human moves and tells the robot to make next move*/
/*robot takes a picture and finds the center of gravity of the new obj*/
/*robot compares this point to the 9 points to determine the one closest*/
/*then it marks it in a separate matrix*/

/*read the experimental pictures in: if robot starts only 1 and 2 are required*/
back = read_img("/eecs/home/hydramin/Documents/4421/Project/TicTacToe/testWork/expr_robodetect/back.ppm");
m1 = read_img("/eecs/home/hydramin/Documents/4421/Project/TicTacToe/testWork/expr_robodetect/1m.ppm");
m2 = read_img("/eecs/home/hydramin/Documents/4421/Project/TicTacToe/testWork/expr_robodetect/2m.ppm");
/*--Break--*/

proj_showImage(m1);
proj_showImage(m2);
/*--Break--*/
m3 = read_img("/eecs/home/hydramin/Documents/4421/Project/TicTacToe/testWork/expr_robodetect/3m.ppm");
m4 = read_img("/eecs/home/hydramin/Documents/4421/Project/TicTacToe/testWork/expr_robodetect/4m.ppm");
m5 = read_img("/eecs/home/hydramin/Documents/4421/Project/TicTacToe/testWork/expr_robodetect/5m.ppm");
/*--Break--*/
/*find the center of gravity of the new object in m2 comparing to m1*/
c = proj_getCenter(m1,m2);
/*--Break--*/
proj_prtCenters(refX,refY);
/*--Break--*/
inner_prtMat(refX);

/*--Break--*/
inner_prtMat(refY);
/*--Break--*/
dist = proj_getDistance(refX,refY,c);
/*--Break--*/
index = proj_getMinIndex(dist);
/*--Break--*/
??"array";
/*--Break--*/
arr = make_array(3,"p");
/*--Break--*/
arr[1]=back;
arr[2] = m1;
arr[3] = m2;
/*--Break--*/
gshow(arr[1],:rescale=t);
/*--Break--*/
arr[1][1];
/*--Break--*/
arr[2];
/*--Break--*/
arr[3][2,2];
/*--Break--*/
