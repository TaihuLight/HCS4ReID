
Save Detection Output to .txt file https://github.com/AlexeyAB/darknet/issues/1355
# commont h311 and in the function draw_detections_v3() in image.c

./darknet detector test ./cfg/coco.data ./cfg/yolov3.cfg ./yolov3.weights data/dog.jpg -i 0 -thresh 0.25
./darknet detector test ./cfg/coco.data ./cfg/yolov3.cfg ./yolov3.weights -dont_show -ext_output < coco_testdev2017.txt > detectresult.txt
./darknet detector test ./cfg/coco.data ./cfg/yolov3.cfg ./yolov3.weights -dont_show -ext_output < train.txt
./darknet detector valid cfg/coco.data cfg/yolov3.cfg yolov3.weights

./darknet detector test cfg/prw.data cfg/prw-yolov3.cfg yolov3prw.weights -dont_show -ext_output < prw-test.txt >prwdetfixed.txt
./darknet detector valid cfg/prw.data cfg/prw-yolov3.cfg yolov3prw.weights

./darknet detector test cfg/prw.data cfg/prw-yolov3.cfg yolov3prw.weights -dont_show -ext_output < prw-test-csrec.txt > prwcsdet.txt

./darknet detector test cfg/prw.data cfg/prw-yolov3.cfg yolov3prw.weights -dont_show -ext_output < prw-test-csrec.txt > /media/chengzi/FT-dataset/PRW-MGN-ReID/PRW2Market/det-result/prwdet_result.txt

./darknet detector test cfg/prw.data cfg/prw-yolov3.cfg yolov3prw.weights -dont_show -ext_output < train.txt > demofixed.txt



