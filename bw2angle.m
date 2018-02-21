clc
clear
%%%%%%%%%%%%%%%%������õĶ�ֵͼ��
for t=1:2
%     d_pic_pix_bir=imread('1.png');
    d_pic_pix_bir=imread([num2str(t),'.png']);
    pix_threshold = 200;
    d_pic_pix_r = d_pic_pix_bir(:,:,1);
    d_pic_pix_r_bw = im2bw(d_pic_pix_r,pix_threshold/255);
    size_pic = size(d_pic_pix_r_bw);
    %��ȡͼ���������������ھ���M��
    M = zeros(3,size_pic(2));
    n = 0;
    
    x_min = 1;
    x_max = 1;
    y_min = 1;
    y_max = 1;
    for i=1:(size_pic(2)-1)
        if ((d_pic_pix_r_bw(1,i) > 0) && ((d_pic_pix_r_bw(1,i+1) == 0)))
            x_min = i+1;
        end
        if ((d_pic_pix_r_bw(1,i) == 0) && ((d_pic_pix_r_bw(1,i+1) > 0)))
            x_max = i;
        end
    end
    if x_min == 1 && x_max ==1
        x_min = 1;
        x_max = size_pic(2);
    end
    for j=1:(size_pic(1)-1)
        if ((d_pic_pix_r_bw(j,1) > 0) && ((d_pic_pix_r_bw(j+1,1) == 0)))
            y_min = j+1;
        end
        if ((d_pic_pix_r_bw(j,1) == 0) && ((d_pic_pix_r_bw(j+1,1) > 0)))
            y_max = j;
        end
    end
    if y_min == 1 && y_max ==1
        y_min = 1;
        y_max = size_pic(1);
    end
    
    for i=x_min:x_max
        for j=y_min:y_max
            if d_pic_pix_r_bw(j,i) > 0
                M(1,i) = i;
                M(2,i) = M(2,i)+j;
                M(3,i) = M(3,i)+1;
            end
        end
        if M(3,i)>0
            M(2,i) = M(2,i)/M(3,i);
        end
    end
    %ͼ�������ĺ�����ķ�Χ
    x_range = zeros(2,50)-1;    
    x_range(2,1) = 0;           %��¼��������
    for i=1:size_pic(2)-1
        if (M(1,i)==0 && M(1,i+1)>0)
            x_range(1,x_range(2,1)*2+1) = i+1;
        elseif (M(1,i)>0 && M(1,i+1)==0)
            x_range(1,x_range(2,1)*2+2) = i;
            x_range(2,1) = x_range(2,1)+1;
        end
    end
    figure(t*2-1)
    plot(M(1,:),M(2,:))
    figure(t*2)
    %������������
    for i=1:x_range(2,1)
        plot(M(1,x_range(1,i*2-1):x_range(1,i*2)),M(2,x_range(1,i*2-1):x_range(1,i*2)),'*-')
%         axis([0 800 0 800])
        hold on
    end
    %��ϳ�����������һ��ֱ��
    x_long = 1400;
    x = 1:x_long;
    y = zeros(x_range(2,1),x_long);
    ab = zeros(2,x_range(2,1));
    for i=1:x_range(2,1)
        ab(:,i) = polyfit(M(1,x_range(1,i*2-1):x_range(1,i*2)),M(2,x_range(1,i*2-1):x_range(1,i*2)),1);
        y(i,:) = ab(1,i)*x+ab(2,i);
        plot(x,y(i,:))
        hold on
    end
    title([num2str(t)])
    %�����������֮��ļнǣ�Ҳ���Ǹ���ָ��֮��ļн�
    angle = zeros(x_range(2,1),x_range(2,1));
    for i=1:(x_range(2,1)-1)
        for j=(i+1):x_range(2,1)
            if ab(1,i)>ab(1,j)
                angle(i,j) = Get_AngleOfTwoLine(ab(1,i),ab(1,j));
            else
                angle(i,j) = -Get_AngleOfTwoLine(ab(1,i),ab(1,j));
            end
        end
    end
    angle121 = zeros(1,4);
    angle121(1) = t;
    angle121(2) = angle(1,2);
    angle121(3) = angle(2,3);
    angle121(4) = angle(3,4);
    dlmwrite('angle.txt',angle121,'delimiter','\t','newline','pc','-append');%��һ��append��������
    % xlswrite('a.xls', angel,7)
end