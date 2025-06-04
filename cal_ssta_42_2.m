function [ssta] = cal_ssta_42_2(sst,sst_t)
%该函数用于计算一个范围内温度的温度异常值，使用42年固定阈值，11天的窗口
%这个函数没有很好地考虑跨年的阈值情况
%输入：sst：lon*lat*365 sst_t lon*lat*365
%输出: ssta: lon*lat*365 当年的温度异常值
            ssta=sst-squeeze(sst_t);%要取出需要算的那年的海温
            ssta(ssta<=0)=NaN;
            ssta=single(ssta); 

end
