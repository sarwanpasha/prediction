 function [Final_Divergence_Value]= Divergence_Log(Mixing_Matrix)
% Mixing_Matrix = mixingMatrix_1;
% Mixing_Matrix;
% Mixing_Matrix = [1 3 2; 4 2 5; 6 1 4] % Sample Matrix
% S = sum(A,2); %  A is a matrix, then sum(A,2) is a column vector containing the sum of each row.
% s=sum(A(1,:)); % For row 1
% n=3
% s=sum(A(n,:));% For row n
corelation=0;
Column_Sum=sum(Mixing_Matrix);
Row_Sum=sum(transpose(Mixing_Matrix));
Matrix_Sum=sum(Column_Sum);
Column_Count=length(Column_Sum);
Row_Count=length(Row_Sum);
Total_Final_Value = 0;

Column_Sum_1 = sum(Column_Sum);
Row_Sum_1 = sum(Row_Sum);
Total_Matrix_Sum = Column_Sum_1 + Row_Sum_1;
% d_f=0;
%-------- First Part of numerator ------------------%
Final_numerator_First_value = 0;
Final_Second_value = 0;
First_value = 0;
First_value_numerator = 0;
Second_value_numerator=0;
Third_value_numerator=0;
for j=1:Column_Count
%     for j=1:Column_Count
%             First_value = (Mixing_Matrix(i,j))^2 + First_value;
%     end
First_value_numerator=(Column_Sum(j) * log(Column_Sum(j)) ) + First_value_numerator;
end

for i=1:Row_Count
Second_value_numerator=(Row_Sum(i) * log(Row_Sum(i)) ) + Second_value_numerator;
end

for i=1:Row_Count
    for j=1:Column_Count
            Third_value_numerator = ((Mixing_Matrix(i,j)) * log(Row_Sum(i)) ) + Third_value_numerator;
    end
end
Final_numerator_First_value = First_value_numerator + Second_value_numerator - Third_value_numerator;


%-------- First Part of Denumerator ------------------%
First_value_Denumerator = 0;
Second_value_Denumerator = 0;
for j=1:Column_Count
    First_value_Denumerator = (Column_Sum(j) * log(Column_Sum(j)) ) + First_value_Denumerator;
end
for i=1:Row_Count
    Second_value_Denumerator= ( Row_Sum(i)* log(Row_Sum(i)) ) + Second_value_Denumerator;
end
Resultant_Value_Denumerator = (1/2) * (First_value_Denumerator  + Second_value_Denumerator );
%-------- First Part of Denumerator ------------------%


Total_Final_Value = Final_numerator_First_value / Resultant_Value_Denumerator;
Total_Final_Value
Final_Divergence_Value = 1 - Total_Final_Value;
Final_Divergence_Value
