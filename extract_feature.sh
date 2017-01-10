    <span style="color:#333333;">#!/usr/bin/env sh  
    # args for EXTRACT_FEATURE  
    TOOL=/home/ypp/caffe-master/build/tools  
    MODEL=/home/ypp/caffe-master/examples/imagenet/caffe_reference_imagenet_model #下载得到的caffe model  
    PROTOTXT=/home/ypp/caffe-master//examples/_temp/imagenet_val.prototxt # 网络定义  
    LAYER=fc7 # 提取层的名字，如提取fc7等  
    LEVELDB=/home/ypp/caffe-master//examples/_temp/features # 保存的leveldb路径  
    BATCHSIZE=10  
      
    # args for LEVELDB to MAT  
    DIM=4096 # 需要手工计算feature长度(</span><span style="color:#cc0000;">需要更改的，不然会报错；也可以报错是多少维再回来进行修改</span><span style="color:#333333;">)  
    OUT=/home/ypp/caffe-master//examples/_temp/features.mat #.mat文件保存路径  
    BATCHNUM=1 # 有多少个batch， 本例只有两张图， 所以只有一个batch  
      
    $TOOL/extract_features.bin  $MODEL $PROTOTXT $LAYER $LEVELDB $BATCHSIZE  
    python /home/ypp/caffe-master/src/ypp/lmdb2mat.py $LEVELDB $BATCHNUM  $BATCHSIZE $DIM $OUT</span>  
