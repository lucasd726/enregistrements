function [angles] = compute_angles(meanFx, meanFy)


    % Compute phase angles from mean Fx and mean Fy
    Z = meanFx + 1j * meanFy;
    angles = rad2deg(angle(Z));


end