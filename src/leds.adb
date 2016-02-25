with Ada.Interrupts.Names;
with Ada.Real_Time;  use Ada.Real_Time;
 
with Registers;      use Registers;
 
pragma Warnings (Off);
with System.STM32F4; use System.STM32F4;
with System.Stm32f4.RCC; use System.Stm32f4.RCC;

pragma Warnings (On);
 
package body Leds is
 
   Masks : constant array (LED_Number) of Word :=
     (16#1_000#, 16#2_000#, 16#4_000#, 16#8_000#);
 
   procedure On  (This : LED_Number) is
   begin
      GPIOG.BSRR := Masks (This);
   end On;
 
   procedure Off (This : LED_Number) is
   begin
      GPIOG.BSRR := Masks (This) * 2**16;
   end Off;
 
 
   protected Button is
      pragma Interrupt_Priority;
 
      function Current_Direction return Directions;
 
   private
      procedure Interrupt_Handler;
      pragma Attach_Handler (Interrupt_Handler, Ada.Interrupts.Names.EXTI0_Interrupt);
 
      Direction : Directions := Counterclockwise;
      Last_Time : Time := Clock;
   end Button;
 
   Debounce_Time : constant Time_Span := Milliseconds (500);
 
   protected body Button is
 
      function Current_Direction return Directions is
      begin
         return Direction;
      end Current_Direction;
 
      procedure Interrupt_Handler is
         Now : constant Time := Clock;
      begin
         --  Clear interrupt
         EXTI.PR (0) := 1;
 
         --  Debouncing
         if Now - Last_Time >= Debounce_Time then
            if Direction = Counterclockwise then
               Direction := Clockwise;
            else
               Direction := Counterclockwise;
            end if;
 
            Last_Time := Now;
         end if;
      end Interrupt_Handler;
 
   end Button;
 
   function Current_Direction return Directions is
   begin
      return Button.Current_Direction;
   end Current_Direction;
 
   procedure Initialize is
   begin
      --  Enable clock for GPIO-D (leds) and GPIO-A (button)
 
      System.Stm32f4.Rcc.Registers.AHB1ENR := System.Stm32f4.Rcc.Registers.AHB1ENR or RCC_AHB1ENR_GPIOG or RCC_AHB1ENR_GPIOA;
 
      --  And for SYSCFGEN
 
      System.Stm32f4.Rcc.Registers.APB2ENR := System.Stm32f4.Rcc.Registers.APB2ENR or RCC_APB2ENR_SYSCFGEN;
 
      --  Configure PD12-15 (leds) and PA0 (Button)
      declare
         use GPIO;
      begin
         GPIOG.MODER   (12 .. 15) := (others => Mode_OUT);
         GPIOG.OTYPER  (12 .. 15) := (others => Type_PP);
         GPIOG.OSPEEDR (12 .. 15) := (others => Speed_100MHz);
         GPIOG.PUPDR   (12 .. 15) := (others => No_Pull);
 
         GPIOA.MODER   (0) := Mode_IN;
         GPIOA.PUPDR   (0) := No_Pull;
      end;
 
      --  Select PA for EXTI0
 
      SYSCFG.EXTICR1 (0) := 0;
 
      --  Interrupt on rising edge
      EXTI.FTSR (0) := 0;
      EXTI.RTSR (0) := 1;
      EXTI.IMR (0) := 1;
   end Initialize;
 
begin
   Initialize;
end Leds;
