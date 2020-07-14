function  classes = get_courses(grades,field1,val1,field2,val2)
% This function removes all entries from the grades structure
% whose field does not match any of the entries in vals.

if nargin == 3
    field2=[]; val2=[];
end

classes = grades;
for i = length(grades):-1:1
    if (~isempty(field1) && isempty(intersect(classes(i).(field1),val1)))
        classes(i)=[];
    end
    if (~isempty(field2) && isempty(intersect(classes(i).(field2),val2)))
        classes(i)=[];
    end
end

end