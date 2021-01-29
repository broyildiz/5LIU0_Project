#include <stdio.h>
#include <math.h>
#include <string.h>

#include "dft.h"

//#define N sizeof(input)/sizeof(double)
#define N 512
#define N_half 512/2
#define TWO_PI 6.28318530718

float ReX[ (N / 2)  ];
float ImX[ (N / 2)  ];

float PI = 3.14159265;
double input[N-1];
float remap_output_end = 0.0;

void sin_gen()
{
	int Fsample = 1000;
	int Fsignal = 100;
	int amp = 0;
	int phase = 0;
	int dc = 0;
	int i = 0;

	memset(input, 0, sizeof(input));
	
	char line[256];
	int init_size = strlen(line);
	char delim[] = ",";
	
	FILE *fp;
	
	fp = fopen("settings.txt", "r");
	
	fgets(line, sizeof(line), fp);
	printf("%s\n", line);
	
	char *ptr = strtok(line, delim);
	
	while(ptr != NULL)
	{
		switch(i)
		{
			case 0:
			{
				amp = atoi(ptr);
			}break;
			case 1:
			{
				Fsample = atoi(ptr);
			}break;
			case 2:
			{
				Fsignal = atoi(ptr);
			}break;
			case 3:
			{
				phase = atoi(ptr);
			}break;
			case 4:
			{
				dc = atoi(ptr);
			}break;
			default:
			{
				printf("Hello\n");
			}break;
			
		}
		
//		printf("%d\t", atoi(ptr));
//		printf("'%s'\n", ptr);
		ptr = strtok(NULL, delim);
		i++;
	}
	
//	printf("Amp = %d\n", amp);
//	printf("Fsample = %d\n", Fsample);
//	printf("Fsignal = %d\n", Fsignal);
//	printf("Phase = %d\n", phase);
//	printf("DC = %d\n", dc);
	
	fclose(fp);
	
	remap_output_end = (float)Fsample;
	
	fp = fopen("sine.txt", "w+");
	
	// Generate sine values
	float j;
	for(j = 0, i = 0; j < N; j++, i++)
	{
		input[i] = sin(TWO_PI * Fsignal * (j/Fsample));
		fprintf(fp, "%f\n", input[i]);
	}
	
	fclose(fp);
}


void DFT()
{
	FILE *fp;
	fp = fopen("dft_out.txt", "w+");
	int k, i = 0;
	
	for(i = 0; i < N/2; i++)
	{
		ReX[i] = 0;
		ImX[i] = 0;
	}
	printf("i = %d\n\n", i);
	printf("length: %d\n", (sizeof(ReX)/sizeof(ReX[0])));
	
	for(k = 0; k < N/2; k++)
	{
		for(i = 0; i < N-1; i++)
		{
			ReX[k] = ReX[k] + input[i]*cos(2*PI*k*i/N);
			ImX[k] = ImX[k] - input[i]*sin(2*PI*k*i/N);
		}
	}
	printf("i = %d\n\n", --i);
	printf("i = %d\n\n", --k);
	
//	fprintf(fp, "N\tRe\tIm\n", i, ReX[i], ImX[i]); // Debug
	fprintf(fp, "Re\tIm\n");
	for(i = 0; i < N/2+1; i++)
	{
//		fprintf(fp, "%d\t%f\t%f\n", i, ReX[i], ImX[i]); // Debug
		fprintf(fp, "%f\t%f\n", ReX[i], ImX[i]);
	}
	
	fclose(fp);		
	
//	fp = fopen("sqrt.txt", "w+"); // Debug
	fp = fopen("FSB_IN.txt", "w+");	
	float big_freq = 0.0;
	int loc = 0;
	float abs = 0.0;
	
//	fprintf(fp, "i\tabs\tbig_freq\tloca\n"); // Debug
	
	// Find the maximal frequency
	for(i = 0; i < N/2; i++)
	{
		abs = sqrt(ReX[i]*ReX[i] + ImX[i]*ImX[i]);

		if(big_freq < abs)
		{
			big_freq = abs;
			loc = remap(i);
					
		}
//		fprintf(fp, "%d\t%f\t%f\t%d\n", i, abs, big_freq, loc); // Debug
	}
	printf("big freq = %d\n", loc);
	fprintf(fp, "%d\n", loc);
	fclose(fp);	
}	

// Source: https://stackoverflow.com/questions/5731863/mapping-a-numeric-range-onto-another
int remap(int i)
{
  float input_start = 0.0;
  float input_end = N;
  float output_start = 0.0;
  float output_end = remap_output_end;
  float slope = 0.0;
  
  int output = 0;
  
  slope = (output_end - output_start) / (input_end - input_start);
  output = (int)(output_start + slope * (i -input_start));
  
  return output;
}
	
int main()
{
	sin_gen();
	DFT();
	
	return 0;
}
