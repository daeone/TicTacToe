
function generate_imgcoords(cam, data_points)
{
	
	/*To generate the U,V coordinates*/
	/*- take the base image and save it in base_img*/
	/*- give the object to the arm, have it put the object at a position given*/
	/*- get the arm out away*/
	/*- take a picture and calculat the center of gravity*/
	/*- save the U,V coordinates in the matrix ( write them down for data safety)*/

	/* this matrix contains 6 data points [X,Y,u,v]*/
	
	
	/*input the X,Y values in the first data_points matrix*/
	
	
	
	
	/*generate the u,v values*/
	/*take the base_img*/	
	
	rob_move_abs(0,90,0,0,0);
	sleep(10);
	base_img = proj_grabImage(cam);
	
	/*go to the base position and grab the object*/
	CRSinvkin (0, -15, 1);
	sleep(4);
	servo_close(50);
	sleep(4);
	rob_move_abs(0,90,0,0,0);
	sleep(4);
	
	for(i=1; i<=data_points1->vsize;i++)
	{
	 
	    /*delivers the object to the x,y position given*/
	    CRSinvkin(data_points1[i,1], data_points1[i,2], -1);
	    sleep(4);
	    servo_open(50);
	    sleep(4);
	    rob_move_abs(0,90,0,0,0);
	    sleep(8);
	    img2 = proj_grabImage(cam);
	    
	    /*use base_img and ref_img to calculate a u,v using ass1*/
	    pixle_point = proj_getCenter(base_img,img2);

	    /*add this pixle point to the data_points matrix*/
	    data_points1[i,3] = pixle_point[1];
	    data_points1[i,4] = pixle_point[2];

	    /*go to where the object is, grab it and return to the ready position*/
	    CRSinvkin(data_points[i,1], data_points[i,2], 1);
	    sleep(4);
	    servo_close(50);
	    sleep(4);
	    rob_move_abs(0,90,0,0,0);
	};
	data_points1;
	
};