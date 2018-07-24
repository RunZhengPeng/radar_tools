%--------------------------------------------------------------------------
%   20180621
%   ����д�����txt�ĵ�
%--------------------------------------------------------------------------
%   write_data(data_name,data_type,file_name)
%   ���룺
%   data_name   ��������
%   data_type   ���ݸ�ʽ
%   file_name   �����ļ���
%--------------------------------------------------------------------------
%   example
%   cos_data = round(8191*real(rt.exp_wave(1/5e6,5e6,350e6)));
%   rt.write_data(cos_data,,'%d,\n','a.txt')
%--------------------------------------------------------------------------
function write_data(data_name,data_type,file_name)
[M,~] = size(data_name);
f = fopen(file_name,'w');
for idx = 1:M
            fprintf(f,data_type,data_name(idx,:));
            fprintf(f,'\n');
end
fclose(f);