% 下面mAP的具体计算过程请参阅：http://yongyuan.name/blog/evaluation-of-information-retrieval.html

clear;clear all;
addpath('Images/');
load('groudtruthodd.mat');
queryFile = 'filelist_odd.txt';
%classesFile = 'databaseClasses.txt';
load images4096Normlodd.mat
%N = 2474; % 
POSITIVE =0;
fid = fopen(queryFile,'rt');
queryImgs = textscan(fid, '%s');
fclose(fid);

%classesAndNum = textscan(fid, '%s %d');
%fclose(fid);

%for i = 1:length(classesAndNum{1, 1})
%    classes{i,1} = classesAndNum{1, 1}{i,1}(1:4);
%end

[numImg,d] = size(feat_norm);
querysNum = length(queryImgs{1, 1});

%ap = zeros(querysNum,1);
cosdist=zeros(querysNum,querysNum);
decision=zeros(querysNum,querysNum);
precision = [];
recall=[];
k=1;
for threshold = 0.4:0.05:1
  
   TP =0;
   FP=0;
  TN = 0;
for i =101:querysNum
    queryName = queryImgs{1, 1}{i, 1};
   % queryClass = queryName(1:4);
    
    [row,col]=ind2sub(size(imgNamList),strmatch(queryName,imgNamList,'exact'));
    queryFeat = feat_norm(row, :);
    
    %[row1,col1]=ind2sub(size(classesAndNum{1, 1}),strmatch(queryClass,classes,'exact'));
   % queryClassNum = double(classesAndNum{1, 2}(row1,1));
    
    %dist = distMat(queryFeat,feat_norm);
    %dist = dist';
    %[~, rank] = sort(dist, 'ascend');
    
    %dist = zeros(numImg, 1);
    for j = 1:(i-100)
        VecTemp = feat_norm(j, :);
       %dist(j) = queryFeat*VecTemp';
        x= [queryFeat;VecTemp];
        sim =  1 - pdist(x,'cosine');
        cosdist(i,j)= sim;
        if sim > threshold
            decision(i,j) = 1;
            POSITIVE = POSITIVE+1;
            
              if (groudtruthodd(i,j)-decision(i,j)) == 0
                 TP=TP+1;
              end
              if (groudtruthodd(i,j)-decision(i,j)) == -1
                 FP=FP+1;
              end
        end
        if (groudtruthodd(i,j)-decision(i,j)) == 1
            TN=TN+1;
        end
          
        end
end
  recall(k) = TP/(TP+TN);
  precision(k) =TP/(TP+FP);
  k=k+1;
end  
    %similarTerm = 0;
    
    %precision = zeros(N,1);
    
%    for k = 1:N
%        topkClass = imgNamList{rank(k, 1), 1}(1:4);        
%        if strcmp(queryClass,topkClass)==1;
%            similarTerm = similarTerm+1;
%      end
    
%   for k = 1:N
%        topkClass = imgNamList{rank(k, 1), 1}(1:4); 
%        % use for configure
%        subplot(4,3,k);
%        im = imread(imgNamList{rank(k, 1), 1});
%        im = imshow(im)
%    end
    

%   ap(i,1) = sum(precision)/length(queryClassNum);
    
%   fprintf('%s ap is %f \n',queryName,ap(i,1));
 
% ap(i,1) = sum(precision)/length(queryClassNum);
       
[grow,gcol,gvec] = find(groudtruthodd>0);
positive=length(gvec);
%result = decision-groudtruth;
%[missgrow,misscol,missvec] = find(result<0);
%[wrow,wcol,wvec] = find(result>0);
%recall = 1-length(missvec)/positive;
%precison = 1-length(wvec)/2473;


plot(recall,precision,'.');
%mAP = sum(ap)/querysNum;
fprintf('recall is %f \n, precision is %f',recall,precision);
