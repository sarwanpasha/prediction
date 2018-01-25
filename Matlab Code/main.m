clear

Load_Data_File = 'Rice31.mat';
% Load_Data_File = 'Caltech36';
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
delete (File_Name_Results); % Delete old Excel file
xlswrite(File_Name_Results,{Name_Of_Attributes,Name_Of_Attribute_gender,Name_Of_Attribute_major,Name_Of_Attributes_minor,Name_Of_Attributes_dorm,Name_Of_Attributes_Graduation,Name_Of_Attributes_high_school},'Accuracies_Divergence','A1');



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

column_Name_For_Writting_1 = 0;
temp_1=8;
temp_2=0;
% Predictor_Auto_Increamental = 775; % For Caltech dataset
Predictor_Auto_Increamental = 4095; % For Rice Dataset

attributeCount=7; %Attribute value (Max 7 attributes)
for outerLoop=1:attributeCount
    for innerLoop=1:attributeCount
        fprintf('Outer Loop Value : %d\n',outerLoop);
        fprintf('Inner Loop Value : %d\n',innerLoop);
        
        attribute1=outerLoop;
        attribute2=innerLoop;
%            attribute1=1;
%            attribute2=7;
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
        %         rAdjMatrix=adjMatrix;
        %         rAdjMatrix(user,:)=[];
        %         rAdjMatrix(:,user)=[];
        
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
        
        

        
        Friend_with_Missing_Attributes=0;
        Mixing_Matrix;
        Row_Sum=sum(transpose(Mixing_Matrix));
        Mixing_Matrix=bsxfun(@rdivide,Mixing_Matrix,Row_Sum(:));
        Mixing_Matrix;
        Column_Sum=sum(Mixing_Matrix);
        
        for user=1:nodeCount
            Friend_with_Missing_Attributes=0;
            User_Friend_List=adjMatrix(:,user);
            User_Friend_Count=sum(User_Friend_List);
            Value_Wise_Probability=zeros(length(a2_distinct),1);
            for i=1:length(User_Friend_List)
                if(User_Friend_List(i)==1)
                    if(a2(i)~=0)
                        Value_Wise_Probability(find(a2_distinct==a2(i)))=Value_Wise_Probability(find(a2_distinct==a2(i)))+1;
                    else
                        Friend_with_Missing_Attributes=Friend_with_Missing_Attributes+1;
                    end
                end
            end
            % Row_value_Wise_Probability=Value_Wise_Probability./(User_Friend_Count-Friend_with_Missing_Attributes);
            Row_value_Wise_Probability=Value_Wise_Probability./(User_Friend_Count-Friend_with_Missing_Attributes);
            
            Value_Wise_Probability;
            totalPr=0;
            Individual_Atr_Value_Pr=zeros(a1_length,1);
            
            
            for i=1:a1_length
                for j=1:a2_length
                    if(Column_Sum(j)~=0)
                        %             fprintf('%f%s%f\n',((Mixing_Matrix(i,j)/Column_Sum(j))),'*',Row_value_Wise_Probability(j))
                        Individual_Atr_Value_Pr(i)=Individual_Atr_Value_Pr(i)+((Mixing_Matrix(i,j)/Column_Sum(j))*Row_value_Wise_Probability(j));
                    end
                end
            end

            Predict_Probability(:,user)= Individual_Atr_Value_Pr;

        end
        
        %-----------------Mixing Matrix Writitng in Excel -----------------%
        outerLoop_String = int2str(attribute1); % outerLoop (Name_For_First_Attribute_Value)
        innerLoop_String = int2str(attribute2); % innerLoop (Name_For_Second_Attribute_Value)
        excel_Sheet_name = strcat('Prediction_Attribute_',Name_For_First_Attribute_Value);
        excel_Sheet_name1 = strcat(excel_Sheet_name,'_And_');
        excel_Sheet_name2 = strcat(excel_Sheet_name1,Name_For_Second_Attribute_Value);
        
        First_Dimention = int2str(a1_length);
        Second_Dimention = int2str(a2_length);
        Matrix_Dimentions_2 = strcat('_',First_Dimention);
        Matrix_Dimentions_1 = strcat(Matrix_Dimentions_2,'x');
        Matrix_Dimentions = strcat(Matrix_Dimentions_1,Second_Dimention);
        
        Combine_Attribute_Names_2 = strcat(Name_For_First_Attribute_Value,'_VS_');
        Combine_Attribute_Names_1 = strcat(Combine_Attribute_Names_2,Name_For_Second_Attribute_Value);
        Combine_Attribute_Names = strcat(Combine_Attribute_Names_1,Matrix_Dimentions);

        Predictor_Auto_Increamental_temp_1 = int2str(Predictor_Auto_Increamental);
        Predictor_Auto_Increamental_temp_2 = int2str(Predictor_Auto_Increamental+1);

        Predictor_Auto_Increamental_String_1 = strcat('A',Predictor_Auto_Increamental_temp_1);
        Predictor_Auto_Increamental_String_2 = strcat('A',Predictor_Auto_Increamental_temp_2);
