#ifndef __TYPES_H__
#define __TYPES_H__

typedef double vector3[3];
#define FILL_VECTOR(vector,a,b,c) {vector[0]=a;vector[1]=b;vector[2]=c;}
extern vector3 *hVel, *d_hVel;
extern vector3 *hPos, *d_hPos;
extern double *mass;

#endif


//#ifndef __VECTOR_H__
//#define __VECTOR_H__

//typedef double vector3[3];

// CUDA-safe macro
//#define FILL_VECTOR(v, a, b, c) do { \
	(v)[0] = (a); \
	(v)[1] = (b); \
	(v)[2] = (c); \
//} while(0)

// Global variables defined in nbody.cu
//extern vector3 *hVel, *d_hVel;
//extern vector3 *hPos, *d_hPos;
//extern double *mass;

//#endif
