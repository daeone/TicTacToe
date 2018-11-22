function generate_imgcoords(){
	/*
		To generate the U,V coordinates
			- take the base image and save it in base_img
			- give the object to the arm, have it put the object at a position given
			- get the arm out away
			- take a picture and calculat the center of gravity
			- save the U,V coordinates in the matrix ( write them down for data safety)	
	*/
	
	/* this matrix contains 6 data points [X,Y,u,v]*/
	data_points = mk_fmat(1..6, 1..4);
	
	/*input the X,Y values in the data_points matrix*/
	data_points[1,1] = 14;
	data_points[1,2] = 8;
	
	data_points[2,1] = 11;
	data_points[2,2] = 14;
	
	data_points[3,1] = 7;
	data_points[3,2] = 15;
	
	data_points[4,1] = 0;
	data_points[4,2] = 15;
	
	data_points[5,1] = -10;
	data_points[5,2] = 15;
	
	data_points[6,1] = 15;
	data_points[6,2] =  9;
	
	/*generate the u,v values*/
	/*take the base_img*/	
	
	base_img = get_base_img();
	
	/*give the arm the object and make it take the object to an x,y position for a photo shoot
	==========================================================================================	
	*/
	rob_ready();
	servo_open(30);
	sleep(5);
	servo_close(30);
	/*delivers the object to the x,y position given*/
	CRSinvkin(data_points[1,1], data_points[1,1], 0);
	servo_open(30);	
	ref_img1 = get_base_img();
	/*use base_img and ref_img to calculate a u,v using ass1*/
	pixle_point = diffimgobj(img1,img2);
	/*add this pixle point to the data_points matrix*/
	data_points[1,3] = pixle_point[1];
	data_points[1,4] = pixle_point[2];
	
	/*give the arm the object and make it take the object to an x,y position for a photo shoot
	==========================================================================================	
	*/
	rob_ready();
	servo_open(30);
	sleep(5);
	servo_close(30);
	/*delivers the object to the x,y position given*/
	CRSinvkin(data_points[2,1], data_points[2,1], 0);
	servo_open(30);	
	ref_img1 = get_base_img();
	/*use base_img and ref_img to calculate a u,v using ass1*/
	pixle_point = diffimgobj(img1,img2);
	/*add this pixle point to the data_points matrix*/
	data_points[2,3] = pixle_point[1];
	data_points[2,4] = pixle_point[2];
	
	/*give the arm the object and make it take the object to an x,y position for a photo shoot
	==========================================================================================	
	*/
	rob_ready();
	servo_open(30);
	sleep(5);
	servo_close(30);
	/*delivers the object to the x,y position given*/
	CRSinvkin(data_points[3,1], data_points[3,1], 0);
	servo_open(30);	
	ref_img1 = get_base_img();
	/*use base_img and ref_img to calculate a u,v using ass1*/
	pixle_point = diffimgobj(img1,img2);
	/*add this pixle point to the data_points matrix*/
	data_points[3,3] = pixle_point[1];
	data_points[3,4] = pixle_point[2];
	
	/*give the arm the object and make it take the object to an x,y position for a photo shoot
	==========================================================================================	
	*/
	rob_ready();
	servo_open(30);
	sleep(5);
	servo_close(30);
	/*delivers the object to the x,y position given*/
	CRSinvkin(data_points[4,1], data_points[4,1], 0);
	servo_open(30);	
	ref_img1 = get_base_img();
	/*use base_img and ref_img to calculate a u,v using ass1*/
	pixle_point = diffimgobj(img1,img2);
	/*add this pixle point to the data_points matrix*/
	data_points[4,3] = pixle_point[1];
	data_points[4,4] = pixle_point[2];
	
	/*give the arm the object and make it take the object to an x,y position for a photo shoot
	==========================================================================================	
	*/
	rob_ready();
	servo_open(30);
	sleep(5);
	servo_close(30);
	/*delivers the object to the x,y position given*/
	CRSinvkin(data_points[5,1], data_points[5,1], 0);
	servo_open(30);	
	ref_img1 = get_base_img();
	/*use base_img and ref_img to calculate a u,v using ass1*/
	pixle_point = diffimgobj(img1,img2);
	/*add this pixle point to the data_points matrix*/
	data_points[5,3] = pixle_point[1];
	data_points[5,4] = pixle_point[2];
	
	/*give the arm the object and make it take the object to an x,y position for a photo shoot
	==========================================================================================	
	*/
	rob_ready();
	servo_open(30);
	sleep(5);
	servo_close(30);
	/*delivers the object to the x,y position given*/
	CRSinvkin(data_points[6,1], data_points[6,1], 0);
	servo_open(30);	
	ref_img1 = get_base_img();
	/*use base_img and ref_img to calculate a u,v using ass1*/
	pixle_point = diffimgobj(img1,img2);
	/*add this pixle point to the data_points matrix*/
	data_points[6,3] = pixle_point[1];
	data_points[6,4] = pixle_point[2];
	
};


function diffimgobj(img1,img2)
	"Find the center of gravity of an object denoted by img1 and img2"
{
	/*Take average of the RGB of each image, changes to gray scale*/
	img1 = (img1->r + img1->g + img1->b)/3.0;
	img2 = (img2->r + img2->g + img2->b)/3.0;
	/*Background subtraction between the images*/
	imd = img2-img1;
	/*dot product of the matrix with itself?*/
	imd*=imd;
	gshow(imd,:rescale=t);
	/*makes absolutely no sense*/
	imbin = imd>1500;
	/* same image but the additional image is labeled?*/
	imgcc = con_compon(imbin);
	gshow(imgcc,:rescale=t);

	gg = mk_uctmpl2(-1..1,-1..1,[[1,1,1],[1,1,1],[1,1,1]]);

	imbin1 = imbin(*)gg;
	imbin1 = imbin1(*)gg;
	imbin1 = ~( (~imbin1)(*)gg);
	imbin1 = ~( (~imbin1)(*)gg);
	gshow(imbin1,:rescale=t);

	imbin1 = ~( (~imbin1)(*)gg);
	imbin1 = ~( (~imbin1)(*)gg);
	imbin1 = imbin1(*)gg;
	imbin1 = imbin1(*)gg;
	gshow(imbin1,:rescale=t);

	imgcc = con_compon(imbin1);

	gshow(obj1img = select_iimg(imgcc,1),:rescale = t);

	o1 = to_fimg(obj1img);

	sz = sum_fimg(o1);

	c_x = sum_fimg(o1*x_img(o1->vsize,o1->hsize))/sz;

	c_y = sum_fimg(o1*y_img(o1->vsize,o1->hsize))/sz;

	printf("%d %d\n",c_x,c_y);

	/* Return array with x, y of center of mass */

	mk_fvec(1..2, [c_x, c_y]);
};

function get_base_img()
	"Takes an image of the empty work area"
{
	cam = LT_C920(:file = "/dev/video0");
	/* Move arm out of the way */
	rob_move_abs(0,90,0,0,0);
	sleep(15);
	/* Take image */
	v4l2_streamon(cam);
	base_img=v4l2_grab(cam);
	v4l2_streamoff(cam);
	sleep(2);
	/* Show image to user*/
	gshow(base_img,:rescale=t);
	
	/* return image */
	base_img;
};


