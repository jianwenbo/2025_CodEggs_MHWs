function [sst_shape1]=trans_shape(sst_shape2)
if size(sst_shape2,4) == 1%三维
   for year = 1:(size(sst_shape2,3)/365)
   sst_shape1(:,:,year,:) = sst_shape2(:,:,(year-1)*365+1:365*year);
   end 
else
    for year = 1:size(sst_shape2,3)
    sst_shape1(:,:,(year-1)*365+1:365*year) = sst_shape2(:,:,year,:);
    end 
end
end