

function get_calibration_matrix(X, Y, u, v) 
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