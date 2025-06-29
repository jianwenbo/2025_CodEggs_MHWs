计算海洋热浪的程序，这里计算了大西洋鳕鱼和极地鳕鱼两种鱼的产卵季期间计三种情况的热浪，分别别为AWI模式数据42年固定阈值热浪，AWI模式数据31年滑动阈值热浪，OISST数据42年固定阈值热浪。
其中movingbaseline.m和stablebaseline.m以及oisst_stablebaseline.m是三种情景下热浪的计算程序。
其他.m文件为自定义函数。

This program calculates MHWs during the spawning seasons of two fish species: Atlantic cod and polar cod. Three scenarios of MHWs are computed using different datasets and threshold methods: 
1. **42-year fixed threshold heatwaves using AWI model data** 
2. **31-year sliding threshold heatwaves using AWI model data** 
3. **42-year fixed threshold heatwaves using OISST observational data** 

The calculation scripts for the three scenarios are: - `movingbaseline.m` (sliding threshold method) - `stablebaseline.m` (fixed threshold method for AWI data) - `oisst_stablebaseline.m` (fixed threshold method for OISST data) Other `.m` files contain custom functions used in the calculations. 