%          xlswrite(Mixing_Matrix_File_Name,Mixing_Matrix,excel_Sheet_name2);
        xlswrite(File_Name_Results,cellstr(Combine_Attribute_Names),'Accuracies_Divergence', Predictor_Auto_Increamental_String_1);
        xlswrite(File_Name_Results,Mixing_Matrix,'Accuracies_Divergence', Predictor_Auto_Increamental_String_2);

        Predictor_Auto_Increamental = Predictor_Auto_Increamental + a1_length + 3;
        %-----------------Mixing Matrix Writitng in Excel -----------------%

        
        
        
        %-----------------Prediction Calculator logic Starts -----------------%    
        Predicted_Decision=zeros(nodeCount,1);
        for i=1:nodeCount
            [m,n]=max(Predict_Probability(:,i));
            if(length(n)>=1)
                Predicted_Decision(i)=a1_distinct(n(1));
            end
        end

        correctPrediction=0; %Counter for correct Predictions
        for i=1:nodeCount
            if(Predicted_Decision(i)==a1(i))
                correctPrediction=correctPrediction+1;
            end
        end

        accuracy=(correctPrediction/nodeCount)*100;
        fprintf('Accuracy : %0.2f\n',accuracy); % Print by the accuracy of 2 decimal points
        


        column_Name_For_Writting_1 = column_Name_For_Writting_1 + 1;
        column_Name_For_Writting_String = column_Name_For_Writting_1;
        column_Name_For_Writting_Attribute_Combinations = strcat('A',int2str(column_Name_For_Writting_String+2));
        column_Name_For_Writting_Accuracies = strcat('B',int2str(column_Name_For_Writting_String+2));
        column_Name_For_Writting_Divergence_Log = strcat('C',int2str(column_Name_For_Writting_String+2));
        column_Name_For_Writting_Divergence_Square = strcat('D',int2str(column_Name_For_Writting_String+2));
        column_Name_For_Writting_Divergence_Cube = strcat('E',int2str(column_Name_For_Writting_String+2));
        
        
        Attribute_Combinaiton_Name_1 = strcat(Name_For_First_Attribute_Value,'_VS_');
        Attribute_Combinaiton_Name = strcat(Attribute_Combinaiton_Name_1,Name_For_Second_Attribute_Value);
        xlswrite(File_Name_Results,cellstr('Attribute_Combinations'),'Accuracies_Divergence', 'A2');
        xlswrite(File_Name_Results,cellstr(Attribute_Combinaiton_Name),'Accuracies_Divergence', column_Name_For_Writting_Attribute_Combinations);
%         fprintf('\n Value = %s \n',column_Name_For_Writting); % For writting in colums A1, A2, A3 ......
        xlswrite(File_Name_Results,cellstr('Accuracy'),'Accuracies_Divergence', 'B2');
        xlswrite(File_Name_Results,accuracy,'Accuracies_Divergence', column_Name_For_Writting_Accuracies);
        %-----------------Prediction Calculator logic Ends -----------------%  
        
        
%*******************-----------------Calculating Divergence (LOG) by calling Divergence Function -----------------*****************%
        corelation = Divergence_Log(Mixing_Matrix);
        xlswrite(File_Name_Results,cellstr('Corelation LOG'),'Accuracies_Divergence', 'C2');
        xlswrite(File_Name_Results,corelation,'Accuracies_Divergence', column_Name_For_Writting_Divergence_Log);
        
        %-----------------Calculating Divergence (LOG) by calling Divergence Function -----------------%

