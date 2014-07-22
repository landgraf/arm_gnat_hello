with LEDs;          use LEDs; 
with Button;        use Button; 
with Ada.Real_Time; use Ada.Real_Time; 
procedure Driver is 
   type Index is mod 4; 
   Pattern : constant array (Index) of User_LED := (Orange, Red, Blue, Green); 
   task body Controller is 
      Period     : constant Time_Span := Milliseconds (75);  -- arbitrary 
      Next_Start : Time := Clock; 
      Next_LED   : Index := 0; 
   begin 
      loop 
         Off (Pattern (Next_LED)); 
         Next_LED := Next_LED +  
           (if Button.Current_Direction = Counterclockwise then -1 else 1); 
         On (Pattern (Next_LED)); 
         Next_Start := Next_Start + Period; 
         delay until Next_Start; 
      end loop; 
   end Controller; 
begin
    null;
end Driver;
