ratingDataset = load('./Data/ratingDataset.mat');
ratingDataset = ratingDataset.ratingDataset;

trackIdx = 1:1:length(ratingDataset{1,2}{1,1});
playcountsArray = cell2mat(ratingDataset{1,2}{1,1}(:,2));
ratingArray = cell2mat(ratingDataset{1,2}{1,1}(:,4));

figure(1);
bar(trackIdx,ratingArray);
xlabel('Track index');
ylabel('Rating');
title('SaulCLRadiohead''s tarcks'' rating');

figure(2);
plot(trackIdx,playcountsArray);
xlabel('Track index');
ylabel('Play counts');
title('SaulCLRadiohead''s tarcks'' play counts');

