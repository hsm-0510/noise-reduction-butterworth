clc
clear all
close all
warning off
Fs=16000;%Sampling frequency in hertz
ch=1;%Number of channels--2 options--1 (mono) or 2 (stereo)
datatype='uint8';
nbits=16;%8,16,or 24
Nseconds=5;
% to record audio data from an input device ...
...such as a microphone for processing in MATLAB
% recorder=audiorecorder(Fs,nbits,ch);
% disp('Start speaking..')
%Record audio to audiorecorder object,...
...hold control until recording completes
% recordblocking(recorder,Nseconds);
% disp('End of Recording.');
%Store recorded audio signal in numeric array
% x=getaudiodata(recorder,datatype);
%Write audio file
% audiowrite('test.wav',x,Fs);
% subplot(211)
% plot (x)
% subplot(212)
 
 
[y,Fs]=audioread('testing.wav');
% Set the desired SNR (in dB)
SNR = 0.01;
% Calculate the power of the signal
signal_power = norm(y)^2 / length(y);
% Calculate the noise power required to achieve the desired SNR
noise_power = signal_power / (10^(SNR/10));
% Generate Gaussian noise with the required power and add it to the signal
noise = sqrt(noise_power) * randn(size(y));
y_noisy = y + noise;
% Save the noisy signal to a new audio file
audiowrite('noisy_audiofile.wav', y_noisy, Fs);
 
[y2,Fs] = audioread('noisy_audiofile.wav');
%creating time vector
%(start time,end time,samples in y)
t=linspace(0,length(y2)/Fs,length(y2));
figure(1);
plot(t,y2);
title('signal in time domain');
info=audioinfo('testing.wav');
%spectral analysis
L=length(y2);
NFFT=2^nextpow2(L);
y_fft = abs(fft(y2,NFFT));
freq=Fs/2*linspace(0,1,NFFT/2+1);
figure(2);
plot(freq, y_fft(1:length(freq)));
title('signal in frequency domain');
sample_rate =Fs; % Sampling Frequency (Hz)
Fn = Fs/2; % Nyquist Frequency (Hz)
Wp = 1500/Fn; % Passband Frequency (Normalised)
Ws = 450/Fn; % Stopband Frequency (Normalised)
Rp = 1; % Passband Ripple (dB)
Rs = 150; % Stopband Ripple (dB)
[n,Ws] = cheb2ord(Wp,Ws,Rp,Rs); % Filter Order
[z,p,k] = cheby2(n,Rs,Ws,'low'); % Filter Design
[soslp,glp] = zp2sos(z,p,k); % Convert To Second-Order-Section For Stability
figure(5)
freqz(soslp, 2^16, Fs) % Filter Bode Plot
filtered_sound = filtfilt(soslp, glp, y2);
sound(filtered_sound, sample_rate);

%1)   Load the 'audio_sample.wav' file in MATLAB
[sample_data, sample_rate] = audioread('noisy_audiofile.wav');
% a.  Plot the signal in time and the amplitude of its frequency 
% components using the FFT.
sample_period = 1/sample_rate;
t = (0:sample_period:(length(sample_data)-1)/sample_rate);
subplot(2,2,1)
plot(t,sample_data)
title('Time Domain Representation - Unfiltered Sound')
xlabel('Time (seconds)')
ylabel('Amplitude')
xlim([0 t(end)])
m = length(sample_data); % Original sample length.
n = pow2(nextpow2(m)); % Transforming the length so that the number of 
% samples is a power of 2. This can make the transform computation 
% significantly faster,particularly for sample sizes with large prime 
% factors.
y = fft(sample_data, n);
f = (0:n-1)*(sample_rate/n);
amplitude = abs(y)/n;
subplot(2,2,2)
plot(f(1:floor(n/2)),amplitude(1:floor(n/2)))
title('Frequency Domain Representation - Unfiltered Sound')
xlabel('Frequency')
ylabel('Amplitude')
% b.  Listen to the audio file.
% sound(sample_data, sample_rate)
%%2)  Filter the audio sample data to remove noise from the signal.
order = 14;
[b,a] = butter(order,1000/(sample_rate/2),'low');
filtered_sound = filter(b,a,sample_data);
audiowrite('filtered_audiofile.wav', filtered_sound, Fs)
sound(filtered_sound, sample_rate)
t1 = (0:sample_period:(length(filtered_sound)-1)/sample_rate);
subplot(2,2,3)
plot(t1,filtered_sound)
title('Time Domain Representation - Filtered Sound')
xlabel('Time (seconds)')
ylabel('Amplitude')
xlim([0 t1(end)])
m1 = length(sample_data); % Original sample length.
n1 = pow2(nextpow2(m1)); % Transforming the length so that the number of 
% samples is a power of 2. This can make the transform computation 
% significantly faster,particularly for sample sizes with large prime 
% factors. 
y1 = fft(filtered_sound, n1);
f = (0:n1-1)*(sample_rate/n1);
amplitude = abs(y1)/n1;
subplot(2,2,4)
plot(f(1:floor(n1/2)),amplitude(1:floor(n1/2)))
title('Frequency Domain Representation - Filtered Sound')
xlabel('Frequency')
ylabel('Amplitude')
Fs = sample_rate;                                       % Sampling Frequency (Hz)
Fn = Fs/2;                                              % Nyquist Frequency (Hz)
Wp = 4000/Fn;                                           % Passband Frequency (Normalised)
Ws = 4010/Fn;                                           % Stopband Frequency (Normalised)
Rp =   1;                                               % Passband Ripple (dB)
Rs = 10;                                               % Stopband Ripple (dB)
[n,Ws] = cheb2ord(Wp,Ws,Rp,Rs);                         % Filter Order
[z,p,k] = cheby2(n,Rs,Ws,'low');                        % Filter Design
[soslp,glp] = zp2sos(z,p,k);                            % Convert To Second-Order-Section For Stability
figure(6)
freqz(soslp, 2^16, Fs)                                  % Filter Bode Plot
filtered_sound = filtfilt(soslp, glp, sample_data);
sound(filtered_sound, sample_rate)