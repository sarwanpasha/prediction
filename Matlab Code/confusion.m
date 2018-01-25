classdef confusion
    methods (Static)
        function [c_matrix,Result,RefereceResult]= getMatrix(actual,predict,Name_For_Second_Attribute_Value, Display)

            %Condition Check
            if (nargin < 2)
                error('Not enough input arguments. Need atleast two vectors as input');
            elseif (nargin == 2)
                Display=1;
            elseif (nargin > 5)
                error('Too many input arguments.');
            end
            actual=actual(:);
            predict=predict(:);
            if length(actual) ~= length(predict)
                error('Input have different lengths')
            end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            un_actual=unique(actual);
%             un_predict=unique(predict);
            un_predict=unique(actual);
            
            condition=length(un_actual)==length(un_predict);
            
            if ~condition
                error('Class List is not same in given inputs')
            end
            condition=(sum(un_actual==un_predict)==length(un_actual));
            if ~condition
                error('Class List in given inputs are different')
            end
            
            %%
            %Start process
            %Build Confusion matrix
            %Set variables
            class_list=un_actual;
%             disp('Class List in given sample');
%             disp(class_list);
            fprintf('\nTotal Instance = %d\n',length(actual));
%             xlswrite('Confusion_Matrix.xlsx',length(actual),Combine_Attributes,'A1');
            n_class=length(un_actual);
            c_matrix=zeros(n_class);
            predict_class=cell(1,n_class);
            class_ref=cell(n_class,1);
            row_name=cell(1,n_class);
            %Calculate conufsion for all classes
            for i=1:n_class
                
                Class_Value = class_list(i);
                if(strcmp(Name_For_Second_Attribute_Value, 'status')==1)
                        if(Class_Value==1)
                            Class_Value_str = 'Student';
                        elseif(Class_Value==2)
                            Class_Value_str = 'Lecturer';
                        elseif(Class_Value==5)
                            Class_Value_str = 'Asistant_Professor';
                        elseif(Class_Value==6)
                            Class_Value_str = 'Professor';
                        end
                elseif (strcmp(Name_For_Second_Attribute_Value, 'gender')==1)
                        if(Class_Value==0)
                            Class_Value_str = 'Zero';
                        elseif(Class_Value==1)
                            Class_Value_str = 'Male';
                        elseif(Class_Value==2)
                            Class_Value_str = 'Female';
                        end
                elseif (strcmp(Name_For_Second_Attribute_Value, 'major')==1)
%                     Class_Value_str = num2str(class_list(i));
                        if(Class_Value==0)
                            Class_Value_str = 'Zero';
                        elseif(Class_Value==190)
                            Class_Value_str = 'CS';
                        elseif(Class_Value==192)
                            Class_Value_str = 'EE';
                        elseif(Class_Value==194)
                            Class_Value_str = 'bio';
                        elseif(Class_Value==195)
                            Class_Value_str = 'phy';
                        elseif(Class_Value==196)
                            Class_Value_str = 'chemistry';    
                        elseif(Class_Value==197)
                            Class_Value_str = 'finance'; 
                        elseif(Class_Value==198)
                            Class_Value_str = 'mba'; 
                        elseif(Class_Value==199)
                            Class_Value_str = 'econ'; 
                        elseif(Class_Value==200)
                            Class_Value_str = 'political'; 
                        elseif(Class_Value==201)
                            Class_Value_str = 'history'; 
                        elseif(Class_Value==202)
                            Class_Value_str = 'machenical'; 
                        elseif(Class_Value==204)
                            Class_Value_str = 'civil'; 
                        elseif(Class_Value==205)
                            Class_Value_str = 'chemical'; 
                        elseif(Class_Value==206)
                            Class_Value_str = 'math';
                        elseif(Class_Value==207)
                            Class_Value_str = 'urdu';
                        elseif(Class_Value==208)
                            Class_Value_str = 'english';
                        elseif(Class_Value==209)
                            Class_Value_str = 'philosophy';
                        elseif(Class_Value==211)
                            Class_Value_str = 'german';
                        elseif(Class_Value==212)
                            Class_Value_str = 'french';
                        elseif(Class_Value==213)
                            Class_Value_str = 'argicultural';
                        elseif(Class_Value==217)
                            Class_Value_str = 'bba';
                        elseif(Class_Value==220)
                            Class_Value_str = 'geology';
                        elseif(Class_Value==221)
                            Class_Value_str = 'socialScience';
                        elseif(Class_Value==222)
                            Class_Value_str = 'medical';
                        elseif(Class_Value==223)
                            Class_Value_str = 'aeronautical';
                        elseif(Class_Value==224)
                            Class_Value_str = 'avionics';
                        elseif(Class_Value==226)
                            Class_Value_str = 'metallurgy';
                        elseif(Class_Value==227)
                            Class_Value_str = 'bakingAndFinance';
                        elseif(Class_Value==228)
                            Class_Value_str = 'accounting';
                        elseif(Class_Value==229)
                            Class_Value_str = 'entrepreneurship';
                        end
                elseif (strcmp(Name_For_Second_Attribute_Value, 'minor')==1)
