
%% Demo to show the results of the Ultrametric Contour Map obtained by MCG
clear all;close all;home;

% Read an input image
d = './datasets/BSDS500/data/images/val';
d_gt = './datasets/BSDS500/data/groundTruth/val';
fd = fullfile(mcg_root, d);
f=dir([fd '/*.jpg']);
n=numel(f);
for i = 1:1
    idx=randi(n);
    fname = fullfile(fd,f(idx).name);
    I = imread(fname);
    
    gt_fname =  f(idx).name;
    gt_fname = strsplit(gt_fname,'.');
    fname2 = char(gt_fname(1));
    gt_fname = fullfile(mcg_root,d_gt,strcat(char(gt_fname(1)),'.mat'));
    load(gt_fname);
    


    tic;
    % Test the 'fast' version, which takes around 3 seconds
    ucm2_scg = im2ucm(I,'fast');
    toc;

    tic;
    % Test the 'fast' version, which takes around 3 seconds
    ucm2_prcut = im2ucm_PRcut(I,'fast');
    toc;

%     tic;
% %     Test the 'accurate' version, which tackes around 15 seconds
%     ucm2_mcg = im2ucm(I,'accurate');
%     toc;
% 
%     tic;
% %     Test the 'accurate' version, which tackes around 15 seconds
%     ucm2_mPRcut = im2ucm_PRcut(I,'accurate');
%     toc;

    %% Show UCM results (dilated for visualization)
%     ftmp = strcat('/demos/answer/',fname2,'_original.png');
    figure()
    
    subplot(4,3,1)
    imshow(I),title('Original')
%     imwrite(I,fullfile(mcg_root,ftmp));
    
    
%     ftmp = strcat('/demos/answer/',fname2,'_FastUCM(SCG).png');
    subplot(4,3,2)
    imshow(imdilate(ucm2_scg,strel(ones(3))),[]),title('SCG')
%     imwrite(imdilate(ucm2_scg,strel(ones(3))),fullfile(mcg_root,ftmp));
    
    subplot(4,3,3)
    imshow(imdilate(ucm2_prcut,strel(ones(3))),[]),title('PRcut')
%     ftmp = strcat('/demos/answer/',fname2,'_PRcut.png');
%     imwrite(imdilate(ucm2_prcut,strel(ones(3))),fullfile(mcg_root,ftmp));
    
%     ftmp = strcat('/demos/answer/',fname2,'_MCG.png');
%     imwrite(imdilate(ucm2_mcg,strel(ones(3)),[]),fullfile(mcg_root,ftmp));
%     
%     ftmp = strcat('/demos/answer/',fname2,'_multiPRcut.png');
%     imwrite(imdilate(ucm2_mPRcut,strel(ones(3)),[]),fullfile(mcg_root,ftmp));
    
    for j = 1:length(groundTruth)
        a = groundTruth{j}.Boundaries;
%         ftmp = strcat('/demos/answer/',fname2,'_groundtruth_',int2str(j),'.png');
        subplot(4,3,j+3)
        imshow(a),title(strcat('groundTruth-',int2str(j)))
%         imwrite(a,fullfile(mcg_root,ftmp))

    end
    ftmp = strcat('/demos/answer/ans_',fname2);
    ftmp = fullfile(mcg_root,ftmp);
    print(ftmp,'-dpng')
    
    i
    
        

end
