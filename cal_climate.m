function [climate] = cal_climate(sst)
%输入 sst lon lat  365×year
%输出 climate lon lat year-30 365
lon = size(sst,1);
lat = size(sst,2);
years = size(sst,3)/365;
for i = 1:lon
    for j = 1:lat
        lzy = movmean(squeeze(sst(i,j,:)), 11);
        sst_11mean(i,j,:) = lzy;
    end
end

for year = 1:years
    sst_year(:,:,year,:) = sst_11mean(:,:,(year-1)*365+1:365*year);
end 

climate = zeros(size(sst_year,1),size(sst_year,2),length(years-30),size(sst_year,4));
for k = 1:365
    for  year = 16:years-15
    climate(:,:,year-15,k) =  nanmean(sst_year(:,:,year-15:year+15,k),3);
    end
end 

clear sst
end