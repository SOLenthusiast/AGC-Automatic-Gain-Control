[traces,texthead,binaryhead,extendedhead]=SEGY_read('1641.sgy');
val=SEGY_getHeader(binaryhead,'hdt'); %option 'hdt' is defined in binaryhead.definitions.values
scal=SEGY_getHeader(traces,'scalco');
s_coord(:,1)=SEGY_getHeader(traces,'sx')./scal; %likewise for 'sx' traces.definitions.value
s_coord(:,2)=SEGY_getHeader(traces,'sy')./scal;
%sx=1625;
%sy=0;
rec_coord(:,1)=SEGY_getHeader(traces,'gx')./10;
rec_coord(:,2)=SEGY_getHeader(traces,'gy')./10;
h=figure(1);
plot(rec_coord(:,1),rec_coord(:,2),'o')
hold on
plot(1625,0,'r*')
xlabel('X')
ylabel('Y')
hleg=legend('Receivers','Source','Location','NorthEast');

unit=SEGY_getHeader(traces,'counit');
data=SEGY_getData(traces);

%Gain classique
figure(2);
subplot(1,3,1)
fact=plotseis(data);
xlabel('Traces');
ylabel('Samples');
title({'Gain=0',''})
gain1=gainmute(data,(1:2500)',1:96,97,0,0,2);
subplot(1,3,3);fact1=plotseis(gain1);
xlabel('Traces');
ylabel('Samples');
title({'Gain=2',''})
gain2=gainmute(data,(1:2500)',1:96,97,0,0,1.5);
subplot(1,3,2);fact2=plotseis(gain2);
xlabel('Traces');
ylabel('Samples');
title({'Gain=1.5',''})

%aec
figure(3)
trout=aec(data,'op_length',2500/8);
subplot(1,3,1);fact=plotseis(trout);
title({'aec-default';''})
trout=aec(data,'op_length',(0.2*500)/8);
subplot(1,3,2);fact=plotseis(trout);
title({'aec-0.2s';''})
trout=aec(data,'op_length',(0.02*500)/8);
subplot(1,3,3);fact=plotseis(trout);
title({'aec-0.02s';''})



