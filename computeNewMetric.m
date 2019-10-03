function Acc=computeNewMetric(testLabels,predictedLabels)
for i=1:length(predictedLabels)
   predictedLabelsNum(i) = str2num(char(predictedLabels(i)));
   testLabelsNum(i) = str2num(char(testLabels(i)));
end
Acc = sum(predictedLabelsNum>=testLabelsNum)/length(testLabelsNum);