function [sst_t] = cal_ssta_42_1(sst)
%该函数用于计算一个范围内温度的温度异常值，使用42年固定阈值，11天的窗口
%这个函数没有很好地考虑跨年的阈值情况
%输入：sst：lon*lat*(365*42)
%输出: ssta: lon*lat*365 当年的温度异常值
            for k=1:365
                    sst_temp33=[];% store the 11-day window data for each day
                    for n=-5:5
                        if k<=5
                            if k+n>=1
                            sst_temp33=cat(3,sst_temp33,sst(:,:,k+n:365:end));
                            else
                            sst_temp33=cat(3,sst_temp33,sst(:,:,k+n+365:365:end));%这里很好地考虑了去到上一年的情况
                            end
                        elseif k>=361
                            if k+n<=365
                            sst_temp33=cat(3,sst_temp33,sst(:,:,k+n:365:end));
                            else
                            sst_temp33=cat(3,sst_temp33,sst(:,:,k+n-365:365:end));
                            end
                        else
                            sst_temp33=cat(3,sst_temp33,sst(:,:,k+n:365:end));
                        end
                    end
                    sst_temp3_1=prctile(sst_temp33,90,3);% threshold for each day, sst_temp3_1是阈值数组，它的大小是lon*lat*341，对其求0.9分位数，并存储到sst_temp3，得到第k年每一天的阈值温度
                    sst_temp3(:,:,k)=sst_temp3_1;
                end

            sst_t=sst_temp3;
            % sst_t=movmean(sst_t,31,3);
            sst_t=squeeze(single(sst_t)); 
end
