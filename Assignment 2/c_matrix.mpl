with(linalg):
with(CodeGeneration):

#P is the 3x4 projection matrix. If you want to map from plane to plane
#use a 3x3 matrix.

PP:=array(1..3,1..4,[[p1,p2,p3,p4],[p5,p6,p7,p8],[p9,p10,p11,p12]]);

#Xworld is the world coordinates, that is where you told the arm to place
# the token

Xworld:=array(1..4,[X,Y,Z,1]);

#ximg is the image coordinate, where you detected the token in the image.

ximg:=array(1..3,[u,v,1]);

eqvec:=crossprod(ximg,multiply(PP,Xworld));

# AAi is the 3x12 matrix of coefficients. I use a simple trick to get the
# coefficients: I take derivatives with respect to the unknowns.

AAi:=array(1..3,1..12,[
['diff(eqvec[1],PP[1,i])'$i=1..4,
'diff(eqvec[1],PP[2,i])'$i=1..4,
'diff(eqvec[1],PP[3,i])'$i=1..4],
['diff(eqvec[2],PP[1,i])'$i=1..4,
'diff(eqvec[2],PP[2,i])'$i=1..4,
'diff(eqvec[2],PP[3,i])'$i=1..4],
['diff(eqvec[3],PP[1,i])'$i=1..4,
'diff(eqvec[3],PP[2,i])'$i=1..4,
'diff(eqvec[3],PP[3,i])'$i=1..4]]);

# The next statement produces the C code for it. You can edit the result 
# a bit to fit in a typical MediaMath program (i.e. replace the ][ in the
# generated code with either , (comma) or +3*i, so that it places the
# results in the correct place in the matrix.

C(AAi);

# After that you call SVD, find the smallest singular value and copy the
#corresponding singular vector into P


