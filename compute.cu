#include <stdlib.h>
#include <math.h>
#include "vector.h"
#include "config.h"
#include <cuda.h>

extern vector3* d_accels;
extern vector3* d_hPos;
extern vector3* d_hVel;
extern double* d_mass;

//compute: Updates the positions and locations of the objects in the system based on gravity.
//Parameters: None
//Returns: None
//Side Effect: Modifies the hPos and hVel arrays with the new positions and accelerations after 1 INTERVAL
__global__ void compute(){

	int i = blockIdx.x * blockDim.x + threadIdx.x;
	int j = blockIdx.y * blockDim.y + threadIdx.y;
	int k;

	//first compute the pairwise accelerations.  Effect is on the first argument.
	if (i<NUMENTITIES && j<NUMENTITIES){
		if (i==j) {
			FILL_VECTOR(d_accels[i*NUMENTITIES+j],0,0,0);
		}
		else{
			vector3 distance;
			for (k=0;k<3;k++) distance[k]=d_hPos[i][k]-d_hPos[j][k];
			double magnitude_sq=distance[0]*distance[0]+distance[1]*distance[1]+distance[2]*distance[2];
			double magnitude=sqrt(magnitude_sq);
			double accelmag=-1*GRAV_CONSTANT*d_mass[j]/magnitude_sq;
			FILL_VECTOR(d_accels[i*NUMENTITIES+j],accelmag*distance[0]/magnitude,accelmag*distance[1]/magnitude,accelmag*distance[2]/magnitude);
		}
	}
}

__global__ void update_bodies(){

	int i = blockIdx.x * blockDim.x + threadIdx.x;
	int j, k;

	//sum up the rows of our matrix to get effect on each entity, then update velocity and position.
	if (i<NUMENTITIES){
		vector3 accel_sum={0,0,0};
		for (j=0;j<NUMENTITIES;j++){
			for (k=0;k<3;k++){
				accel_sum[k]+=d_accels[i*NUMENTITIES+j][k];
			}
		}

		//compute the new velocity based on the acceleration and time interval
		//compute the new position based on the velocity and time interval
		for (k=0;k<3;k++){
			d_hVel[i][k]+=accel_sum[k]*INTERVAL;
			d_hPos[i][k]+=d_hVel[i][k]*INTERVAL;
		}
	}
}
