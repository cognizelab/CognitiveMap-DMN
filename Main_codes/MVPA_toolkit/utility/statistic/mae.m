function error = mae(diff_y)
%CALC_MAE Mean Absolute Error
    

    error = mean(abs(diff_y(:)));

end