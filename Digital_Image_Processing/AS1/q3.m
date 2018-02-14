
I = double(rgb2gray(imread('Assign1_imgs/bell.jpg')));
I = imresize(I,[320 240]);
figure,imshow(uint8(I));
revI = double(zeros(size(I)));
%ax = 1;ay = 1;tx = 1; ty = 1;
%ax = 2;ay = 3;tx = 2; ty = 5;
%ax = 4;ay = 6;tx = 4; ty = 10;
%ax = 4;ay = 6;tx = 8; ty = 20;
ax = 8;ay = 12;tx = 4; ty = 10;
for i = 1:size(I,1)
    i
    for j = 1:size(I,2)
        tempi = i + ax*sin((2*pi*j)/tx);
        tempj = j + ay*sin((2*pi*i)/ty);
        if (tempi>0 && tempi <=size(I,1))&& (tempj>0 && tempj <= size(I,2))
           revI(i,j) = interp2(I,tempi,tempj); 
        end
    end
end
figure,imshow(uint8(revI));

I = double(rgb2gray(imread('Assign1_imgs/bell.jpg')));
I = imresize(I,[320 240]);
revI = double(zeros(size(I)));
Xc = size(I,1)/2;
Yc = size(I,2)/2;
%rmax = 50;p = 3;
%rmax = 50;p = 4;
%rmax = 50;p = 5;
%rmax = 50;p = 6;
rmax = 80;p = 7;
for  x = 1:size(I,1)
     x
    for y = 1:size(I,2)
        dx = x - Xc; dy = y - Yc; r = sqrt(dx^2 + dy^2); 
        if r <= rmax
           z = sqrt(rmax^2 - r^2);           
           Bx = (1 - 1/p)*asin(dx/sqrt(dx^2 + z^2));
           By = (1 - 1/p)*asin(dy/sqrt(dy^2 + z^2));
           revI(x,y) = interp2(I,x- z*tan(Bx),y - z*tan(By));
        else
           revI(x,y) = I(x,y);
        end
    end
end
figure,imshow(uint8(revI));



