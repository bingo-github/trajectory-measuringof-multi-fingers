clc
clear

file_path =  'G:\WORK\project\Robot\finger\paper\���װ��\';% ͼ���ļ���·��  
img_path_list = dir(strcat(file_path,'*.jpg'));%��ȡ���ļ���������jpg��ʽ��ͼ��  
img_num = length(img_path_list);%��ȡͼ��������  

if img_num > 0 %������������ͼ��  
        for j = 1:img_num %��һ��ȡͼ��  
%         for j = 15:18
            image_name = img_path_list(j).name;% ͼ����  
            image =  imread(strcat(file_path,image_name));  
            fprintf('%d %d %s\n',i,j,strcat(file_path,image_name));% ��ʾ���ڴ����ͼ����  
            
            pic_pix=imread(image_name);
            pic_pix_rotated=imrotate(pic_pix,180,'nearest');
            pix_threshold = 30;
            pic_pix_r = pic_pix_rotated(:,:,1)-pic_pix_rotated(:,:,2);
            pic_pix_r_bw = im2bw(pic_pix_r,pix_threshold/255);
            
%             threadhold = 50;
%             pic_pix_rotated_1 = pic_pix_rotated(:,:,1);
%             pic_pix_rotated_2 = pic_pix_rotated(:,:,2);
%             pic_pix_rotated_3 = pic_pix_rotated(:,:,3);
%             pic_size = size(pic_pix_r_bw);
%             for ii=1:pic_size(1)
%                 for jj=1:pic_size(2)
%                     if (pic_pix_rotated(ii,jj,1)>threadhold && pic_pix_rotated(ii,jj,2)>threadhold && pic_pix_rotated(ii,jj,3)>threadhold)
% %                     if (pic_pix_rotated(ii,jj,1)+pic_pix_rotated(ii,jj,2)+pic_pix_rotated(ii,jj,3))>254
%                         pic_pix_r_bw(ii,jj) = 0;
%                         pic_pix_r_bw(1,1) = 1;
%                     end
%                 end
%             end
            
            figure(j)
%             imshow(pic_pix_r_bw)
            
%             axis normal;
            set(gcf,'color','k');
            set(0, 'DefaultFigureColor', [0.8 0.8 0.8])
            pic_pix_r_bw_rotated = imrotate(pic_pix_r_bw,-3-j*(80/img_num),'bilinear');
%             pic_pix_r_bw_rotated = imrotate(pic_pix_r_bw,0,'bilinear');
            imshow(pic_pix_r_bw_rotated,'border','tight','initialmagnification','fit')
            
            saveas(gcf,[num2str(j),'.png'])
            %ͼ������� ʡ��  
        end  
end  