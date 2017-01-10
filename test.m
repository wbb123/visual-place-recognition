% 下面mAP的具体计算过程请参阅：http://yongyuan.name/blog/evaluation-of-information-retrieval.html

clear;clear all;
addpath('Images/');
groudtruth= load('CityCentreTextFormat.txt');
queryFile = 'filelist.txt';
%classesFile = 'databaseClasses.txt';
load images4096Norml2.mat
threshold = 0.965;
N = 2474; % 如果用于论文中，把这个�?�设为你�?用数据库的大�?
TP =0;
FP=0;
FN = 0;
fid = fopen(queryFile,'rt');
queryImgs = textscan(fid, '%s');
fclose(fid);

[numImg,d] = size(feat_norm);
querysNum = length(queryImgs{1, 1});
cosdist=zeros(querysNum,querysNum);
decision=zeros(querysNum,querysNum);
T= 0;
decision =zeros(querysNum,querysNum);



for i =2:querysNum
    queryName = queryImgs{1, 1}{i, 1};
   % queryClass = queryName(1:4);
    
    [row,col]=ind2sub(size(imgNamList),strmatch(queryName,imgNamList,'exact'));
    queryFeat = feat_norm(row, :);

    for j = 1:(i-1)
        VecTemp = feat_norm(j, :);
    
        x= [queryFeat;VecTemp];
        sim =  1 - pdist(x,'cosine');
        cosdist(i,j)= sim;
        if sim >0.9 
          T=T+1;

         end
    end
  end

   
fprintf('recall is %f \n, precision is %f',recall,precision);
