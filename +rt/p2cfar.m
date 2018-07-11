%--------------------------------------------------------------------------
%   ����Ƥ��ѷ�����
%--------------------------------------------------------------------------
%   ����:
%   datain      ���� �б�ʾ����ά
%   pfa         �龯����
%   train_N     ѵ����Ԫ����,���������ܺ�
%   guard_N     �ػ���Ԫ����,���������ܺ�
%   ���:
%   detected    �о�ƽ��
%   th          �о���ֵ
%--------------------------------------------------------------------------
%   p2cfar��̬
%   �����������������������������
%   ��   ѵ����Ԫ
%   ��   �ػ���Ԫ
%   ��   �о����
%--------------------------------------------------------------------------
%   example
%   [detected,th] = p2cfar(datain,pfa,train_N,guard_N)
%--------------------------------------------------------------------------
function [detected,th] = p2cfar(datain,pfa,train_N,guard_N)
cfar = phased.CFARDetector('NumTrainingCells',train_N,'NumGuardCells',guard_N);
cfar.ProbabilityFalseAlarm = pfa;
cfar.ThresholdOutputPort = true;
cfar.ThresholdFactor = 'Auto';
[detected,th] = cfar(datain,1:size(datain,1));
