import controlP5.*; // For input forms
import grafica.*;

PrintWriter xOutput;
PrintWriter yOutput;
PrintWriter settingsFile;

ControlP5 cp5;
String textValue = "";

PFont f;
int fontSize = 18; 

int h = 600;
int l = h*2;

public class Canvas
{
  public int x_offset;
  public int y_offset;
}

public class Sinusoid
{
 public float A; // Amplitude 
 public float B; // 2*pi/B = Period
 public float C; // Phase offset
 public float D; // Vertical offset
 public float Fsample;
 public float period;
 public float sin_freq;
 public int   Nsamples;
}

Canvas q1 = new Canvas();
Canvas q2 = new Canvas();
Canvas q3 = new Canvas();
Canvas q4 = new Canvas();

Sinusoid s = new Sinusoid();

String Q1_label = "Input Arguments:";
String equation = "A*sin(B(x+C))+D    v    A*sin(2πFc(x + C))+D";
String formA = "A";
String formB = "B";
String formC = "C";
String formD = "D";
String formFsample =  "Fsample";
String formFc = "Fc"; 
String empty =  "a";
String extra =  " = ";
String formN = "Nsamples"; // Number of samples
String[] forms = {formA, formB, formC, formD,formFc, formFsample, formN,empty}; // Werkt alleen zolang het langste element het laatste is
int num_forms = forms.length;

int update = 0;

void settings()
{
  size(l,h);    
}

void set_offsets()
{
  q1.x_offset = 0;
  q1.y_offset = 0;
  
  q2.x_offset = (l/2) + 1;
  q2.y_offset = 0;
  
  q3.x_offset = 0;
  q3.y_offset = (h/2) + 1;
  
  q4.x_offset = (l/2) + 1;
  q4.y_offset = (h/2)+1;  
  
  s.A = 1.0;
  s.B = 1.0;
  s.C = 0.0;
  s.D = 0.0;
  s.Fsample = 100.0;
  s.sin_freq = 10.0;
  s.Nsamples = 64;
}

