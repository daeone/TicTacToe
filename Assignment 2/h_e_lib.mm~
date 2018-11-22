
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

	xx = to_int(c_x);
	yy = to_int(c_y);
	printf("%d %d\n",xx,yy);

	/* Return array with x, y of center of mass */

	mk_fvec(1..2, [c_x, c_y]);
};

function CRSinvkin(y,x,z)
	"Move CRS PLUS robot arm to the position denoted by x, y, z	"
{
	/*Ensure that the arm is in a default state*/
	rob_ready();
	
	/*Most of these values are estimates from trial and error*/
	L1 = 10;
	L2 = 10;
	L3 = 10;
	L4 = 6.8;
	
	/*R is the vector from the origin to the desired location of {4}*/
	R = x^2 + y^2 + z^2;
	
	/*z must be adjusted to account for the height of the arm from the table and the length of the end effector*/
	/* z is made negative because for some reason, a positive z does not work*/
	/*may be due to the ordering of atan2*/
	z = -(z + (-L1 + L4));
	y = -y;
	
	temp_D = (R - L3^2 - L2^2)/(2*L3*L2);
	rad_Th1 = atan2(y, x);
	rad_Th3 = atan2(sqrt(1 - temp_D^2), temp_D);
	rad_Th2 = atan2(sqrt(x^2+y^2), z) - atan2(L2 + L3* cos(rad_Th3), L3*sin(rad_Th3));
 	
	f_Th1 = rad_to_deg(rad_Th1);
	f_Th2 = rad_to_deg(rad_Th2);
	f_Th3 = rad_to_deg(rad_Th3);
	
	/*if Theta2 is negative, the arm joint would have to bend up. the CRS PLUS has not been designed with this feature in mind */
	/*In this case, Theta2 and Theta3 must be recalculated (with the second solution for Theta3)*/
	if (f_Th2 < 0){
		rad_Th3 = atan2(-sqrt(1-temp_D^2), temp_D);
		rad_Th2 = atan2(sqrt(x^2+y^2), z) - atan2(L2 + L3* cos(rad_Th3), L3*sin(rad_Th3));
		f_Th2 = rad_to_deg(rad_Th2);
		f_Th3 = rad_to_deg(rad_Th3);
	};
	
	/*Wrist must always be facing straight down, similar to a claw machine*/
	wrist = (f_Th2 - f_Th3) + 90;
	
	/*Move arm to specified location and activate the end effector*/
	rob_move_abs(f_Th1, f_Th2, f_Th3, wrist, 0); 
};

function rad_to_deg(val1)
	"Convert Radians to Degrees"
{
	val1 * (180 / PI);
};

function norm_vec(vec)
	"returns the normalized vector created from vec"
{
	vec /= vec[vec->vsize];
};

function abs(val)
	"Find absolute value"
{
	sqrt((val)^2);
};

function print_fmat(mat, name)
	"Print formated fmat"
{
	height = mat->vsize;
	width = mat->hsize;
	
	for (i = 1; i <= height; i++){
		for (j = 1; j <= width; j++){
			printf("%s[%d, %d] = %.3f ", name, i, j, mat[i,j]);
		};
		printf("\n");
	};	
};

function print_fvec(vec, name)
	"Print formated fvec"
{
	height = vec->vsize;
	for (i = 1; i <= height; i++){
			printf("%s[%d] = %.6f\n", name, i, vec[i]);
	};
};

