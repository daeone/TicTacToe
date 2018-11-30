/*Instantiates camera and returns the camera object*/
function proj_getCam(){
	cam = LT_C920(:file = "/dev/video0");
};


/*function that streams live image*/
function proj_camStream(cam){
	v4l2_streamoff(cam);	
	v4l2_streamon(cam);
	for(Tk_Button_Set(:text="Grab1", :bell=t);
    	!Tk_Button_Pressed();
    	gshow(img1=v4l2_grab(cam),:tk_img="ltech",:update_now=t));
	v4l2_streamoff(cam);
	x;
};

/*function grabs an image and returns an image object*/
function proj_grabImage(cam){
	v4l2_streamon(cam);    	
   	img=v4l2_grab(cam);
   	gshow(img,:rescale=t);
	v4l2_streamoff(cam);
	img;
};

/*function inputs an image and displays it*/
function proj_showImage(img){
	gshow(img,:rescale=t);
};

/*function inputs two images and returns x,y of the center of gravity of the new image*/
function proj_getCenter(img1,img2)
	"Find the center of gravity of an object denoted by img1 and img2"
{
    /*gshow(img1,:rescale=t);*/
    /*gshow(img2,:rescale=t);*/
	/*Take average of the RGB of each image, changes to gray scale*/
	img1 = (img1->r + img1->g + img1->b)/3.0;
	img2 = (img2->r + img2->g + img2->b)/3.0;
	/*Background subtraction between the images*/
	imd = img2-img1;
	/*dot product of the matrix with itself?*/
	imd*=imd;
	/*gshow(imd,:rescale=t);*/
	/*makes absolutely no sense*/
	imbin = imd>1500;
	/* same image but the additional image is labeled?*/
	imgcc = con_compon(imbin);
	/*gshow(imgcc,:rescale=t);*/

	gg = mk_uctmpl2(-1..1,-1..1,[[1,1,1],[1,1,1],[1,1,1]]);

	imbin1 = imbin(*)gg;
	imbin1 = imbin1(*)gg;
	imbin1 = ~( (~imbin1)(*)gg);
	imbin1 = ~( (~imbin1)(*)gg);
	/*gshow(imbin1,:rescale=t);*/

	imbin1 = ~( (~imbin1)(*)gg);
	imbin1 = ~( (~imbin1)(*)gg);
	imbin1 = imbin1(*)gg;
	imbin1 = imbin1(*)gg;
	/*gshow(imbin1,:rescale=t);*/

	imgcc = con_compon(imbin1);
	obj1img = select_iimg(imgcc,1);
	
	/*gshow(obj1img,:rescale = t);*/

	o1 = to_fimg(obj1img);

	sz = sum_fimg(o1); 

	c_x = sum_fimg(o1*x_img(o1->vsize,o1->hsize))/sz;

	c_y = sum_fimg(o1*y_img(o1->vsize,o1->hsize))/sz;

	printf("x:%f y:%f\n",c_x,c_y);
	xx = to_int(c_x);
	yy = to_int(c_y);
	obj1img[yy,xx] = 0;
	gshow(obj1img,:rescale=t);
	

	/* Return array with x, y of center of mass */

	mk_fvec(1..2, [c_x, c_y]);
};

