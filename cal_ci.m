function [ci] = cal_ci(start_mhw,end_mhw,ssta)
%输入 start_mhw end_mhw lon lat year number
%输入 ssta lon lat year monthdays
%输出 ci lon lat year number
lon = size(start_mhw,1);
lat = size(start_mhw,2);
years = size(start_mhw,3);
number = size(start_mhw,4);
ci = nan(size(start_mhw));
for year = 1:years
    for i = 1:lon
        for j = 1:lat
            for k = 1:number
                 if isnan(start_mhw(i,j,year,k))==0;
                     sdate = start_mhw(i,j,year,k);
                     edate = end_mhw(i,j,year,k);
                     ci(i,j,year,k) = nansum(ssta(i,j,year,sdate:edate));
                 end
            end
        end
    end
end 
end