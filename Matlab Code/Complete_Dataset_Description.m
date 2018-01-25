datasets={'Caltech36.mat','Rice31.mat','American75.mat','Amherst41.mat','Auburn71.mat','Baylor93.mat','BC17.mat','Berkeley13.mat','Bingham82.mat','Bowdoin47.mat','Brandeis99.mat','Brown11.mat','BU10.mat','Bucknell39.mat','Cal65.mat','Carnegie49.mat','Colgate88.mat','Columbia2.mat','Cornell5.mat','Dartmouth6.mat','Duke14.mat','Emory27.mat','FSU53.mat','Georgetown15.mat','GWU54.mat','Hamilton46.mat','Harvard1.mat','Haverford76.mat','Howard90.mat','Indiana69.mat','JMU79.mat','Johns Hopkins55.mat','Lehigh96.mat','Maine59.mat','Maryland58.mat','Mich67.mat','Michigan23.mat','Middlebury45.mat','Mississippi66.mat','MIT8.mat','MSU24.mat','MU78.mat','Northeastern19.mat','Northwestern25.mat','Notre Dame57.mat','NYU9.mat','Oberlin44.mat','Oklahoma97.mat','Penn94.mat','Pepperdine86.mat','Princeton12.mat','Reed98.mat','Rochester38.mat','Rutgers89.mat','Santa74.mat','schools.mat','Simmons81.mat','Smith60.mat','Stanford3.mat','Swarthmore42.mat','Syracuse56.mat','Temple83.mat','Tennessee95.mat','Texas80.mat','Texas84.mat','Trinity100.mat','Tufts18.mat','Tulane29.mat','UC33.mat','UC61.mat','UC64.mat','UCF52.mat','UChicago30.mat','UCLA26.mat','UConn91.mat','UCSB37.mat','UCSC68.mat','UCSD34.mat','UF21.mat','UGA50.mat','UIllinois20.mat','UMass92.mat','UNC28.mat','UPenn7.mat','USC35.mat','USF51.mat','USFCA72.mat','UVA16.mat','Vanderbilt48.mat','Vassar85.mat','Vermont70.mat','Villanova62.mat','Virginia63.mat','Wake73.mat','WashU32.mat','Wellesley22.mat','Wesleyan43.mat','William77.mat','Williams40.mat','Wisconsin87.mat','Yale4.mat'};
datasets_String={'Caltech36','Rice31','American75','Amherst41','Auburn71','Baylor93','BC17','Berkeley13','Bingham82','Bowdoin47','Brandeis99','Brown11','BU10','Bucknell39','Cal65','Carnegie49','Colgate88','Columbia2','Cornell5','Dartmouth6','Duke14','Emory27','FSU53','Georgetown15','GWU54','Hamilton46','Harvard1','Haverford76','Howard90','Indiana69','JMU79','Johns Hopkins55','Lehigh96','Maine59','Maryland58','Mich67','Michigan23','Middlebury45','Mississippi66','MIT8','MSU24','MU78','Northeastern19','Northwestern25','Notre Dame57','NYU9','Oberlin44','Oklahoma97','Penn94','Pepperdine86','Princeton12','Reed98','Rochester38','Rutgers89','Santa74','schools','Simmons81','Smith60','Stanford3','Swarthmore42','Syracuse56','Temple83','Tennessee95','Texas80','Texas84','Trinity100','Tufts18','Tulane29','UC33','UC61','UC64','UCF52','UChicago30','UCLA26','UConn91','UCSB37','UCSC68','UCSD34','UF21','UGA50','UIllinois20','UMass92','UNC28','UPenn7','USC35','USF51','USFCA72','UVA16','Vanderbilt48','Vassar85','Vermont70','Villanova62','Virginia63','Wake73','WashU32','Wellesley22','Wesleyan43','William77','Williams40','Wisconsin87','Yale4'};

 total_Length = length(datasets); 
% max(sum(A)); % Max Degree
% (sum(sum(A))/2)/769; % Average Degree
% sum(sum(A))/2 ; % Edge Count
Excel_File_Name = 'Complete_Dataset_Results.xlsx';
Atributes = {'Graph Name','Node Count', 'Max Degree', 'Average Degree', 'Edge Count'};
delete (Excel_File_Name); % Delete old Excel file

    xlswrite(Excel_File_Name,Atributes,'Sheet1');
    xlswrite(Excel_File_Name,datasets_String','Sheet1', 'A2');
    
for i = 1:total_Length
    i
    load (datasets{i});
    Node_Count = length(A)
    Max_Degree = max(sum(A)) % Max Degree
    Average_Degree = (sum(sum(A))/2)/Node_Count % Average Degree
    Edge_Count = sum(sum(A))/2  % Edge Count
    
    counter_1 = i+1;
    counter = int2str(counter_1);
    counter_Node = strcat('B',counter);
    counter_Max_Degree = strcat('C', counter);
    counter_Average_Degree = strcat('D', counter);
    counter_Edge_Count = strcat('E', counter);
    xlswrite(Excel_File_Name,Node_Count','Sheet1', counter_Node);
    xlswrite(Excel_File_Name,Max_Degree','Sheet1', counter_Max_Degree);
    xlswrite(Excel_File_Name,Average_Degree','Sheet1', counter_Average_Degree);
    xlswrite(Excel_File_Name,Edge_Count','Sheet1', counter_Edge_Count);
%     xlswrite(Excel_File_Name,[Node_Count;Max_Degree;Average_Degree;Edge_Count],'A');

end

winopen(Excel_File_Name);
