
%% Demo to show the results of the Ultrametric Contour Map obtained by MCG
% clear all;close all;home;

% Read an input image
I = imread(fullfile(mcg_root, 'demos','test.jpg'));

tic;
% Test the 'fast' version, which takes around 3 seconds
ucm2_scg = im2ucm_PRcut(I,'fast');
toc;

tic;
% Test the 'accurate' version, which tackes around 15 seconds
ucm2_mcg = im2ucm(I,'fast');
toc;

%% Show UCM results (dilated for visualization)
imwrite(imdilate(ucm2_scg,strel(ones(3))), './prcut.png')
imwrite(imdilate(ucm2_mcg,strel(ones(3))), './dncut.png')
