I = double(rgb2gray(imread('/home/shyam/Downloads/Sem1/DIP/AS2/Assign2_imgs/other_images/saturn.png')));
I = imresize(I,[512 512]);
figure
subplottight(1,3,1), imshow( uint8(I));title('Original'); 
%figure,imshow(uint8(I));
[m,n] = size(I); 
H = zeros(m,n);
for i = 1:m
    for j = 1:n
        D = sqrt((i-m/2)^2 + (j-n/2)^2);
        H(i,j) = 4*pi^2*(D^2);
    end
end
H = H./max(H(:));
subplottight(1,3,2), imshow((H));title('LaplacianFilter'); 
If = H.*fftshift(fft2(I));
ffi = ifft2(ifftshift(If));
subplottight(1,3,3), imshow((abs(ffi)));title('Output Image'); 
%figure,imshow((abs(ffi)));