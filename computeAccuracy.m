function Acc=computeAccuracy(testLabels,predictedLabels)
for i=1:length(predictedLabels)
   predictedLabelsNum(i) = str2num(char(predictedLabels(i)));
   testLabelsNum(i) = str2num(char(testLabels(i)));
end
Acc = sum(testLabelsNum==predictedLabelsNum)/length(testLabelsNum);