function get_base_img(cam)
	"Takes an image of the empty work area"
{
	/* Move arm out of the way */
	rob_move_abs(0,90,0,0,0);
	sleep(5);
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



/*it generates the data_points matrix 6x4 to get the PPinv*/
function calibrateCam(cam)
{
	
	/*To generate the U,V coordinates*/
	/*- take the base image and save it in base_img*/
	/*- give the object to the arm, have it put the object at a position given*/
	/*- get the arm out away*/
	/*- take a picture and calculat the center of gravity*/
	/*- save the U,V coordinates in the matrix ( write them down for data safety)*/

	/* this matrix contains 6 data points [X,Y,u,v]*/
	data_points1 = mk_fmat(1..6, 1..4);
	data_points2 = mk_fmat(1..6, 1..4);	
	data_points3 = mk_fmat(1..6, 1..4);
	
	/*input the X,Y values in the first data_points matrix*/
	data_points1[1,1] = 8.0;
	data_points1[1,2] = 4.5;
	
	data_points1[2,1] = 17.0;
	data_points1[2,2] = 4.5;
	
	data_points1[3,1] = 17.0;
	data_points1[3,2] = -4.5;
	
	data_points1[4,1] = 8.0;
	data_points1[4,2] = -4.5;
	
	data_points1[5,1] = 12.5;
	data_points1[5,2] = 0;
	
	data_points1[6,1] = 12.5;
	data_points1[6,2] = 4.5;

	
	all_data = mk_fmat(1..18,1..4);
	all_data[1..6,1..4] = data_points1;

	
	/*generate the u,v values*/
	/*take the base_img*/	
	
	rob_move_abs(0,90,0,0,0);
	sleep(7);
	base_img = proj_grabImage(cam);
	
	/*go to the base position and grab the object*/
	CRSinvkin (0, -15, 1);
	sleep(3);
	servo_close(50);
	sleep(3);
	rob_move_abs(0,90,0,0,0);
	sleep(3);
	
	for(i=1; i<=6;i++)
	{	 
	    /*delivers the object to the x,y position given*/
	    CRSinvkin(all_data[i,1], all_data[i,2], 1);
	    /*sleep(4);*/
	    servo_open(50);
	    sleep(3);
	    rob_move_abs(0,90,0,0,0);
	    sleep(6);
	    img2 = proj_grabImage(cam);
	    
	    /*use base_img and ref_img to calculate a u,v using ass1*/
	    pixle_point = proj_getCenter(base_img,img2);

	    /*add this pixle point to the data_points matrix*/
	    all_data[i,3] = pixle_point[1];
	    all_data[i,4] = pixle_point[2];

	    /*go to where the object is, grab it and return to the ready position*/
	    CRSinvkin(all_data[i,1], all_data[i,2], 1);
	    servo_open(50);
	    sleep(3);
	    servo_close(50);
	    sleep(3);
	};
	
	/* go to base position*/
	CRSinvkin (0, -15, 1);
	
	pinv1 = cameraMat(all_data[1..6,1..4]);
	pinv1;
	
	
};

/* takes four values u,v,X,Y and returns the matrix AAi  */
function amat(X,Y,u,v)
{ 
	AAi = mk_fmat(1..3,1..9);

	AAi[1,4] = -X;
	AAi[1,5] = -Y;
	AAi[1,6] = -1;
	AAi[1,7] = v * X;
	AAi[1,8] = v * Y;
	AAi[1,9] = v;
	AAi[2,1] = X;
	AAi[2,2] = Y;
	AAi[2,3] = 1;
	AAi[2,7] = -u * X;
	AAi[2,8] = -u * Y;
	AAi[2,9] = -u;
	AAi[3,1] = -v * X;
	AAi[3,2] = -v * Y;
	AAi[3,3] = -v;
	AAi[3,4] = u * X;
	AAi[3,5] = u * Y;
	AAi[3,6] = u;
	
	AAi;
};


/* Takes n * 4 matrix, each row contains value for X,Y,u,v and returns camera matrix PPinv (3x3)*/
function cameraMat(m)
{
	avec = mk_fvec(3*9*m->vsize);
	amat(m[1,1],m[1,2],m[1,3],m[1,4]);
	cmat = AAi;
	
	for (i=2; i < m->vsize+1; i++)
	{
		amat(m[i,1],m[i,2],m[i,3],m[i,4]);
		cmat = cmat <|> AAi;
	
	};
	svd = SVD(cmat^T*cmat);

	p = svd[3][1..svd[3]->vsize,minind_fvec(svd[2])];
	pmat = unstack_vec(p,3,3);
	pmat = pmat^T;
	inner_prtMat(pmat);
	pinv = inverse_mat(pmat);
	pinv;
};


/* Given an image point (x and y) and camera matrix, return the corresponding real world position vector */  
function findWorldPosition(x,y,PP)
{
	ivec = mk_fvec(1..3, [x,y,1]);
	pvec = PP * ivec;
	pvec = normalizeVec(pvec);
	pvec;
};


/*function takes a list and displays the content*/
function proj_prtList(list){	

	for(x=1;x<=list->vsize;x++){
   	printf("=> %d\n",list[x]);
   };
};

/*given 2 3x3 matrices for the center of gravities, print them merged*/
function proj_prtCenters(xm,ym){
    for(i=1;i<=3;i++){
        for(j=1;j<=3;j++){
            printf("(%.2f,%.2f) ",xm[i,j],ym[i,j]);
        };
        printf("\n");
    };
};


/*given a distance matrix 3x3, outputs the entry index as vector (r,c) with the min value*/
function proj_getMinIndex(mat){
    index = mk_ivec(1..2,[0,0]);
    min = mat[1,1];
    for(i = 1;i<=3;i++){
        for(j = 1;j<=3;j++){
           if(mat[i,j] < min){
                min = mat[i,j];
                index[1] = i;
                index[2] = j;
           }; 
        };
    };
    index;
};


function inner_prtMat(mat){
    for(i=1;i<=mat->vsize;i++){
        for(j=1;j<=mat->hsize;j++){
            printf("%.2f ",mat[i,j]);
        };
        printf("\n");
    };
    0;
};

function normalizeVec(v){
    f = mk_fvec(1..3);
    f = v/v[3];
    f;
};

/*generates a 3x3 square matrix filled with the input param*/
function inner_fillMat(x){
    mat = mk_fmat(1..3,1..3,[[x,x,x],[x,x,x],[x,x,x]]);
};

/*G is a 9x2 matrix that holds ref values, vector <x,y> are the newly identified real world points*/
/*x,y are obtained from the matrix calibration*/
/*it spits out the index (1 .. 9) of where the min value was found*/
function proj_minDistIndex(pt, G)
{
    x = pt[1];
    y = pt[2];
    c = mk_fvec(9);
    cx=(G[1..9,1] - x);
    cy=(G[1..9,2] - y);
    for(i=1;i< 10; i++){
        a = cx[i]^2;
        b = cy[i]^2;
        c[i] = sqrt(a+b);
    };
    gridPosition = minind_fvec(c);
    gridPosition;
};

/*--------------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------------*/

function radtoDegree(rad)
{
	degree = rad * (180/PI);

};
function CRSinvkin(x,y,zz)
{
	l0 = 10;
	l1 = 10.5;
	l2 = 10;
	l3 = 6.5;
	
	X = x;
	Y = y;	
	z = zz + l3-l0;	
	R = sqrt(x^2 + y^2);
	r = x^2 + y^2 + z^2;
	th1 = atan2(y/R, x/R);
	
	th3 = acos((r - l2^2 - l1^2)/(2*l2*l1));
	
	v1 = z^2 * l2^2 * cos(th3)^2 - l2^2 * z^2 + l2^4 * sin(th3)^2 + 2 * l2^3 * cos(th3) * l1 * sin(th3)^2 + l1^2 * l2^2 * sin(th3)^2;
	v2 = l2^2 + 2 * l2 * cos(th3)*l1 + l1^2;

	th2v1 = atan2((2*z*l1 + 2*z*l2*cos(th3) + 2*sqrt(v1)) / (2*v2),(-z + ((l2*cos(th3) + l1)*(2*l1*z + 2*z*l2*cos(th3) + 2 *sqrt(v1)))/(2*v2))/ (l2*sin(th3)));
	
	th2v2 = atan2((2*z*l1 + 2*z*l2*cos(th3) - 2*sqrt(v1)) / (2*v2),(-z + ((l2*cos(th3) + l1)*(2*l1*z + 2*z*l2*cos(th3) - 2 *sqrt(v1)))/(2*v2))/ (l2*sin(th3)));
	

	if (th2v1 < 0)
	{
		th2 = th2v2;	
	}
	else 
	{
		th2 = th2v1;	
	};
	
	theta1 = radtoDegree(th1);
	theta2 = radtoDegree(th2);
	theta3 = radtoDegree(th3);
	theta4 = theta2 - theta3 + 90;	
	printf("%f %f %f %f\n", theta1, theta2,theta3, theta4);
	
	flag = 0;
	if(theta2 > 110)
	{
	printf("theta 2 ANGLE EXCEEDED: %f\nROBOT WILL NOT MOVE\n", theta2);
	flag = 1;
	};	
	if(theta3 > 125)
	{
	printf("theta 3 ANGLE EXCEEDED: %f\nROBOT WILL NOT MOVE\n", theta3);
	flag = 1;
	};	


	if(flag != 1)
	{	
		sleep(2);
		/*rob_move_abs(0,48.3,104.83,33.48,0);*/
		/*rob_move_abs(theta1,60,40,0,0);*/
		/*sleep(2);*/
		rob_move_abs(theta1,theta2,theta3,theta4,0);
		sleep(4);
		flag = 0;	
	};

};