%*******************-----------------Calculating Divergence (Square) by calling Divergence Function -----------------*****************%
        corelation = Divergence_Square(Mixing_Matrix);
        xlswrite(File_Name_Results,cellstr('Corelation Square'),'Accuracies_Divergence', 'D2');
        xlswrite(File_Name_Results,corelation,'Accuracies_Divergence', column_Name_For_Writting_Divergence_Square);
        
        %-----------------Calculating Divergence (Square) by calling Divergence Function -----------------%

%*******************-----------------Calculating Divergence (Cube) by calling Divergence Function -----------------*****************%
        corelation = Divergence_Cube(Mixing_Matrix);
        xlswrite(File_Name_Results,cellstr('Corelation Cube'),'Accuracies_Divergence', 'E2');
        xlswrite(File_Name_Results,corelation,'Accuracies_Divergence', column_Name_For_Writting_Divergence_Cube);
        
        %-----------------Calculating Divergence (Cube) by calling Divergence Function -----------------%
        
        
        %-----------------Calculating All Predictions -----------------%
        temp_1 = temp_1 + 1;
        temp_2 = temp_1 + 1;

        Row_Status_For_Predicted_Values = attribute1;
        Row_Int_Converter_For_Predicted_String = conv2xlscell(1, temp_1); % it returns str = (row, column)
        Row_Int_Converter_For_Original_String = conv2xlscell(1, temp_2); % it returns str = (row, column)
        

        Row_Int_Converter_For_Predicted_Decision = conv2xlscell(2, temp_1); % it returns str = (row, column)
        Row_Int_Converter_For_Original_Attribute = conv2xlscell(2, temp_2); % it returns str = (row, column)
%         Row_Int_Converter =  conv2xlscell(attribute1+1, attribute1+38);
        
        Getting_Attribute_1_Original_Value = strcat(Attribute_Combinaiton_Name,'_Original_Attribute');
        Getting_Attribute_1_Predicted_Value = strcat(Attribute_Combinaiton_Name,'_Predicted_Decision');
        
        xlswrite(File_Name_Results,cellstr(Getting_Attribute_1_Predicted_Value),'Accuracies_Divergence', Row_Int_Converter_For_Predicted_String);
        xlswrite(File_Name_Results,Predicted_Decision,'Accuracies_Divergence', Row_Int_Converter_For_Predicted_Decision);
        xlswrite(File_Name_Results,cellstr(Getting_Attribute_1_Original_Value),'Accuracies_Divergence', Row_Int_Converter_For_Original_String);
        xlswrite(File_Name_Results,a1,'Accuracies_Divergence', Row_Int_Converter_For_Original_Attribute);
        
        temp_1 = temp_1 + 2;
        temp_2 = temp_2 + 2;
        %-----------------Calculating All Predictions -----------------%
    end % Inner Loop Ends

end % Outer Loop Ends


% winopen(Mixing_Matrix_File_Name);   % to open Mixing Matrix excel file, just to check.
% 
%--------------------------------------------
% Predicted_Decision=zeros(nodeCount,1);
% for i=1:nodeCount
%     [m,n]=max(Predict_Probability(:,i));
%     if(length(n)>=1)
%         Predicted_Decision(i)=a1_distinct(n(1));
%     end
% end
% 
% correctPrediction=0;
% for i=1:nodeCount
%     if(Predicted_Decision(i)==a1(i))
%         correctPrediction=correctPrediction+1;
%     end
% end
% 
% accuracy=(correctPrediction/nodeCount)*100;
%----------------------------------------------
%fprintf('Accuracy : %0.2f\n',accuracy);
% Writting into excel file 


winopen(File_Name_Results);   % to open excel file, just to check.


probabilityVector=zeros(a1_length,1);
for i=1:a1_length
    index=find(Predict_Probability(:,1)==max(Predict_Probability(:,1)));
    probabilityVector(index)=probabilityVector(index)+1;
end
attribute_ID=zeros(nodeCount,1);
for i=1:nodeCount
    if(a1(i)~=0)
        attribute_ID(i)=find(a1_distinct==a1(i));
    end
end


% End code %
