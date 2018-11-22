/* Auth:                                                     andres15 */
/* Date:                                 Wed Nov 07 16:46:18 EST 2018 */
/*--Break--*/
cam = LT_C920(:flie = "/dev/video0");
/*--Break--*/
rob_ready();

/*--Break--*/
rob_init();
/*--Break--*/
servo_close(50);
/*--Break--*/
base_img = get_base_img(cam);
/*--Break--*/
get_cord_pairs(cam, base_img);
/*--Break--*/
servo_open(40);
/*--Break--*/
