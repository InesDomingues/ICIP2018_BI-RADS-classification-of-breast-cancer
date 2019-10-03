function MAE=computeMAE(testLabels,predictedLabels)

for i=1:length(predictedLabels)
   predictedLabelsNum(i) = str2num(char(predictedLabels(i)));
   testLabelsNum(i) = str2num(char(testLabels(i)));
end

 MAE = mean(abs(testLabelsNum - predictedLabelsNum) / length(testLabelsNum));