 function [Final_Divergence_Value]= Divergence_Square(mixingMatrix_1)
mixingMatrix = mixingMatrix_1;
mixingMatrix;
% mixingMatrix = [1 3 2; 4 2 5; 6 1 4] % Sample Matrix
% S = sum(A,2); %  A is a matrix, then sum(A,2) is a column vector containing the sum of each row.
% s=sum(A(1,:)); % For row 1
% n=3
% s=sum(A(n,:));% For row n
corelation=0;
Column_Sum=sum(mixingMatrix);
Row_Sum=sum(transpose(mixingMatrix));
Matrix_Sum=sum(Column_Sum);
Column_Count=length(Column_Sum);
Row_Count=length(Row_Sum);

Column_Sum_1 = sum(Column_Sum);
Row_Sum_1 = sum(Row_Sum);
Total_Matrix_Sum = Column_Sum_1 + Row_Sum_1;
% d_f=0;
%-------- First Part of numerator ------------------%
Final_First_value = 0;
Final_Second_value = 0;
First_value = 0;
for i=1:Row_Count
    for j=1:Column_Count
            First_value = (mixingMatrix(i,j))^2 + First_value;
    end
    

%     First_Part_Value = 0;
    
end
First_value


First_value_Numerator=0;
Second_value_numerator=0;
for i=1:Row_Count
    First_value_Numerator = Row_Sum(i)^2 + First_value_Numerator;
end
for j=1:Column_Count
    Second_value_numerator=Column_Sum(j)^2 + Second_value_numerator;
%         Fourth_value_Denumerator=((Row_Sum(i)*Column_Sum(j))/Matrix_Sum)^2+Fourth_value_Denumerator;
end
    First_Result_Numerator = First_value_Numerator * Second_value_numerator;
%     Final_First_value = (First_value - First_Part_Value) + Final_First_value;
Final_First_value = First_value - First_Result_Numerator;

Final_First_value
%-------- First Part of numerator ------------------%


% %-------- 2nd Part of numerator Starts ------------------%
% for j=1:Column_Count
%     Second_value=Column_Sum(j)^2;
%     Second_Part_Value = 0;
%     for i=1:Row_Count
% %         Second_Part_Value=Second_value-(mixingMatrix(i,j));
%         Second_Part_Value = (mixingMatrix(i,j))^2 + Second_Part_Value;
%     end
%      Final_Second_value = (Second_value - Second_Part_Value) + Final_Second_value;
% end
% Final_Second_value
% %-------- 2nd Part of numerator Ends ------------------%
% Final_Numerator_Value = Final_First_value + Final_Second_value ;
% Final_Numerator_Value


%-------- First Part of Denumerator ------------------%
First_value_Denumerator = 0;
Second_value_Denumerator = 0;
for i=1:Row_Count
    First_value_Denumerator = Row_Sum(i)^2 + First_value_Denumerator;
end
for j=1:Column_Count
    Second_value_Denumerator=Column_Sum(j)^2 + Second_value_Denumerator;
end
Resultant_Value_Denumerator = First_value_Denumerator + Second_value_Denumerator;
%-------- First Part of Denumerator ------------------%

%-------- 2nd Part of Denumerator ------------------%
Third_value_Denumerator=0;
Fourth_value_Denumerator=0;
for i=1:Row_Count
    Third_value_Denumerator = Row_Sum(i)^2 + Third_value_Denumerator;
end
    for j=1:Column_Count
        Fourth_value_Denumerator=Column_Sum(j)^2 + Fourth_value_Denumerator;
%         Fourth_value_Denumerator=((Row_Sum(i)*Column_Sum(j))/Matrix_Sum)^2+Fourth_value_Denumerator;
    end
result_of_Second_Part_Denomenator = Third_value_Denumerator * Fourth_value_Denumerator;
% result = 2 * Third_value_Denumerator;
Final_Denominator_Value = ((1/2) * (Resultant_Value_Denumerator) - result_of_Second_Part_Denomenator);
% Final_Denominator_Value = Resultant_Value_Denumerator - result;
%-------- 2nd Part of Denumerator ------------------%

Total_Final_Value = Final_First_value / Final_Denominator_Value;
Total_Final_Value
Final_Divergence_Value = 1 - Total_Final_Value;
Final_Divergence_Value
