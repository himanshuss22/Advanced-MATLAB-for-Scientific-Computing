function  gpa = compute_gpa(grades)
% Compute gpa from grades structure

if isempty(grades)
    gpa=NaN;
    return;
end
gpa = [grades(:).gpa_credits]*[grades(:).gpa_units]'/sum([grades(:).gpa_units]);

end