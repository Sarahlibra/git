# 哪些特征  

## 第一大类特征（相似用户特征 + 相似物品特征）  

> 1. 定义similar user（基本属性 + 基本属性对应的基数（即，比如country,country这个属性对了5个用户。那么country的基数就是5.））  
> > 
> > 主要思想：  
> > 基本属性：找user 对应的某个属性的所有user的点击率。  
> > 
> > 基本属性的基数：找基本属性基数对应的user的点击率  
> > 
> > 本比赛由于针对 u-i pair, 故用户的上述点击率值得是 UID,即用户对应的某个属性 所对应的所有用户 点击 该物品的次数。  
> > 下文中，设计 计算物品点击率时，需要 IUD,和 IUDS. 即物品对应的某个属性所对应的所有物品 被 该用户点击的次数。   
> > 和 该物品对应的某个属性所对应的所有物品被点击的次数。 体现物品流行性，解决冷启动问题。  
> > 
> > jobroles + discipline_id + (country) + region + career_level + experience几个 + edu_degree + edu_fieldofstudies  
> > 

> 2. 定义related user  
> > 主要思想：两用户相关需符合两大条件  
> > 比如user的jobtitles  
> > > 
> > > 1. 两用户的jobtitle 字段集合需要有交集  
> > > 2. 两用户的jobtitle字段集合的彼此差集《一定阈值  
> > > 
> > 同论文里的做法。有交集的jobroles  

> 3. 定义similar job  
> > 除了industry, 下没下架，发布日期3个，其它都要  
> > job涉及的特征，（title + discipline+career_level + (counry) + region + 经纬度 + tags+...）  
> > 

> 4. 定义related job  
> > 同论文里的做法  
> > 
> > 3,4思路同上。  
> > 

> 以上特征提取是按窗口提取。 这里的窗口设计方案如下：  
> > 1-1  
> > 2-1  
> > 2-2  
> > all-1  
> > all-2  

> 
> 其中第一列表示，最近x周，新发布的物品数，或新增加的用户数。   
> 第二列表示，第一列所对应的用户 在第二列所对应的周内的点击率。  

## 第二大类特征： 用户物品的基础特征  
> 

## 第三大类特征； 即用户，物品的某个属性离散化后的特征  

> 1. JobTitle(6个特征) 
> > 
> > 1. JobTitle 的字段长度  
> > 2. JobTitle 字段划分成5个bins. （？每个bin里的单词的出现频次？？）  

> 2. Jobtags (6个特征)  
> 

> 3. User jobtiles（6个特征）  
> => 取法有两种：针对单个job，针对jobs（针对单个user，针对users）  
> 加上SU RU SJ RJ  
> 加上BU BJ  
> 加上(title长度) (title.word 5 BIN) (tag 8) (jobrole.word )  

# 最后  
## 1. 改数据库  
> engine从innodb改成myMyISAM  
> text, char做成全文索引  
> 注意空值  

## 2. 接下来就是取样（问：就是抽取特征的意思把。答：嗯）  
> TreeNet学生版是否是全功能的。  

## 3. 接下来的工作  
> 1. 建立新的索引数据库  
> 2. 读取数据  
> 3. 抽样本的代码  
