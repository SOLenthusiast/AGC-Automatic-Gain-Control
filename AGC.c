/******************************************************************************
**
** Function             : AGC()
**
** Description          : AGC algorithm is used to automatically adjust the 
**                        speech level of an audio signal to a predetermined 
**                        value noramally in db.
**
** Arguments:
**  float *x            : input vector (range from -1 to 1 )
**  float *y            : output vector (range from -1 to 1 )
**  float gain_level    : output power level in db
**  int   N             : number of samples or frame length
**
** Inputs:
**  float *x             
**  float gain_level    
**  int   N             
**
** Outputs:
**  float *y            
**
** Return value         : None

#include<math.h>

void  AGC(float *x, float *y, float gain_level, int N)
{
    int i;
    float energy, output_power_normal, K;
    
    /* ouput power gain level is in db convert it into normal power */
    output_power_normal = (float)pow((double)10,(double)(gain_level/10));

    /* Calculate the energy of the signal */
    energy = 0;
    for(i = 0; i < N; i++)
        energy += x[i] * x[i];

    /* calculate the multiplication factor */
    K = (float)sqrt ((output_power_normal*N)/energy);

    /* scale the input signal to achieve the required output power */
    for(i = 0; i < N; i++)
        y[i] = x[i] * K ;
}