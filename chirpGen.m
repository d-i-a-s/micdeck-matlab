% Chirp fs
fs = 44100;

% Chirp duration
secToPlay = 10;

t = 0:1/fs:.5;

y = chirp(t,100,.5,3500);

y = repmat(y,1,secToPlay*2);

spectrogram(y,256,250,256,fs,'yaxis')

% Chirp play
soundsc(y, fs);