%--------------------------------------------------------------------------
%   20180601
%   ����
%   �ź�Ƶ���Զ�����������
%--------------------------------------------------------------------------
%   ����:
%   sig     �ź�
%   fs      ��������
%   AD_len  ADλ��
%   N_waves ����Ƶ����г������
%   N_sep   ��Ƶ��+г���������              Ĭ��10
%   Nfft    fft����                         Ĭ��10
%   rho     Ƶ�ʷֱ���0��ʾ���              Ĭ��10
%	�����
%   F       Ƶ����
%   P       ��������
%--------------------------------------------------------------------------
%   example
%--------------------------------------------------------------------------
%   rt.AD_analyzer(sig,fs,AD_len,N_waves)
%   rt.AD_analyzer(sig,fs,AD_len,N_waves,N_sep)
%   rt.AD_analyzer(sig,fs,AD_len,N_waves,N_sep,Nfft)
%   rt.AD_analyzer(sig,fs,AD_len,N_waves,N_sep,Nfft,rho)
%--------------------------------------------------------------------------
function [F,P] = AD_analyzer(sig,fs,AD_len,N_waves,N_sep,Nfft,rho)
disp('Ҫ��:�����źű�������,��������ʱ����Чλ�����')
if nargin <=3
    disp('�������������Ҫ���źţ������ʣ�AD���ȣ�г������');
    return
elseif nargin <=4
    N_sep = 10;
    Nfft  = 1024;
    rho   = 10;
elseif nargin <=5
	Nfft  = 1024;
    rho   = 10; 
elseif nargin <=6
	rho   = 10;
end

[P,F] = pwelch(sig,kaiser(length(sig),rho),[],Nfft,fs);                     %���Ƶ��ͼ
db = pow2db(P);                                                             %�����db

maxloc = find(db==max(db));                                                 %�ź����Ƶ������
[~,loc] = findpeaks(db,'MinPeakDistance',(2*Nfft/100));                     %��ֵƵ������

N = round(N_waves/2);                                                       %г������
mid = find(loc ==maxloc);                                                   %�����ź�
X = loc(mid-N:mid+N);                                                       %г��+��Ƶ����
XX = [X-N_sep X+N_sep];                                                     %г��������ȥ��Χ

NDR = 0.5 * mean(P(1:(loc(mid)-N_sep))) + ...                               %��ȥ���źź�����ƽ������
      0.5 * mean(P((loc(mid)+N_sep):end));
NDR = pow2db(NDR);

for idx = 1:size(XX,1)
    Y(idx,:) =  XX(idx,1):XX(idx,2);
end
Y = Y';                                                                     %����г������߶�
n_loc=Y(:);                                                                 %��ȥ�������е�
n_loc = [(1:(loc(1)+N_sep))';n_loc;((loc(end)-N_sep):length(P))'];                          %���ֱ����ȥ��Χ

%--------------------------------------------------------------------------
%   �ų���ȥ�����õ�������
%--------------------------------------------------------------------------
x = 1:length(F);
for idx = 1:length(n_loc)
    x(x==n_loc(idx))=[];
end

%--------------------------------------------------------------------------
%   ���ӻ�
%--------------------------------------------------------------------------
figure;
plot(F/1e6,db,'LineWidth',1.5);grid on;hold on;                             %ԭʼ�ź�
plot(F(n_loc)/1e6,db(n_loc),'g-','LineWidth',1.2);                          %г��,ֱ��ɸѡ
plot(F(maxloc-N_sep:maxloc+N_sep)/1e6,db(maxloc-N_sep:maxloc+N_sep),...     %�ź�ɸѡ
    'r-','LineWidth',1.2);
title('ADƵ�׷���')
legend('Ƶ�׷���','г��,ֱ��ɸѡ','�ź�ɸѡ');xlabel('Ƶ�� MHz');ylabel('���� dB')
hold off

%--------------------------------------------------------------------------
%   �������
%--------------------------------------------------------------------------
SNDR = db(maxloc) - NDR;
SNR = db(maxloc)- pow2db(mean(P(x)));
X(X==maxloc)=[];                                                            %ʣ��ȫ��г����Ƶ������
ang = rad2deg(angle(max(fft(sig))));
%--------------------------------------------------------------------------
fprintf('-------------------------------------------------------------\n');
fprintf("�ź�Ƶ�� -> %1.2f Mhz\n",F(maxloc)/1e6);
fprintf('-------------------------------------------------------------\n');
for idx = 1:length(X)
    fprintf("г��Ƶ�� -> %1.2f Mhz\n",F(X(idx))/1e6);
end
fprintf('-------------------------------------------------------------\n');
fprintf('��ֵ�Ƕ�    -> %1.2f��\n',ang);
fprintf("���������  -> %1.2f dB\n",6.02*AD_len + 1.76);
fprintf("ʵ�������  -> %1.2f dB\n",SNR);
fprintf("����ʧ���  -> %1.2f dB\n",SNDR);
fprintf("������Чλ  -> %1.2f \n",AD_len);
fprintf("ʵ����Чλ  -> %1.2f \n",(SNDR-1.76)/6.02);
fprintf('-------------------------------------------------------------\n');