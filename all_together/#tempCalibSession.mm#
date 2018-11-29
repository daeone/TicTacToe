rob_init();
rob_move_abs(0,0,0,0,0);
rob_ready();
/*--Break--*/
/*get the rob arm reach corners*/
CRSinvkin(20,-4.5,0.5);
sleep(5);
CRSinvkin(20,4.5,0.5);
sleep(5);
CRSinvkin(11,4.5,0);
sleep(5);
CRSinvkin(11,-4.5,0);
sleep(5);

/*--Break--*/
/*get the robot to all centers*/
CRSinvkin(12.5,3,-0.5);
sleep(5);
rob_ready();
/*--Break--*/
CRSinvkin(12.5,0,-0.5);
sleep(5);
rob_ready();
/*--Break--*/
CRSinvkin(12.5,-3,-0.5);
sleep(5);
rob_ready();
/*--Break--*/
CRSinvkin(15.5,3,-0.3);
sleep(5);
rob_ready();
/*--Break--*/
CRSinvkin(15.5,0,-0.3);
sleep(5);
rob_ready();
/*--Break--*/
CRSinvkin(15.5,-3,-0.3);
sleep(5);
rob_ready();
/*--Break--*/
CRSinvkin(18.5,3,0);
sleep(5);
rob_ready();
/*--Break--*/
CRSinvkin(18.5,0,0);
sleep(5);
rob_ready();
/*--Break--*/
CRSinvkin(18.5,-3,0);
sleep(5);
rob_ready();
/*--Break--*/

/*Generate the calibration matrix take 6 pics*/
cam = proj_getCam();
/*--Break--*/
back = proj_grabImage(cam);
/*--Break--*/
c1 = proj_grabImage(cam);
/*--Break--*/
c2 = proj_grabImage(cam);
/*--Break--*/
c3 = proj_grabImage(cam);
/*--Break--*/
c4 = proj_grabImage(cam);
/*--Break--*/
c5 = proj_grabImage(cam);
/*--Break--*/
c6 = proj_grabImage(cam);
/*--Break--*/
c7 = proj_grabImage(cam);
/*--Break--*/
c8 = proj_grabImage(cam);
/*--Break--*/
c9 = proj_grabImage(cam);
/*--Break--*/
c10 = proj_grabImage(cam);
/*--Break--*/

/*find the pixle centers of the images*/
a1 = proj_getCenter(back,c1);
a2 = proj_getCenter(back,c2);
a3 = proj_getCenter(back,c3);
a4 = proj_getCenter(back,c4);
a5 = proj_getCenter(back,c5);
a6 = proj_getCenter(back,c6);
a7 = proj_getCenter(back,c7);
a8 = proj_getCenter(back,c8);
a9 = proj_getCenter(back,c9);
a10 = proj_getCenter(back,c10);

/*--Break--*/
data_points = mk_fmat(1..10,1..4);
data_points[1,1] = 11.0;
data_points[1,2] = 4.5;
data_points[1,3] = a1[1];
data_points[1,4] = a1[2];

data_points[2,1] = 20;
data_points[2,2] = 4.5;
data_points[2,3] = a2[1];
data_points[2,4] = a2[2];

data_points[3,1] = 20;
data_points[3,2] = -4.5;
data_points[3,3] = a3[1];
data_points[3,4] = a3[2];

data_points[4,1] = 11;
data_points[4,2] = -4.5;
data_points[4,3] = a4[1];
data_points[4,4] = a4[2];


data_points[5,1] = 15.5;
data_points[5,2] = 0;
data_points[5,3] = a5[1];
data_points[5,4] = a5[2];

data_points[6,1] = 15.5;
data_points[6,2] = 4.5;
data_points[6,3] = a6[1];
data_points[6,4] = a6[2];
/*new pts*/
data_points[7,1] = 12.5;
data_points[7,2] = 0;
data_points[7,3] = a7[1];
data_points[7,4] = a7[2];

data_points[8,1] = 15.5;
data_points[8,2] = -3;
data_points[8,3] = a8[1];
data_points[8,4] = a8[2];

data_points[9,1] = 18.5;
data_points[9,2] = 0;
data_points[9,3] = a9[1];
data_points[9,4] = a9[2];

data_points[10,1] = 15.5;
data_points[10,2] = 3;
data_points[10,3] = a10[1];
data_points[10,4] = a10[2];

for(i=1;i<=data_points->vsize;i++){
    for(j=1;j<=data_points->hsize;j++){
        printf("%.2f, ",data_points[i,j]);
    };
    printf("\n");
};

