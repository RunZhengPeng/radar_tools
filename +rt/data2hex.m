%--------------------------------------------------------------------------
%   matlab����ת��16����,���Զ����������ŵ�ѡ������ݷ�Χ,�����txt��ʽ
%   20180410
%   ����
%   qwe14789cn@gmail.com
%--------------------------------------------------------------------------
%   �����ݴ������Ű���N_bitλ��������
%   input_data  ��������
%   N_bit       ����ת��16���Ƶķ�Χ ��N_bit = 16,��������Ϊ-32767 ~ 32767
%   output_flag ���Ϊ1 ������txt�ļ�
%--------------------------------------------------------------------------
function [hex_r,hex_i] = data2hex(input_data,N_bit,outputname)
if nargin <=2
    output_flag = 0;
else
    output_flag = 1;
end
disp('���ݽ���������������...');
input_data = input_data(:);
input_data = input_data ./ max(abs(input_data)) .* (2^(N_bit-1)-1);
input_data_r = round(real(input_data));
input_data_i = round(imag(input_data));

input_data_r(input_data_r<0) = input_data_r(input_data_r<0)+2^N_bit;
input_data_i(input_data_i<0) = input_data_i(input_data_i<0)+2^N_bit;

hex_r = dec2hex(input_data_r);
hex_i = dec2hex(input_data_i);

if output_flag ~= 0
    fi = fopen([outputname,'_I.txt'],'w');
    fr = fopen([outputname,'_Q.txt'],'w');
    for index = 1:size(hex_r,1)
        fprintf(fi,'%s\n',hex_r(index,:));
        fprintf(fr,'%s\n',hex_i(index,:));
    end
    fclose(fi);
    fclose(fr);
end