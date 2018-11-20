/* Auth:                                                     hydramin */
/* Date:                                 Mon Nov 19 12:16:19 EST 2018 */
/*--Break--*/
??"rob_";
/*--Break--*/


cam = proj_getCam();
/*--Break--*/
rob_move_abs(-30,0,0,0,0);
/*--Break--*/
rob_init();
/*--Break--*/
??"servo";
/*--Break--*/
servo_open(40);
sleep(5);
servo_close(50);
/*--Break--*/
??"invkin";
/*--Break--*/
CRSinvkin(20,-4.5,0.2);
sleep(5);
CRSinvkin(11,4.5,0.2);
sleep(5);
CRSinvkin(20,4.5,0.2);
sleep(5);
CRSinvkin(11,-4.5,0.2);
/*--Break--*/
??"sqrt";
/*--Break--*/
sqrt(2)*8;
/*--Break--*/
??"proj_";
/*--Break--*/
servo_open(30);
/*--Break--*/
rob_ready();
/*--Break--*/
proj_readyPos();
sleep(10);
proj_writeImage(proj_grabImage(cam),"imgx");
/*--Break--*/
CRSinvkin(0,20,0.4);
servo_open(40);
sleep(10);
servo_close(30);
/*--Break--*/
proj_readyPos();
/*--Break--*/
back = proj_grabImage(cam);
gshow(back,:rescale=t);

/*--Break--*/
img1 = proj_grabImage(cam);
/*--Break--*/
proj_getCenter(back,img1);
/*--Break--*/
proj_camStream(cam);
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
CRSinvkin(18.5,-3,0.3);
sleep(5);
CRSinvkin(12.5,-3,0.3);
sleep(5);
CRSinvkin(15.5,-3,0.3);
sleep(5);

/*--Break--*/
CRSinvkin(10,10,0.2);
/*--Break--*/
servo_close(50);
/*--Break--*/
CRSinvkin(12.5,-3,0.3);
/*--Break--*/
servo_open(30);
/*--Break--*/
servo_close(40);
/*--Break--*/
