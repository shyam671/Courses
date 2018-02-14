%Io = (imread('Assign3_imgs/rectangle1.jpg'));Size = 200;Canny = 0.15;th = 50;%Image1
%Io = (imread('Assign3_imgs/rectangle3.jpg'));Size = 400;Cany = 0.5 ; th = 60;
Io = (imread('Assign3_imgs/rectangle4.jpg'));Size = 400;Cany = 0.15 ; th = 80;
C = [0,-1,1,89,-89,90,-90];
Io = imresize(Io,[Size , Size ]);
I = rgb2gray(Io);
BW = edge(I,'canny',0.15);
figure,imshow(Io);
Theta = 90;
Rho =  ceil(Size*sqrt(2));
AccMat = zeros(2*Rho+1,2*Theta);

for x= 1:size(BW,1)
    for y = 1:size(BW,2)
     if(BW(x,y)==1)
        for theta = 0:pi/180:pi/2-pi/180
         rho = ceil(x*cos(theta) + y*sin(theta));
         radian  = round((theta/pi)*180);
         AccMat(Rho+rho+1,Theta+radian+1) =  AccMat(Rho+rho+1,Theta+radian+1) + 1;
        end
        
        for theta = -pi/2:pi/180:-pi/180 
         rho = ceil(x*cos(theta) + y*sin(theta));
         radian  = round((theta/pi)*180);
         AccMat(Rho + rho+1,radian + Theta + 1) =  AccMat(Rho+rho + 1,Theta + radian + 1 ) + 1;
        end
        
     end
    end
end
[row,col] = find(AccMat>th+10);
Rect_theta = [];Rect_phro = [];Max_Count = [];
for i = 1:size(row,1)
    
 if row(i)>Rho
   l = row(i) - Rho;
 else 
   l = -Rho + row(i); 
 end
 if col(i)>Theta
   angle = col(i) - Theta;
 else 
   angle = -Theta + col(i); 
 end
 if find(C==angle)
    Rect_theta = [Rect_theta angle];
    Rect_phro =  [Rect_phro  l];
    Max_Count = [Max_Count AccMat(row(i),col(i))];
 end    
 if find(C==angle)
  
  Y = round(l*cosd(angle)) ;
  X = round(l*sind(angle)) ;
 
 lineLength = Size;
 x(1) = X;
 y(1) = Y;
 x(2) = x(1) + lineLength * cosd(angle);
 y(2) = y(1) + lineLength * sind(angle);
 hold on; 
 plot(x, y);
 xlim([0 Size]);
 ylim([0 Size]);
 grid on;
 end
end



