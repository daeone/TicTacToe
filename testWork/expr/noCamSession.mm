??"proj_";
/*--Break--*/
back = read_img("/eecs/home/hydramin/Documents/4421/Project/TicTacToe/testWork/exper/back.ppm");
img1 = read_img("/eecs/home/hydramin/Documents/4421/Project/TicTacToe/testWork/exper/img1.ppm");
img2 = read_img("/eecs/home/hydramin/Documents/4421/Project/TicTacToe/testWork/exper/img2.ppm");
img3 = read_img("/eecs/home/hydramin/Documents/4421/Project/TicTacToe/testWork/exper/img3.ppm");
img4 = read_img("/eecs/home/hydramin/Documents/4421/Project/TicTacToe/testWork/exper/img4.ppm");
img5 = read_img("/eecs/home/hydramin/Documents/4421/Project/TicTacToe/testWork/exper/img5.ppm");
img6 = read_img("/eecs/home/hydramin/Documents/4421/Project/TicTacToe/testWork/exper/img6.ppm");
img7 = read_img("/eecs/home/hydramin/Documents/4421/Project/TicTacToe/testWork/exper/img7.ppm");
img8 = read_img("/eecs/home/hydramin/Documents/4421/Project/TicTacToe/testWork/exper/img8.ppm");
img9 = read_img("/eecs/home/hydramin/Documents/4421/Project/TicTacToe/testWork/exper/img9.ppm");
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
/*save all centers in a 3x3 matrix x values separated from y*/
/*refX is a metrix that contains all the x coordinates of the grid center of gravities*/
refX = mk_fmat(1..3,1..3,[
[c1[1],c2[1],c3[1]],
[c4[1],c5[1],c6[1]],
[c7[1],c8[1],c9[1]]
]);

/*refX is a metrix that contains all the x coordinates of the grid center of gravities*/
refX = mk_fmat(1..3,1..3,[
[c1[2],c2[2],c3[2]],
[c4[2],c5[2],c6[2]],
[c7[2],c8[2],c9[2]]
]);

/*use this to read image*/
gshow(img1,:rescale=t);