%                     Class_Value_str = num2str(class_list(i));
                        if(Class_Value==0)
                            Class_Value_str = 'Zero';
                        elseif(Class_Value==190)
                            Class_Value_str = 'CS';
                        elseif(Class_Value==192)
                            Class_Value_str = 'EE';
                        elseif(Class_Value==194)
                            Class_Value_str = 'bio';
                        elseif(Class_Value==196)
                            Class_Value_str = 'chemistry';    
                        elseif(Class_Value==197)
                            Class_Value_str = 'finance'; 
                        elseif(Class_Value==198)
                            Class_Value_str = 'mba'; 
                        elseif(Class_Value==199)
                            Class_Value_str = 'econ'; 
                        elseif(Class_Value==200)
                            Class_Value_str = 'political'; 
                        elseif(Class_Value==202)
                            Class_Value_str = 'machenical'; 
                        elseif(Class_Value==204)
                            Class_Value_str = 'civil'; 
                        elseif(Class_Value==205)
                            Class_Value_str = 'chemical'; 
                        elseif(Class_Value==206)
                            Class_Value_str = 'math';
                        elseif(Class_Value==207)
                            Class_Value_str = 'urdu';
                        elseif(Class_Value==208)
                            Class_Value_str = 'english';
                        elseif(Class_Value==209)
                            Class_Value_str = 'philosophy';
                        elseif(Class_Value==210)
                            Class_Value_str = 'history';
                        elseif(Class_Value==211)
                            Class_Value_str = 'german';
                        elseif(Class_Value==212)
                            Class_Value_str = 'french';
                        elseif(Class_Value==213)
                            Class_Value_str = 'argicultural';
                        elseif(Class_Value==214)
                            Class_Value_str = 'phy';
                        elseif(Class_Value==215)
                            Class_Value_str = 'anthropology';
                        elseif(Class_Value==217)
                            Class_Value_str = 'bba';
                        elseif(Class_Value==218)
                            Class_Value_str = 'econMath';
                        elseif(Class_Value==219)
                            Class_Value_str = 'doubleMath';
                        elseif(Class_Value==220)
                            Class_Value_str = 'geology';
                        elseif(Class_Value==221)
                            Class_Value_str = 'socialScience';
                        elseif(Class_Value==222)
                            Class_Value_str = 'medical';
                        elseif(Class_Value==223)
                            Class_Value_str = 'aeronautical';
                        elseif(Class_Value==224)
                            Class_Value_str = 'avionics';
                        elseif(Class_Value==225)
                            Class_Value_str = 'envirnmentalScience';
                        elseif(Class_Value==226)
                            Class_Value_str = 'metallurgy';
                        elseif(Class_Value==227)
                            Class_Value_str = 'bakingAndFinance';
                        elseif(Class_Value==228)
                            Class_Value_str = 'accounting';
                        elseif(Class_Value==230)
                            Class_Value_str = 'entrepreneurship';
                        elseif(Class_Value==231)
                            Class_Value_str = 'IT';
                        end
                elseif (strcmp(Name_For_Second_Attribute_Value, 'dorm')==1)
%                     Class_Value_str = num2str(class_list(i));
                      Class_Value_str = strcat('Hostel Number: ',num2str(Class_Value));
                      
                elseif (strcmp(Name_For_Second_Attribute_Value, 'Graduation_Year')==1)
%                     Class_Value_str = num2str(class_list(i));
                    Class_Value_str = strcat('Graduation Year: ',num2str(Class_Value));
                elseif (strcmp(Name_For_Second_Attribute_Value, 'high_school')==1)
