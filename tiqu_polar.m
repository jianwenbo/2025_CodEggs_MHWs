function [sst_polar] = tiqu_polar(sst)
%输入 sst lon lat year 365
%输出 sst_polar lon lat year-1 121
for year = 1:size(sst,3)-1
        sst_polar(:,:,year,1:31)=sst(:,:,year,335:365);
        sst_polar(:,:,year,32:121)=sst(:,:,year+1,1:90);
end
end