function f = cubic(x)
    a = -0.9;
    absx = abs(x);
    absx2 = absx.^2;
    absx3 = absx.^3;
    f = ((a+2)*absx3 - (a+3)*absx2 + 1) .* (absx <= 1) + ...
        (a*absx3 -5*a*absx2 + 8*a*absx - 4*a) .* ((1 < absx) & (absx <= 2));
end
