%--------------------------------------------------------------------------
%   ��ֵ�Զ�����
%   ���ݣ�N��ͨ
%--------------------------------------------------------------------------
function [output] = auto_fusion(input_data,conn)
CC = bwconncomp(input_data,conn);
N = CC.NumObjects;
output = zeros(N,2);
S = regionprops(CC,'Centroid');
for idx = 1:N
    output(idx,:) = S(idx).Centroid;
end