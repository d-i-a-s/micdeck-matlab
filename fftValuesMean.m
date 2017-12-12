% Computes the fftVales mean in a time interval 
function m = fftValuesMean(tfftValues, fftValues, cursor_info1, cursor_info2)
    t1 = cursor_info1.Position(1);
    t2 = cursor_info2.Position(1);
    [c index1] = min( abs( tfftValues - ones(size(tfftValues))*t1 ) );
    [c index2] = min( abs( tfftValues - ones(size(tfftValues))*t2 ) );
    m = mean(fftValues(:, index1:index2), 2);
end