function get_base_img(cam)
	"Takes an image of the empty work area"
{
	/* Move arm out of the way */
	CRSinvkin (-6, 6, 13);
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

function get_obj_cord(cam, base_img, x, y, z)
	"Gets camera and world coordinates by moving an object attached to the robot arm"
{
	
	
	/* Move robot arm to specified location and drop object */
	CRSinvkin(x, y, z);
	sleep(5);
	servo_open(50); 
	sleep(3);

	/* Get Arm out of the frame */
	CRSinvkin (-6, 6, 13);
	sleep(10);

	/* Take image of object */
	v4l2_streamon(cam);
	img1=v4l2_grab(cam);
	v4l2_streamoff(cam);
	gshow(img1,:rescale=t);
	
	/* Pick up object and return to neutral position */
	CRSinvkin(x, y, z);
	sleep(6);
	servo_close(50);
	sleep(4); 
	rob_ready(); 
	
	/* find center of mass for the object and return its x,y */
	cMass = diffimgobj(img1,base_img);
	cMass;
};

function get_calibration_matrix(u, v, X, Y) 
	"Compute a calibration array from the real world coordinates (X, Y, Z) and the image plane coordinates (u, v) of an object"
{
	AA = mk_fmat(1..3, 1..9);
	
	/* Z is set to 0 since all objects are assumed to be flat on the base */
	Z = 0;

	/* Initialize all matrix slots to 0 */
	for (yy=1; yy <= 3; yy++){
		for (xx = 1; xx <= 9; xx++){
			AA[yy,xx] = 0;
		};
	};

	AA[1,4] = -X;
	AA[1,5] = -Y;
	AA[1,6] = -1;
	AA[1,7] = v * X;
	AA[1,8] = v * Y;
	AA[1,9] = v;
	
	AA[2,1] = X;
	AA[2,2] = Y;
	AA[2,3] = 1;
	AA[2,7] = -u * X;
	AA[2,8] = -u * Y;
	AA[2,9] = -u;
	
	AA[3,1] = -v * X;
	AA[3,2] = -v * Y;
	AA[3,3] = -v;
	AA[3,4] = u * X;
	AA[3,5] = u * Y;
	AA[3,6] = u;

	/* return AA array */
	AA;
};

function generate_PP(input_mat)
	"Generate bold P matrix from an matrix of calibration points. input_mat = matrix of 6 or more calibration pairs <u, y, X, Y>"
{
	/* Create a large array of calibration matrices using the input point pairs */
	/* These calibration matrices are then stacked on top of each other */
	for (i = 1; i <= input_mat->vmax; i++){
		printf("populating mstack:   %d / %d\n", i, input_mat->vmax);
		
		u = input_mat[i, 1];
		v = input_mat[i, 2];
		X = input_mat[i, 3];
		Y = input_mat[i, 4];

		if (i <= 1){
			mstack = get_calibration_matrix(u, v, X, Y); 
		}
		
		else {
			mstack = mstack <|> get_calibration_matrix(u, v, X, Y);
		};
	};
	
	/* perform the Single Value Decomposition on the combined array */
	svd_mat = SVD(mstack);
	printf("svd_mat created\n");
	
	/* Find the min value of the vector in svd_mat[2] */
	e_vec = svd_mat[2];
	vT = svd_mat[3];
	printf("svd_mat separated\n");
	
	min_val = e_vec[1];
	min_index = 1;
	for (i = 2; i <= e_vec->vmax; i++){
		if (e_vec[i] < min_val){
			min_val = e_vec[i];
			min_index = i;
		};
	};
	
	tmp_col = vT[1..vT->vsize, min_index];
	
	PP = mk_fmat(1..3, 1..3);
	
	c = 0;
	for (i = 1; i <= 3; i++){
		for (j = 1; j <= 3; j++){
			c += 1;
			printf("adding tmp_col[%d] to PP [%d,%d]\n", c, i, j);
			PP[i, j] = tmp_col[c];
		};
	};
	PP;
};



function get_cord_pairs(cam, base_img){
	cord_mat = mk_fmat(1..6, 1..4);
	
	temp_vec = mk_fvec(1..2);
	
	cord_mat[2, 1] = 10.8;
	cord_mat[2, 2] = 8;
	temp_vec = get_obj_cord (cam, base_img, 10.8, 8, 0); 
	cord_mat[2, 3] = temp_vec[1];
	cord_mat[2, 4] = temp_vec[2];
	
	cord_mat[3, 1] = 10.2;
	cord_mat[3, 2] = 10.5;
	temp_vec = get_obj_cord (cam, base_img, 10.2, 10.5, 0);
	cord_mat[3, 3] = temp_vec[1];
	cord_mat[3, 4] = temp_vec[2];
	
	cord_mat[1, 1] = 7;
	cord_mat[1, 2] = 10.5;
	temp_vec = get_obj_cord (cam, base_img, 7, 10.5, 0); 
	cord_mat[1, 3] = temp_vec[1];
	cord_mat[1, 4] = temp_vec[2];
	
	cord_mat[4, 1] = 0;
	cord_mat[4, 2] = 10.5;
	temp_vec = get_obj_cord (cam, base_img, 0, 10.5, 0) ;
	cord_mat[4, 3] = temp_vec[1];
	cord_mat[4, 4] = temp_vec[2];
	
	cord_mat[5, 1] = -10;
	cord_mat[5, 2] = 10;
	temp_vec = get_obj_cord (cam, base_img, -10, 10, 0); 
	cord_mat[5, 3] = temp_vec[1];
	cord_mat[5, 4] = temp_vec[2];
	
	cord_mat[6, 1] = -10.3;
	cord_mat[6, 2] = 9;
	temp_vec = get_obj_cord (cam, base_img, -10.3, 9, 0); 
	cord_mat[6, 3] = temp_vec[1];
	cord_mat[6, 4] = temp_vec[2];
	
	/* Let go of object once calibration is done */
	servo_open(30);
	
	PP = generate_PP(cord_mat);
	
};

function pick_up_obj(cam, base_img, inv_PP)
	"CRS arm detects an object that is placed on the workbench and picks it up. Requires a connection to a web cam, an image of the empty workspace, and an calibrated inverted projection matrix "
{
	/* Move arm out of the way */
	CRSinvkin (-6, 6, 13);
	sleep(15);

	/* Take image */
	v4l2_streamon(cam);
	img1=v4l2_grab(cam);
	v4l2_streamoff(cam);
	sleep(2);

	/* Find pixel location for object in the image */
	img_vec = diffimgobj(base_img,img1);
	world_vec = inv_PP * img_vec;
	n_World_vec = norm_vec(world_vec);
	X = n_World_vec[1];
	Y = n_World_vec[2];

	/* Warn passers by */
	printf("Watch out! Robot on the move");
	sleep(3);
	
	/* Move robot to <X, Y, 0> */	
	CRSinvkin (X, Y, 0);
	sleep(5);
	
	/* Pick up  */
	servo_close(50);
	sleep(5);
	
	/* Present the object */
	rob_ready();

};

function test_c ()
	"temp function used to test implemented logic"
{
	
	/* generate vector of random points, order <u, v, X, Y> */
	cord_mat = mk_fmat(1..6, 1..4);
	
	g_PP = rand_fmat(1..3, 1..3);
	g_PP /= g_PP[3,3];

	for (i = 1; i <= 6; i++){
		printf("populating cord_mat:   %d / 6\n", i);
	
		/* generates the X and Y of the real world plane */
		rand_W_vec = rand_fvec(3);
		r_W = norm_vec(rand_W_vec);
		
		/* generates the u and v of the image plane */
		rand_img_vec = g_PP*rand_W_vec;
		r_i = norm_vec(rand_img_vec);
		
		/*row = r_i^T <-> r_W^T; cord_vec [i] = row ;*/
		
		cord_mat[i, 1] = r_i[1];
		cord_mat[i, 2] = r_i[2];
		cord_mat[i, 3] = r_W[1];
		cord_mat[i, 4] = r_W[2];
	};
	
	printf("_____________________\n");
	
	PP = generate_PP(cord_mat);

	norm_PP = PP / PP[PP->vsize, PP->hsize];
	
	/* Test input values with result */
	
	inv_PP = inverse_mat(PP);

	norm_inv_PP = inv_PP / inv_PP[inv_PP->vsize, inv_PP->hsize];

	printf("\n\n______Cam to World_______\n\n");
	for (i = 1; i <= 6; i++){
		cam_cord = mk_fvec(1..3,[cord_mat[i, 1], cord_mat[i, 2], 1]);
		result = norm_inv_PP * cam_cord;
		result = norm_vec(result);
		printf("_____________________\n");
		printf("res_X = %f\tres_Y = %f\nreal_X = %f\treal_Y = %f\n", result[1] ,result[2] ,cord_mat[i, 3],cord_mat[i, 4]);
	};
	
	printf("\n\n______World to Cam_______\n\n");
	for (i = 1; i <= 6; i++){
		world_cord = mk_fvec(1..3,[cord_mat[i, 3], cord_mat[i, 4], 1]);
		result = norm_PP * world_cord;
		result = norm_vec(result);
		printf("_____________________\n");
		printf("res_X = %f\tres_Y = %f\nreal_X = %f\treal_Y = %f\n", result[1] ,result[2] ,cord_mat[i, 1],cord_mat[i, 2]); 
	};

	printf("_____________________\n\n");
	n_PP = norm_PP - g_PP;

	print_fmat(n_PP, "n_PP");
};


