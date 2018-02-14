I = double(rgb2gray(imread('Assign1_imgs/portraits2.jpg')));
figure,imshow(uint8(I))
% %% Gaussian Filtering
%Sd = 50;WinSize = 8;
%Sd = 10 ; WinSize = 8;
Sd = 5 ; WinSize = 8;
GaussOut = zeros(size(I,1)-2*WinSize-1,size(I,2)-2*WinSize-1);
[X,Y] = meshgrid(-WinSize:WinSize);
G = (1/(2*WinSize+1).^2).*exp((-X.^2 -Y.^2)/(Sd.^2));

for i = 1:size(I,1)-2*WinSize-1
    for j = 1:size(I,2)-2*WinSize-1
        GaussOut(i,j) = sum(sum(I(i:i+2*WinSize,j:j+2*WinSize).*G));
    end
end

figure,imshow(uint8(GaussOut));

%% Median Filtering
 I = rgb2gray(imread('Assign1_imgs/zelda512-NoiseV400.jpg'));
 figure,imshow(I);
 Ws = 8;
 MedFilImg = zeros(size(I,1)-Ws-1,size(I,2)-Ws-1);
for i = 1:size(I,1)-Ws-1
     for j = 1:size(I,2)-Ws-1
         temp = I(i:i+Ws-1,j:j+Ws-1);
         temp = sort(temp);
         MedFilImg(i,j) = temp(2*Ws-1);
     end
end
figure,imshow(uint8(MedFilImg));
 %% High Boost Filtering
I = double(rgb2gray(imread('Assign1_imgs/bell.jpg')));
I = imresize(I,[size(I,1)/2 size(I,2)/2]);
figure,imshow(uint8(I))
Sd = 90;K = 4;WinSize = 8;
GaussOut = zeros(size(I,1),size(I,2));
[X,Y] = meshgrid(-WinSize:WinSize);
G = (1/(2*WinSize+1).^2).*exp((-X.^2 -Y.^2)/(Sd.^2));
for i = 1:size(I,1)-2*WinSize-1
    for j = 1:size(I,2)-2*WinSize-1
        GaussOut(i,j) = sum(sum(I(i:i+2*WinSize,j:j+2*WinSize).*G));
    end
end
%figure,imshow(uint8(GaussOut));
I = I + K*(I - GaussOut);
I = I(1:size(I,1)-2*WinSize-1,1:size(I,2)-2*WinSize-1);
figure,imshow(uint8(I));


    
    
    

































