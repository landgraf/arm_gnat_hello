with Leds;          use Leds;
with Ada.Real_Time; use Ada.Real_Time;
procedure Main is
 
   Period     : constant Time_Span := Milliseconds (100);  -- arbitrary
   Next_Start : Time := Clock;
 
   Next_LED   : LED_Number := 0;
 
begin
   loop
      Off (Next_LED);
 
      if Current_Direction = Counterclockwise then
         Next_LED := Next_LED + 1;
      else
         Next_LED := Next_LED - 1;
      end if;
 
      On (Next_LED);
 
      Next_Start := Next_Start + Period;
      delay until Next_Start;
   end loop;
end Main;
