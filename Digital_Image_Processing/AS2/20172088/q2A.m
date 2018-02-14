function main()

  I = double((imread('/home/shyam/Downloads/Sem1/DIP/AS2/Assign2_imgs/notch_pass_reject_filter/notch1.png')));
  I = imresize(I,[256 256]);
  [m,n] = size(I);
  Ifftc = zeros(m,n);
  for inc1 = 1:n
     Ifftc(:,inc1) = my_fft(I(:,inc1));
  end
  Ifftr = zeros(m,n);
  for inc1 = 1:m
     Ifftr(inc1,:) = (my_fft((Ifftc(inc1,:))'))';
  end
  figure,imshow((abs(log((Ifftr)))),[]);
  
  Ifftm = fft2(I);
  figure,imshow((abs(log((Ifftm)))),[]);
  sum(Ifftm(:) - Ifftr(:))
  

end

function Y = my_fft(a)
  if size(a,1) == 1
      Y = a;
  else
   n = size(a,1);
   Wn = exp((-2i*pi)/n);
   W = 1;
  
   Y_even = my_fft(a(1:2:size(a,1)));
   Y_odd = my_fft(a(2:2:size(a,1)));
   tempY = zeros(n,1);
   for k = 1:n/2
       tempY(k) = Y_even(k) + W*Y_odd(k);
       tempY(k+n/2) = Y_even(k) - W*Y_odd(k);
       W = W*Wn;
   end
   Y = tempY;
  end
end



