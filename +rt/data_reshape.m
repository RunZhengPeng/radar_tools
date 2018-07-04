%--------------------------------------------------------------------------
%   ���ź���������Ϊ��Ҫ����̬
%--------------------------------------------------------------------------
%   function dataout = data_reshape(datain,data_size)
%   ����:
%   datain ԭʼ�ź�
%   data_size MTD��̬
%--------------------------------------------------------------------------
%   example
%   data_size = [2640 1024];
%   dataout = data_reshape(datain,data_size)
%--------------------------------------------------------------------------
function dataout = data_reshape(datain,data_size)
dim = length(size(datain));
if dim >= 3
    disp('�����ź�ά�ȱ���Ϊ2ά');
    return
end

L = size(datain)==1;
if L(1)==0 && L(2)==1
    disp('������ -> ���ݴ���')
elseif L(1)==1 && L(2)==0
    disp('������ -> �ź�ת�� -> ���ݴ���')
    datain = datain.';
else
    disp('�뱣֤��������Ϊһά����')
    return
end
if length(data_size)==2
    level = floor(size(datain,1)/(data_size(1)*data_size(2)));              %�ȼ�����Եõ����ٸ�CPI����
    datain = datain(1:data_size(1)*data_size(2)*level,:);                   %�����и�����
    dataout = reshape(datain,data_size(1),data_size(2),level);              %�����޸���״
    
elseif length(data_size)==1
    level = floor(size(datain,1)/(data_size(1)));                           %�ȼ�����Եõ����ٸ�CPI����
    datain = datain(1:data_size(1)*level,:);                                %�����и�����
    dataout = reshape(datain,data_size(1),level);                           %�����޸���״
end
