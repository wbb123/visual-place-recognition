% 下面mAP的具体计算过程请参阅：http://yongyuan.name/blog/evaluation-of-information-retrieval.html

clear;clear all;
groudtruth = load('CityCentreTextFormat.txt');
groudtruthodd = zeros(1237,1237);
groudtrutheven = zeros(1237,1237);
for i = 1: 2474
  for j = 1:2474
    if (mod(i,2)==0) &&(mod(j,2)==0)
      groudtruthodd(i/2,j/2) = groudtruth(i,j);
    end
    if (mod(i,2)==1) &&(mod(j,2)==1)
      groudtrutheven((i+1)/2,(j+1)/2) = groudtruth(i,j);
    end
  end
end

