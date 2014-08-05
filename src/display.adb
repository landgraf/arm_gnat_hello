package body display is 

    procedure Set_Background (Color : Color_T) is
    begin
        LTDC.BCCR.Color := Color;
    end Set_Background;
end display; 

