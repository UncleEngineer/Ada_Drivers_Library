with Last_Chance_Handler;
pragma Unreferenced (Last_Chance_Handler);
--  The "last chance handler" is the user-defined routine that is called when
--  an exception is propagated. We need it in the executable, therefore it must
--  be somewhere in the closure of the context clauses.

with STM32.GPIO;  use STM32.GPIO;
with STM32;       use STM32;
with STM32.Board; use STM32.Board;
with STM32.Device;
with STM32.RTC;   use STM32.RTC;
with STM32.Power_Control;

with Ada.Real_Time;       use Ada.Real_Time;
with HAL.Real_Time_Clock; use HAL.Real_Time_Clock;

procedure Power_Demo is

   --  Blink with a period for limit
   procedure Blink (Period : Time_Span; Limit : in Time);

   procedure Blink (Period : Time_Span; Limit : in Time) is
      Next_Release : Time := Clock;
   begin
      loop
         Toggle (All_LEDs);

         Next_Release := Next_Release + Period;

         delay until Next_Release;

         exit when Next_Release > Limit;
      end loop;
   end Blink;

begin
   --  Enable the prower control
   Power_Control.Enable;
   Board.Initialize_LEDs;

   --  Enable RTC support
   Enable (Device.RTC);

   --  Test if we already went in deep sleep mode
   if STM32.Power_Control.Standby_Flag = False then

      --  set Arbitrary time
      Set
        (This => Device.RTC, Time => (Hour => 22, Min => 37, Sec => 0),
         Date =>
           (Day_Of_Week => Sunday, Day => 23, Month => August, Year => 20));

      --  Set when to wakeup
      Set_Alarm_A
        (This => Device.RTC, Time => (Hour => 22, Min => 37, Sec => 15),
         Date =>
           (Day_Of_Week => Sunday, Day => 23, Month => August, Year => 20));

      Enable_Alarm_A (Device.RTC, True);

      --  Blink for 5 seconds
      Blink (Milliseconds (200), Clock + Seconds (5));

   else
      --  When waking up, blink 10 seconds
      STM32.Power_Control.Clear_Standby_Flag;
      Blink (Milliseconds (500), Clock + Seconds (10));
   end if;

   --  Then standby
   Power_Control.Enter_Standby_Mode;

end Power_Demo;
