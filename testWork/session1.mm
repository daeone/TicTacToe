??"proj_";
/*--Break--*/
cam = proj_getCam();
/*--Break--*/
back = proj_grabImage(cam);
proj_writeImage(back,"back");
/*--Break--*/
img1 = proj_grabImage(cam);
proj_writeImage(img1,"img1");
/*--Break--*/
img2 = proj_grabImage(cam);
proj_writeImage(img2,"img2");
/*--Break--*/
img3 = proj_grabImage(cam);
proj_writeImage(img3,"img3");
/*--Break--*/
img4 = proj_grabImage(cam);
proj_writeImage(img4,"img4");
/*--Break--*/
img5 = proj_grabImage(cam);
proj_writeImage(img5,"img5");
/*--Break--*/
img6 = proj_grabImage(cam);
proj_writeImage(img6,"img6");
/*--Break--*/
img7 = proj_grabImage(cam);
proj_writeImage(img7,"img7");
/*--Break--*/
img8 = proj_grabImage(cam);
proj_writeImage(img8,"img8");
/*--Break--*/
img9 = proj_grabImage(cam);
proj_writeImage(img9,"img9");
/*--Break--*/
c1 = proj_getCenter(back,img1);
/*--Break--*/
c2 = proj_getCenter(back,img2);
/*--Break--*/
c3 = proj_getCenter(back,img3);
/*--Break--*/
c4 = proj_getCenter(back,img4);
/*--Break--*/
c5 = proj_getCenter(back,img5);
/*--Break--*/
c6 = proj_getCenter(back,img6);
/*--Break--*/
c7 = proj_getCenter(back,img7);
/*--Break--*/
c8 = proj_getCenter(back,img8);
/*--Break--*/
c9 = proj_getCenter(back,img9);
/*--Break--*/
/*use this to read image*/
h = read_img("/eecs/home/hydramin/Documents/4421/Project/pics/img1.ppm");
gshow(h,:rescale=t);