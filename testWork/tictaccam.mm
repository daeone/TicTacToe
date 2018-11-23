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

/*--------------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------------*/
function proj_getRef(xory){
/*now the robot analyzes the picture with background subtraction and determines a pixle location*/
/*a reference matrix that contains the center of gravities of the pixel locations is needed*/
/*--------------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------------*/
/*Generates the reference matrix for the center of gravities*/
/*--------------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------------*/

back = read_img("/eecs/home/hydramin/Documents/4421/Project/TicTacToe/testWork/expr/back.ppm");
img1 = read_img("/eecs/home/hydramin/Documents/4421/Project/TicTacToe/testWork/expr/img1.ppm");
img2 = read_img("/eecs/home/hydramin/Documents/4421/Project/TicTacToe/testWork/expr/img22.ppm");
img3 = read_img("/eecs/home/hydramin/Documents/4421/Project/TicTacToe/testWork/expr/img3.ppm");
img4 = read_img("/eecs/home/hydramin/Documents/4421/Project/TicTacToe/testWork/expr/img44.ppm");
img5 = read_img("/eecs/home/hydramin/Documents/4421/Project/TicTacToe/testWork/expr/img5.ppm");
img6 = read_img("/eecs/home/hydramin/Documents/4421/Project/TicTacToe/testWork/expr/img6.ppm");
img7 = read_img("/eecs/home/hydramin/Documents/4421/Project/TicTacToe/testWork/expr/img7.ppm");
img8 = read_img("/eecs/home/hydramin/Documents/4421/Project/TicTacToe/testWork/expr/img8.ppm");
img9 = read_img("/eecs/home/hydramin/Documents/4421/Project/TicTacToe/testWork/expr/img9.ppm");

/*calculate centers of gravities of the centers of all the grids*/
c1 = proj_getCenter(back,img1);
c2 = proj_getCenter(back,img2);
c3 = proj_getCenter(back,img3);
c4 = proj_getCenter(back,img4);
c5 = proj_getCenter(back,img5);
c6 = proj_getCenter(back,img6);
c7 = proj_getCenter(back,img7);
c8 = proj_getCenter(back,img8);
c9 = proj_getCenter(back,img9);

/*save all centers in a 3x3 matrix x values separated from y*/
/*refX is a metrix that contains all the x coordinates of the grid center of gravities*/
refX = mk_fmat(1..3,1..3,[
[c1[1],c2[1],c3[1]],
[c4[1],c5[1],c6[1]],
[c7[1],c8[1],c9[1]]
]);

/*refX is a metrix that contains all the x coordinates of the grid center of gravities*/
refY = mk_fmat(1..3,1..3,[
[c1[2],c2[2],c3[2]],
[c4[2],c5[2],c6[2]],
[c7[2],c8[2],c9[2]]
]);

if(xory = "X"){
  returnValue = refX;
};
if(xory = "Y")
  returnValue = refY;
};


/*--------------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------------*/
/*returnValue;*/
};
