 function [Final_Divergence_Value]= Divergence(mixingMatrix_1)
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
Column_Count=length(Column_Sum);
Row_Count=length(Row_Sum);

Column_Sum_1 = sum(Column_Sum);
Row_Sum_1 = sum(Row_Sum);
Total_Matrix_Sum = Column_Sum_1 + Row_Sum_1;
% d_f=0;
%-------- First Part of numerator ------------------%
for i=1:Row_Count
    First_value = Row_Sum(i);
    for j=1:Column_Count
        First_Part_Value=First_value-(mixingMatrix(i,j));
    end
end
%-------- First Part of numerator ------------------%


%-------- 2nd Part of numerator Starts ------------------%
for j=1:Column_Count
    Second_value=Column_Sum(j);
    for i=1:Row_Count
        Second_Part_Value=Second_value-(mixingMatrix(i,j));
    end
end
%-------- 2nd Part of numerator Ends ------------------%
Final_Numerator_Value = First_Part_Value + Second_Part_Value ;



%-------- First Part of Denumerator ------------------%
for i=1:Row_Count
    First_value_Denumerator = Row_Sum(i);
end
for j=1:Column_Count
    Second_value_Denumerator=Column_Sum(j);
end
Resultant_Value_Denumerator = First_value_Denumerator + Second_value_Denumerator;
%-------- First Part of Denumerator ------------------%

%-------- 2nd Part of Denumerator ------------------%
for i=1:Row_Count
    for j=1:i
       result_2 = First_value_Denumerator * Second_value_Denumerator;
       result_1 = result_2 ./ Total_Matrix_Sum;
    end
end
result = 2 * result_1;

Final_Denominator_Value = Resultant_Value_Denumerator - result;
%-------- 2nd Part of Denumerator ------------------%

Total_Final_Value = Final_Numerator_Value ./ Final_Denominator_Value;
Total_Final_Value;
Final_Divergence_Value = 1 - Total_Final_Value;
Final_Divergence_Value;
