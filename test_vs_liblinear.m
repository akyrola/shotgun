addpath ./liblinear/liblinear-1.8/matlab/
load examples/arcene.mat;

model=train(y, A,'-c 1.0')
[x,l]=predict(y, A, model);
diff=y.*x;
disp(['Liblinear error is: ', num2str(sum(diff<=0)/length(y))]);


lambda=1:10;
lambda=2.^-lambda;
for j=1:10
x1 = shotgun_logreg(A,y,lambda(j),1);
y1= A*x1;
diff=y.*y1;
disp(['shotgun error for ', num2str(lambda(j)), ' is: ', num2str(sum(diff<=0)/length(y))]);
end
