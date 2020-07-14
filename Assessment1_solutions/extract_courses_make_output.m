function  [X,label1,label2] = extract_courses_make_output(courses,func,field1,field2)
% This function removes all entries from the grades structure
% whose field does not match any of the entries in vals.

% Extract all entries in field1
if ischar(courses(1).(field1))
    entry1  = unique({courses(:).(field1)});
else
    entry1  = unique([courses(:).(field1)]);
end
nentry1 = length(entry1);

% Defaults
if nargin < 4
    field2=[]; val2=[];
    nentry2 = 0;
else
    if ischar(class(courses(1).(field2)))
        entry2  = unique({courses(:).(field2)});
    else
        entry2  = unique([courses(:).(field2)]);
    end
    nentry2 = length(entry2);
end

% Parse courses
X = zeros(nentry1,max(1,nentry2));
label1 = cell(1,nentry1);
label2 = cell(1,max(1,nentry2));
for i = 1:nentry1
    course_sub = get_courses(courses,field1,entry1(i));
    X(i,1) = func(course_sub);
    if iscell(entry1)
        label1{i} = entry1{i};
    else
        label1{i} = num2str(entry1(i));
    end
    for j = 1:nentry2
        course_sub_inner = get_courses(course_sub,field2,entry2(j));
        X(i,j) = func(course_sub_inner);
        if iscell(entry2)
            label2{j} = entry2{j};
        else
            label2{j} = num2str(entry2(j));
        end
    end
end

end