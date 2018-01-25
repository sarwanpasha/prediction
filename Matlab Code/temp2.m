clear
warning off all

% Load_Data_File = 'Rice31.mat';
% Load_Data_File = 'American75.mat';
Load_Data_File = 'Caltech36.mat';
load (Load_Data_File)


% Hidden_Users = [4001:4087]; % For rice31 dataset
if (strcmp(Load_Data_File,'Caltech36.mat')==1)
    Hidden_Users = randi(769,80,1); % generate 5 random values between 1 and 100  (For caltech Dataset)
%     Hidden_Users = [1:80]; % For rice31 dataset
    Load_Data_File
end
if (strcmp(Load_Data_File,'Rice31.mat')==1)
    Hidden_Users = randi(4087,80,1); % generate 5 random values between 1 and 100 ( For rice31 dataset)
    Load_Data_File
end
if (strcmp(Load_Data_File,'American75.mat')==1)
    Hidden_Users = randi(6386,80,1); % generate 5 random values between 1 and 100 ( For American75 dataset)
    Load_Data_File
end
Hidden_Count = length(Hidden_Users);




% Writing dataset values in Excel File
 data=load(Load_Data_File);
 f=fieldnames(data); %Get names of fields
 
File_Name1_Results = strcat('E:\MS Computer Science\MS Thesis\Step 3\Coding\Results\Results_Of_', Load_Data_File);
File_Name_Results = strcat(File_Name1_Results,'.xlsx');


Mixing_Matrix_File_Name_2 ='E:\MS Computer Science\MS Thesis\Step 3\Coding\Results\Mixing_Matrix_For_';
Mixing_Matrix_File_Name_1 =strcat(Mixing_Matrix_File_Name_2, Load_Data_File);
Mixing_Matrix_File_Name =strcat(Mixing_Matrix_File_Name_1,'.xlsx');
% delete (Mixing_Matrix_File_Name); % Delete old Excel file

% Confusion_Matrix_File = 'Confusion_Matrix.xlsx';
Confusion_Matrix_File_1 = strcat('E:\MS Computer Science\MS Thesis\Step 3\Coding\Results\Confusion_Matrix_', Load_Data_File);
Confusion_Matrix_File = strcat(Confusion_Matrix_File_1 , '.xlsx');
delete (Confusion_Matrix_File);


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

loop_temp =2;
predict_loop_temp =2;
accuracy_Count = 0;

Confusion_Starting_Index = 5;
index_Str = Confusion_Starting_Index;
index_Str_temp = Confusion_Starting_Index;
index_For_Confusion_Matrix = Confusion_Starting_Index;
actual_index_temp = 3;
actual_index_Str = actual_index_temp;
index_Str_2 = Confusion_Starting_Index - 1;
prediction_check = 1;
accuracy_check = 2;  


attributeCount=1; %Attribute value (Max 7 attributes)
for outerLoop=1:attributeCount
    for innerLoop=1:attributeCount        
        attribute1=outerLoop;
        attribute2=innerLoop;
           attribute1=1;
           attribute2=2;
           
        [Name_For_First_Attribute_Value, Name_For_Second_Attribute_Value] = First_And_Second_Attribute(attribute1, attribute2);
       
        
%         fprintf('First Attribute : %d (%s)\n',attribute1,Name_For_First_Attribute_Value);
%         fprintf('Second Attribute : %d (%s)\n',attribute2,Name_For_Second_Attribute_Value);
        
        fprintf('Predicting Attribute  %s Using %s\n',Name_For_Second_Attribute_Value, Name_For_First_Attribute_Value);   
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
                    end
                    index1=find(a2_distinct==a2(i));
                    index2=find(a1_distinct==a1(j));
                    if(attributeMatrix(j,attribute1)~=0 && attributeMatrix(i,attribute2)~=0 )
                        Mixing_Matrix(index2,index1)=Mixing_Matrix(index2,index1)+1;
                    end
                end
            end
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Row sum normalization Start %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        Row_Sum=sum(transpose(Mixing_Matrix));
        Mixing_Matrix=bsxfun(@rdivide,Mixing_Matrix,Row_Sum(:)); %bsxfun: Divide each entry of row by value of row sum
        Mixing_Matrix;
