% Generate a multichannel .raw audio file compatible with ODAS
% Author: Luis M. Gato, lmiguelgato@gmail.com

close all
clear
clc

disp(' ')  
disp('[1/5] Initialization ...')
  single_wavs_path = 'single_channels/';
  disp(['* Input directory set to "' single_wavs_path '"'])
  
  root_wav_name = 'wav_mic';
  disp(['* Root .wav file name set to "' root_wav_name '"'])
  
  N = 8;
  disp(['* Number of .wav files expected: ' num2str(N)])
  
  multichannel_wav_path = 'multichannel/';
  out_mkdir = mkdir(multichannel_wav_path);
  if (out_mkdir == 1)
    disp(['* Output directory set to "' multichannel_wav_path '"'])
  end

disp('Done.')
disp(' ')

disp('[2/5] Getting metadata from .wav files ...')  
  [tmp, fs] = audioread([single_wavs_path root_wav_name '1.wav']);
  disp(['* Sampling rate     : ' num2str(fs) ' Hz'])  
  [m, n] = size(tmp);
  disp(['* Duration          : ' num2str(m/fs) ' s'])  
  disp(['* Channels per .wav : ' num2str(n)])  
  
  if n ~= 1
    error('Wrong audio file dimensions. Aborting ...')
  end
disp('Done.')    
disp(' ')    

disp(['[3/5] Reading ' num2str(N) ' single-channel .wav files ...'])  
  y = zeros(m, N);
  for i = 1:N
    disp([' ' num2str(i) ' - ' root_wav_name num2str(i) '.wav'])  
    y(:, i) = audioread([single_wavs_path root_wav_name num2str(i) '.wav']);
  end
disp('Done.')    
disp(' ')

disp('[4/5] Writing multichannel .wav file ...')
  audiowrite([multichannel_wav_path 'mics.wav'], y, fs)
  disp(['* Written as "' multichannel_wav_path 'mics.wav"'])
disp('Done.')  
disp(' ')

disp('[5/5] Converting to .raw file ...')
  out_system = system('sh wav2raw_bash.sh');
  disp(['* Written as "' multichannel_wav_path 'mics.raw"'])
  
  if out_system ~= 0
    error('Unable to run bash. Aborting ...')
  end
disp('Done.')    
disp(' ')