/*--Break--*/
/*Now that we have the matrix we can change any pixle value to X,Y*/
/*get the pictures and find the centers*/

cameraMat(data_points);

/*--Break--*/
back = proj_grabImage(cam);
/*--Break--*/
img1 = proj_grabImage(cam);
/*--Break--*/
img2 = proj_grabImage(cam);
/*--Break--*/
img3 = proj_grabImage(cam);
/*--Break--*/
img4 = proj_grabImage(cam);
/*--Break--*/
img5 = proj_grabImage(cam);
/*--Break--*/
img6 = proj_grabImage(cam);
/*--Break--*/
img7 = proj_grabImage(cam);
/*--Break--*/
img8 = proj_grabImage(cam);
/*--Break--*/
img9 = proj_grabImage(cam);

/*--Break--*/
/*calculate the X,Y coordinates from the ccx values. Just do PPx[u,v,1]^T*/
function threeVec(){
    x = mk_fvec(1..3);
    x[3] = 1;
    x;
};
function normalize(v){
    f = mk_fvec(1..2);
    f = v[1..2]/v[3];
    f;
};
function prtMe(arr){
    for(i=1;i<=9;i++){
        printf("(%.2f, %.2f)\n",arr[i][1], arr[i][2]);
    };
};
/*--Break--*/

/*create vectors [_,_,1] to be filled later*/
cc1 = threeVec();
cc2 = threeVec();
cc3 = threeVec();
cc4 = threeVec();
cc5 = threeVec();
cc6 = threeVec();
cc7 = threeVec();
cc8 = threeVec();
cc9 = threeVec();
/*--Break--*/

/*calculate centers of gravities of the centers of all the grids*/
cc1[1..2] = proj_getCenter(back,img1);
cc2[1..2] = proj_getCenter(back,img2);
cc3[1..2] = proj_getCenter(back,img3);
cc4[1..2] = proj_getCenter(back,img4);
cc5[1..2] = proj_getCenter(back,img5);
cc6[1..2] = proj_getCenter(back,img6);
cc7[1..2] = proj_getCenter(back,img7);
cc8[1..2] = proj_getCenter(back,img8);
cc9[1..2] = proj_getCenter(back,img9);

/*--Break--*/

n1 = normalize(pinv*cc1);
n2 = normalize(pinv*cc2);
n3 = normalize(pinv*cc3);
n4 = normalize(pinv*cc4);
n5 = normalize(pinv*cc5);
n6 = normalize(pinv*cc6);
n7 = normalize(pinv*cc7);
n8 = normalize(pinv*cc8);
n9 = normalize(pinv*cc9);
/*--Break--*/
final = mk_fmat(1..9,1..2,[
    [n1[1],n1[2]],[n2[1],n2[2]],[n3[1],n3[2]],
    [n4[1],n4[2]],[n5[1],n5[2]],[n6[1],n6[2]],
    [n7[1],n7[2]],[n8[1],n8[2]],[n9[1],n9[2]]
]);

for(i=1;i<=final->vsize;i++){
    for(j=1;j<=final->hsize;j++){
        printf("%.2f, ",final[i,j]);
    };
    printf("\n");
};

/*--Break--*/
pinv = mk_fmat(1..3,1..3,[         
         [  13.7302239948088385,      5.59593512522204684,     -2062.09919022869371],
         [ -0.212614322135509848,     -18.4398170119040152,    3821.49708599337737 ],
         [-0.00651901600167567596,    0.364848257340051496,    142.692797906011492 ]
  ]);
  
12.58, 2.13, 
15.48, 2.07, 
18.34, 2.13, 
12.68, -0.73, 
15.60, -0.82, 
18.42, -0.71, 
12.60, -3.67, 
15.52, -3.24, 
18.52, -3.53,
 
10.32, 4.02, 
16.38, 1.61, 
18.77, 0.77, 
13.31, -1.44, 
16.80, -1.50, 
18.58, -1.42, 
14.43, -3.90, 
16.90, -3.06, 
18.46, -2.84,

12.68, 2.83, 
15.41, 2.81, 
18.40, 2.91, 
12.68, -0.04, 
15.44, -0.13, 
18.40, -0.14, 
12.46, -3.06, 
15.34, -2.71, 
18.50, -3.16,

if(board[a] == 1 && board[b]==1){
            prt(v);        
            printf("|| %d Is winning move",c);
        } else if(board[b] == 1 && board[c]==1){
            prt(v);        
            printf("|| %d Is winning move",a);
        } else if(board[a] == 1 && board[c]==1){
            prt(v);        
            printf("|| %d Is winning move",b);
        };