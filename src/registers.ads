pragma Warnings (Off);
with System.STM32F4; use System.STM32F4;
pragma Warnings (On);
 
package Registers is
 
   --  Bit definitions for RCC AHB1ENR register
   RCC_AHB1ENR_GPIOD    : constant Word := 2**3;
   RCC_AHB1ENR_GPIOG    : constant Word := 2**6; 
   RCC_AHB1ENR_GPIOA    : constant Word := 2**0;
 
   RCC_APB2ENR_SYSCFGEN : constant Word := 16#4000#;
 
   GPIOD_Base           : constant := AHB1_Peripheral_Base + 16#0C00#;
   GPIOG_Base           : constant := AHB1_Peripheral_Base + 16#1800#;
   GPIOA_Base           : constant := AHB1_Peripheral_Base + 16#0000#;
   SYSCFG_Base          : constant := APB2_Peripheral_Base + 16#3800#;
   EXTI_Base            : constant := APB2_Peripheral_Base + 16#3c00#;
 
   GPIOD : GPIO_Registers with
     Volatile,
     Address => System'To_Address (GPIOD_Base);
   pragma Import (Ada, GPIOD);
 
   GPIOG : GPIO_Registers with
     Volatile,
     Address => System'To_Address (GPIOG_Base);
   pragma Import (Ada, GPIOG);

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
 

   package SPI is
      -- SPI_CR1
      Cpha     : constant Bits_16 := 2**0;
      Cpol     : constant Bits_16 := 2**1;
      Mstr     : constant Bits_16 := 2**2;
      Br0      : constant Bits_16 := 2**3;
      Br1      : constant Bits_16 := 2**4;
      Br2      : constant Bits_16 := 2**5;
      Spe      : constant Bits_16 := 2**6;
      Lsbfirst : constant Bits_16 := 2**7;
      Ssi      : constant Bits_16 := 2**8;
      Ssm      : constant Bits_16 := 2**9;
      Rxonly   : constant Bits_16 := 2**10;
      Dff      : constant Bits_16 := 2**11;
      Crcnext  : constant Bits_16 := 2**12;
      Crcen    : constant Bits_16 := 2**13;
      Bidioe   : constant Bits_16 := 2**14;
      Bidimode : constant Bits_16 := 2**15;
      
      -- SPI_CR2
      Rxdmaen : constant Bits_16 := 2**0;
      Txdmaen : constant Bits_16 := 2**1;
      Ssoe    : constant Bits_16 := 2**2;
      Frf     : constant Bits_16 := 2**4;
      Errie   : constant Bits_16 := 2**5;
      Rxneie  : constant Bits_16 := 2**6;
      Txeie   : constant Bits_16 := 2**7;
      
      -- SPI_SR
      Rxne   : constant Bits_16 := 2**0;
      Txe    : constant Bits_16 := 2**1;
      Chside : constant Bits_16 := 2**2;
      Udr    : constant Bits_16 := 2**3;
      Crcerr : constant Bits_16 := 2**4;
      Modf   : constant Bits_16 := 2**5;
      Ovr    : constant Bits_16 := 2**6;
      Bsy    : constant Bits_16 := 2**7;
      Fre    : constant Bits_16 := 2**8;
      --
      
   end SPI;
   
   

   type SPI_Registers is record
      Reserved_0  : Bits_16;
      Spi_Cr1     : Bits_16;
      Reserved_1  : Bits_16;
      Spi_Cr2     : Bits_16;
      Reserved_2  : Bits_16;
      Spi_sr      : Bits_16;
      Reserved_3  : Bits_16;
      Spi_Dr      : Bits_16;
      Reserved_4  : Bits_16;
      Spi_Crcpr   : Bits_16;
      Reserved_5  : Bits_16;
      Spi_Rxcrcpr : Bits_16;
      Reserved_6  : Bits_16;
      Spi_I2scfgr : Bits_16;
      Reserved_7  : Bits_16;
      Spi_I2cpr   : Bits_16;
   end record with Pack;

   SPI1 : SPI_Registers with Volatile, 
     Address => System'To_Address (16#4001_33FF#);
   SPI4 : Spi_Registers with Volatile,
     Address => System'To_Address (16#4001_3400#);
   
end Registers;
