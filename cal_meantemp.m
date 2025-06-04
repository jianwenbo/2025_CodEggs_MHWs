function [duration,meantemp] = cal_meantemp(sst,start_mhw,end_mhw)
%这个函数用于计算平均温度和持续时间 不用外部循环
%输入 sst lon*lat*year*365 start_mhw lon*lat*year*number
%输出 duration meantemp lon*lat*year*number
lon = size(start_mhw,1);
lat = size(start_mhw,2);
years = size(start_mhw,3);
number = size(start_mhw,4);
duration = nan(size(start_mhw));
meantemp = nan(size(start_mhw));
for year = 1:years
    for i = 1:lon
        for j = 1:lat
            for k = 1:number
                 if isnan(start_mhw(i,j,year,k))==0 && isnan(nanmean(sst(i,j,year,:)))==0;
                     sdate = start_mhw(i,j,year,k);
                     edate = end_mhw(i,j,year,k);
                     %pol_30W_temp(i,j,year,k) = mean(sstyear(i,j,sdate:edate));
                     meantemp(i,j,year,k) = nanmean(sst(i,j,year,sdate:edate));
                     duration(i,j,year,k) = edate-sdate+1;
                 end
            end
        end
    end
end 
end