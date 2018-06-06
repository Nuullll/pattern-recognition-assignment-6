% knn

%% load train data
load('trainData.txt');

%% test set
x = -6:0.1:6;
y = -6:0.1:6;

n = length(x);
Nsample = n * n;

[X,Y] = meshgrid(x,y);
testData = [X(:),Y(:),zeros(Nsample,1)];

%% knn kernel
K = 10;

for i = 1:Nsample
    sample = testData(i,1:2);
    distances = sqrt(sum((trainData(:,1:2) - sample).^2,2));
    [~,I] = sort(distances);
    testData(i,3) = mode(trainData(I(1:K),3));
end

%% plot knn region
figure;
cmap = [1 0 0; 0 0 1; 0.5 0.2 0.2; 0.2 0.2 0.5];
colormap(cmap);

hold on;
h = pcolor(X,Y,reshape(testData(:,3)+2,n,n));
h.EdgeColor = 'None';
scatter(trainData(:,1),trainData(:,2),100,trainData(:,3),'filled');
title(sprintf('K=%d',K));

% add legend
hold on;
labels = {'组别1';'组别2'};
hl(1) = plot(NaN,NaN,'r.','MarkerSize',20);
hl(2) = plot(NaN,NaN,'b.','MarkerSize',20);
legend(hl,labels);
