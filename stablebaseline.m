%42年固定阈值，其热浪时间范围(ssta,meantemp_mhw,duration,meantemp_nanmhw)1982-2100 meantemp_climate范围1982-2085
 clear;clc
for y=1:24
    y 
fbl = 60;
lon = ncread(['shuju/sst2004.nc'],'lon',[(y-1)*fbl+1],[fbl]);
lat = ncread(['shuju/sst2004.nc'],'lat'); 
datadir=['shuju/'];
filelist=dir([datadir,'*.nc'])
time_length= length(filelist);

for s=1:time_length
        s
        filename=[datadir,filelist(s).name];
        sst{s}=squeeze(ncread(filename,'sst',[(y-1)*fbl+1 1 1 1],[fbl inf inf inf]));%
end
sst=cat(3,sst{:});
tim=datenum('1-Jan-1967'):datenum('31-Dec-2100');
TIM = datestr(tim,'yyyymmdd');
start_date = datetime(1967, 1, 1);  
end_date = datetime(2100, 12, 31);
date_range = start_date:end_date;
valid_dates = date_range(~(month(date_range) == 2 & day(date_range) == 29));
valid_indices = find(ismember(start_date:end_date, valid_dates));
sst=sst(:,:,valid_indices);
sst(sst<-1000)=NaN;
[climate] = cal_climate(sst);
sst = sst(:,:,15*365+1:119*365);
%此时去闰年成功，计算阈值温度
[sst_thre] = cal_ssta_42_1(sst(:,:,1:42*365));
[sst] = trans_shape(sst);
for year = 1:104
    [ssta(:,:,year,:)] = cal_ssta_42_2(squeeze(sst(:,:,year,:)),sst_thre);
end

%极地鳕鱼
number = 20;
ssta_polar = tiqu_polar(ssta);%lon lat 104 121
%极地鳕鱼热浪的时间
for i = 1:size(ssta_polar,1)
    for j = 1:size(ssta_polar,2)
        for year = 1:size(ssta_polar,3)
            [start_mhw_polar(i,j,year,:),end_mhw_polar(i,j,year,:)] = cal_date(squeeze(ssta_polar(i,j,year,:)),number);
        end
    end
end
%极地鳕鱼非热浪的时间
for i = 1:size(ssta_polar,1)
    for j = 1:size(ssta_polar,2) 
        for year = 1:size(ssta_polar,3)
            [start_nanmhw_polar(i,j,year,:), end_nanmhw_polar(i,j,year,:)] = cal_date_amoung(start_mhw_polar(i,j,year,:),end_mhw_polar(i,j,year,:), number,size(ssta_polar,4));
        end
    end
end

%大西洋鳕鱼
number = 20;
ssta_atl = tiqu_atl(ssta);%lon lat 104 92
%大西洋鳕鱼热浪的时间
for i = 1:size(ssta_atl,1)
    for j = 1:size(ssta_atl,2)
        for year = 1:size(ssta_atl,3)
            [start_mhw_atl(i,j,year,:),end_mhw_atl(i,j,year,:)] = cal_date(squeeze(ssta_atl(i,j,year,:)),number);
        end
    end
end
%大西洋鳕鱼非热浪的时间
for i = 1:size(ssta_atl,1)
    for j = 1:size(ssta_atl,2) 
        for year = 1:size(ssta_atl,3)
            [start_nanmhw_atl(i,j,year,:), end_nanmhw_atl(i,j,year,:)] = cal_date_amoung(start_mhw_atl(i,j,year,:),end_mhw_atl(i,j,year,:), number,size(ssta_atl,4));
        end
    end
end
% save(['D:\环北极鱼卵热浪\date\',num2str(y),'.mat'],'start_mhw_polar','end_mhw_polar','start_nanmhw_polar','end_nanmhw_polar','start_mhw_atl','end_mhw_atl','start_nanmhw_atl','end_nanmhw_atl','-v7.3');
%计算ci
[ci_polar] = cal_ci(start_mhw_polar,end_mhw_polar,ssta_polar);
[ci_atl] = cal_ci(start_mhw_atl,end_mhw_atl,ssta_atl);

%清理ssta
clear ssta ssta_atl ssta_polar
%%
%计算平均温度和气候态温度平均
[sst_atl] = tiqu_atl(sst);
[climate_atl] = tiqu_atl(climate);
[duration_mhw_atl,meantemp_mhw_atl] = cal_meantemp(sst_atl,start_mhw_atl,end_mhw_atl);
[duration_mhw_atl,meantemp_climate_atl] = cal_meantemp(climate_atl,start_mhw_atl,end_mhw_atl);
[duration_nanmhw_atl,meantemp_nanmhw_atl] = cal_meantemp(sst_atl,start_nanmhw_atl,end_nanmhw_atl);
%去除-1.5(根据meantemp)
[meantemp_mhw_atl,meantemp_climate_atl,duration_mhw_atl,ci_atl] = fuzhi_15(-1.5,meantemp_mhw_atl,meantemp_climate_atl,duration_mhw_atl,ci_atl);
save(['result2/atlantic/',num2str(y),'.mat'],'duration_mhw_atl','meantemp_mhw_atl','meantemp_climate_atl','duration_nanmhw_atl','meantemp_nanmhw_atl','lon','lat','ci_atl','-v7.3');
clear sst_atl climate_atl duration_mhw_atl meantemp_mhw_atl meantemp_climate_atl duration_nanmhw_atl meantemp_nanmhw_atl start_mhw_atl end_mhw_atl start_nanmhw_atl end_nanmhw_atl

[sst_polar] = tiqu_polar(sst);
[climate_polar] = tiqu_polar(climate);
[duration_mhw_polar,meantemp_mhw_polar] = cal_meantemp(sst_polar,start_mhw_polar,end_mhw_polar);
[duration_mhw_polar,meantemp_climate_polar] = cal_meantemp(climate_polar,start_mhw_polar,end_mhw_polar);
[duration_nanmhw_poalr,meantemp_nanmhw_polar] = cal_meantemp(sst_polar,start_nanmhw_polar,end_nanmhw_polar);
[meantemp_mhw_polar,meantemp_climate_polar,duration_mhw_polar,ci_polar] = fuzhi_15(-1.5,meantemp_mhw_polar,meantemp_climate_polar,duration_mhw_polar,ci_polar);
save(['result2/polar/',num2str(y),'.mat'],'duration_mhw_polar','meantemp_mhw_polar','meantemp_climate_polar','duration_nanmhw_poalr','meantemp_nanmhw_polar','lon','lat','ci_polar','-v7.3');
clear
end

