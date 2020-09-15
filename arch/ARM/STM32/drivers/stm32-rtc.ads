------------------------------------------------------------------------------
--                                                                          --
--                        Copyright (C) 2016, AdaCore                       --
--                                                                          --
--  Redistribution and use in source and binary forms, with or without      --
--  modification, are permitted provided that the following conditions are  --
--  met:                                                                    --
--     1. Redistributions of source code must retain the above copyright    --
--        notice, this list of conditions and the following disclaimer.     --
--     2. Redistributions in binary form must reproduce the above copyright --
--        notice, this list of conditions and the following disclaimer in   --
--        the documentation and/or other materials provided with the        --
--        distribution.                                                     --
--     3. Neither the name of the copyright holder nor the names of its     --
--        contributors may be used to endorse or promote products derived   --
--        from this software without specific prior written permission.     --
--                                                                          --
--   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS    --
--   "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT      --
--   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR  --
--   A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT   --
--   HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, --
--   SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT       --
--   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,  --
--   DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY  --
--   THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT    --
--   (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE  --
--   OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.   --
--                                                                          --
------------------------------------------------------------------------------

with HAL.Real_Time_Clock;

package STM32.RTC is

   type RTC_Device is new HAL.Real_Time_Clock.RTC_Device with private;

   type Wakeup_Clock_Selection is
     (RTC_16, RTC_8, RTC_4, RTC_2, CK_SPRE_Low, CK_SPRE_High);
   for Wakeup_Clock_Selection use (RTC_16 => 2#000#,
                                   RTC_8 => 2#001#,
                                   RTC_4 => 2#010#,
                                   RTC_2 => 2#011#,
                                   CK_SPRE_Low => 2#100#,
                                   CK_SPRE_High => 2#111#);


   overriding procedure Set
     (This : in out RTC_Device; Time : HAL.Real_Time_Clock.RTC_Time;
      Date :        HAL.Real_Time_Clock.RTC_Date);

   overriding procedure Get
     (This : in out RTC_Device; Time : out HAL.Real_Time_Clock.RTC_Time;
      Date :    out HAL.Real_Time_Clock.RTC_Date);

   overriding function Get_Time
     (This : RTC_Device) return HAL.Real_Time_Clock.RTC_Time;

   overriding function Get_Date
     (This : RTC_Device) return HAL.Real_Time_Clock.RTC_Date;

   procedure Enable (This : in out RTC_Device);
   procedure Disable (This : in out RTC_Device);

   procedure Enable_Wakeup
     (This : in out RTC_Device; With_Interrupt : Boolean);

   procedure Disable_Wakeup (This : in out RTC_Device);

   procedure Set_Wakeup_Clock
     (This : in out RTC_Device; Clock_Selection : in Wakeup_Clock_Selection);

   procedure Set_Wakeup_Timer (This : in out RTC_Device; Value : in UInt16);

   procedure Clear_Alarm_A (This : in out RTC_Device);

   procedure Set_Alarm_A
     (This : in out RTC_Device; Time : in HAL.Real_Time_Clock.RTC_Time;
      Date :        HAL.Real_Time_Clock.RTC_Date);

   procedure Enable_Alarm_A
     (This : in out RTC_Device; With_Interrupt : Boolean);

   procedure Clear_Alarm_B (This : in out RTC_Device);

   procedure Set_Alarm_B
     (This : in out RTC_Device; Time : in HAL.Real_Time_Clock.RTC_Time;
      Date :        HAL.Real_Time_Clock.RTC_Date);

   procedure Enable_Alarm_B
     (This : in out RTC_Device; With_Interrupt : Boolean);

private

   type RTC_Device is new HAL.Real_Time_Clock.RTC_Device with null record;

end STM32.RTC;
