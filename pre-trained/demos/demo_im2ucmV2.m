
%% Demo to show the results of the Ultrametric Contour Map obtained by MCG
clear all;close all;home;clc;

% Read an input image
d = './datasets/BSDS500/data/images/test';
d_gt = './datasets/BSDS500/data/groundTruth/test';
fd = fullfile(mcg_root, d);
f=dir([fd '/*.jpg']);
n=numel(f);

n_iter = 1;
for i = 1:n_iter
    idx=randi(n);
%     fname = fullfile(fd,f(idx).name);
    fname = fullfile(fd,'100007.jpg');
    I = imread(fname);
    [ix,iy,iz] = size(I);
    
    
%     gt_fname =  f(idx).name;
    gt_fname = '100007.jpg';
    gt_fname = strsplit(gt_fname,'.');
    fname2 = char(gt_fname(1));
    gt_fname = fullfile(mcg_root,d_gt,strcat(char(gt_fname(1)),'.mat'));
    load(gt_fname);
    


    disp('Ncut:');
    tic;
    % Test the 'fast' version, which takes around 3 seconds
    ucm2_Ncut = im2ucm_Ncut(I,'fast');
    toc;
    disp('PRcut:');
    tic;
    % Test the 'fast' version, which takes around 3 seconds
    ucm2_PRcut = im2ucm_PRcut(I,'fast');
    toc;
    disp('dNcut:');
    tic;
    % Test the 'fast' version, which takes around 3 seconds
    ucm2_dNcut = im2ucm(I,'fast');
    toc;
     disp('dPRcut:');
    tic;
    % Test the 'fast' version, which takes around 3 seconds
    ucm2_dPRcut = im2ucm_dPRcut(I,'fast');
    toc;

    %% Show UCM results (dilated for visualization)
    figure('visible','off')
    ftmp = strcat('/demos/answer/',fname2,'_original.png');
    imwrite(I,fullfile(mcg_root,ftmp));
    
    figure('visible','off')
    ftmp = strcat('/demos/answer/',fname2,'_dNcut.png');
    imwrite(imdilate(ucm2_dNcut,strel(ones(3))),fullfile(mcg_root,ftmp));
    
    figure('visible','off')
    ftmp = strcat('/demos/answer/',fname2,'_PRcut.png');
    imwrite(imdilate(ucm2_PRcut,strel(ones(3))),fullfile(mcg_root,ftmp));
    
    figure('visible','off')
    ftmp = strcat('/demos/answer/',fname2,'_Ncut.png');
    imwrite(imdilate(ucm2_Ncut,strel(ones(3))),fullfile(mcg_root,ftmp));
    
    figure('visible','off')
    ftmp = strcat('/demos/answer/',fname2,'_dPRcut.png');
    imwrite(imdilate(ucm2_dPRcut,strel(ones(3))),fullfile(mcg_root,ftmp));
    
%     ftmp = strcat('/demos/answer/',fname2,'_MCG.png');
%     imwrite(imdilate(ucm2_mcg,strel(ones(3)),[]),fullfile(mcg_root,ftmp));
%     
%     ftmp = strcat('/demos/answer/',fname2,'_multiPRcut.png');
%     imwrite(imdilate(ucm2_mPRcut,strel(ones(3)),[]),fullfile(mcg_root,ftmp));
    
    
    
    
    
end




