#include <stdio.h>

int main()
{
	char line[256];
	
	FILE *fp;
	
	fp = fopen("FSB_IN.txt", "r");
	fgets(line, sizeof(line), fp); // Read the input value
	fclose(fp);
	
	int input = atoi(line);
	printf("Input = %d\n", input);
	
	// tijdstap in seconde
	const float dt = 0.001;
	
	// variabelen
	float t;               		// tijd
	float u;               		// input
	float x1, x2, x3;       // states
	float y;               		// output 
	float dx1,dx2, dx3;    // verandering van de state per tijdstap
	
	float error;
	
	float k3 = 0.0;
	float k2 = 0.0;
	float k1 = 0.0;
	
	t  = 0;              
	x1 = 0;               
	x2 = 0;
	x3 = 0;
	
	error = 0;
	u = input;
	y = 0;
	
	fp = fopen("ctrl_out.txt", "w+");
	
	for(t = 0; t < 1; t += dt)
	{
//		error = u - k3 - k2 - k1;
//		error = u - k3 - k2;
//		error = u - k3;
		error = (u * 91.5881) - y;
//		error = (u) - y;		

		dx1 = (x2) * dt;
		dx2 = (x3) * dt;
//		dx3 = ( -285.714285714286*x3 -17073.1707317073*x2 -24390.243902439*x1 + 698780.487804878*error ) * dt; // Normal plant
		dx3 = ( -1200*x3 -479999.999988538*x2 -63999999.9954152*x1 + 698780.487804879*error ) * dt; // FSFB Plant
			
		y = x1;
		
		t  += dt;
	    x1 += dx1;
	    x2 += dx2;
	    x3 += dx3;

	    fprintf(fp, "%f\t%f\n",t, x1);

//	    fprintf(fp, "%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\n", t, error,t, y, t, x1, t, x2, t, x3); // Debug
		
	}

	fclose(fp);
	return 0;
}
