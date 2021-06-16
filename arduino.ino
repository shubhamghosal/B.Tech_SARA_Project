

#include <Servo.h> 
 
Servo myservo1;
Servo myservo2;
Servo myservo3;
Servo myservo4;               
int pos = 0;   
 int c;
void setup() 
{ 
  Serial.begin(9600);
  myservo1.attach(2); 
 myservo2.attach(3);
  myservo3.attach(7);
  myservo4.attach(12);
  pinMode(22,OUTPUT);
} 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 
void loop() 
{ 
   if (Serial.available())
  {
    c = Serial.read();
    if(c == 'd'){
      digitalWrite(22,LOW);
      
  for(pos = 30; pos <= 85; pos += 1)
  {                                  
    myservo1.write(pos);
    delay(15); 
                            
  } 
   for(int x = 0; x<=20; x+=1){
    myservo4.write(x);
    }
  
  
  delay(500);
   for(int j = 90; j>=50; j-=1){
    myservo2.write(j);
    delay(25);
    }
  
    for(int k = 95; k>=80; k-=1){
    myservo3.write(k);
    delay(10);
    
    }
    delay(500);
    for(int y = 20; y>=0; y-=1){
    myservo4.write(y);
    }
    
    delay(500);
     for(int m = 50; m<=90; m+=1){
    myservo2.write(m);
    delay(25);
    }
    for(int n = 80; n<=95; n+=1){
    myservo3.write(n);
    delay(10);
    
    }
    delay(1000);






    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
  for(pos = 85; pos>=30; pos-=1)     
  {                                
    myservo1.write(pos);              
       delay(15);                   
  } 
  delay(500); 
  for(int q = 95; q>=80; q-=1){
    myservo3.write(q);
    delay(10);
    }
    
   for(int p = 90; p>=50; p-=1){
    myservo2.write(p);
    delay(25);
    }
  
    
    delay(500);
    for(int z = 0; z<=20; z+=1){
    myservo4.write(z);
    }
    delay(500);
      for(int r = 50; r<=90; r+=1){
    myservo2.write(r);
    delay(25);
    }
    for(int s = 80; s<=95; s+=1){
    myservo3.write(s);
    delay(10);
    
    }
    delay(1000);
      Serial.println(1);
    }
  
    else if(c == 'p')
    {
      Serial.println(1);
    }
    else{
      }
} 

else
{
    digitalWrite(22,HIGH);
  for(int y = 0; y<=1; y+=1){
    myservo4.write(y);
    }
  for(pos = 29; pos <= 30; pos += 1)
  {                                  
    myservo1.write(pos);
    delay(15); 
                            
  } 
  delay(1000);
     for(int m = 89; m<=90; m+=1){
    myservo2.write(m);
    delay(25);
    }
    for(int n = 94; n<=95; n+=1){
    myservo3.write(n);
    delay(10);
    
    }
    delay(800);

  
}

}