%         Column_Sum=sum(Mixing_Matrix);
        % Row sum and column sum normalization Ends     

        Row_Sum_Formula = sum(transpose(Mixing_Matrix));
        correctPrediction=0; %Counter for correct Predictions
        
        mm_New=zeros(Hidden_Count,length(a2_distinct));
        mm = zeros(length(a1_distinct),length(a2_distinct));
        Mixing_Matrix=bsxfun(@rdivide,Mixing_Matrix,Row_Sum_Formula(:));
        
         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Row sum normalization Ends %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         
        individualMajorFriendCount=zeros(Hidden_Count,length(a1_distinct));
        imidiate_individualMajorFriendCount=zeros(Hidden_Count,length(a1_distinct));
        Male_Friends = 0;
        Female_Friends = 0;
        index_observer=zeros(length(a2_distinct),1);
        Predicted_Value=zeros(Hidden_Count,1);
        % adjacency matrix count
        for i=1:Hidden_Count
            neighbor=adjMatrix(Hidden_Users(i),:); % getting neigbours of hidden user
            neighbourCount=sum(neighbor);
            prediction_sarwan=zeros(neighbourCount,length(a2_distinct));
            friend_count_iterator=1;
            finding_Max_Vote_class = zeros(length(a2_distinct),1);
            for j=1:nodeCount
                if neighbor(j)==1
                    n=find(a1(j)==a1_distinct); % Attibute value wise friends count
                    imidiate_individualMajorFriendCount(i,n)=imidiate_individualMajorFriendCount(i,n)+1;
                    Friends_Of_Friend = adjMatrix(j,:);
                    finding_Max_Vote_class = zeros(length(a2_distinct),1);
                   for k=1:nodeCount
                       if (Friends_Of_Friend(k)==1 && k~=j)
                           if(a2(k)~=0)
                                finding_Max_Vote_class(find(a2_distinct==a2(k)))=...
                                    finding_Max_Vote_class(find(a2_distinct==a2(k)))+1;
                           end
                       end
                   end
                   finding_Max_Vote_class=finding_Max_Vote_class/sum(finding_Max_Vote_class);
                   
                   
                    
                    for x=1:length(a2_distinct)
                        index=(find(a1(j)==a1_distinct));
                        prediction_sarwan(friend_count_iterator,x)=Mixing_Matrix(index,x)*finding_Max_Vote_class(x);
                        
                    end
                    friend_count_iterator=friend_count_iterator+1;
                end
                
            end  % j Node count loop ends here
            
            for final_i=1:neighbourCount
                [m,max_index]= max(prediction_sarwan(final_i,:));
                index_observer(max_index) = index_observer(max_index)+1;
            end
            [predicted_max,predicted_index]= max(index_observer);
            
            Predicted_Value(i)=predicted_index; % Predicted classes
            Actual_Value(i) = a2(Hidden_Users(i)); % True classes
            
            if(Predicted_Value(i)==Actual_Value(i))
                correctPrediction=correctPrediction+1;
            end
        end % i hidden count loop ends here
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%% Confusion Matrix Logic Start Here %%%%%%%%%%%%%%%%%%%%%%%%%
%           [c_matrix,Result,RefereceResult]= confusion.getMatrix(Actual_Value,Predicted_Value,Name_For_Second_Attribute_Value,'');

           Confusion_Matrix=zeros(length(unique(Actual_Value)),length(unique(Actual_Value))); % Initializing Confusion matrix with zero's
           Actual_Distinct = unique(Actual_Value);
           Predicted_Distinct = unique(Predicted_Value);
           for i =1:Hidden_Count
               row_index = find(unique(Actual_Value) == Predicted_Value(i));
               column_index = find(unique(Actual_Value) == Actual_Value(i));
