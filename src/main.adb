with Leds;          use Leds;
with Ada.Real_Time; use Ada.Real_Time;
with Registers;
pragma Warnings (Off);
with System.STM32F4; use System.STM32F4;
pragma Warnings (On);

procedure Main is
 
   Period     : constant Time_Span := Milliseconds (100);  -- arbitrary
   Next_Start : Time := Clock;
 
   Next_LED   : LED_Number := 0;
   
   type Byte  is mod 2**8  with Size => 8;
   
   procedure Setup_Spi is
      use Registers;
   begin

      -- scale 1/256
      Spi1.Spi_Cr1 := Spi1.Spi_Cr1 or Spi.Br0 or Spi.Br1 or Spi.Br2; 
      -- Set master mode
      Spi1.Spi_Cr1 := Spi1.Spi_Cr1 or Spi.mstr;
      
      -- set on trailing edge
      Spi1.Spi_Cr1 := Spi1.Spi_Cr1 or Spi.cpha;
      -- Idle high
      Spi1.Spi_Cr1 := Spi1.Spi_Cr1 or Spi.Cpol;
      Spi1.Spi_Cr1 := Spi1.Spi_Cr1 or Spi.cpha;
      
      -- enable SPI
      Spi1.Spi_Cr1 := Spi1.Spi_Cr1 or Spi.Spe;
      

      
      -- half duplex
      -- sending mode
      Spi1.Spi_Cr1 := Spi1.Spi_Cr1 or Spi.Bidimode;
      Spi1.Spi_Cr1 := Spi1.Spi_Cr1 or Spi.Bidioe;
      
      -- FIXME check this
      Spi1.Spi_Cr1 := Spi1.Spi_Cr1 or Spi.Ssm;
      
      -- LS first
      Spi1.Spi_Cr1 := Spi1.Spi_Cr1 or Spi.lsbfirst;
      
   end Setup_Spi;
   
   procedure Spi_Send (Message : Byte) is
   begin
      null;
   end Spi_Send;
   
   procedure Spi_Send (Message : Character) is
      Byte_Value : Byte := Byte(Character'Pos (Message));
      use Registers;
   begin
      loop
         exit when (Spi1.Spi_Sr and Spi.Txe) /= 0;
      end loop;
      Spi1.Spi_Dr := Bits_16(Byte_Value);
   end Spi_Send;
   
   Hello_World : constant String := "Hello world";
begin
   Setup_Spi;
   loop
      Off (Next_LED);
 
      if Current_Direction = Counterclockwise then
         Next_LED := Next_LED + 1;
      else
         Next_LED := Next_LED - 1;
      end if;
      for Char of Hello_World loop
         Spi_Send (Char);
      end loop;
      On (Next_LED);
 
      Next_Start := Next_Start + Period;
      delay until Next_Start;
   end loop;
end Main;
