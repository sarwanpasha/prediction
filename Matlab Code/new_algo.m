clear

% Load_Data_File = 'Rice31.mat';
% Load_Data_File = 'American75.mat';
Load_Data_File = 'Caltech36.mat';
load (Load_Data_File)


% Writing dataset values in Excel File
 data=load(Load_Data_File);
 f=fieldnames(data); %Get names of fields
 
Name_Of_Attributes = 'student/faculty status';
Name_Of_Attribute_gender ='gender';
Name_Of_Attribute_major ='major';
Name_Of_Attributes_minor ='minor';
Name_Of_Attributes_dorm ='dorm';
Name_Of_Attributes_Graduation ='Graduation Year';
Name_Of_Attributes_high_school ='high school';
File_Name1_Results = strcat('E:\MS Computer Science\MS Thesis\Step 3\Coding\Results\Results_Of_', Load_Data_File);
File_Name_Results = strcat(File_Name1_Results,'.xlsx');
% delete (File_Name_Results); % Delete old Excel file
% xlswrite(File_Name_Results,{Name_Of_Attributes,Name_Of_Attribute_gender,Name_Of_Attribute_major,Name_Of_Attributes_minor,Name_Of_Attributes_dorm,Name_Of_Attributes_Graduation,Name_Of_Attributes_high_school},'Accuracies_Divergence','A1');



