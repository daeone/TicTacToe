/* Auth:                                                     hydramin */
/* Date:                                 Thu Nov 15 13:58:09 EST 2018 */
/*--Break--*/
??"proj_";
/*--Break--*/
cam = proj_getCam();
/*--Break--*/
proj_camStream(cam);
/*--Break--*/
img1 = proj_grabImage(cam);
/*--Break--*/
proj_showImage(img1);
/*--Break--*/
img2 = proj_grabImage(cam);
/*--Break--*/
??"loop";
/*--Break--*/
list = proj_getCenter(img1,img2);
/*--Break--*/
