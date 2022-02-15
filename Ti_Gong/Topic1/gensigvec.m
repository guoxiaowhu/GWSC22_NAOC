function signal = gensigvec(dataX,snr,Coefs,SignalType)
% Generate different signals
% S = GENSIGVEC(X,SNR,C,STYPE)
% Generates different signals S. X is the vector of time stamps at which
% the samples of the signal are to be computed. SNR is the matched filtering 
% signal-to-noise ratio of S, and C is the vector of coefficients that 
% parametrize the phase of the signal. STYPE is the type of the signal.

% Ti Gong, Feburary 2022

    if SignalType == 1
        signal = sin(2*pi*Coefs(1)*dataX + Coefs(2));
        signal = snr*signal/norm(signal);
    end

    if SignalType == 2
        signal = sin(2*pi*(Coefs(1)*dataX + Coefs(2)*dataX.^2) + Coefs(3));
        signal = snr*signal/norm(signal);
    end

    if SignalType == 3
        signal = exp(-0.5*(dataX - Coefs(1)).^2/(Coefs(2)^2)).*sin(2*pi*Coefs(3)*dataX + Coefs(4));
        signal = snr*signal/norm(signal);
    end

    if SignalType == 4
        signal = sin(2*pi*Coefs(2)*dataX + Coefs(1)*cos(2*pi*Coefs(3)*dataX));
        signal = snr*signal/norm(signal);
    end

    if SignalType == 5
        signal = cos(2*pi*Coefs(2)*dataX).*sin(2*pi*Coefs(1)*dataX + Coefs(3));
        signal = snr*signal/norm(signal);
    end

    if SignalType == 6
        signal = cos(2*pi*Coefs(3)*dataX).*sin(2*pi*Coefs(2)*dataX + Coefs(1)*cos(2*pi*Coefs(3)*dataX));
        signal = snr*signal/norm(signal);
    end

    if SignalType == 7
        for i=1:length(dataX)
            if dataX(i) >= Coefs(1) && dataX(i) <= Coefs(1) + Coefs(5)
                signal(i) = sin(2*pi*(Coefs(2)*(dataX(i) - Coefs(1)) + Coefs(3)*(dataX(i) - Coefs(1))^2) + Coefs(4));
            else
                signal(i) = 0;
            end
        end
        signal = snr*signal/norm(signal);
    end

    if SignalType == 8
        for i=1:length(dataX)
            if dataX(i) >= Coefs(1) && dataX(i) <= Coefs(1) + Coefs(5)
                signal(i) = exp(-(dataX(i) - Coefs(1))/Coefs(3))*sin(2*pi*Coefs(2)*dataX(i) + Coefs(4));
            else
                signal(i) = 0;
            end
        end
        signal = snr*signal/norm(signal);
    end

    if SignalType == 9
        for i=1:length(dataX)
            if dataX(i) <= Coefs(1)
                signal(i) = sin(2*pi*Coefs(2)*dataX(i));
            else
                signal(i) = sin(2*pi*(Coefs(3)*(dataX(i) - Coefs(1)) + Coefs(2)*Coefs(1)));
            end
        end
        signal = snr*signal/norm(signal);
    end
end