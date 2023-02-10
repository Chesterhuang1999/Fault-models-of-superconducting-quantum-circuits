// QASM 2.0 file generated by QuTiP

OPENQASM 2.0;
include "qelib1.inc";
qreg q[4];
u3(0,0,pi/4) q[0];
u3(pi/4,pi/4,-pi) q[1];
u3(pi/4,0.0,0.0) q[2];
cz q[2],q[1];
u3(pi/4,-pi,-pi) q[1];
u3(pi/4,0.0,0.0) q[2];
u3(pi/3,-0.61547971,-2.186276) q[3];
cz q[2],q[3];
u3(pi/3,-0.61547971,0.95531662) q[2];
cz q[2],q[1];
u3(pi/3,0.61547971,-2.5261129) q[1];
u3(0.54802841,-1.2858722,-1.2858722) q[2];
cz q[1],q[2];
u3(pi/2,0,-3*pi/4) q[2];
u3(pi/4,-pi/2,3*pi/4) q[3];
cz q[0],q[3];
u3(0,0,pi/4) q[0];
u3(3*pi/4,0,-pi) q[3];