function output = cluster_1d(input)
disp('�������ݵ��н���1ά����');
output = zeros(size(input));
flag = 0;                                                                   %cfar״̬���λ 0 �ȴ������� 1�ȴ��½���
max_x = [];
max_y = [];
for jdx = 1:size(input,2)
    temp = 0;
    for idx = 1:size(input,1)
        %------------------------------------------------------------------
        if flag==0 && input(idx,jdx)>0                                      %��״̬0�м�⵽������
            flag = 1;                                                       %�޸�Ϊ״̬1
            
            if input(idx,jdx)>temp                                          %ѡ��洢
                temp = input(idx,jdx);                                      %�滻���ֵ��ֵ
                max_x = idx;                                                %�õ�x����
                max_y = jdx;                                                %�õ�y����
            end
        end
        %------------------------------------------------------------------
        if flag==1 && input(idx,jdx)==0                                     %��״̬1�м�⵽�½���
            flag = 0;
            output(max_x,max_y) = temp;                                     %�����ֵ����cfar���
        end
        %------------------------------------------------------------------
    end
end


