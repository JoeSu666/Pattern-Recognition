%% preprocessing
test_label=[test_1(:,1);test_2(:,1);test_3(:,1)];
test1=test_1(:,2:end);
test2=test_2(:,2:end);
test3=test_3(:,2:end);
train1=train_1(:,2:end);
train2=train_2(:,2:end);
train3=train_3(:,2:end);
%%
aa12=hok(train1,train2);%boundary between 1,2
aa23=hok(train2,train3);%boundary between 2,3
aa31=hok(train3,train1);%boundary between 3,1
test=[test1;test2;test3];
N=length(test);
N1=length(test1);
N2=length(test2);
[N3,ps]=size(test3);
test=[ones(N,1) test];
class1=[];class2=[];class3=[];%storage the classification result
a=[];%arranged class label
for i=1:N1
    data=test(i,:);
    if data*aa12>0
        if data*aa31<=0
            data=[1 data(:,2:end)];
            class1=[class1;data];a=[a;1];
        else
            data=[1 data(:,2:end)];
            class3=[class3;data];a=[a;3];
        end
    else
        if data*aa23>0
            data=[1 data(:,2:end)];
            class2=[class2;data];a=[a;2];
        else
            data=[1 data(:,2:end)];
            class3=[class3;data];a=[a;3];
        end
    end
end
for i=N1+1:N1+N2
    data=test(i,:);
    if data*aa12>0
        if data*aa31<=0
            data=[2 data(:,2:end)];
            class1=[class1;data];a=[a;1];
        else
            data=[2 data(:,2:end)];
            class3=[class3;data];a=[a;3];
        end
    else
        if data*aa23>0
            data=[2 data(:,2:end)];
            class2=[class2;data];a=[a;2];
        else
            data=[2 data(:,2:end)];
            class3=[class3;data];a=[a;3];
        end
    end
end
 for i=N1+N2+1:N
    data=test(i,:);
    if data*aa12>0
        if data*aa31<=0
            data=[3 data(:,2:end)];
            class1=[class1;data];a=[a;1];
        else
            data=[3 data(:,2:end)];
            class3=[class3;data];a=[a;3];
        end
    else
        if data*aa23>0
            data=[3 data(:,2:end)];
            class2=[class2;data];a=[a;2];
        else
            data=[3 data(:,2:end)];
            class3=[class3;data];a=[a;3];
        end
    end
 end  
%% accuracy
c1=class1(:,1);%labels of classified data
c2=class2(:,1);
c3=class3(:,1);
index1=find(c1==1);
index2=find(c2==2);
index3=find(c3==3);
NN1=length(index1);
NN2=length(index2);
NN3=length(index3);
accuracy=(NN1+NN2+NN3)/N;
acc1=NN1/N1;
acc2=NN2/N2;
acc3=NN3/N3;
sprintf('total accuracy= %f\ntest1 accuracy= %f\ntest2 accuracy= %f\ntest3 accuracy= %f',accuracy,acc1,acc2,acc3)
%% plot
figure
hold on
plot(test_label,'o');
plot(a,'r*');
xlabel('Test Set Sample','FontSize',12);
ylabel('Label','FontSize',12);
legend('Real','Predicted');
title('Classifications Figure of Test Set','FontSize',12);
grid on;
