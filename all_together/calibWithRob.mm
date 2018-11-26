/*the robot places and picks up object from points*/
function calib_dropOffAt(X,Y,Z){
    /*get the robot to all centers*/
    CRSinvkin(X,Y,Z);
    sleep(5);
    servo_open(50);
    sleep(2);
    proj_readyPos();
    sleep(10);
};

function calib_pickUpFrom(X,Y,Z){
    servo_open(50);       
    CRSinvkin(X,Y,Z);
    sleep(5);    
    proj_readyPos();
    sleep(10);
};