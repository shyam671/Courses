Io = (imread('Assign3_imgs/circle3.jpg'));
%rmin = 30;rmax = 80;thresh1 = 0.2;thresh2 = 140;%circle4
%rmin = 7;rmax = 10;thresh1 = 0.2;thresh2 = 150; %circle1
rmin = 35;rmax = 65;thresh1 = 0.9;thresh2 = 160; %circle3
Io = imresize(Io,[size(Io,1)/4, size(Io,2)/4]);
I = rgb2gray(Io);
BW = edge(I,'canny',thresh1);
AccMat = zeros(size(I,1),size(I,2),rmax-rmin +1);
figure,imshow(Io);
for x= 1:size(BW,1)
    for y = 1:size(BW,2)
        
     if(BW(x,y)==1)
         
        for r = rmin:rmax
          
          for theta = 0:360 
             a = round(x - r * cos(theta * pi / 180)); 
             b = round(y - r * sin(theta * pi / 180));
             if (a>0 && b>0)&&(a<size(BW,1) && b<size(BW,2))
              AccMat(a,b,r-rmin+1) = AccMat(a,b,r-rmin+1) + 1;
             end
          end
          
        end
     end
      
    end
end
[X,Y,R] = ind2sub(size(AccMat),find(AccMat > thresh2));
for i = 1:size(X,1)
 hold on
 th = 0:pi/50:2*pi;
 xunit = ((R(i)+rmin-1) * cos(th) + Y(i));
 yunit = ((R(i)+rmin-1) * sin(th) + X(i));
 h = plot(xunit, yunit);
 hold off
end