% File_Name1 = strcat('E:\MS Computer Science\MS Thesis\Step 3\Coding\Results\', Load_Data_File);
% File_Name2 = strcat(File_Name1,'_Dataset_Description');
% File_Name = strcat(File_Name2,'.xlsx');

Mixing_Matrix_File_Name_2 ='E:\MS Computer Science\MS Thesis\Step 3\Coding\Results\Mixing_Matrix_For_';
Mixing_Matrix_File_Name_1 =strcat(Mixing_Matrix_File_Name_2, Load_Data_File);
Mixing_Matrix_File_Name =strcat(Mixing_Matrix_File_Name_1,'.xlsx');
% delete (Mixing_Matrix_File_Name); % Delete old Excel file

adjMatrix=A;
attributeMatrix=local_info;
missingValueIndices=[];
nodeCount=length(adjMatrix);
for i=1:length(attributeMatrix)
    index=find(attributeMatrix(i,:)==0);
    if(length(index)>0)
        missingValueIndices=[missingValueIndices;i];
    end
end

excel_Name_1 = 'A';
excel_Name_2 = 'B';

true_Positive = 0;
false_Positive = 0;
true_Negative = 0;
false_Negative = 0;
missing_Value = 0;

accuracy_Count = 0;
attributeCount=1; %Attribute value (Max 7 attributes)
for outerLoop=1:attributeCount
    for innerLoop=1:attributeCount
%         fprintf('Outer Loop Value : %d\n',outerLoop);
%         fprintf('Inner Loop Value : %d\n',innerLoop);
        
        attribute1=outerLoop;
        attribute2=innerLoop;
           attribute1=3;
           attribute2=2;
        if(attribute1 == 1)
            Name_For_First_Attribute_Value = 'status';
        elseif (attribute1 == 2)
            Name_For_First_Attribute_Value = 'gender';
        elseif (attribute1 == 3)
            Name_For_First_Attribute_Value = 'major';
        elseif (attribute1 == 4)
            Name_For_First_Attribute_Value = 'minor';
        elseif (attribute1 == 5)
            Name_For_First_Attribute_Value = 'dorm';
        elseif (attribute1 == 6)
            Name_For_First_Attribute_Value = 'Graduation_Year';
        elseif (attribute1 == 7)
            Name_For_First_Attribute_Value = 'high_school';
        end
        if(attribute2 == 1)
            Name_For_Second_Attribute_Value = 'status';
        elseif (attribute2 == 2)
            Name_For_Second_Attribute_Value = 'gender';
        elseif (attribute2 == 3)
            Name_For_Second_Attribute_Value = 'major';
        elseif (attribute2 == 4)
            Name_For_Second_Attribute_Value = 'minor';
        elseif (attribute2 == 5)
            Name_For_Second_Attribute_Value = 'dorm';
        elseif (attribute2 == 6)
            Name_For_Second_Attribute_Value = 'Graduation_Year';
        elseif (attribute2 == 7)
            Name_For_Second_Attribute_Value = 'high_school';
        end
        
        fprintf('First Attribute : %d (%s)\n',attribute1,Name_For_First_Attribute_Value);
        fprintf('Second Attribute : %d (%s)\n',attribute2,Name_For_Second_Attribute_Value);
        
        
        a1=attributeMatrix(:,attribute1);
        a2=attributeMatrix(:,attribute2);
        a1_distinct=unique(a1);
        a2_distinct=unique(a2);
        a1_distinct=a1_distinct(a1_distinct~=0);
        a2_distinct=a2_distinct(a2_distinct~=0);
        
        a1_length=length(a1_distinct);
        a2_length=length(a2_distinct);
        
        Predict_Probability=zeros(a1_length,nodeCount);

        Mixing_Matrix=zeros(a1_length,a2_length); % Initializing Mixing matrix with zero's
        
        for i=1:nodeCount-1
            for j=i+1:nodeCount
                if(adjMatrix(i,j)==1)
                    %if((a1(i)==a1(j)) & (a2(i)==a2(j)))
                    index1=find(a1_distinct==a1(i));
                    index2=find(a2_distinct==a2(j));
                    %                 Mixing_Matrix(index1,index2)=Mixing_Matrix(index1,index2)+1;
                    if(attributeMatrix(i,attribute1)~=0 && attributeMatrix(j,attribute2)~=0)
                        Mixing_Matrix(index1,index2)=Mixing_Matrix(index1,index2)+1;
                        %                             Mixing_Matrix(attributeMatrix(i,attribute1),attributeMatrix(j,attribute2))=Mixing_Matrix(attributeMatrix(i,attribute1),attributeMatrix(j,attribute2))+1;
                    end
                    index1=find(a2_distinct==a2(i));
                    index2=find(a1_distinct==a1(j));
                    if(attributeMatrix(j,attribute1)~=0 && attributeMatrix(i,attribute2)~=0 )
                        Mixing_Matrix(index2,index1)=Mixing_Matrix(index2,index1)+1;
                        %                             Mixing_Matrix(attributeMatrix(j,attribute1),attributeMatrix(i,attribute2))=Mixing_Matrix(attributeMatrix(j,attribute1),attributeMatrix(i,attribute2))+1;
                    end
                end
            end
        end
        
        individualMajorFriendCount=zeros(nodeCount,length(a1_distinct));
        
        % adjacency matrix count
        for i=1:nodeCount
            neighbor=adjMatrix(i,:);
            for j=1:nodeCount
                if neighbor(j)==1
                    n=find(a1(j)==a1_distinct);
                    individualMajorFriendCount(i,n)=individualMajorFriendCount(i,n)+1;
                end
            end
        end
        

        % Row sum and column sum normalization Start
        Row_Sum=sum(transpose(Mixing_Matrix));
        Mixing_Matrix=bsxfun(@rdivide,Mixing_Matrix,Row_Sum(:)); %bsxfun: Divide each entry of row by value of row sum
        Mixing_Matrix;
%         Column_Sum=sum(Mixing_Matrix);
        % Row sum and column sum normalization Ends     

        Mixing_Matrix;
        correctPrediction=0; %Counter for correct Predictions
        mm=zeros(nodeCount,length(a2_distinct));
        for i=1:nodeCount
            for j=1:length(a2_distinct)
                mm(i,j) = individualMajorFriendCount(i,:) * (Mixing_Matrix(:,j));
            end
            i;
            j;
            [M,I] = max(mm(i,:));
            asd = int2str(i);
            temp_1 = strcat(excel_Name_1,asd);
            temp_2 = strcat(excel_Name_2,asd);
            
%             xlswrite('test.xlsx',I,'',temp_1);
%             xlswrite('test.xlsx',a2(i),'', temp_2);
            
            if(a2_distinct(I)==a2(i))
                correctPrediction=correctPrediction+1;
            end
            
            
            if(I==1 && a2(i) ==1)
                true_Positive = true_Positive + 1;
            elseif (I==1 && a2(i) ==2)
                false_Positive = false_Positive + 1;
            elseif (I==2 && a2(i) ==1)
                true_Negative = true_Negative + 1;
            elseif (I==2 && a2(i) ==2)
                false_Negative = false_Negative + 1;
            
            else
                missing_Value = missing_Value+1;
            end

%             if I == 1
%                 prediction = 'Male'
%             elseif I==2
%                 prediction = 'Female'
%             end
        end
        accuracy=(correctPrediction/nodeCount)*100;
        fprintf('Accuracy : %0.2f\n',accuracy); % Print by the accuracy of 2 decimal points
        
        accuracy_Count = accuracy_Count+1;
        tempp = int2str(accuracy_Count);
        temp_1 = strcat(excel_Name_1,tempp);
        xlswrite('test.xlsx',accuracy,'accuracy',temp_1);
    end % Inner Loop Ends

end % Outer Loop Ends

true_Positive
false_Positive
true_Negative
false_Negative
missing_Value
  winopen('test.xlsx');



% End code %
