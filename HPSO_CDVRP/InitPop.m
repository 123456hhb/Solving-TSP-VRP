function VRProute=InitPop(CityNum,Distance,Demand,Travelcon,Capacity)
%% 初始化各粒子

%输入：
%CityNum	需求点个数
%Distance       距离矩阵
%Demand      各点需求量
%Travelcon      行程约束
%Capacity   车容量约束

%输出：
%VRProute	VRP路径

TSProute=[0,randperm(CityNum)]+1; %随机生成一条不包括尾位的TSP路线
VRProute=ones(1,CityNum*2+1); %初始化VRP路径

DisTraveled=0;  % 汽车已经行驶的距离
delivery=0;% 汽车已经送货量，即已经到达点的需求量之和
k=1;
for j=2:CityNum+1
	k=k+1;   %对VRP路径下一点进行赋值

	if  DisTraveled+Distance(VRProute(k-1),TSProute(j))+Distance(TSProute(j),1) > Travelcon || delivery+Demand(TSProute(j)) > Capacity
        VRProute(k)=1; %经过配送中心
        
        % 新一辆车再去下一个需求点
        DisTraveled=Distance(1,TSProute(j)); %距离初始化为配送中心到此点距离
        delivery=Demand(TSProute(j)); %新一辆车可配送量初始化
        k=k+1;
        VRProute(k)=TSProute(j);  %TSP路线中此点添加到VRP路线
	else %
        DisTraveled=DisTraveled+Distance(VRProute(k-1),TSProute(j));
        delivery=delivery+Demand(TSProute(j)); %累加可配送量
        VRProute(k)=TSProute(j); %TSP路线中此点添加到VRP路线
	end
end