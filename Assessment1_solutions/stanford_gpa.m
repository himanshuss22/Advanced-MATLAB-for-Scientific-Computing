fname = 'courses.txt';

% Read file and get cell array of grades
course_cell = read_courses(fname);
courses     = make_course_struct(course_cell);

% Compute some statistics
fprintf('Cumulative GPA = %5.3f\n',compute_gpa(courses));
fprintf('Total # of classes taken at Stanford = %i\n',length(courses));
fprintf('Total # of graduation units = %.1f\n',sum([courses(:).grad_units]));

% Bar graph of courses taken per department
[X,label1] = extract_courses_make_output(courses,@compute_gpa,'department');
[Y,label2] = extract_courses_make_output(courses,@compute_units,'department');
figure('position',[251         347        1010         437],'paperpositionmode','auto'); 
subplot(1,2,1); bar(X); set(gca,'xticklabel',label1);
xlabel('Department'); ylabel('GPA'); grid on;
title('GPA by department');
subplot(1,2,2); bar(Y); set(gca,'xticklabel',label2);
xlabel('Department'); ylabel('Number of units'); grid on;
title('Units by department');
print(gcf,'-depsc2','grades_department');

% Bar graph of courses taken per quarter
[X,label1] = extract_courses_make_output(courses,@compute_gpa,'quarter');
[Y,label2] = extract_courses_make_output(courses,@compute_units,'quarter');
figure('position',[251         347        1010         437],'paperpositionmode','auto'); 
subplot(1,2,1); bar(X); set(gca,'xticklabel',label1); 
xlabel('Quarter'); ylabel('GPA'); grid on;
title('GPA by quarter');
subplot(1,2,2); bar(Y); set(gca,'xticklabel',label2); 
xlabel('Quarter'); ylabel('Number of units'); grid on;
title('Units by quarter');
print(gcf,'-depsc2','grades_quarter');

% Bar graph of courses taken each quarter during career at Stanford
[X,label1,label2] = extract_courses_make_output(courses,@compute_gpa,'academic_year','quarter');
Y = extract_courses_make_output(courses,@compute_units,'academic_year','quarter');
figure('position',[251         347        1010         437],'paperpositionmode','auto'); 
subplot(1,2,1); bar(X); set(gca,'xticklabel',label1); 
legend(label2{:},'Location','SouthEast');
xlabel('Academic Year'); ylabel('GPA'); grid on;
title('GPA by quarter and academic year');
subplot(1,2,2); bar(Y); set(gca,'xticklabel',label1); 
xlabel('Academic Year'); ylabel('Number of units'); grid on;
title('Units by quarter and academic year');
print(gcf,'-depsc2','grades_year_quarter');