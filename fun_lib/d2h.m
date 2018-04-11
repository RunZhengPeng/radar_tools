%--------------------------------------------------------------------------
%   10����  �з���  ->16����
%   20180409
%   ����
%   qwe14789cn@gmail.com
%   h_output = d2h(data,N_bit)
%   data    10����ԭʼ����
%   N_bit   2�����µ�λ��
%--------------------------------------------------------------------------
function h_output = d2h(data,N_bit)
 str_len= rem(N_bit,4);
if str_len~=0
    disp('������λ������Ϊ4�ı���');
    return
end
[X,Y,Z] = size(data);
data(data<0) = data(data<0)+2^N_bit;
h = dec2hex(data);
for index = 1:X*Y*Z
    temp(index)= string(h(index,:));
end
h_output = reshape(temp,[X Y Z]);


    
    