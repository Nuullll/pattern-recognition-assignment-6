% fisher
%% specify samples
situation = 2;

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

Sw = size(w1,1) * cov(w1,1) + size(w2,1) * cov(w2,1);
W = Sw \ (m1-m2)';
W = W / norm(W);

%% plot
% target line equation:
% y = k * x
plot([-5 5],[-5 5]*W(2)/W(1));

% projected samples
w1p = w1 * (W * W');
w2p = w2 * (W * W');

scatter(w1p(:,1),w1p(:,2),50,'r^','filled');
scatter(w2p(:,1),w2p(:,2),50,'b^','filled');

% projection lines
n1 = size(w1,1);
t = [w1(:),w1p(:)]';
plot(t(:,1:n1),t(:,n1+1:end),'r--');

n2 = size(w2,1);
t = [w2(:),w2p(:)]';
plot(t(:,1:n2),t(:,n2+1:end),'b--');

axis equal;
legend('类别1','类别2','投影方向','类别1（降维）','类别2（降维）');

% boundary
m1p = mean(w1p);
m2p = mean(w2p);
x = linspace(-5,5);
y = -W(1)/W(2)*(x-(m1p(1)+m2p(1))/2) + (m1p(2)+m2p(2))/2;
line(x,y);
