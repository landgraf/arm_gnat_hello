pragma Warnings (Off);
package Leds is
   pragma Elaborate_Body;
 
   type LED_Number is mod 4;
 
   procedure On  (This : LED_Number) with Inline;
   procedure Off (This : LED_Number) with Inline;
 
   type Directions is (Clockwise, Counterclockwise);
 
   function Current_Direction return Directions;
 
end Leds;
