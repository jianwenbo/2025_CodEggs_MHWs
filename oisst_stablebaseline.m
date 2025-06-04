%31年的滑动阈值，其热浪时间范围(ssta,meantemp_mhw,duration,meantemp_nanmhw)1982-2100 meantemp_climate范围1982-2085
clear;clc
datadir=['OISST/'];
filelist=dir([datadir,'*.nc'])
time_length= length(filelist);

for s=1:time_length
        s
        filename=[datadir,filelist(s).name]; 
        sst{s}=ncread(filename,'sst',[1,601,1,1],[inf,120,inf,inf]);
        %sst{s}=ncread(filename,'sst',[1,601,1,1],[10,10,inf,inf]);
end
sst=cat(3,sst{:});
[sst_thre] = cal_ssta_42_1(sst(:,:,1:42*365));
[sst] = trans_shape(sst);
for year = 1:42
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
[duration_mhw_atl,meantemp_mhw_atl] = cal_meantemp(sst_atl,start_mhw_atl,end_mhw_atl);
[meantemp_mhw_atl,duration_mhw_atl,ci_atl] = fuzhi_15(-1.5,meantemp_mhw_atl,duration_mhw_atl,ci_atl);
save(['atlantic.mat'],'duration_mhw_atl','meantemp_mhw_atl','ci_atl','-v7.3');
clear sst_atl climate_atl duration_mhw_atl meantemp_mhw_atl meantemp_climate_atl duration_nanmhw_atl meantemp_nanmhw_atl start_mhw_atl end_mhw_atl start_nanmhw_atl end_nanmhw_atl

[sst_polar] = tiqu_polar(sst);
[duration_mhw_polar,meantemp_mhw_polar] = cal_meantemp(sst_polar,start_mhw_polar,end_mhw_polar);
[meantemp_mhw_polar,meantemp_climate_polar,duration_mhw_polar,ci_polar] = fuzhi_15(-1.5,meantemp_mhw_polar,meantemp_climate_polar,duration_mhw_polar,ci_polar);
save(['polar.mat'],'duration_mhw_polar','meantemp_mhw_polar','ci_polar','-v7.3');
clear

