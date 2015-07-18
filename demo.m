clear

nPtsPerClust = 250;
nClust = 4; % define 4 clusters
totalNumPts = nPtsPerClust*nClust;
m(:,1) = [0.1,0.2]';
m(:,2) = [0.2,0.6]';
m(:,3) = [0.8,0.9]';
m(:,4) = [0.5,0.1]';
var = .1;
bandwidth = .2;
clustMed = [];

nPtsPerClust = [100,125,150,200];
%rng(0); % comment out if you want to make the data random
x = var*randn(2,sum(nPtsPerClust));
%*** build the point set
ox = zeros(2,0);
for i = 1:nClust
    ox = [ox,repmat(m(:,i),1,nPtsPerClust(i))];   
end
x = ox + x;

% start clustering
tic
[clustCent1,point2cluster1,clustMembsCell1] = HGMeanShiftCluster(x,bandwidth,'gaussian');
toc

figure;
numClust1 = length(clustMembsCell1);
hold on
cVec = 'bgrcmykbgrcmykbgrcmykbgrcmyk';
for k = 1:min(numClust1,length(cVec))
    myMembers1 = clustMembsCell1{k};
    myClustCen1 = clustCent1(:,k);
    plot(x(1,myMembers1),x(2,myMembers1),[cVec(k) '.'])
    plot(myClustCen1(1),myClustCen1(2),'o','MarkerEdgeColor','k','MarkerFaceColor',cVec(k), 'MarkerSize',10)
end
title(['no shifting, numClust:' int2str(numClust1)])
hold off
