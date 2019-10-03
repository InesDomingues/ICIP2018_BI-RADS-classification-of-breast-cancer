close all; clear; clc
filename = 'C:\Users\Administrador\Documents\papers\5mammographyCNN\isAugmented0_isBalanced0\train\6\22613702_dcafa6ba6374ec07_l_ml_withMask_padded.png';
imgOrig = imread(filename);
[Iout,img] = readAndPreprocessImageForAlexNet(filename,1);

% figure;
% subplot(2,3,1);imagesc(img(:,:,1)); axis equal; colormap gray
% subplot(2,3,2);imagesc(img(:,:,2)); axis equal; colormap gray
% subplot(2,3,3);imagesc(img(:,:,3)); axis equal; colormap gray
% 
% subplot(2,3,4);imagesc(Iout(:,:,1)); axis equal; colormap gray
% subplot(2,3,5);imagesc(Iout(:,:,2)); axis equal; colormap gray
% subplot(2,3,6);imagesc(Iout(:,:,3)); axis equal; colormap gray

% figure;
% imagesc(imgOrig); axis equal; colormap gray
% axis tight
% axis equal
% 
% ax = gca;
% outerpos = ax.OuterPosition;
% ti = ax.TightInset;
% left = outerpos(1) + ti(1);
% bottom = outerpos(2) + ti(2);
% ax_width = outerpos(3) - ti(1) - ti(3);
% ax_height = outerpos(4) - ti(2) - ti(4);
% ax.Position = [left bottom ax_width ax_height];
% 
% fig = gcf;
% fig.PaperPositionMode = 'auto';
% fig_pos = fig.PaperPosition;
% fig.PaperSize = [fig_pos(3) fig_pos(4)];
% 
% ax.Box = 'off'
% xticks([])
% yticks([])
% 
% filename='originalImg';
% print(fig,filename,'-dpng');
% 
% figure;
% imagesc(img(:,:,1)); axis equal; colormap gray
% axis tight
% axis equal
% 
% ax = gca;
% outerpos = ax.OuterPosition;
% ti = ax.TightInset;
% left = outerpos(1) + ti(1);
% bottom = outerpos(2) + ti(2);
% ax_width = outerpos(3) - ti(1) - ti(3);
% ax_height = outerpos(4) - ti(2) - ti(4);
% ax.Position = [left bottom ax_width ax_height];
% 
% fig = gcf;
% fig.PaperPositionMode = 'auto';
% fig_pos = fig.PaperPosition;
% fig.PaperSize = [fig_pos(3) fig_pos(4)];
% 
% ax.Box = 'off'
% xticks([])
% yticks([])
% 
% filename='DoG_1';
% print(fig,filename,'-dpng');
% 
% figure;
% imagesc(img(:,:,2)); axis equal; colormap gray
% axis tight
% axis equal
% 
% ax = gca;
% outerpos = ax.OuterPosition;
% ti = ax.TightInset;
% left = outerpos(1) + ti(1);
% bottom = outerpos(2) + ti(2);
% ax_width = outerpos(3) - ti(1) - ti(3);
% ax_height = outerpos(4) - ti(2) - ti(4);
% ax.Position = [left bottom ax_width ax_height];
% 
% fig = gcf;
% fig.PaperPositionMode = 'auto';
% fig_pos = fig.PaperPosition;
% fig.PaperSize = [fig_pos(3) fig_pos(4)];
% 
% ax.Box = 'off'
% xticks([])
% yticks([])
% 
% filename='DoG_2';
% print(fig,filename,'-dpng');
% 
% figure;
% imagesc(img(:,:,3)); axis equal; colormap gray
% axis tight
% axis equal
% 
% ax = gca;
% outerpos = ax.OuterPosition;
% ti = ax.TightInset;
% left = outerpos(1) + ti(1);
% bottom = outerpos(2) + ti(2);
% ax_width = outerpos(3) - ti(1) - ti(3);
% ax_height = outerpos(4) - ti(2) - ti(4);
% ax.Position = [left bottom ax_width ax_height];
% 
% fig = gcf;
% fig.PaperPositionMode = 'auto';
% fig_pos = fig.PaperPosition;
% fig.PaperSize = [fig_pos(3) fig_pos(4)];
% 
% ax.Box = 'off'
% xticks([])
% yticks([])
% 
% filename='DoG_3';
% print(fig,filename,'-dpng');

% imagesc(imgOrig(368:3745,1272:2832))
imwrite(imgOrig(368:3745,1272:2832),'imgOrig.png')
imwrite(img(368:3745,1272:2832,1),'DoG_1.png')
imwrite(img(368:3745,1272:2832,2),'DoG_2.png')
imwrite(img(368:3745,1272:2832,3),'DoG_3.png')