%                    Confusion_Matrix(find(unique(Actual_Value) == Predicted_Value(i)), find(unique(Actual_Value) == Actual_Distinct(i))) = Confusion_Matrix(find(unique(Actual_Value) == Predicted_Value(i)), find(unique(Actual_Value) == Actual_Distinct(i)+1))+1;  
                     Confusion_Matrix(row_index, column_index) = Confusion_Matrix(row_index, column_index)+1;  

           end
           Confusion_Matrix
           
           %%%%%%%%%%% Excel writting Confusion Matrix%%%%%%%%%%%%%%%%%%%%                
               
         
            
           for i=1:length(unique(Actual_Value))
%                     actual_index_Str = 2;
                    un_actual=unique(Actual_Value);
                    class_list=un_actual;
                    Class_Value = class_list(i);
                    
                   %Calling converting_Numeric_To_names function to get names of attribute 
                   Class_Value_str = converting_Numeric_To_names(Name_For_Second_Attribute_Value, Class_Value);
                   
                   preticting_Attribute = Class_Value_str;
                   actual_Attribute = Class_Value_str;
                   
                   predict_String = conv2xlscell(index_Str + 1,2);
                   actual_String = conv2xlscell(index_Str_2 + 1,actual_index_Str);
                   
                   actual_String_2 = conv2xlscell((index_Str_2 ),4);
%                    xlswrite(Confusion_Matrix_File,cellstr('Actual Attribute'),'',actual_String_2); 
                   predict_String_2 = conv2xlscell(index_Str_temp,1);
%                    xlswrite(Confusion_Matrix_File,cellstr('Predicting Attribute'),'',predict_String_2); 
                   
%                    xlswrite(Confusion_Matrix_File,cellstr(preticting_Attribute),'',predict_String);
%                    xlswrite(Confusion_Matrix_File,cellstr(actual_Attribute),'',actual_String); 
                   
                   actual_index_Str = actual_index_Str+1;
                   index_Str = index_Str+1;
           end
           predicttio_check_Combine_2 = strcat('Predicting Attribute_',Name_For_Second_Attribute_Value);
           predicttio_check_Combine_1 = strcat(predicttio_check_Combine_2, '_Using_');
           predicttio_check_Combine = strcat(predicttio_check_Combine_1, Name_For_First_Attribute_Value);
           
           prediction_check_String = conv2xlscell(prediction_check,1);
%            xlswrite(Confusion_Matrix_File,cellstr(predicttio_check_Combine),'',prediction_check_String);
           
           confusion_Str = conv2xlscell(index_For_Confusion_Matrix + 1,3);
           Confusion_Matrix_Str = conv2xlscell(loop_temp,2);
           
%            xlswrite(Confusion_Matrix_File,Confusion_Matrix,'',confusion_Str);
           loop_temp = unique(Actual_Value)+4;

           actual_index_Str = actual_index_temp;
           
           accuracy=(correctPrediction/Hidden_Count)*100;
           fprintf('Accuracy : %0.2f\n',accuracy); % Print by the accuracy of 2 decimal points
           
           Accuracy_check_String = conv2xlscell(accuracy_check,1);
           Accuracy_Value = strcat('Accuracy = ',int2str(accuracy));
%            xlswrite(Confusion_Matrix_File,cellstr(Accuracy_Value),'',Accuracy_check_String);
        
           index_Str_temp = index_Str_temp + length(Confusion_Matrix) + (Confusion_Starting_Index -1);
           index_Str = index_Str + (Confusion_Starting_Index -1);
           index_Str_2 = index_Str_2 + length(Confusion_Matrix)  + (Confusion_Starting_Index -1);
           index_For_Confusion_Matrix = index_For_Confusion_Matrix + length(Confusion_Matrix) + (Confusion_Starting_Index -1);
           
           prediction_check = (index_Str_2 - 2);
           accuracy_check = (index_Str_2 - 1);
        %%%%%%%%%%%%%%%%%%%%%%%%% Confusion Matrix Logic Ends Here %%%%%%%%%%%%%%%%%%%%%%%%%
        
        

        
        accuracy_Count = accuracy_Count+1;
        tempp = int2str(accuracy_Count);
        temp_1 = strcat(excel_Name_1,tempp);
    end % Inner Loop Ends
    
end % Outer Loop Ends

% true_Positive
% false_Positive
% true_Negative
% false_Negative
% missing_Value
%    winopen(Confusion_Matrix_File);



% End code %