/*
  Field for input arguments
*/
void quarter_1()
{
    // Find longest form name and use that for all other forms
    int len = 0;
    //println(num_forms);
    for(int i = 0; i < num_forms-1; i++)
    {
      //println(forms[i]);
      if(textWidth(forms[i] + textWidth(extra)) >= len)
      {
        len = (int)textWidth(forms[i] + (int)textWidth(extra));
      }    
    }
    //println(len);
    //line(len,0,len,h);
    
    int formSize = l/8;
    
    int elements = 1; 
    text(Q1_label,0+q1.x_offset, (fontSize * (elements++))+q1.y_offset);
    //text(Fsample_s,0+q1.x_offset, (fontSize * (elements++))+q1.y_offset);
    //int len = Fsample_s.length();
    //text(str(len),0+q1.x_offset, (fontSize * (elements++))+q1.y_offset);
    elements++;
    cp5 = new ControlP5(this);
  
    text( equation, 0+q1.x_offset, (fontSize * (elements++))+q1.y_offset);
    elements++;
    
    text(formA + " = ", 0+q1.x_offset, (fontSize * (elements))+q1.y_offset);
    cp5.addTextfield(formA)
     .setPosition( len, (fontSize * (--elements))) // -- is needed to put the text box next to the previous text
     .setSize(formSize,fontSize+1)
     .setFont(f)
     .setFocus(true)
     .setColor(color(255,255,255))
     ;
     
    text( "= "+str(s.A), 0 + formSize*2 + q1.x_offset, (fontSize * (elements+1))+q1.y_offset);
  
    elements += 2;
  
    //text(formB + " = ", 0+q1.x_offset, (fontSize * (elements))+q1.y_offset);
    //cp5.addTextfield(formB)
    // .setPosition( len, (fontSize * (--elements))) // -- is needed to put the text box next to the previous text
    // .setSize(formSize,fontSize+1)
    // .setFont(f)
    // .setFocus(true)
    // .setColor(color(255,255,255))
    // ;
    // text( "= "+str(s.B), 0 + formSize*2 + q1.x_offset, (fontSize * (elements+1))+q1.y_offset);
    //elements+= 2;
  
    text(formC + " = ", 0+q1.x_offset, (fontSize * (elements))+q1.y_offset);
    cp5.addTextfield(formC)
     .setPosition( len, (fontSize * (--elements))) // -- is needed to put the text box next to the previous text
     .setSize(formSize,fontSize+1)
     .setFont(f)
     .setFocus(true)
     .setColor(color(255,255,255))
     ;
     
    text( "= "+str(s.C), 0 + formSize*2 + q1.x_offset, (fontSize * (elements+1))+q1.y_offset);
  
    elements += 2;
    
    text(formD + " = ", 0+q1.x_offset, (fontSize * (elements))+q1.y_offset);
    cp5.addTextfield(formD)
     .setPosition( len, (fontSize * (--elements))) // -- is needed to put the text box next to the previous text
     .setSize(formSize,fontSize+1)
     .setFont(f)
     .setFocus(true)
     .setColor(color(255,255,255))
     ;
    text( "= "+str(s.D), 0 + formSize*2 + q1.x_offset, (fontSize * (elements+1))+q1.y_offset);
    elements += 2;
     
    text(formFsample + " = ", 0+q1.x_offset, (fontSize * (elements))+q1.y_offset);
    cp5.addTextfield(formFsample)
     .setPosition( len, (fontSize * (--elements))) // -- is needed to put the text box next to the previous text
     .setSize(formSize,fontSize+1)
     .setFont(f)
     .setFocus(true)
     .setColor(color(255,255,255))
     ;
    text( "= "+str(s.Fsample) + " [Hz]", 0 + formSize*2 + q1.x_offset, (fontSize * (elements+1))+q1.y_offset);
     elements += 2;
     
    text(formFc + " = ", 0+q1.x_offset, (fontSize * (elements))+q1.y_offset);
    cp5.addTextfield(formFc)
     .setPosition( len, (fontSize * (--elements))) // -- is needed to put the text box next to the previous text
     .setSize(formSize,fontSize+1)
     .setFont(f)
     .setFocus(true)
     .setColor(color(255,255,255))
     ;
    text( "= "+str(s.sin_freq), 0 + formSize*2 + q1.x_offset, (fontSize * (elements+1))+q1.y_offset);
     elements += 2;   
    
    text(formN + " = ", 0+q1.x_offset, (fontSize * (elements))+q1.y_offset);
    cp5.addTextfield(formN)
     .setPosition( len, (fontSize * (--elements))) // -- is needed to put the text box next to the previous text
     .setSize(formSize,fontSize+1)
     .setFont(f)
     .setFocus(true)
     .setColor(color(255,255,255))
     ;
    text( "= "+str(s.Nsamples) + " [Hz]", 0 + formSize*2 + q1.x_offset, (fontSize * (elements+1))+q1.y_offset);
     elements += 2;    
     
     
    String aliasing = "NO";
    if(s.sin_freq > (s.Fsample/2)) 
    {
      aliasing = "YES";
      fill(255, 0, 0);
    }
    else
    {
      if(s.sin_freq == (s.Fsample/2))
      {
        aliasing = "Almost";
        fill(0, 0, 255);
      }  
      else 
      {
        aliasing = "No";
      }
    }     
    elements++;
    text("Aliasing" + extra + aliasing, 0 + q1.x_offset, (fontSize * (elements+1))+q1.y_offset);
    fill(0,0,0);
    
    s.period = 1 / s.sin_freq;
    text("Period" + extra + str(s.period), 0 + q1.x_offset, (fontSize * (elements++))+q1.y_offset);
    
    //cp5.addButton("Button")
    //  .setValue(1)
    //  .setPosition(0, (fontSize * (elements++))+q1.y_offset)
    //  .setSize(200,19);
}

void Button(float theValue) {
  println("updating");
  RunFile(1);
  quarter_4();
}

void quarter_2()
{
  
  
  int nPoints = s.Nsamples;
  
  float[] x_values = new float[s.Nsamples];
  float[] y_values = new float[s.Nsamples];
  int cnt = 0;
  
  float Fs = s.Fsample;
  float F = s.sin_freq;
  float period = 1/F;
  
  GPointsArray points1a = new GPointsArray(nPoints);
  GPointsArray points1b = new GPointsArray(nPoints);
  
  for(float x = 0.0; x < period; x += 1/Fs)
  {
    points1a.add(x, s.A * sin(TWO_PI*F*(x + s.C)) + s.D);
    //xOutput.println(x);
    //yOutput.println(s.A * sin(TWO_PI*F*(x + s.C)) + s.D);
  } 
  
  for(float x = 0.0; x < period; x += ((float)1/100000))
  {
    points1b.add(x, s.A * sin(TWO_PI*F*(x + s.C)) + s.D);
  }   
  
  GPlot plot = new GPlot(this);
  
  // Create a new plot and set its position on the screen
  plot.setPos(l/2+1, 0);
  
  // or all in one go
  // GPlot plot = new GPlot(this, 25, 25);

  plot.setOuterDim(new float[] {600, 300});

  // Set the plot title and the axis labels
  plot.setTitleText("The wave");
  plot.getXAxis().setAxisLabelText("Time");
  plot.getYAxis().setAxisLabelText("Aplitude");
  //plot.setLineColor(color(200, 200, 255));
  
  //// Add the points
  //plot.setPoints(points1a);
  //plot.setPointColor(color(0, 0, 255, 255));
  
  //plot.addLayer("layer 1", points1b);
  //plot.getLayer("layer 1");//.setLineColor(color(255, 255, 255));
  //plot.setPointColor(color(0, 0, 0, 255));
  
    // Add the points
  plot.setPoints(points1b);
  plot.setPointColor(color(0, 0, 0, 255));
  
  plot.addLayer("layer 1", points1a);
  plot.getLayer("layer 1");//.setLineColor(color(255, 255, 255));
  plot.setPointColor(color(0, 0, 255, 0));
  
  // Draw it!
  plot.defaultDraw();
  
  for(int x = 0; x < 512; x++)
  {
    
    xOutput.println(x);
    yOutput.println(( s.A * sin(TWO_PI*F*((x/s.Fsample) + s.C)) ) + s.D );
  } 
  
   writeSettingsFile();
  
  
  
}

