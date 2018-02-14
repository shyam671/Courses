I = im2double(imread('Uncompressed_02.BMP'));
figure,imshow((I));
I1 = I(:,:,1);
I2 = I(:,:,2);
I3 = I(:,:,3);
Cr = 0.5;
X1=zeros(size(I,1)/8,size(I,2)/8,8,8);
X2=zeros(size(I,1)/8,size(I,2)/8,8,8);
X3=zeros(size(I,1)/8,size(I,2)/8,8,8);

Q_y = [16  11 10 16 124  140  151  161;
       12 12 14 19 126  158  160  155;
       14 13 16 24 140  157  169  156;
       14 17 22 29 151  187  180  162;
       18 22 37 56 168  109  103  177;
       24 35 55 64 181  104  113  192;
       49 64 78 87 103  121  120  101;
       72 92 95 98 112  100  103  199 ] ;
 Q_c =   [17  18 24 47 99 99 99  99;
          18 21 26 66 99 99 99  99;
          24 26 56 99 99 99 99  99;
          47 66 99 99 99 99 99  99;
          99 99 99 99 99 99 99  99;
          99 99 99 99 99 99 99  99;
          99 99 99 99 99 99 99  99;
          99 99 99 99 99 99 99  99 ] ;
Q_y = round(Cr*Q_y);
Q_c = round(Cr*Q_c);
Comp_Img1 = cell((size(I,1)/8),(size(I,2)/8));
Comp_Img2 = cell((size(I,1)/8),(size(I,2)/8));
Comp_Img3 = cell((size(I,1)/8),(size(I,2)/8));

for J=1:size(I,1)/8
    for K=1:size(I,2)/8
        for j=1:8
            for k=1:8
                X1(J,K,j,k)=I1((J-1)*8+j,(K-1)*8+k);
                X2(J,K,j,k)=I2((J-1)*8+j,(K-1)*8+k);
                X3(J,K,j,k)=I3((J-1)*8+j,(K-1)*8+k);
            end
        end
    end
end
Count = 0;
Final_length = [];
for J=1:size(I,1)/8
    for K=1:size(I,2)/8        
        Im_temp=squeeze(X1(J,K,:,:));
        Im_temp=round(  (fft2( double(Im_temp) - 127 ))./Q_y);
        LO = mat2lin(Im_temp);
        L = detect_last_o(LO);
        Final_length = [Final_length real(L)];
        Count = Count + size(L,2);
        Comp_Img1{J,K} = L;
        
        Im_temp=squeeze(X2(J,K,:,:));
        Im_temp=round(  (fft2( double(Im_temp) - 127 ))./Q_c);
        LO = mat2lin(Im_temp);
        L = detect_last_o(LO);
        Final_length = [Final_length real(L)];
        Count = Count + size(L,2);
        Comp_Img2{J,K} = L;
        
        Im_temp=squeeze(X3(J,K,:,:));
        Im_temp=round(  (fft2( double(Im_temp) - 127))./Q_c);
        LO = mat2lin(Im_temp);
        L = detect_last_o(LO);
        Final_length = [Final_length real(L)];
        Count = Count + size(L,2);
        Comp_Img3{J,K} = L;
    end
end
disp('-------CompressionRatio---------')
disp(Count/(3*size(I,1)*size(I,2)));
I_c1 = zeros(size(I,1),size(I,2));
I_c2 = zeros(size(I,1),size(I,2));
I_c3 = zeros(size(I,1),size(I,2));
Encoded = RunLengthEncoding(Final_length);

for J=1:size(I,1)/8
    for K=1:size(I,2)/8        
        
        R = lin2mat(Comp_Img1{J,K},8,8);
        R = ifft2(R.*Q_y) + 127;
        for j=1:8
            for k=1:8                
                I_c1((J-1)*8+j,(K-1)*8+k) = R(j,k);
            end
        end
        
        R = lin2mat(Comp_Img2{J,K},8,8);
        R = ifft2(R.*Q_c) + 127;
        for j=1:8
            for k=1:8                
                I_c2((J-1)*8+j,(K-1)*8+k) = R(j,k);
            end
        end
        
        R = lin2mat(Comp_Img3{J,K},8,8);
        R = ifft2(R.*Q_c) + 127;
        for j=1:8
            for k=1:8                
                I_c3((J-1)*8+j,(K-1)*8+k) = R(j,k);
            end
        end
    end
end
I_c = cat(3,I_c1,I2,I3);
figure,imshow(real(I_c));



%% RMS error
difference = double(I) - double(real(I_c));
squaredError = difference .^ 2;
figure,imshow((squaredError));
meanSquaredError = sum(squaredError(:)) / numel(I);
rmsError = sqrt(meanSquaredError);
disp('-------------RMSError---------')
disp(rmsError)