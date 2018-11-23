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
	CRSinvkin(15.5,0,6);
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


function generate_imgcoords()
{
	
	/*To generate the U,V coordinates*/
	/*- take the base image and save it in base_img*/
	/*- give the object to the arm, have it put the object at a position given*/
	/*- get the arm out away*/
	/*- take a picture and calculat the center of gravity*/
	/*- save the U,V coordinates in the matrix ( write them down for data safety)*/

	/* this matrix contains 6 data points [X,Y,u,v]*/
	data_points = mk_fmat(1..6, 1..4);
	
	/*input the X,Y values in the data_points matrix*/
	data_points[1,1] = 11;
	data_points[1,2] = 4.5;
	
	data_points[2,1] = 20;
	data_points[2,2] = 4.5;
	
	data_points[3,1] = 20;
	data_points[3,2] = -4.5;
	
	data_points[4,1] = 11;
	data_points[4,2] = -4.5;
	
	data_points[5,1] = 15.5;
	data_points[5,2] = 0;
	
	data_points[6,1] = 15.5;
	data_points[6,2] = 4.5;
	
	/*generate the u,v values*/
	/*take the base_img*/	
	
	base_img = get_base_img();
	
	/*give the arm the object and make it take the object to an x,y position for a photo shoot*/
	servo_open(30);	
	sleep(2);
	CRSinvkin(15.5,0,1);
	sleep(3);
	servo_close(30);
	/*delivers the object to the x,y position given*/
	CRSinvkin(data_points[1,1], data_points[1,2], 1);
	servo_open(30);
	CRSinvkin(15.5,0,6);	
	img2 = proj_grabImage;
	/*use base_img and ref_img to calculate a u,v using ass1*/
	pixle_point = diffimgobj(base_img,img2);
	/*add this pixle point to the data_points matrix*/
	data_points[1,3] = pixle_point[1];
	data_points[1,4] = pixle_point[2];
	
	base_img = img2;
	
	/*give the arm the object and make it take the object to an x,y position for a photo shoot*/
	CRSinvkin(data_points[1,1], data_points[1,2], 1);
	sleep(3);
	servo_close(30);
	/*delivers the object to the x,y position given*/
	CRSinvkin(data_points[2,1], data_points[2,2], 1);
	servo_open(30);
	sleep(3);
	CRSinvkin(15.5,0,6);	
	img2 = proj_grabImage;
	/*use base_img and ref_img to calculate a u,v using ass1*/
	pixle_point = diffimgobj(base_img,img2);
	/*add this pixle point to the data_points matrix*/
	data_points[2,3] = pixle_point[1];
	data_points[2,4] = pixle_point[2];
	
	base_img = img2;

	/*give the arm the object and make it take the object to an x,y position for a photo shoot*/
	CRSinvkin(data_points[2,1], data_points[2,2], 1);
	sleep(3);
	servo_close(30);
	/*delivers the object to the x,y position given*/
	CRSinvkin(data_points[3,1], data_points[3,2], 1);
	servo_open(30);	
	sleep(3);
	CRSinvkin(15.5,0,6);	
	img2 = proj_grabImage;
	/*use base_img and ref_img to calculate a u,v using ass1*/
	pixle_point = diffimgobj(base_img,img2);
	/*add this pixle point to the data_points matrix*/
	data_points[3,3] = pixle_point[1];
	data_points[3,4] = pixle_point[2];
	
	base_img = img2;	
	
	/*give the arm the object and make it take the object to an x,y position for a photo shoot*/
	CRSinvkin(data_points[3,1], data_points[3,2], 1);
	sleep(3);
	servo_close(30);
	/*delivers the object to the x,y position given*/
	CRSinvkin(data_points[4,1], data_points[4,2], 1);
	servo_open(30);
	sleep(3);
	CRSinvkin(15.5,0,6);	
	img2 = proj_grabImage;
	/*use base_img and ref_img to calculate a u,v using ass1*/
	pixle_point = diffimgobj(base_img,img2);
	/*add this pixle point to the data_points matrix*/
	data_points[4,3] = pixle_point[1];
	data_points[4,4] = pixle_point[2];
	
	base_img = img2;

	/*give the arm the object and make it take the object to an x,y position for a photo shoot*/
	CRSinvkin(data_points[3,1], data_points[3,2], 1);
	sleep(3);
	servo_close(30);
	/*delivers the object to the x,y position given*/
	CRSinvkin(data_points[4,1], data_points[4,2], 1);
	servo_open(30);
	sleep(3);
	CRSinvkin(15.5,0,6);	
	img2 = proj_grabImage;
	/*use base_img and ref_img to calculate a u,v using ass1*/
	pixle_point = diffimgobj(base_img,img2);
	/*add this pixle point to the data_points matrix*/
	data_points[5,3] = pixle_point[1];
	data_points[5,4] = pixle_point[2];
	
	base_img = img2;

	/*give the arm the object and make it take the object to an x,y position for a photo shoot*/	
	CRSinvkin(data_points[3,1], data_points[3,2], 1);
	sleep(3);
	servo_close(30);
	/*delivers the object to the x,y position given*/
	CRSinvkin(data_points[4,1], data_points[4,2], 1);
	servo_open(30);
	sleep(3);
	CRSinvkin(15.5,0,6);	
	img2 = proj_grabImage;
	/*use base_img and ref_img to calculate a u,v using ass1*/
	pixle_point = diffimgobj(base_img,img2);
	/*add this pixle point to the data_points matrix*/
	data_points[6,3] = pixle_point[1];
	data_points[6,4] = pixle_point[2];
	
};