void writeSettingsFile()
{
  settingsFile.print(int(s.A)); settingsFile.print(",");
  settingsFile.print(int(s.Fsample)); settingsFile.print(",");
  settingsFile.print(int(s.sin_freq)); settingsFile.print(",");
  settingsFile.print(int(s.C)); settingsFile.print(",");
  settingsFile.print(int(s.D));
}  

float remap(int i)
{
  float input_start = 0.0;
  float input_end = 512;
  float output_start = 0.0;
  float output_end = s.Fsample;
  float slope = 0.0;
  
  int output = 0;
  
  slope = (output_end - output_start) / (input_end - input_start);
  output = int(output_start + slope * (i -input_start));
  
  return output;
  
}


void quarter_3()
{
  RunFile(0);
  //launch("DFT_sin_gen.exe");
  //exec(sketchPath("DFT_sin_gen.exe"));
  String[] lines = loadStrings("dft_out.txt");
  //println("there are " + lines.length + " lines");
  String line;
  
  float[] ReX = new float [258];
  float[] ImX = new float [258]; 
  
  GPointsArray abs = new GPointsArray(256);
 
  for (int i = 1 ; i < lines.length; i++) 
  {
    line = lines[i];
    String[] list = split(line, '\t');
    ReX[i] = float(list[0]);
    ImX[i] = float(list[1]);
    abs.add(remap(i), sqrt( ReX[i]*ReX[i] + ImX[i]*ImX[i] ));
  }
  
  GPlot plot = new GPlot(this);
  
  // Create a new plot and set its position on the screen
  plot.setPos(0, h/2 +1);
  plot.setOuterDim(new float[] {600, 300});

  // Set the plot title and the axis labels
  plot.setTitleText("The DFT");
  plot.getXAxis().setAxisLabelText("Hz");
  plot.getYAxis().setAxisLabelText("Magnitude");
  plot.setLineColor(color(200, 200, 255));
  

    // Add the points
  plot.setPoints(abs);
  plot.setPointColor(color(0, 0, 0, 255));
  
  // Draw it!
  plot.defaultDraw();  
  println("3 present");

}

void quarter_4()
{
  //launch("DFT_sin_gen.exe");
  //exec(sketchPath("DFT_sin_gen.exe"));
  String[] lines = loadStrings("ctrl_out.txt");
  //println("there are " + lines.length + " lines");
  String line;
  
  float[] t = new float [lines.length];
  float[] y = new float [lines.length]; 
  GPointsArray pos = new GPointsArray(lines.length-2);
 
  for (int i = 1 ; i < lines.length; i++) 
  {
    line = lines[i];
    String[] list = split(line, '\t');
    t[i] = float(list[0]);
    y[i] = float(list[1]);
    pos.add(t[i], y[i]);
  }
  
  GPlot plot = new GPlot(this);
  
  // Create a new plot and set its position on the screen
  plot.setPos(q4.x_offset, q4.y_offset);
  plot.setOuterDim(new float[] {600, 300});

  // Set the plot title and the axis labels
  plot.setTitleText("The Pos");
  plot.getXAxis().setAxisLabelText("t");
  plot.getYAxis().setAxisLabelText("Pos");
  plot.setLineColor(color(200, 200, 255));
  

    // Add the points
  plot.setPoints(pos);
  plot.setPointColor(color(0, 0, 0, 255));
  
  // Draw it!
  plot.defaultDraw();  

}

