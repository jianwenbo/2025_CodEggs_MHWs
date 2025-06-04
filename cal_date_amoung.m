function [start_nanmhw, end_nanmhw] = cal_date_amoung(start_mhw,end_mhw, number,monthdays)
%这个函数用于提取非热浪期间的范围
%输入:start_mhw 1*number end_mhw 1*number number monthdays: 产卵季节长度
%输出:start_nanmhw end_nanmhw 1*number
start_nanmhw = nan(1,number);
end_nanmhw = nan(1,number);
jwb = ones(1,monthdays);
for i = 1:number
    if ~isnan(start_mhw(i)) 
        jwb(start_mhw(i):end_mhw(i)) = nan;
    end
end
long = length(jwb);
start_idx = [];
end_idx = [];
i = 1;
while i <= long
    if ~isnan(jwb(i)) % 如果当前元素不是 NaN
        start = i; % 记录非 NaN 范围的开始
        while i <= long && ~isnan(jwb(i)) % 继续遍历直到遇到 NaN 或数组结束
            i = i + 1;
        end
        finish = i - 1; % 记录非 NaN 范围的结束
        start_idx = [start_idx, start]; % 将开始索引添加到数组
        end_idx = [end_idx, finish]; % 将结束索引添加到数组
    else
        i = i + 1; % 如果当前元素是 NaN，继续遍历
    end
end
start_nanmhw(1:length(start_idx)) = start_idx;
end_nanmhw(1:length(end_idx)) = end_idx;
end
