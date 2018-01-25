function [Class_Value_str] = converting_Numeric_To_names(Name_For_Second_Attribute_Value, Class_Value)

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
                            Class_Value_str = 'Zero(Missing)';
                        elseif(Class_Value==1)
                            Class_Value_str = 'Male';
                        elseif(Class_Value==2)
                            Class_Value_str = 'Female';
                        end
                elseif (strcmp(Name_For_Second_Attribute_Value, 'major')==1)
%                     Class_Value_str = num2str(class_list(i));
                        if(Class_Value==0)
                            Class_Value_str = 'Zero(Missing)';
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
                            Class_Value_str = 'Zero(Missing)';
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
                    Class_Value_str = strcat('Graduation Year: ',num2str(Class_Value));
                elseif (strcmp(Name_For_Second_Attribute_Value, 'high_school')==1)
                    Class_Value_str = strcat('High School number: ',num2str(Class_Value));
                    
                end
end

