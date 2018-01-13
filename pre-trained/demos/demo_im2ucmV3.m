clear all;close all;home;clc;

% Read an input image
d = './datasets/BSDS500/data/images/test';
d_gt = './datasets/BSDS500/data/groundTruth/test';
fd = fullfile(mcg_root, d);

fid = fopen('test_set.txt');
fsaveRes = fopen('results.txt','w+');
n_iter = 200;
for i = 1:n_iter
    s_name = fgets(fid);
    fname = fullfile(fd,strcat(s_name,'.jpg'));
    I = imread(fname);
    fprintf(fsaveRes,'%3d ---- ', i);
    tic;
     ucm2 = im2ucm(I,'fast');
     fprintf(fsaveRes,'DNcut : ');
     fprintf(fsaveRes,'%.4f   ',max(max(ucm2)) - min(min(ucm2)));
     fprintf(fsaveRes, 'time   :');
     t = toc;
     fprintf(fsaveRes,'%1.4f',t);
     fprintf(fsaveRes,'  ');
    ftmp = strcat('./answer/Compare/',int2str(i),'_',s_name,'_DNcut.jpg');
    imwrite(ucm2, ftmp)
    
    ftmp = strcat('./answer/DNcut/',s_name);
    save(ftmp, 'ucm2')
    
    tic;
     ucm2 = im2ucm(I,'accurate');
     fprintf(fsaveRes,'DNcut_accurate : ');
     fprintf(fsaveRes,'%.4f   ',max(max(ucm2)) - min(min(ucm2)));
     fprintf(fsaveRes, 'time   :');
     t = toc;
     fprintf(fsaveRes,'%1.4f',t);
     fprintf(fsaveRes,'  ');
    ftmp = strcat('./answer/Compare/',int2str(i),'_',s_name,'_DNcutAccurate.jpg');
    imwrite(ucm2, ftmp)
    
    ftmp = strcat('./answer/DNcut_accurate/',s_name);
    save(ftmp, 'ucm2')
    
    tic;
    ucm2 = im2ucm_PRcut(I,'fast');
    fprintf(fsaveRes,'PRcut : ');
    fprintf(fsaveRes,'%.4f  ',max(max(ucm2)) - min(min(ucm2)));
    fprintf(fsaveRes, 'time   :');
    t = toc;
     fprintf(fsaveRes,'%1.4f',t);
    fprintf(fsaveRes,'  ');
    

    ftmp = strcat('./answer/Compare/',int2str(i),'_',s_name,'_PRcut.jpg');
    imwrite(ucm2, ftmp)
    
    ftmp = strcat('./answer/PRcut/',s_name);
    save(ftmp, 'ucm2')
    
     tic;
    ucm2 = im2ucm_dPRcut(I,'fast');
    
    fprintf(fsaveRes,'dPRcut : ');
    fprintf(fsaveRes,'%.4f  ',max(max(ucm2)) - min(min(ucm2)));
    fprintf(fsaveRes,'time   :');
    t = toc;
     fprintf(fsaveRes,'%1.4f',t);
    fprintf(fsaveRes,'  ');

    ftmp = strcat('./answer/Compare/',int2str(i),'_',s_name,'_dPRcut.jpg');
    imwrite(ucm2, ftmp)
    
    ftmp = strcat('./answer/dPRcut/',s_name);
    save(ftmp, 'ucm2')
    
    
     tic;
    ucm2 = im2ucm_dPRcut(I,'accurate');
    
    fprintf(fsaveRes,'dPRcut_accurate : ');
    fprintf(fsaveRes,'%.4f  ',max(max(ucm2)) - min(min(ucm2)));
    fprintf(fsaveRes,'time   :');
    t = toc;
     fprintf(fsaveRes,'%1.4f',t);
    fprintf(fsaveRes,'  ');

    ftmp = strcat('./answer/Compare/',int2str(i),'_',s_name,'_dPRcut_accurate.jpg');
    imwrite(ucm2, ftmp)
    
    ftmp = strcat('./answer/dPRcut_accurate/',s_name);
    save(ftmp, 'ucm2')
    
    
         tic;
    ucm2 = im2ucm_Ncut(I,'fast');
    
    fprintf(fsaveRes,'Ncut : ');
    fprintf(fsaveRes,'%.4f  ',max(max(ucm2)) - min(min(ucm2)));
    fprintf(fsaveRes, 'time   :');
    t = toc;
     fprintf(fsaveRes,'%1.4f',t);
    fprintf(fsaveRes,'\n');
    

    ftmp = strcat('./answer/Compare/',int2str(i),'_',s_name,'_Ncut.jpg');
    imwrite(ucm2, ftmp)
    
    ftmp = strcat('./answer/Ncut/',s_name);
    save(ftmp, 'ucm2')


    gt_fname = fullfile(mcg_root,d_gt,strcat(s_name,'.mat'));
    load(gt_fname);
    [im,in,~] = size(I);
    Ans = zeros(im,in);
    for j = 1:length(groundTruth)
        a = groundTruth{j}.Boundaries;
        Ans =  Ans + a;
    end
    Ans(Ans > 0) = 1;
    ftmp = strcat('./answer/Compare/',int2str(i),'_',s_name,'_GT.jpg');
    imwrite(Ans, ftmp)
    disp(i)
end




