function [start_mhw,end_mhw] = cal_date(ssta,number)
%该函数可以根据温度异常值计算热浪的开始和结束时间
%输入:ssta 1×长度
%输出: start_mhw:1×60 end_mhw
start_mhw = nan(1,number);
end_mhw = nan(1,number);
% ssta = [1,1,1,1,1,1,nan,nan,1,1,nan,1,1,1,nan,nan,1,1,1,1,1,1,nan,nan];
long = length(ssta);
        o=1;k=1;%o用来代表海洋热浪时间发生的次数，k表示开始的日期
        while k<=long-4%k不是最后的四天
            if sum(isnan(ssta(k:k+4))==1)==0%如果这四天存在海洋热浪事件
                m=k+4;n=0;%m代表时间结束的天数，k代表事件开始的天数，n计数
                while m<long%m没有超过总天数的最大日期
                    m=m+1;%这个时候对下一天进行判定
                    %这个时候一共有俩个情况，一种是下一天会低于阈值(超过两天低于与阈值后热浪结束 或者 间隔一天或者两天后后面接着一个至少天数为五天的热浪)，另一种是高于阈值(这种情况不需要予以讨论，while循环会自动进行)
                    if isnan(ssta(m))==1%如果下一天低于阈值，n加上1
                        n=n+1;%n~=0&&isnan(sst_a90_all(i,j,m,x))==0 并列
                        if n>2%循环直到n大于2时，这个时候热浪结束
                            m=m-n;%对m的值进行修正，因为先前的延期测试让m的值多了n-1天
                            break
                        end
                        
                    elseif n~=0&&isnan(ssta(m))==0%和 isnan(sst_a90_all(i,j,m,x))==1 并列，这个时候判断n不等于0且第m天温度高于阈值
                        if m+4<=long&&sum(isnan(ssta(m:m+4))==1)==0%热浪结束时间不超过总日期，且m的前四天都高于阈值，这个时候判断两个热浪之间是否隔了一天
                            m=m+4;n=0;%如果出现5 0 5 的情况，视为一个热浪
                        else%
                            m=m-n-1;%后面五天没有连续的热浪，则恢复到原来的日期
                            break
                        end
                    end        
                end
               
                start_mhw(o)=k;
                if m == length(ssta) && isnan(ssta(m-1)) == 1
                    m = m-2;
                end
                end_mhw(o)=m;%经度纬度年份以及次数
                o=o+1;
                k=m+1;
            else 
                k=k+1;
            end
        end
end
