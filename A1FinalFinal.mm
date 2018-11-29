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

		rob_move_abs(theta1,90,90,0,0);
		sleep(4);	
		rob_move_abs(theta1,theta2,theta3,theta4,0);
		sleep(4);
		flag = 0;	
	};

};