%                     Class_Value_str = num2str(class_list(i));
                    Class_Value_str = strcat('High School number: ',num2str(Class_Value));
                    
                end
%                 class_ref{i,1}=strcat('class',num2str(i),'==>',num2str(class_list(i)));
                  class_ref{i,1}=strcat('class',num2str(i),'==>',Class_Value_str);
                

               
                for j=1:n_class
                    val=(actual==class_list(i)) & (predict==class_list(j));
                    c_matrix(i,j)=sum(val);
                    predict_class{i,j}=sum(val);
                end
                row_name{i}=strcat('Actual_class_',Class_Value_str);
                column_name{i}=strcat('Predicted_class_',Class_Value_str);
                disp(class_ref{i})
            end
            c_matrix_table=cell2table(predict_class);
            c_matrix_table.Properties.RowNames=row_name;
%             
%             xlswrite('Confusion_Matrix.xlsx','Confusion Matrix',Combine_Attributes,'C1');
%              xlswrite('Confusion_Matrix.xlsx',c_matrix_table,Combine_Attributes,'C2');
            disp('Confusion Matrix')
            disp(c_matrix_table)
            [Result,RefereceResult]=confusion.getValues(c_matrix);
            %Output Struct for individual Classes
            RefereceResult.Class=class_ref;
            %%
            %Diplay
            % Display=1;
            if Display
                if n_class>2
                    disp('Multi-Class Confusion Matrix Output')
                    TruePositive=RefereceResult.TruePositive;
                    FalsePositive=RefereceResult.FalsePositive;
                    FalseNegative=RefereceResult.FalseNegative;
                    TrueNegative=RefereceResult.TrueNegative;
                    TFPN=table(TruePositive,FalsePositive,FalseNegative,TrueNegative,...
                        'RowNames',row_name);
                    disp(TFPN);
                    Param=struct2table(RefereceResult);
%                     disp(Param)
                else
                    disp('Two-Class Confution Matrix')
                    param={'','TruePositive','FalsePositive';...
                        'FalseNegative',c_matrix(1,1),c_matrix(1,2);...
                        'TrueNegative=TN',c_matrix(2,1),c_matrix(2,2)};
                    disp(param)
                    
                end
%                 disp('Over all valuses')
%                 disp(Result)
                
            end
        end
        function  [Result,RefereceResult]= getValues(c_matrix)
            %%
            %Finding
            %1.TP-True Positive
            %2.FP-False Positive
            %3.FN-False Negative
            %4.TN-True Negative
            if (nargin < 1)
                error('Not enough input arguments. Need atleast two vectors as input');
            elseif (nargin > 1)
                error('Too many input arguments.');
            end
            [row,col]=size(c_matrix);
            if row~=col
                error('Confusion matrix dimention is wrong')
            end
            n_class=row;
            switch n_class
                case 2
                    TP=c_matrix(1,1);
                    FN=c_matrix(1,2);
                    FP=c_matrix(2,1);
                    TN=c_matrix(2,2);
                    
                otherwise
                    TP=zeros(1,n_class);
                    FN=zeros(1,n_class);
                    FP=zeros(1,n_class);
                    TN=zeros(1,n_class);
                    for i=1:n_class
                        TP(i)=c_matrix(i,i);
                        FN(i)=sum(c_matrix(i,:))-c_matrix(i,i);
                        FP(i)=sum(c_matrix(:,i))-c_matrix(i,i);
                        TN(i)=sum(c_matrix(:))-TP(i)-FP(i)-FN(i);
                    end
                    
            end
            
            %%
            %Calulations
            %1.P-Positive
            %2.N-Negative

            P=TP+FN;
            N=FP+TN;
            switch n_class
                case 2
                    accuracy=(TP+TN)/(P+N);
                    Error=1-accuracy;
                    Result.Accuracy=(accuracy);
                    Result.Error=(Error);
                otherwise
                    accuracy=(TP)./(P+N);
                    Error=(FP)./(P+N);
                    Result.Accuracy=sum(accuracy);
                    Result.Error=sum(Error);
            end

            RefereceResult.TruePositive=TP';
            RefereceResult.FalsePositive=FP';
            RefereceResult.FalseNegative=FN';
            RefereceResult.TrueNegative=TN';

            
        end
        
    end
end