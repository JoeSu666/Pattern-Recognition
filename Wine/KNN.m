a1w1=0;a2w2=0;a3w3=0;
test=[test_1;test_2;test_3];
train=[train_1;train_2;train_3];
N1=length(test);N2=length(train);
dis_m=[];
dis=[];
a1=[];a2=[];a3=[];class_label=[];
test_label=test(:,1);
%% count
for i=1:N1
    for j=1:N2
        d=norm(test(i,2:13)-train(j,2:13));
        d=[train(j,1),d];
        dis=[dis;d];
    end
    dis=sortrows(dis,2);
    rank=dis(1:5,1);%return top 5 nearest classes lebal
    U=[1 2 3];
    H=histc(rank,U);%return number of each class
    class=find(H==max(H));
    if length(class)==2
        class=rank(1);%if tie exit, declare it as the nearest class
    end
    class_label=[class_label;class];
    if class==1
        a1=[a1;test(i,:)];
        if class==test(i,1)
            a1w1=a1w1+1;
        end
    elseif class==2
        a2=[a2;test(i,:)];
        if class==test(i,1)
            a2w2=a2w2+1;
        end
    elseif class==3
        a3=[a3;test(i,:)];
        if class==test(i,1)
            a3w3=a3w3+1;
    end
    end
    dis=[];
end
%% accracy
accuracy=(a1w1+a2w2+a3w3)/length(test);
acc1=a1w1/length(test_1);
acc2=a2w2/length(test_2);
[len,x]=size(test_3);
acc3=a3w3/len;
total_acc=sprintf('total accuracy is %f',accuracy)
test1_acc=sprintf('test1 accuracy is %f',acc1)
test2_acc=sprintf('test2 accuracy is %f',acc2)
test3_acc=sprintf('test3 accuracy is %f',acc3)
%% plot
figure
hold on
plot(test_label,'o');
plot(class_label,'r*');
xlabel('Test Set Sample','FontSize',12);
ylabel('Label','FontSize',12);
legend('Real','Predicted');
title('Classifications Figure of Test Set','FontSize',12);
grid on;
    
    