Io = (imread('Assign3_imgs/parabola1.jpg'));thresh2 = 825;thresh1 = 0.2;amax = 30;amin = 15;
%Io = (imread('Assign3_imgs/parabola3.jpg'));thresh2 = 200;thresh1 = 0.1;amax = 40;amin = 30;
%Io = (imread('Assign3_imgs/parabola2.jpg'));thresh2 = 700;thresh1 = 0.3;amax = 40;amin = 30;
%450%Img3
%800%Img1
%1700%Img2

Io = imresize(Io,[size(Io,1)/4, size(Io,2)/4]);
I = rgb2gray(Io);
BW = edge(I,'canny',thresh1);
figure,imshow(BW);
AccMat = zeros(size(I,1),size(I,2),amax-amin+1);
for x = 1:size(I,1)
    
    for y = 1:size(I,2)
        if(BW(x,y)==1)
            for xo = 1:size(I,1)
                for yo = 1:size(I,2)
                   
                    a = abs(round(1/4*(((x-xo)^2)/(y-yo))));
                    
                    if (a>0 && a<amax && a>=amin)
                        AccMat(x,y,a-amin+1) = AccMat(x,y,a-amin+1) + 1;
                    end
                end
            end
        end
    end
end

[X,Y,a] = ind2sub(size(AccMat),find(AccMat>=thresh2));

hold on
plot(Y, X, 'r*');