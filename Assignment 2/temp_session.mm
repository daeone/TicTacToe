/* Auth:                                                     andres15 */
/* Date:                                 Sat Nov 03 16:57:21 EDT 2018 */
/*--Break--*/
rob_init();
/*--Break--*/


cam = LT_C920(:file = "/dev/video0");
/*--Break--*/
v4l2_streamon(cam);
for(Tk_Button_Set(:text="Grab1", :bell=t);
    !Tk_Button_Pressed();
    gshow(img1=v4l2_grab(cam),:tk_img="ltech",:update_now=t));
v4l2_streamoff(cam);
/*--Break--*/
v4l2_streamon(cam);
for(Tk_Button_Set(:text="Grab2", :bell=t);
    !Tk_Button_Pressed();
    gshow(img2=v4l2_grab(cam),:tk_img="ltech",:update_now=t));
v4l2_streamoff(cam);
/*--Break--*/
cam = LT_C920(:file = "/dev/video1");
/*--Break--*/
rob_ready();
/*--Break--*/
servo_close(30);
/*--Break--*/


servo_open(30);
/*--Break--*/
get_obj_cord(cam, 9, -12, 0);
/*--Break--*/
CRSinvkin(10, -15, 0);
/*--Break--*/
diffimgobj(img1, img2);
/*--Break--*/
 bP=get_calibration_matrix(175, 319, 9, -12);
/*--Break--*/

printf("%d\n",yy);
/*--Break--*/
printf("%f, ", 
/*--Break--*/
]);
/*--Break--*/

    printf("lll\n");
/*--Break--*/



/*--Break--*/
for (yy=1; yy <= 3; yy++) {
		for (xx = 1; xx <= 9; xx++){
			printf("%9.2f, ", AA[yy,xx]);
		};
    printf("lll\n");
	};
/*--Break--*/
yy;
/*--Break--*/
printf("%f\n",3);
/*--Break--*/
 AA[1, 4];

/*--Break--*/
t=rand_fvec(3);
/*--Break--*/
for (i=1; i <= 3; i++) {
    printf("%f\n",t[i]);
};
/*--Break--*/
??"stack";
/*--Break--*/
text_c();
/*--Break--*/
mmm=rand_fmat(3,3)<|>rand_fmat(3,3);
/*--Break--*/
mmm->vmax;
/*--Break--*/
mmm->hmax;
/*--Break--*/
