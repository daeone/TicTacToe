function radtoDegree(rad)
{
	degree = rad * (180/PI);

};
function move(x,y,zz)
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
		rob_move_abs(0,50,60,0,0);
		sleep(2);
		rob_move_abs(theta1,50,60,0,0);
		sleep(1);	
		rob_move_abs(theta1,theta2,theta3,0,0);
		sleep(1);	
		rob_move_abs(theta1,theta2,theta3,theta4,0);
		sleep(4);
		flag = 0;	
	};




};
/*function CRSinvkin(x,y,zz)*/
/*{*/
 	
	/*servo_open(50);*/	
	/*move(x,y,zz);*/
	/*servo_close(40);*/
	/*sleep(4);*/
	/*rob_move_abs(0,50,60,0,0);*/
	/*sleep(2);*/


/*};*/




function diffimgobj(img1,img2)
{
 	img1 = (img1->r + img1->g + img1->b)/3.0;
	img2 = (img2->r + img2->g + img2->b)/3.0;
	/*--Break--*/
	imd = img2-img1;
	imd*=imd;
	gshow(imd,:rescale=t);
	imbin = imd>1000;
	/*--Break--*/
	imgcc = con_compon(imbin);
	gshow(imgcc,:rescale=t);
	/*--Break--*/
	gg = mk_uctmpl2(-1..1,-1..1,[[1,1,1],[1,1,1],[1,1,1]]);
	/*--Break--*/
	imbin1 = imbin(*)gg;
	imbin1 = imbin1(*)gg;
	imbin1 = ~( (~imbin1)(*)gg);
	imbin1 = ~( (~imbin1)(*)gg);
	gshow(imbin1,:rescale=t);
	/*--Break--*/
	imbin1 = ~( (~imbin1)(*)gg);
	imbin1 = ~( (~imbin1)(*)gg);
	imbin1 = imbin1(*)gg;
	imbin1 = imbin1(*)gg;
	gshow(imbin1,:rescale=t);
	/*--Break--*/
	imgcc = con_compon(imbin1);
	/*--Break--*/
	gshow(obj1img = select_iimg(imgcc,1),:rescale = t);
	/*--Break--*/
	o1 = to_fimg(obj1img);
	/*--Break--*/
	sz = sum_fimg(o1);
	/*--Break--*/
	c_x = sum_fimg(o1*x_img(o1->vsize,o1->hsize))/sz;
	/*--Break--*/
	c_y = sum_fimg(o1*y_img(o1->vsize,o1->hsize))/sz;
	/*--Break--*/
	
	x = to_int(c_x);
	y = to_int(c_y);
	

};


/* Auxillary functions */

/* normalize vector by the last element */
function normalizeVec(v)
{
	v = v / v[v->vsize];
};

/* normalize matrix by the last element */
function normalizeMat(m)
{
    m = m / m[m->vsize, m->hsize];
};

/* normalize each column in a matrix by the last element (last row in the column) */
function normalizeCol(m)
{
    for (i = 1; i< m->hsize; i++)
    {
        m[1..m->vsize,i] = normalizeVec(m[1..m->vsize,i]);
    };
};

/* normalize each row in a matrix by the last element (last column in the row) */
function normalizeRow(m)
{
    h = m->hsize;
    for (i = 1; i< m->vsize+1; i++)
    {
        m[i,1..h] = m[i,1..h]/m[i,h];
    };
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

};


/* Takes n * 4 matrix, each row contains value for u,v,X,Y and returns camera matrix p (3x3)*/
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
	printMat(pmat);
	pinv = inverse_mat(pmat);
	printMat(pinv);

};



/* Given an image point (x and y) and camera matrix, return the corresponding real world position vector */  
function findWorldPosition(x,y,m)
{
	ivec = mk_fvec(1..3, [x,y,1]);
	pvec = m * ivec;
	pvec = normalizeVec(pvec);
	printf("X: %f\tY:%f\tZ:%f\n",pvec[1],pvec[2],pvec[3]);
};


function printMat(m)
{
    for (i=1; i< m->vsize+1; i++)
    {
        for (j=1; j< m->hsize+1; j++){
            printf("%f ", m[i,j]);       
        };
        printf("\n");
    };
    printf("\n");
};


 
    
function testCamMat()
{
    rc = rand_fmat(3,3);
    rc = normalizeMat(rc);
    bool = 1;
    
    rw = rand_fmat(7,3);
    rw = rw * 10; 
    normalizeRow(rw);
    
    ri = rw * rc;
    normalizeRow(ri);

    rw = rw[1..rw->vsize, 1..rw->hsize-1];
    ri = ri[1..ri->vsize, 1..ri->hsize-1];
    
    rmat = ri <-> rw;
    
    cameraMat(rmat);
    result = pmat^T;
    result = normalizeMat(result);
    
    for (i=1; i< result->vsize+1; i++)
    {
        for (j=1; j< result->hsize+1; j++){
             if (result[i,j] -rc[i,j] >= 0.000001){
	    	bool = 0;	
 	     };    
        };
    };
    
    if (bool == 1){ printf("Succeeded! cameraMat functions works correctly\n");}
    else {printf("Failed.. please revise your cameraMat function\n");};
   
};


