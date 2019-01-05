train=[train_1;train_2;train_3];
label_train=train(:,1);
train=train(:,2:end);
test=[test_1;test_2;test_3];
label_test=test(:,1);
test=test(:,2:end);
data=[train;test];
N1=length(train);
[N2,x]=size(test);
[data_scale, ps] = mapminmax(data', 0, 1);%normalization the value along the dimension
data_scale = data_scale';
train=data_scale(1:N1,:);
test=data_scale((N1+1):(N1+N2),:);
predict=zeros(length(label_test),1);
model=svmtrain(label_train,train,'-t 2');% use Gaussian Kernel
[predict,accuracy,dec]=svmpredict(label_test,test,model);
NN1=length(test_1);NN2=length(test_2);[NN3,xx]=size(test_3);
index1=find(predict(1:NN1)==1);
index2=find(predict(NN1+1:NN1+NN2)==2);
index3=find(predict(NN1+NN2+1:end));
acc1=length(index1)/NN1;acc2=length(index2)/NN2;acc3=length(index3)/NN3;
sprintf('test1 accuracy= %f\ntest2 accuracy= %f\ntest3 accuracy= %f',acc1,acc2,acc3)
%% plot
figure
hold on
plot(label_test,'o');
plot(predict,'r*');
xlabel('Test Set Sample','FontSize',12);
ylabel('Label','FontSize',12);
legend('Real','Predicted');
title('Classifications Figure of Test Set','FontSize',12);
grid on;
%index=find(predict==3);
%data1=test_3(index,:);