function generate_PP(input_mat)"Generate bold P matrix from an matrix of calibration points. input_mat = matrix of 6 or more calibration pairs <u, y, X, Y>"
{
	/* Create a large array of calibration matrices using the input point pairs */
	/* These calibration matrices are then stacked on top of each other */
	for (i = 1; i <= input_mat->vmax; i++){
		
		u = input_mat[i, 1];
		v = input_mat[i, 2];
		X = input_mat[i, 3];
		Y = input_mat[i, 4];

		if (i <= 1){
			mstack = get_calibration_matrix(u, v, X, Y); 
		}
	"Generate bold P matrix from an matrix of calibration points. input_mat = matrix of 6 or more calibration pairs <u, y, X, Y>"
{
	/* Create a large array of calibration matrices using the input point pairs */
	/* These calibration matrices are then stacked on top of each other */
	for (i = 1; i <= input_mat->vmax; i++){
		
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
	
	/* Find the min value of the vector in svd_mat[2] */
	e_vec = svd_mat[2];
	vT = svd_mat[3];
	
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
			PP[i, j] = tmp_col[c];
		};
	};
	PP;
};

/* Given an image point (x and y) and camera matrix, return the corresponding real world position vector */  
function findWorldPosition(x,y,PP)
{
	pinv = inverse_mat(PP);
	ivec = mk_fvec(1..3, [x,y,1]);
	pvec = PP * ivec;
	pvec = normalizeVec(pvec);
	printf("X: %f\tY:%f\tZ:%f\n",pvec[1],pvec[2],pvec[3]);
};


/*function takes a list and displays the content*/
function proj_prtList(list){	

	for(x=1;x<=list->vsize;x++){
   	printf("=> %d\n",list[x]);
   };
};

/*prints an image variable to a file*/
function proj_writeImage(img,name){
	ppm = ".ppm";
	/*location = "/eecs/home/hydramin/Documents/4421/Project//testWork/exper/";*/
	location = "/eecs/home/hydramin/Documents/4421/Project/TicTacToe/testWork/exper/";
	file = str_concat(location,name,ppm);
	write_img(img,file);
};

/*Reads an image from location provided*/
/*read_img("absolute path");*/

/*gets the robot out of the way of the camera, vertically upward*/
function proj_readyPos(){
    rob_move_abs(0,90,0,0,0);
    servo_open(30);    
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

/*input the refX,refY matrices and a point, calculate the distance from each point*/
/*this calculates the pixle distance*/
function proj_getDistance(xm,ym,pt){
    
    /*dx is refX - ptx*/
    dx = xm - inner_fillMat(pt[1]);
    dy = ym - inner_fillMat(pt[2]);
    dxsq = inner_squareMat(dx);
    dysq = inner_squareMat(dy);
    dxysum = dxsq + dysq;
    /*dxyfinal contains distance of the point pt from each of the reference center of gravities*/
    dxyfinal = inner_sqrtMat(dxysum);
    inner_prtMat(dxyfinal);
    dxyfinal;
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


/*square each values of a matrix*/
function inner_squareMat(mat){
    mat1 = mk_fmat(1..3,1..3);
    for(i = 1;i<=3;i++){
        for(j = 1;j<=3;j++){
           mat1[i,j] = mat[i,j]^2;
        };
    };            
    /*inner_prtMat(mat1);*/
    mat1;
};

/*square roots each entry of a 3x3 matrix*/
function inner_sqrtMat(mat){
    mat1 = mk_fmat(1..3,1..3);
    for(i = 1;i<=3;i++){
        for(j = 1;j<=3;j++){
           mat1[i,j] = sqrt(mat[i,j]);           
        };
    };
    /*inner_prtMat(mat1);*/
    mat1;
};

function inner_prtMat(mat){
    for(i=1;i<=3;i++){
        for(j=1;j<=3;j++){
            printf("%.2f ",mat[i,j]);
        };
        printf("\n");
    };
    0;
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
};
