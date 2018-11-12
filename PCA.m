%-----------------------------------------------------
% Base on MNIST dataset, using PCA to reconstruct image
%-----------------------------------------------------
%% Load data
image_folder='D:\Rensselaer\pattern recognition\HW7\train_data\';
file_pattern=fullfile(image_folder,'*.jpg');
image_files=dir(file_pattern);
nfiles=length(image_files);
data=zeros(nfiles,28*28);
for i=1:nfiles
    filename=image_files(i).name;
    im=imread([image_folder,filename]);
    data(i,:)=reshape(im,[1,28*28]);
end
data=data/255;
%% compute Principle component
mean_data=sum(data)/nfiles;
mean_data1=ones(100,1)*mean_data;
data_m=data-mean_data1;
S=zeros(28*28,28*28);
for j=1:100
    S=S+data_m(j,:)'*data_m(j,:);
end
%%%%%%%%%%%%%%%%%%principal basis vectors, stored in V
[V,D]=eig(S); %V are eigenvectors, D are eigenvalues
D_vector=(D*ones(28*28,1))';% vector of eigenvalues
D_vector1=sort(D_vector,'descend');
%%%%%%%%%%%%%%%%%%plot the eigenvalues
figure (1);
plot(N,D_vector1);
%%%%%%%%%%%%%%%%%% compute principal components
a=zeros(784,3);
a=V(:,784:-1:782);
pc=data*a;
scatter3(pc(:,1),pc(:,2),pc(:,3));
pccomp=zeros(784,100);% principal components of 100 images
for i=1:784
    for j=1:100
        pccomp(i,j)=data(j,:)*V(:,784-i+1);
    end
end
%% show basis images
a=zeros(28,28);
for j=0:9
    b=reshape(V(:,784-j),[28,28]);
    b=mat2gray(b);
    a=b;
    figure(1)
    subplot(2,5,j+1)
    imshow(a)
    title(['basis img',num2str(j+1)]);   
end
%% image reconstruction
b1=[1 3 10 50 100];
for i=1:5
    w=V(:,784:-1:784-b1(i)+1);
    z=data(2,:)*w;
    x1=z*w'+mean_data;
    x2=reshape(x1,[28,28]);
    x2=mat2gray(x2);
    xx=reshape(data(2,:),[28,28]);
    figure(1)
    subplot(2,3,1)
    imshow(xx)
    title('origin img')
    subplot(2,3,i+1)
    imshow(x2)
    title(['recon img',num2str(i)]);
end