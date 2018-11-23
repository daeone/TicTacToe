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

