combinedDataset = load('./Data/combinedDataset_52_4.mat');
combinedDataset = combinedDataset.combinedDataset;
userTrackNumArray = [];

for numOfUser = 1:length(combinedDataset)
   currentUserTrackNum = length(combinedDataset{numOfUser,2}{1,1})...
       +length(combinedDataset{numOfUser,2}{2,1});
   userTrackNumArray = [userTrackNumArray; currentUserTrackNum];
end

userIdx = 1:length(combinedDataset);

figure(1);
plot(userIdx, userTrackNumArray);