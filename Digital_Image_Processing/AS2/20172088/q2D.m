I = double(rgb2gray(imread('/home/shyam/Downloads/Sem1/DIP/AS2/Assign2_imgs/notch_pass_reject_filter/notch3.jpg')));
%figure,imshow(uint8(I));
figure
subplottight(1,4,1),imshow(uint8(I));
F = fftshift(fft2(I));
%figure,imshow(log(F+1),[]);
subplottight(1,4,2), imshow(log(F+1),[]);title('FT'); 
[m,n] = size(F);
H = zeros(m,n);Do =40;
H(m/2-2:m/2+2,:) = 1;
H(:,m/2-2:m/2+2) = 1;
H = 1- H;
for i = 1:m
    for j = 1:n
        D = sqrt((i-m/2)^2 + (j-n/2)^2);
        if(D<Do)
            H(i,j) = 1;
        end
    end
end
Img = F.*H;
%figure,imshow(log(Img+1),[]);
subplottight(1,4,3), imshow(log(Img+1),[]);title('After Notch');
Ifft_ = ifft2(ifftshift(Img));
%figure,imshow(uint8(abs(Ifft_)));
subplottight(1,4,4),imshow(uint8(abs(Ifft_)));title('Result');
I = double((imread('/home/shyam/Downloads/Sem1/DIP/AS2/Assign2_imgs/notch_pass_reject_filter/notch2.jpg')));
%figure,imshow(uint8(I));
figure
subplottight(1,4,1),imshow(uint8(I));
F = fftshift(fft2(I));
%figure,imshow(log(F+1),[]);
subplottight(1,4,2), imshow(log(F+1),[]);title('FT'); 
[m,n] = size(F);
Do = 5;
C1 = [22 ,90];C2 = [44,53];
H1 = ones(m,n);H3 = ones(m,n);
for i = 1:m
    for j = 1:n
       D1 = sqrt((i-n/2-24)^2 + (j-n/2-44)^2);
       if(D1<Do)
         H1(i,j) = 0;
       end 
       D2 = sqrt((i-n/2+C2(1)/2-10)^2 + (j-n/2+C2(2)/2-5)^2);
       if(D2<Do)
         H3(i,j) = 0;
       end 
    end
end
H1 = H1(:,end:-1:1,:);
H2 = H1(end:-1:1,end:-1:1,:);
H4 = H3(end:-1:1,end:-1:1,:);
Img = F.*H1.*H2.*H3.*H4;
%figure,imshow(log(Img+1),[]);
subplottight(1,4,3), imshow(log(Img+1),[]);title('After Notch');
Ifft_ = ifft2(ifftshift(Img));
%figure,imshow(uint8(abs(Ifft_)))
subplottight(1,4,4),imshow(uint8(abs(Ifft_)));title('Result')
I = double((imread('/home/shyam/Downloads/Sem1/DIP/AS2/Assign2_imgs/notch_pass_reject_filter/notch1.png')));
I = imresize(I,[256 256]);
figure
subplottight(1,4,1),imshow(uint8(I));
F = fftshift(fft2(I));
subplottight(1,4,2), imshow(log(F+1),[]);title('FT'); 
%figure ,imshow(uint8(I));
[m,n] = size(F);
filter = ones(m,n);
Do = 15; 
C1 = [105,80];C2 = [140,79];C3 = [119,178];C4 = [153,179];
H1 = ones(m,n);H2 = ones(m,n);H3 = ones(m,n);
for i = 1:m
    for j = 1:n
        D1 = sqrt((i-C1(1)-n/2)^2 + (j-C1(2)-n/2)^2);
        if(D1<Do)
         H1(i,j) = 0;
        end
        D2 = sqrt((i+C1(1)-n/2)^2 + (j+C1(2)-n/2)^2);
        if(D2<Do)
         H2(i,j) = 0;
        end
        D3 = sqrt((i-C4(1)+n/2+5)^2 + (j-C4(2)+n/2)^2);
        if(D3<Do)
          H3(i,j) = 0;
        end
    end
end
H1 = fftshift(H1);H2 = fftshift(H2);H3 = fftshift(H3);
H3 = flipdim(H3,2);
H4 = H3(end:-1:1,end:-1:1,:);
Img = F.*H2'.*H1'.*H3'.*H4';
%figure,imshow(log(Img+1),[]);
subplottight(1,4,3), imshow(log(Img+1),[]);title('After Notch');
Ifft_ = ifft2(ifftshift(Img));
%figure,imshow(uint8(abs(Ifft_)))
subplottight(1,4,4),imshow(uint8(abs(Ifft_)));title('Result')