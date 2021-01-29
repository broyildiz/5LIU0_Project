#include <stdio.h>

int main()
{
	char line[256];
	
	FILE *fp;
	
	fp = fopen("FSB_IN.txt", "r");
	fgets(line, sizeof(line), fp);
	fclose(fp);
	
	int input = atoi(line);
	printf("Input = %d\n", input);
	
	// tijdstap in seconde
	const float dt = 0.001;
	
	// variabelen
	float t;               		// tijd
	float u;               		// input
	float x1, x2, x3, x4;       // states
	float y;               		// output 
	float dx1,dx2, dx3, dx4;    // verandering van de state per tijdstap
	
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
//	u = 1;
	y = 0;
	
	fp = fopen("ctrl_out.txt", "w+");
	
//	fprintf(fp, "t\terror\tt\ty\tt\tx1\tt\tx2\tt\tx3\n");
	
	for(t = 0; t < 0.1; t += dt)
	{
//		error = u - k3 - k2 - k1;
//		error = u - k3 - k2;
//		error = u - k3;
		error = (u * 91.5881) - y;
//		error = (u) - y;		

		dx1 = (x2) * dt;
		dx2 = (x3) * dt;
//		dx3 = ( -285.7*x3 -17070*x2 + 0*x1 + 698800*error ) * dt;
//		dx3 = ( -285.714285714286*x3 -17073.1707317073*x2 -24390.243902439*x1 + 698780.487804878*error ) * dt;
		dx3 = ( -1200*x3 -479999.999988538*x2 -63999999.9954152*x1 + 698780.487804879*error ) * dt;
			
		y = x1;
//		y = (x1/57.3)*2.0;
		
		t  += dt;
	    x1 += dx1;
	    x2 += dx2;
	    x3 += dx3;

//	    k3 = (x1 / 57.3) * 2.0;
//	    k2 = (x2/57.3)*2;
//	    k1 = (x3 * 2);	
	    fprintf(fp, "%f\t%f\n",t, x1);

//	    fprintf(fp, "%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\n", t, error,t, y, t, x1, t, x2, t, x3);
		
	}

	fclose(fp);
	return 0;
}
