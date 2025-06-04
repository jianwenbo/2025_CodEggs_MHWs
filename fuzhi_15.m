function [a,b,c,d] = fuzhi_15(temp,a,b,c,d);
idx = a < temp;
a(idx) = nan;
b(idx) = nan;
c(idx) = nan;
d(idx) = nan;
end