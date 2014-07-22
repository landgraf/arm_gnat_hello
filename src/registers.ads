pragma Warnings (Off);
with System.STM32F4; use System.STM32F4;
pragma Warnings (On);
 
package Registers is
 
   --  Bit definitions for RCC AHB1ENR register
   RCC_AHB1ENR_GPIOD    : constant Word := 16#08#;
   RCC_AHB1ENR_GPIOA    : constant Word := 16#01#;
 
   RCC_APB2ENR_SYSCFGEN : constant Word := 16#4000#;
 
   GPIOD_Base           : constant := AHB1_Peripheral_Base + 16#0C00#;
   GPIOA_Base           : constant := AHB1_Peripheral_Base + 16#0000#;
   SYSCFG_Base          : constant := APB2_Peripheral_Base + 16#3800#;
   EXTI_Base            : constant := APB2_Peripheral_Base + 16#3c00#;
 
   GPIOD : GPIO_Registers with
     Volatile,
     Address => System'To_Address (GPIOD_Base);
   pragma Import (Ada, GPIOD);
 
   GPIOA : GPIO_Registers with
     Volatile,
     Address => System'To_Address (GPIOA_Base);
   pragma Import (Ada, GPIOA);
 
   type EXTI_Registers is record
      IMR   : Bits_32x1;
      EMR   : Bits_32x1;
      RTSR  : Bits_32x1;
      FTSR  : Bits_32x1;
      SWIER : Bits_32x1;
      PR    : Bits_32x1;
   end record;
 
   EXTI : EXTI_Registers with
     Volatile,
     Address => System'To_Address (EXTI_Base);
   pragma Import (Ada, EXTI);
 
   type SYSCFG_Registers is record
      MEMRM   : Word;
      PMC     : Word;
      EXTICR1 : Bits_8x4;
      EXTICR2 : Bits_8x4;
      EXTICR3 : Bits_8x4;
      EXTICR4 : Bits_8x4;
      CMPCR   : Word;
   end record;
 
   SYSCFG : SYSCFG_Registers with
     Volatile,
     Address => System'To_Address (SYSCFG_Base);
   pragma Import (Ada, SYSCFG);
 
end Registers;
