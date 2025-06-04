function [sst_atl] = tiqu_atl(sst)
%输入 sst lon lat year 365
%输出 sst_polar lon lat year-1 121
for year = 1: size(sst,3)
       sst_atl(:,:,year,:)=sst(:,:,year,60:151);  
end
end