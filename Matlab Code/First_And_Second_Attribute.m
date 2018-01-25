function [Name_For_First_Attribute_Value, Name_For_Second_Attribute_Value] = First_And_Second_Attribute (attribute1, attribute2)
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
end