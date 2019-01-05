function aa=hok(train1,train2)
N=length(train1);%N is length of train1
train=[train1;train2];%without label
train=[ones(N,1) train(1:N,:);-ones(N,1) -train(N+1:end,:)];
[N1,DIM]=size(train);%N1 is length of total train
step=0.8;
a=zeros(DIM,1);
b=zeros(N1,1)+0.1*ones(N1,1);
bmin=b;
k=0;
flag=1;
y_wro=[];
tol=100;
while flag==1
    e=train*a-b;
    ee=0.5*(e+abs(e));
    b=b+2*step*ee;
    a=pinv(train)*b;
    if norm(abs(e))<=norm(bmin);
        aa=a;
        bb=b;
        flag=0;
    else
        k=k+1;
    end
    if k==tol
        fprintf('no solution');
        aa=a;
        bb=b;
        flag=0;
    end 
end
end