% fisher
%% specify samples
situation = 1;

if situation == 1
    w1 = [
        2,0;
        2,2;
        2,4;
        3,3;
        ];
    w2 = [
        0,3;
        -2,2;
        -1,-1;
        1,-2;
        3,-1;
        ];
else
    w1 = [
        1,1;
        2,0;
        2,1;
        0,2;
        1,3;
        ];
    w2 = [
        -1,2;
        0,0;
        -1,0;
        -1,-1;
        0,-2;
        ];
end

%% scatter
figure;
hold on;
scatter(w1(:,1),w1(:,2),100,'r','filled');
scatter(w2(:,1),w2(:,2),100,'b','filled');
axis([-5 5 -5 5]);

%% fisher kernel
m1 = mean(w1);
m2 = mean(w2);

Sw = size(w1,1) * cov(w1,1) + size(w2,1) + cov(w2,1);
W = Sw \ (m1-m2)';
W = W / norm(W);