void setup()
{
  xOutput = createWriter("xdata.txt");
  yOutput = createWriter("ydata.txt");
  settingsFile = createWriter("settings.txt");
  
  f = createFont("Arial",20,true);
  background(255);
  fill(0);
  textFont(f);
  
  line(l/2,0,l/2,h);
  line(0,h/2,l,h/2);
  
  set_offsets();
  quarter_1();
  quarter_2();
  
  
  RunFile(0);
  quarter_3();
  RunFile(1);
  quarter_4();
  //frame.setResizable(true);
  
  xOutput.flush(); // Write the remaining data
  xOutput.close(); // Finish the file
  yOutput.flush(); // Write the remaining data
  yOutput.close(); // Finish the file
  settingsFile.flush(); // Finish the file
  settingsFile.close(); // Finish the file 
}

void RunFile(int i)
{
  if(i == 0)
  {
    PrintWriter output=null;
    output = createWriter("myfile.bat");
    //output.println("cd C:\\Users\\Ömer\\Desktop\\5LIU0\\GUI\\old_new\\gui\\");
    output.println("cd " + sketchPath(""));
    output.println("DFT_sin_gen.exe");
    output.flush();
    output.close();  
    output=null;
    //println(sketchPath(""));
    //launch(sketchPath("")+"myfile.bat");
    launch(sketchPath("")+"myfile.bat");
    //exec(sketchPath("")+"myfile.bat");
    //REFERENCE: //http:// stackoverflow.com/questions/33974730/processing-3-0-launch-function-doesnt-launch-my-exe
  }
  
  if(i == 1)
  {
    PrintWriter output=null;
    output = createWriter("myfile2.bat");
    output.println("cd " + sketchPath(""));
    output.println("fsfb.exe");
    output.flush();
    output.close();  
    output=null;
    //println(sketchPath(""));
    launch(sketchPath("")+"myfile2.bat");
    //exec(sketchPath("")+"myfile2.bat");
  }
  
}

  
void draw()
{
  if(update == 1)
  {
      background(255);
      fill(0);
      textFont(f);
      
      line(l/2,0,l/2,h);
      line(0,h/2,l,h/2);
      
      xOutput = createWriter("xdata.txt");
      yOutput = createWriter("ydata.txt");
      settingsFile = createWriter("settings.txt");
      
      quarter_1();
      quarter_2();
      
      RunFile(0);
      quarter_3();
      RunFile(1);
      quarter_4();
      
      xOutput.flush(); // Write the remaining data
      xOutput.close(); // Finish the file
      yOutput.flush(); // Write the remaining data
      yOutput.close(); // Finish the file
      settingsFile.flush(); // Finish the file
      settingsFile.close(); // Finish the file 
        
      update = 0;
  }
      
}

void controlEvent(ControlEvent theEvent) {
  if(theEvent.isAssignableFrom(Textfield.class)) {
    println("controlEvent: accessing a string from controller '"
            +theEvent.getName()+"': "
            +theEvent.getStringValue()
            );
            
      // Switch case doesn't work with strings in processing
            
      if(theEvent.getName() == formA) 
      { 
        s.A = float(theEvent.getStringValue());
        
        update = 1;
        //println(s.A);
      } 
      if(theEvent.getName() == formB) 
      { 
        s.B = float(theEvent.getStringValue());
        update = 1;
        //println(s.A);
      } 
      if(theEvent.getName() == formC) 
      { 
        s.C = float(theEvent.getStringValue());
        update = 1;
        //println(s.A);
      } 
      if(theEvent.getName() == formD) 
      { 
        s.D = float(theEvent.getStringValue());
        update = 1;
        //println(s.A);
      } 
      if(theEvent.getName() == formFsample) 
      { 
        s.Fsample = float(theEvent.getStringValue());
        update = 1;
        //println(s.A);
      } 
      
      if(theEvent.getName() == formFc) 
      { 
        s.sin_freq = float(theEvent.getStringValue());
        update = 1;
        //println(s.A);
      } 
      
      if(theEvent.getName() == formN) 
      { 
        s.Nsamples = int(theEvent.getStringValue());
        update = 1;
        //println(s.A);
      } 
  }
  //update = 1;
}
 
int inputCheck(String form)
{
  int error = 0;
  
  if(form == formA)
  {
    // No upper or lower bound
    //if(s.A > 100 || s.A < 0.0)
      error = 0;
  }

  if(form == formB)
  {
    if(s.B > 100 || s.A < 0.0)
      error = 1;
  }
  
  if(form == formA)
  {
    if(s.A > 100 || s.A < 0.0)
      error = 1;
  }  
  if(form == formA)
  {
    if(s.A > 100 || s.A < 0.0)
      error = 1;
  }
  
  
  return error;
}
  
