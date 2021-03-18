import themidibus.*;
MidiBus myBus;
int num=400, size=10, note_on1, note_on2;
float x1_prev, y1_prev, x2_prev, y2_prev, x1_curr, y1_curr, x2_curr, y2_curr;
int[] notes1=new int[num];
int[] notes2=new int[num];
color[] c=new color[12];

void setup () {
  size(1200, 800);
  for (int i=0; i<12; i++) c[i]=color(random(0, 255), random(0, 255), random(0, 255));
  MidiBus.list();
  myBus = new MidiBus(this, 1, 2);
  strokeWeight(4);
}

void noteOn(int channel, int note, int velocity) {
  if (channel==0) {
    note_on1=1;
    notes1[0]=note;
    for (int i=num-1; i>0; i--) {
      notes1[i]=notes1[i-1];
    }
  }
  if (channel==1) {
    note_on2=1;
    notes2[0]=note;
    for (int i=num-1; i>0; i--) notes2[i]=notes2[i-1];
  }
}

void draw() {
  //fill(0, 64);
  //noStroke();
  //rect(0, 0, width, height);
  background(0);
  for (int i=0; i<12; i++) {
    fill(c[i]);
    stroke(c[i]);
    rect(map(i, 0, 12, 0, width), height, width/12.0, -40);
  }
  if (note_on1==1) {
    for (int i=0; i<num; i++) {
      fill(c[notes1[i]%12]);
      stroke(c[notes1[i]%12]);
      x1_curr=map(i, 0, num, 0, width);
      y1_curr=map(notes1[i], 0, 127, height, 0);
      ellipse(x1_curr, y1_curr, size, size);
      //line(x1_prev, y1_prev, x1_curr, y1_curr);
      //x1_prev=map(i, 0, num, 0, width);
      //y1_prev=map(notes1[i], 0, 127, 0, height);
    }
  }
  if (note_on2==1) {
    for (int i=0; i<num; i++) {
      fill(c[notes2[i]%12]);
      stroke(c[notes2[i]%12]);
      x2_curr=map(i, 0, num, 0, width);
      y2_curr=map(notes2[i], 0, 127, height, 0);
      ellipse(x2_curr, y2_curr, size, size);
      //line(x2_prev, y2_prev, x2_curr, y2_curr);
      //x2_prev=map(i, 0, num, 0, width);
      //y2_prev=map(notes2[i], 0, 127, 0, height);
    }
  }
}
