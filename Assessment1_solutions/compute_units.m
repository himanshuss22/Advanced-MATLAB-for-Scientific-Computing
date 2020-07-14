function  units = compute_units(grades)
% Compute units from grades structure

if isempty(grades)
    units=NaN;
    return;
end
units = sum([grades(:).units]);

end