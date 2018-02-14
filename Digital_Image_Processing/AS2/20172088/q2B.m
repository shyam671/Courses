%Low/High Pass filter: Ideal, Butterworth and Gaussian
I = double(rgb2gray(imread('/home/shyam/Downloads/Sem1/DIP/AS2/Assign2_imgs/other_images/saturn.png')));
I = imresize(I,[512 512]);
%figure,imshow(uint8(I));
[m,n] = size(I);
Do = 10;
%% High pass Ideal, Butterworth and Gaussian Filter

H = zeros(m,n);
for i = 1:m
    for j = 1:n
        D = sqrt((i-m/2)^2 + (j-n/2)^2);
        if D < Do
            H(i,j) = 1;
        end
    end
end
H = 1 - H;
%figure,imshow(H);
If = H.*fftshift(fft2(I));
ffi = ifft2(ifftshift(If));
figure
subplottight(1,3,1), imshow( uint8(abs(ffi)));title('IdealHighPass'); 
%figure,imshow(255 -uint8(abs(ffi)));

H = zeros(m,n);
for i = 1:m
    for j = 1:n
        D = sqrt((i-m/2)^2 + (j-n/2)^2);
        H(i,j) = 1/(1 + (Do/D)^2);
    end
end
If = H.*fftshift(fft2(I));
ffi = ifft2(ifftshift(If));
subplottight(1,3,2),imshow(uint8(abs(ffi)));title(' ButterworthHighPass'); 
H = zeros(m,n);
for i = 1:m
    for j = 1:n
        D = sqrt((i-m/2)^2 + (j-n/2)^2);
        H(i,j) = exp(-0.5*(D/Do)^2);
    end
end
H = 1 - H;

If = H.*fftshift(fft2(I));
ffi = ifft2(ifftshift(If));
subplottight(1,3,3),imshow(uint8(abs(ffi)));title('GaussianHighPass'); 
%% Low pass Ideal, Butterworth and Gaussian Filter

H = zeros(m,n);
for i = 1:m
    for j = 1:n
        D = sqrt((i-m/2)^2 + (j-n/2)^2);
        H(i,j) = exp(-0.5*(D/Do)^2);
    end
end
%figure,imshow(H);
If = H.*fftshift(fft2(I));
ffi = ifft2(ifftshift(If));
%figure,imshow(uint8(abs(ffi)));
figure
subplottight(1,3,1), imshow( uint8(abs(ffi)));title('GaussianLowPass'); 
H = zeros(m,n);
for i = 1:m
    for j = 1:n
        D = sqrt((i-m/2)^2 + (j-n/2)^2);
        H(i,j) = 1/(1 + (D/Do)^2);
    end
end
%figure,imshow(H);
If = H.*fftshift(fft2(I));
ffi = ifft2(ifftshift(If));
%figure,imshow(uint8(abs(ffi)));
subplottight(1,3,2), imshow(uint8(abs(ffi)));title('ButterworthLowPass'); 
H = zeros(m,n);
for i = 1:m
    for j = 1:n
        D = sqrt((i-m/2)^2 + (j-n/2)^2);
        if D < Do
            H(i,j) = 1;
        end
    end
end
%figure,imshow(H);
If = H.*fftshift(fft2(I));
ffi = ifft2(ifftshift(If));
%figure,imshow(uint8(abs(ffi)));
subplottight(1,3,3), imshow(uint8(abs(ffi)));title('IdealLowPass');
