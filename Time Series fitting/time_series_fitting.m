%%% formal fitting

clear;
close all;
clc;


path='/home/svu/dbszhq/matlab_Test/';
out_path='/home/svu/dbszhq/matlab_Test/paras/';
files = dir([path,'*.','csv']);
num_file=length(files)/2;


 for j=1:num_file
    
    path_rad=[path,files(j*2-1).name];
    path_cvg=[path,files(j*2).name];
    
    rad= csvread(path_rad,1,1);
    cvg=csvread(path_cvg,1,1);
    
    if sum(rad(end,:))==0
        rad(end,:)=[];
    end
    
    if sum(cvg(end,:))==0
        cvg(end,:)=[];
    end
    
    
    
    num_obs=size(rad,2);
    num_record=size(rad,1);
    t=1:num_obs;
    
    k=zeros(num_record,1);
    c_est1=zeros(num_record,1);
    c_est2=zeros(num_record,1);
    c_est3=zeros(num_record,1);
    c_est4=zeros(num_record,1);
    c_est5=zeros(num_record,1);
    c_est6=zeros(num_record,1);
    c_est7=zeros(num_record,1);
    c_est8=zeros(num_record,1);
    RMSE=zeros(num_record,1);
    Rsquare=zeros(num_record,1);
    
    parfor i=1:num_record
        
        [k_temp,c_est_temp,RMSE_temp,Rsquare_temp]=logistic_fitting_v3(t,rad,cvg,i);
        k(i,1)=k_temp;
        if length(c_est_temp)==6
            c_est1(i,1)=c_est_temp(1);
            c_est2(i,1)=c_est_temp(2);
            c_est3(i,1)=c_est_temp(3);
            c_est4(i,1)=c_est_temp(4);
            c_est5(i,1)=c_est_temp(5);
            c_est6(i,1)=c_est_temp(6);
            
        else
            c_est1(i,1)=c_est_temp(1);
            c_est2(i,1)=c_est_temp(2);
            c_est3(i,1)=c_est_temp(3);
            c_est4(i,1)=c_est_temp(4);
            c_est5(i,1)=c_est_temp(5);
            c_est6(i,1)=c_est_temp(6);
            c_est7(i,1)=c_est_temp(7);
            c_est8(i,1)=c_est_temp(8);
        end
        RMSE(i,1)=RMSE_temp;
        Rsquare(i,1)=Rsquare_temp;
        
        fprintf('i=%d\n',i);
    end
    
    paras=[c_est1,c_est2,c_est3,c_est4,c_est5,c_est6,c_est7,c_est8,RMSE,Rsquare,k];
    outName=files(j*2-1).name;
    outFile=[out_path,outName(1:(strfind(files(j*2-1).name,'Viirs')-1)),'_paras.csv'];
    csvwrite(outFile,paras);
 end