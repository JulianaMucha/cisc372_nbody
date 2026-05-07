__global__ void compute(vector3* pos, vector3* accels, double* mass);
__global__ void update_bodies(vector3* pos, vector3* vel, vector3* accels);

// extern vector3* d_accels;
// extern double* d_mass;
// extern vector3* d_hPos;
// extern vector3* d_hVel;
