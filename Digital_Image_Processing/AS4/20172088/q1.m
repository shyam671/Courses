I = im2double(rgb2gray(imread('restore_03.jpg')));

%figure,imshow(I);
x = 1:size(I,1);
y = x;
[X,Y] = meshgrid(x);

length = 31;
angle = 10;
Kernel = fspecial('motion',length,angle);
H = fft2(Kernel,size(I,1),size(I,2));
Inverse_f2 = real(ifft2(fft2(I).*conj(H)./(abs(H).^2 + 1e-2)));
figure,subplottight(1,3,1),imshow((I));
subplottight(1,3,2),imshow(real(fftshift(H)));
subplottight(1,3,3),imshow((Inverse_f2))

I = im2double(imread('restore_01.jpg'));

x = 1:size(I,1);
y = x;
[X,Y] = meshgrid(x);
length = 31;
angle = 0;
Kernel = fspecial('motion',length,angle);
H = fft2(Kernel,size(I,1),size(I,2));

Inverse_f2 = real(ifft2(fft2(I).*conj(H)./(abs(H).^2 + 1e-2)));
figure,subplottight(1,3,1),imshow((I));
subplottight(1,3,2),imshow(real(fftshift(H)));
subplottight(1,3,3),imshow((Inverse_f2))

I = im2double(rgb2gray(imread('restore_04.jpg')));
I = imcrop(I,[166 116 332 270]);

x = 1:size(I,1);
y = x;
[X,Y] = meshgrid(x);
length = 25;
angle = 160;
Kernel = fspecial('motion',length,angle);
H = fft2(Kernel,size(I,1),size(I,2));

Inverse_f2 = real(ifft2(fft2(I).*conj(H)./(abs(H).^2 + 3e-2)));
figure,subplottight(1,3,1),imshow((I));
subplottight(1,3,2),imshow(real(fftshift(H)));
subplottight(1,3,3),imshow((Inverse_f2))

I = im2double(rgb2gray(imread('restore_02.jpg')));

x = 1:size(I,1);
y = x;
[X,Y] = meshgrid(x);
length = 9;
angle = 90;
Kernel = fspecial('gaussian',[7,7],10);
H = fft2(Kernel,size(I,1),size(I,2));

Inverse_f2 = real(ifft2(fft2(I).*conj(H)./(abs(H).^2 + 1e-2)));
figure,subplottight(1,3,1),imshow((I));
subplottight(1,3,2),imshow(real(fftshift(H)));
subplottight(1,3,3),imshow((Inverse_f2))