// $Id$
//
// Earth System Modeling Framework
// Copyright (c) 2002-2025, University Corporation for Atmospheric Research, 
// Massachusetts Institute of Technology, Geophysical Fluid Dynamics 
// Laboratory, University of Michigan, National Centers for Environmental 
// Prediction, Los Alamos National Laboratory, Argonne National Laboratory, 
// NASA Goddard Space Flight Center.
// Licensed under the University of Illinois-NCSA License.
//
// ESMC Clock method code (body) file
//
//-------------------------------------------------------------------------
//
// !DESCRIPTION:
//
// The code in this file implements the C++ {\tt ESMC\_Clock} methods declared
// in the companion file {\tt ESMCI\_Clock.h}
//
//-------------------------------------------------------------------------
#define ESMC_FILENAME "ESMCI_Clock.C"

// associated class definition file
#include "ESMCI_Clock.h"

// higher level, 3rd party or system includes here
#include <stdio.h>
#include <string.h>
#include <ctype.h>

#include "ESMCI_LogErr.h"
#include "ESMCI_Alarm.h"

//-------------------------------------------------------------------------
// leave the following line as-is; it will insert the cvs ident string
// into the object file for tracking purposes.
static const char *const version = "$Id$";
//-------------------------------------------------------------------------

namespace ESMCI{

// initialize static clock instance counter
// TODO: inherit from ESMC_Base class
int Clock::count=0;

//
//-------------------------------------------------------------------------
//-------------------------------------------------------------------------
//
// This section includes all the Clock routines
//
//

//-------------------------------------------------------------------------
//BOP
// !IROUTINE:  ESMCI_ClockCreate - Allocates and Initializes a Clock object
//
// !INTERFACE:
      Clock *ESMCI_ClockCreate(
//
// !RETURN VALUE:
//     pointer to newly allocated Clock
//
// !ARGUMENTS: 
      int          nameLen,           // in
      const char   *name,             // in
      TimeInterval *timeStep,         // in
      Time         *startTime,        // in
      Time         *stopTime,         // in
      TimeInterval *runDuration,      // in
      int          *runTimeStepCount, // in
      Time         *refTime,          // in
      TimeInterval *repeatDuration,   // in
      int          *rc) {             // out - return code

// !DESCRIPTION:
//      Allocates and Initializes a {\tt ESMC\_Clock} with given values
//
//EOP
// !REQUIREMENTS:  

 #undef  ESMC_METHOD
 #define ESMC_METHOD "ESMCI_ClockCreate(new)"

    int returnCode;
    Clock *clock;

    // default return code
    if (rc != ESMC_NULL_POINTER) *rc = ESMC_RC_NOT_IMPL;

    // allocate a clock object & set defaults via constructor
    try {
      clock = new Clock;
    }
    catch (...) {
      ESMC_LogDefault.AllocError(ESMC_CONTEXT,rc);
      return(ESMC_NULL_POINTER);
    }

    // TODO: use inherited methods from ESMC_Base
    if (name != ESMC_NULL_POINTER) {
      if (nameLen < ESMF_MAXSTR) {
        strncpy(clock->name, name, nameLen);
        clock->name[nameLen] = '\0';  // null terminate
      } else {
        // truncate
        strncpy(clock->name, name, ESMF_MAXSTR-1);
        clock->name[2*ESMF_MAXSTR-1] = '\0';  // null terminate

        char logMsg[2*ESMF_MAXSTR];
        sprintf(logMsg, "clock name %s, length >= ESMF_MAXSTR; truncated.",
                name);
        ESMC_LogDefault.Write(logMsg, ESMC_LOGMSG_WARN,ESMC_CONTEXT);
        // TODO: return ESMF_WARNING when defined
        // if (rc != ESMC_NULL_POINTER) *rc = ESMF_WARNING;
      }
    } else {
      // create default name "ClockNNN"
      sprintf(clock->name, "Clock%3.3d", clock->id);
    }

    if (timeStep  != ESMC_NULL_POINTER) {
      clock->timeStep  = *timeStep;
      clock->currAdvanceTimeStep = clock->prevAdvanceTimeStep = clock->timeStep;
    }
    if (startTime != ESMC_NULL_POINTER) clock->startTime = *startTime;
    if (stopTime  != ESMC_NULL_POINTER) {
      clock->stopTime  = *stopTime;
      clock->stopTimeEnabled = true;
    }

    if (runDuration != ESMC_NULL_POINTER) {
      clock->stopTime = clock->startTime + *runDuration;
      clock->stopTimeEnabled = true;
    }
    if (runTimeStepCount != ESMC_NULL_POINTER) {
      // use passed-in timestep if specified, otherwise use the clock's
      TimeInterval duration;
      if (timeStep != ESMC_NULL_POINTER) {
        duration = *runTimeStepCount * *timeStep;
      } else {
        duration = *runTimeStepCount * clock->timeStep;
      }
      clock->stopTime = clock->startTime + duration;
#if 0
// TODO: this code breaks Apple's g++ 3.3 compiler!
      clock->stopTime = clock->startTime + (*runTimeStepCount *
        (timeStep != ESMC_NULL_POINTER) ? *timeStep : clock->timeStep);
#endif
      clock->stopTimeEnabled = true;
    }

    if (refTime != ESMC_NULL_POINTER) clock->refTime = *refTime;
    else clock->refTime = clock->startTime;

    clock->prevTime = clock->currTime = clock->startTime;

    // Set repeat information
    clock->repeat=false;
    clock->repeatDuration=(TimeInterval)0;
    clock->repeatCount=0;
    if ((repeatDuration != ESMC_NULL_POINTER) &&
        (*repeatDuration !=0 )){ // Gives a way to not have repeat, but still have arg. (useful for C->F)
      clock->repeat=true;
      clock->repeatDuration=*repeatDuration;
    }

    returnCode = clock->validate();
    if (ESMC_LogDefault.MsgFoundError(returnCode, ESMCI_ERR_PASSTHRU, 
      ESMC_CONTEXT, rc)) {
      // TODO: distinguish non-fatal rc's (warnings, info) at this level (C++),
      //   and at the F90 level, so isInit flag can be set to usable value.
      delete clock;
      return(ESMC_NULL_POINTER);
    }

    if (rc != ESMC_NULL_POINTER) *rc = ESMF_SUCCESS;
    return(clock);

 } // end ESMCI_ClockCreate (new)

//-------------------------------------------------------------------------
//BOP
// !IROUTINE:  ESMCI_ClockCreate - Creates a copy of a clock
//
// !INTERFACE:
      Clock *ESMCI_ClockCreate(
//
// !RETURN VALUE:
//     pointer to newly allocated Clock
//
// !ARGUMENTS:
      Clock *clock,  // in  - clock to copy
      int        *rc) {   // out - return code

// !DESCRIPTION:
//      Creates a new copy of the given clock.
//
//EOP
// !REQUIREMENTS:  

 #undef  ESMC_METHOD
 #define ESMC_METHOD "ESMCI_ClockCreate(copy)"

    int returnCode;
    Clock *clockCopy;

    // default return code
    if (rc != ESMC_NULL_POINTER) *rc = ESMC_RC_NOT_IMPL;

    // can't copy a non-existent object
    if (clock == ESMC_NULL_POINTER) {
      ESMC_LogDefault.Write("Can't copy a non-existent clock",
                                    ESMC_LOGMSG_WARN,ESMC_CONTEXT);
      return(ESMC_NULL_POINTER);
    }

    try {
      // allocate new clock and pass given clock to copy constructor.
      clockCopy = new Clock(*clock);
    }
    catch (...) {
      ESMC_LogDefault.AllocError(ESMC_CONTEXT,rc);
      return(ESMC_NULL_POINTER);
    }

    returnCode = clockCopy->validate();
    if (ESMC_LogDefault.MsgFoundError(returnCode, ESMCI_ERR_PASSTHRU, 
      ESMC_CONTEXT, rc)) {
      // TODO: distinguish non-fatal rc's (warnings, info) at this level (C++),
      //   and at the F90 level, so isInit flag can be set to usable value.
      delete clockCopy;
      return(ESMC_NULL_POINTER);
    }

    if (rc != ESMC_NULL_POINTER) *rc = ESMF_SUCCESS;
    return(clockCopy);

 } // end ESMCI_ClockCreate (copy)

//-----------------------------------------------------------------------------
//BOP
// !IROUTINE:  ESMCI_ClockDestroy - free a Clock created with Create
//
// !INTERFACE:
      int ESMCI_ClockDestroy(
//
// !RETURN VALUE:
//    int error return code
//
// !ARGUMENTS:
      Clock **clock) {  // in - Clock to destroy
//
// !DESCRIPTION:
//      ESMF routine which destroys a Clock object previously allocated
//      via an {\tt ESMCI\_ClockCreate} routine.  Define for deep classes only.
//
//EOP

   // set any associated alarm's clock pointers to null
   if (*clock != ESMC_NULL_POINTER) {
     for(int i=0; i < (*clock)->alarmCount; i++) {
       ((*clock)->alarmList[i])->clock = ESMC_NULL_POINTER;
     }
   }

   // TODO: clock->destruct(); constructor calls it!
   delete *clock; // ok to delete null pointer

   *clock = ESMC_NULL_POINTER;
   return(ESMF_SUCCESS);

 } // end ESMCI_ClockDestroy

//-------------------------------------------------------------------------
//BOP
// !IROUTINE:  Clock::set - Sets a Clock object's properties
//
// !INTERFACE:
      int Clock::set(
//
// !RETURN VALUE:
//    int error return code
//
// !ARGUMENTS:
      int                nameLen,          // in
      const char        *name,             // in
      TimeInterval *timeStep,         // in
      Time         *startTime,        // in
      Time         *stopTime,         // in
      TimeInterval *runDuration,      // in
      int               *runTimeStepCount, // in
      Time         *refTime,          // in
      Time         *currTime,         // in
      ESMC_I8      *advanceCount,     // in
      ESMC_Direction    *direction) {      // in

// !DESCRIPTION:
//      Sets a {\tt ESMC\_Clock}'s properties
//
//EOP
// !REQUIREMENTS:  

 #undef  ESMC_METHOD
 #define ESMC_METHOD "ESMCI::Clock::set()"

    int rc = ESMF_SUCCESS;

    if (this == ESMC_NULL_POINTER) {
      ESMC_LogDefault.MsgFoundError(ESMC_RC_PTR_NULL,
         "; 'this' pointer is NULL.", ESMC_CONTEXT, &rc);
      return(rc);
    }

    // save current values to restore in case of failure;
    Clock saveClock = *this;

    // TODO: use inherited methods from ESMC_Base
    if (name != ESMC_NULL_POINTER) {
      if (nameLen < ESMF_MAXSTR) {
        strncpy(this->name, name, nameLen); 
        this->name[nameLen] = '\0';  // null terminate
      } else {
        // truncate
        strncpy(this->name, name, ESMF_MAXSTR-1);
        this->name[2*ESMF_MAXSTR-1] = '\0';  // null terminate

        char logMsg[2*ESMF_MAXSTR];
        sprintf(logMsg, "clock name %s, length >= ESMF_MAXSTR; truncated.",
                name);
        ESMC_LogDefault.Write(logMsg, ESMC_LOGMSG_WARN,ESMC_CONTEXT);
        // TODO: return ESMF_WARNING when defined
        // rc = ESMF_WARNING;
      }
    }

    if (timeStep  != ESMC_NULL_POINTER) {

      // Repeat isn't supported yet with a negative time step or one that's 0
      if ((this->repeat) && (*timeStep <= (TimeInterval)0)) {
        ESMC_LogDefault.MsgFoundError(ESMF_RC_INTNRL_INCONS,
          "repeating clocks currently do not support negative or 0 time steps.",
                                      ESMC_CONTEXT, &rc);
          return(rc);
      }

      // Set new timeStep
      this->timeStep  = *timeStep;
    }
    
    if (startTime != ESMC_NULL_POINTER) this->startTime = *startTime;
    if (stopTime  != ESMC_NULL_POINTER) {
      this->stopTime  = *stopTime;
      this->stopTimeEnabled = true;
    }

    if (runDuration != ESMC_NULL_POINTER) {
      this->stopTime = this->startTime + *runDuration;
      this->stopTimeEnabled = true;
    }
    if (runTimeStepCount != ESMC_NULL_POINTER) {
      // use passed-in timestep if specified, otherwise use the clock's
      TimeInterval duration;
      if (timeStep != ESMC_NULL_POINTER) {
        duration = *runTimeStepCount * *timeStep;
      } else {
        duration = *runTimeStepCount * this->timeStep;
      }
      this->stopTime = this->startTime + duration;
#if 0
// TODO: this code breaks Apple's g++ 3.3 compiler!
      this->stopTime = this->startTime + (*runTimeStepCount *
        (timeStep != ESMC_NULL_POINTER) ? *timeStep : this->timeStep);
#endif
      this->stopTimeEnabled = true;
    }

    if (refTime   != ESMC_NULL_POINTER) this->refTime   = *refTime;

    if (currTime  != ESMC_NULL_POINTER) {
      // Don't reset prevTime! Only clockAdvance() should change internal
      // state properties.  Setting prevTime here caused multiple calls to
      // set() with the same value, which should be innocuous, to result in
      // incorrect alarm behavior, as Ratko Vasic discovered in ticket #2685243.
      // this->prevTime = this->currTime;
      this->currTime = *currTime;
    }

    if (advanceCount != ESMC_NULL_POINTER) this->advanceCount = *advanceCount;

    if (direction != ESMC_NULL_POINTER) {
      this->direction = *direction;
      this->userChangedDirection = true;

      if ((this->repeat) && (this->direction==ESMF_DIRECTION_REVERSE)) {
        ESMC_LogDefault.MsgFoundError(ESMF_RC_INTNRL_INCONS,
         "repeating clocks are not currently supported with reverse direction.",
                                      ESMC_CONTEXT, &rc);
        return(rc);        
      }
    }

    rc = Clock::validate();
    if (ESMC_LogDefault.MsgFoundError(rc, ESMCI_ERR_PASSTHRU, ESMC_CONTEXT,
      &rc)) {
      // restore original clock values
      *this = saveClock;
    }

    return(rc);

 } // end Clock::set

//-------------------------------------------------------------------------
//BOP
// !IROUTINE:  Clock::get - gets a Clock object's properties
//
// !INTERFACE:
      int Clock::get(
//
// !RETURN VALUE:
//    int error return code
//
// !ARGUMENTS:
      int             nameLen,          // in
      int            *tempNameLen,      // out
      char           *tempName,         // out
      TimeInterval   *timeStep,         // out
      Time           *startTime,        // out
      Time           *stopTime,         // out
      TimeInterval   *runDuration,      // out
      ESMC_R8        *runTimeStepCount, // out
      Time           *refTime,          // out
      Time           *currTime,         // out
      Time           *prevTime,         // out
      TimeInterval   *currSimTime,      // out
      TimeInterval   *prevSimTime,      // out
      Calendar      **calendar,         // out
      ESMC_CalKind_Flag *calkindflag,   // out
      int            *timeZone,         // out
      ESMC_I8        *advanceCount,     // out
      int            *alarmCount,       // out
      ESMC_Direction *direction,        // out
      TimeInterval   *repeatDuration,   // out
      ESMC_I8        *repeatCount       // out
                     ) {      

// !DESCRIPTION:
//      Gets a {\tt ESMC\_Clock}'s property values
//
//EOP
// !REQUIREMENTS:  

 #undef  ESMC_METHOD
 #define ESMC_METHOD "ESMCI::Clock::get()"

    int rc = ESMF_SUCCESS;

    if (this == ESMC_NULL_POINTER) {
      ESMC_LogDefault.MsgFoundError(ESMC_RC_PTR_NULL,
         "; 'this' pointer is NULL.", ESMC_CONTEXT, &rc);
      return(rc);
    }

    // TODO: use inherited methods from ESMC_Base
    if (nameLen > 0) {
      if (strlen(this->name) < nameLen) {
        // copy all of it
        strcpy(tempName, this->name);
      } else {
        // TODO: copy what will fit and return ESMF_FAILURE ?
        strncpy(tempName, this->name, nameLen-1);
        tempName[nameLen] = '\0';  // null terminate

        char logMsg[2*ESMF_MAXSTR];
        sprintf(logMsg, "clock name %s, "
                "length >= given character array; truncated.", this->name);
        ESMC_LogDefault.Write(logMsg, ESMC_LOGMSG_WARN,ESMC_CONTEXT);
        // TODO: return ESMF_WARNING when defined
        // rc = ESMF_WARNING;
      }
      // report how many characters were copied
      *tempNameLen = strlen(tempName);
    }

    if (timeStep  != ESMC_NULL_POINTER) *timeStep  = this->timeStep;
    if (startTime != ESMC_NULL_POINTER) *startTime = this->startTime;
    if (stopTime  != ESMC_NULL_POINTER) *stopTime  = this->stopTime;

    if (runDuration != ESMC_NULL_POINTER) {
      *runDuration = this->stopTime - this->startTime;
    }
    if (runTimeStepCount != ESMC_NULL_POINTER) {
      *runTimeStepCount = (this->stopTime - this->startTime) / this->timeStep;
    }

    if (refTime   != ESMC_NULL_POINTER) *refTime   = this->refTime;
    if (currTime  != ESMC_NULL_POINTER) *currTime  = this->currTime;
    if (prevTime  != ESMC_NULL_POINTER) *prevTime  = this->prevTime;

    // Get the clock's current simulation time
    if (currSimTime != ESMC_NULL_POINTER) {
      *currSimTime = (this->currTime - this->refTime);
    }
    // Get the clock's previous simulation time
    if (prevSimTime != ESMC_NULL_POINTER) {
      *prevSimTime = (this->prevTime - this->refTime);
    }

    if (calendar != ESMC_NULL_POINTER) {
      // get calendar from currTime, but could get from any other clock Time,
      //   since they all use the same calendar
      // TODO: use native C++ Get, not F90 entry point, when ready
      rc = this->currTime.Time::get((ESMC_I4 *)ESMC_NULL_POINTER,
                      ESMC_NULL_POINTER, ESMC_NULL_POINTER, ESMC_NULL_POINTER,
                      ESMC_NULL_POINTER, ESMC_NULL_POINTER, ESMC_NULL_POINTER,
                      ESMC_NULL_POINTER, ESMC_NULL_POINTER, ESMC_NULL_POINTER,
                      ESMC_NULL_POINTER, ESMC_NULL_POINTER, ESMC_NULL_POINTER,
                      ESMC_NULL_POINTER, ESMC_NULL_POINTER, ESMC_NULL_POINTER,
                      ESMC_NULL_POINTER, ESMC_NULL_POINTER, ESMC_NULL_POINTER,
                      ESMC_NULL_POINTER, ESMC_NULL_POINTER, ESMC_NULL_POINTER,
                      ESMC_NULL_POINTER, ESMC_NULL_POINTER, calendar);
      ESMC_LogDefault.MsgFoundError(rc, "Time::get(...calendar) failed.",
        ESMC_CONTEXT, &rc);
    }
    if (calkindflag != ESMC_NULL_POINTER) {
      // get calendar kind from currTime, but could get from any other clock
      // Time, since they all use the same calendar
      // TODO: use native C++ Get, not F90 entry point, when ready
      rc = this->currTime.Time::get((ESMC_I4 *)ESMC_NULL_POINTER,
                      ESMC_NULL_POINTER, ESMC_NULL_POINTER, ESMC_NULL_POINTER,
                      ESMC_NULL_POINTER, ESMC_NULL_POINTER, ESMC_NULL_POINTER,
                      ESMC_NULL_POINTER, ESMC_NULL_POINTER, ESMC_NULL_POINTER,
                      ESMC_NULL_POINTER, ESMC_NULL_POINTER, ESMC_NULL_POINTER,
                      ESMC_NULL_POINTER, ESMC_NULL_POINTER, ESMC_NULL_POINTER,
                      ESMC_NULL_POINTER, ESMC_NULL_POINTER, ESMC_NULL_POINTER,
                      ESMC_NULL_POINTER, ESMC_NULL_POINTER, ESMC_NULL_POINTER,
                      ESMC_NULL_POINTER, ESMC_NULL_POINTER, ESMC_NULL_POINTER,
                      calkindflag);
      ESMC_LogDefault.MsgFoundError(rc, "Time::get(...calkindflag) failed.",
        ESMC_CONTEXT, &rc);
    }
    if (timeZone != ESMC_NULL_POINTER) {
      // get timeZone from currTime, but could get from any other clock Time,
      //   since they all are in the same timezone
      // TODO: use native C++ Get, not F90 entry point, when ready
      rc = this->currTime.Time::get((ESMC_I4 *)ESMC_NULL_POINTER,
                      ESMC_NULL_POINTER, ESMC_NULL_POINTER, ESMC_NULL_POINTER,
                      ESMC_NULL_POINTER, ESMC_NULL_POINTER, ESMC_NULL_POINTER,
                      ESMC_NULL_POINTER, ESMC_NULL_POINTER, ESMC_NULL_POINTER,
                      ESMC_NULL_POINTER, ESMC_NULL_POINTER, ESMC_NULL_POINTER,
                      ESMC_NULL_POINTER, ESMC_NULL_POINTER, ESMC_NULL_POINTER,
                      ESMC_NULL_POINTER, ESMC_NULL_POINTER, ESMC_NULL_POINTER,
                      ESMC_NULL_POINTER, ESMC_NULL_POINTER, ESMC_NULL_POINTER,
                      ESMC_NULL_POINTER, ESMC_NULL_POINTER, ESMC_NULL_POINTER,
                      ESMC_NULL_POINTER, timeZone);
      ESMC_LogDefault.MsgFoundError(rc, "Time::get(...timeZone) failed.",
        ESMC_CONTEXT, &rc);
    }

    if (advanceCount != ESMC_NULL_POINTER) *advanceCount = this->advanceCount;
    if (alarmCount   != ESMC_NULL_POINTER) *alarmCount   = this->alarmCount;
    if (direction    != ESMC_NULL_POINTER) *direction    = this->direction;
    if (repeatDuration  != ESMC_NULL_POINTER) *repeatDuration  = this->repeatDuration;
    if (repeatCount  != ESMC_NULL_POINTER) *repeatCount  = this->repeatCount;

    
    return(rc);

 } // end Clock::get
  
//-------------------------------------------------------------------------
//BOP
// !IROUTINE:  Clock::advance - increment a clock's time
//
// !INTERFACE:
      int Clock::advance(
//
// !RETURN VALUE:
//    int error return code
//
// !ARGUMENTS:
      TimeInterval *timeStep,               // in  - optional new timestep
      char              *ringingAlarmList1stElementPtr, // out - optional array
                                                 //        of ringing alarms
      char              *ringingAlarmList2ndElementPtr, // in - address of 2nd
                                                 //        element to calculate
                                                 //        F90 array element
                                                 //        size
      int                sizeofRingingAlarmList, // in  - size of given array
                                                 //       of ringing alarms
      int               *ringingAlarmCount) {    // out - number of ringing
                                                 //       alarms
//
// !DESCRIPTION:
//     Advances a clock's current time by timestep, then checks
//     each of its alarms to see if its time to ring.
//
//EOP
// !REQUIREMENTS:  TMG 3.4.1
 
 #undef  ESMC_METHOD
 #define ESMC_METHOD "ESMCI::Clock::advance()"

    int rc = ESMF_SUCCESS;
    bool userChangedDirLocal;

    if (this == ESMC_NULL_POINTER) {
      ESMC_LogDefault.MsgFoundError(ESMC_RC_PTR_NULL,
         "; 'this' pointer is NULL.", ESMC_CONTEXT, &rc);
      return(rc);
    }

    if (direction == ESMF_DIRECTION_FORWARD) {

      // save current time, then advance it
      prevTime = currTime;

      // use passed-in timestep if specified, otherwise use the clock's;
      // keep track of timeStep previously used in advance, to detect
      // direction (sign) change -- used for alarm consistency
      prevAdvanceTimeStep = currAdvanceTimeStep;
      currAdvanceTimeStep = (timeStep != ESMC_NULL_POINTER) ?
                            *timeStep : this->timeStep;

      // Advance based on whether repeat clock or not
      if (repeat) {

        // Repeat isn't supported yet with a negative time step or one that's 0
        // The code below will have to be re-thought to support either. 
        if (currAdvanceTimeStep <= (TimeInterval)0) {
          ESMC_LogDefault.MsgFoundError(ESMF_RC_INTNRL_INCONS,
                 "repeating clocks currently do not support negative or 0 time steps.", ESMC_CONTEXT, &rc);
          return(rc);
        }
        
        // Time at which we repeat
        Time repeatTime=startTime+repeatDuration;
        
        // At first use whole time step
        TimeInterval leftoverTimeStep = currAdvanceTimeStep;

        // Loop while we still have time step left
        while (currTime+leftoverTimeStep >= repeatTime) {

          // Check alarms from currTime to repeatTime

          // Take off part to get to repeatTime
          leftoverTimeStep = (currTime+leftoverTimeStep)-repeatTime;

          // Move currTime back to startTime
          currTime=startTime;
          
          // Because we went back to startTime, advance repeatCount
          repeatCount++;                      
        }

        // Add remaining part of time step to currTime
        currTime += leftoverTimeStep;

        // Check Alarms from currTime to currTime+leftoverTimeStep
        
      } else {
        currTime += currAdvanceTimeStep;
      }

      
      // count number of timesteps
      advanceCount++;

    } else { // ESMF_DIRECTION_REVERSE
      
      // TODO: make more robust by removing simplifying assumptions:
      //       1) timeSteps are constant throughout clock run.

      // Note:  Clocks can be stepped in reverse without first having been
      //        stepped forward.  This implies that the logic cannot use
      //        the prevTime state variable in order to step back; the
      //        currTime state variable must be reconstructed from timeStep.
      //        advanceCount represents the number of actual calls to
      //        Clock::advance(), so if a clock is jumped forward via a
      //        Clock::set() and then reversed, the advanceCount does not
      //        account for the "missing" timeSteps.

      // Repeat isn't supported yet with reverse direction
      if (repeat) {
        ESMC_LogDefault.MsgFoundError(ESMF_RC_INTNRL_INCONS,
         "repeating clocks are not currently supported with reverse direction.", ESMC_CONTEXT, &rc);
        return(rc);
      }
      
      // step backwards; use passed-in timestep if specified, otherwise
      //   use the clock's prevTime
      currTime -= (timeStep != ESMC_NULL_POINTER) ? *timeStep : this->timeStep;

      // restore previous "previous" time
      // TODO:  remove assumption of constant timeStep; need to allow for
      //        variable timeSteps
      prevTime -= this->timeStep;

      // decrement timeStep count
      advanceCount--;

    }

    // TODO: validate (range check) new time against its calendar ?

    if (ringingAlarmCount != ESMC_NULL_POINTER) *ringingAlarmCount = 0;

    // Calculate element size of F90 array of Alarm pointers since we
    // cannot depend on C++ element size to be the same as F90's across all
    // platforms.  It is assumed that all F90 platforms allocate arrays
    // contiguously and uniformly in memory, in either ascending or descending
    // address order.
    // TODO:  calculate once during ESMF_FrameworkInitialize() (runtime),
    //        since this is a platform constant. compile-time constant ?
    //        put into src/prologue directory.
    // see also Clock::getAlarmList().

    int f90ArrayElementSize = 0; 
    if (ringingAlarmList1stElementPtr != ESMC_NULL_POINTER &&
        ringingAlarmList2ndElementPtr != ESMC_NULL_POINTER) {
        f90ArrayElementSize = (int)(ringingAlarmList2ndElementPtr -
                                    ringingAlarmList1stElementPtr);
    }

    // Each alarm sets userChangedDirection to false in checkRingTime,
    // so only the first alarm knows if the user changed direction.
    // To remedy this, we'll save userChangedDirection and reset
    // the clock's userChangedDirection before each alarm. After
    // the last alarm::checkRingTime, this->userChangedDirection
    // will be false. This is not the most efficient fix, but
    // requires the least code changing to achieve it.
    userChangedDirLocal = this->userChangedDirection;

    // traverse alarm list (i) for ringing alarms (j)
    for(int i=0, j=0; i<alarmCount; i++) {
      int rc;
      bool ringing;

      this->userChangedDirection = userChangedDirLocal;
      // check each alarm to see if it's time to ring
      ringing = alarmList[i]->Alarm::checkRingTime(&rc);

      // report ringing alarms if requested
      if (ringing) {
        // report number of ringing alarms
        if (ringingAlarmCount != ESMC_NULL_POINTER) (*ringingAlarmCount)++;

        // report ringing alarm list
        if (ringingAlarmList1stElementPtr != ESMC_NULL_POINTER) {
          if (j < sizeofRingingAlarmList) {
            // F90 equivalent: ringingAlarmList(j) = alarmList(i)
            //                 j = j + 1
            // calculate F90 array address for the j'th element ...
            char *f90ArrayElementJ;
            f90ArrayElementJ = ringingAlarmList1stElementPtr +
                               (j++ * f90ArrayElementSize);
            // ... then copy it in!
            *((Alarm**)f90ArrayElementJ) = alarmList[i];
          } else {
            // list overflow!
            char logMsg[2*ESMF_MAXSTR];
            sprintf(logMsg, "For clock %s, "
                    "trying to report %dth ringing alarm, but given "
                    "ringingAlarmList array can only hold %d.",
                    this->name, j+1, sizeofRingingAlarmList);
            ESMC_LogDefault.Write(logMsg, ESMC_LOGMSG_WARN,ESMC_CONTEXT);
            rc = ESMF_FAILURE;
          }
        }
      }
    }

    return(rc);

 } // end Clock::advance

//-------------------------------------------------------------------------
//BOP
// !IROUTINE:  Clock::isStopTime - check if Clock's stop time has been reached
//
// !INTERFACE:
      bool Clock::isStopTime(
//
// !RETURN VALUE:
//    bool is stop time or not
//
// !ARGUMENTS:
      int  *rc) const {        // out - error return code
//
// !DESCRIPTION:
//    checks if {\tt Clock}'s stop time has been reached.
//
//EOP
// !REQUIREMENTS:

 #undef  ESMC_METHOD
 #define ESMC_METHOD "ESMCI::Clock::isStopTime()"

    if (rc != ESMC_NULL_POINTER) *rc = ESMF_SUCCESS;

    if (this == ESMC_NULL_POINTER) {
      ESMC_LogDefault.MsgFoundError(ESMC_RC_PTR_NULL,
         "; 'this' pointer is NULL.", ESMC_CONTEXT, rc);
      return(false);
    }

    if (!stopTimeEnabled) return(false);

    // positive time step ?
    if (stopTime > startTime) {
      return(currTime >= stopTime);

    // or negative time step ?
    } else if (stopTime < startTime) {
      return(currTime <= stopTime);

    // or no time step? (stopTime == startTime)
    } else return(currTime == stopTime);

 } // end Clock::isStopTime

//-------------------------------------------------------------------------
//BOP
// !IROUTINE:  Clock::stopTimeEnable - enables a Clock's stopTime to function
//
// !INTERFACE:
      int Clock::stopTimeEnable(
//
// !RETURN VALUE:
//    int error return code
//
// !ARGUMENTS:
      Time *stopTime) {              // in  - optional new stop time
//
// !DESCRIPTION:
//      ESMF routine which enables a {\tt ESMC\_Clock}'s stopTime to function.
//
//EOP
// !REQUIREMENTS:  WRF

 #undef  ESMC_METHOD
 #define ESMC_METHOD "ESMCI::Clock::stopTimeEnable()"

    int rc = ESMF_SUCCESS;

    if (this == ESMC_NULL_POINTER) {
      ESMC_LogDefault.MsgFoundError(ESMC_RC_PTR_NULL,
         "; 'this' pointer is NULL.", ESMC_CONTEXT, &rc);
      return(rc);
    }

    if (stopTime != ESMC_NULL_POINTER) {
      this->stopTime = *stopTime;
    }

    stopTimeEnabled = true;

    return(ESMF_SUCCESS);

 } // end Clock::stopTimeEnable

//-------------------------------------------------------------------------
//BOP
// !IROUTINE:  Clock::stopTimeDisable - disables a Clock's stopTime from functioning
//
// !INTERFACE:
      int Clock::stopTimeDisable(void) {
//
// !RETURN VALUE:
//    int error return code
//
// !ARGUMENTS:
//    none
//
// !DESCRIPTION:
//      ESMF routine which disables a {\tt ESMC\_Clock}'s stopTime from
//      functioning.
//
//EOP
// !REQUIREMENTS:  WRF

 #undef  ESMC_METHOD
 #define ESMC_METHOD "ESMCI::Clock::stopTimeDisable()"

    int rc = ESMF_SUCCESS;

    if (this == ESMC_NULL_POINTER) {
      ESMC_LogDefault.MsgFoundError(ESMC_RC_PTR_NULL,
         "; 'this' pointer is NULL.", ESMC_CONTEXT, &rc);
      return(rc);
    }

    stopTimeEnabled = false;

    return(ESMF_SUCCESS);

 } // end Clock::stopTimeDisable

//-------------------------------------------------------------------------
//BOP
// !IROUTINE:  Clock::isStopTimeEnabled - check if Clock's stop time is enabled
//
// !INTERFACE:
      bool Clock::isStopTimeEnabled(
//
// !RETURN VALUE:
//    bool is stop time enabled or not
//
// !ARGUMENTS:
      int  *rc) const {        // out - error return code
//
// !DESCRIPTION:
//    checks if {\tt ESMCI\_Clock}'s stop time is enabled.
//
//EOP
// !REQUIREMENTS:

 #undef  ESMC_METHOD
 #define ESMC_METHOD "ESMCI::Clock::isStopTimeEnabled()"

    if (rc != ESMC_NULL_POINTER) *rc = ESMF_SUCCESS;

    if (this == ESMC_NULL_POINTER) {
      ESMC_LogDefault.MsgFoundError(ESMC_RC_PTR_NULL,
         "; 'this' pointer is NULL.", ESMC_CONTEXT, rc);
      return(false);
    }

    return(stopTimeEnabled);

 } // end Clock::isStopTimeEnabled

//-------------------------------------------------------------------------
//BOP
// !IROUTINE:  Clock::isDone - check if Clock's stop time or start time has been reached, depending on direction
//
// !INTERFACE:
      bool Clock::isDone(
//
// !RETURN VALUE:
//    bool is done or not
//
// !ARGUMENTS:
      int  *rc) const {        // out - error return code
//
// !DESCRIPTION:
//    Checks if {\tt ESMC\_Clock}'s stop time has been reached if in
//    {\tt ESMF\_DIRECTION\_FORWARD} or if it has reached start time if in
//    {\tt ESMF\_DIRECTION\_REVERSE}.
//
//EOP
// !REQUIREMENTS:

 #undef  ESMC_METHOD
 #define ESMC_METHOD "ESMCI::Clock::isDone()"

    if (rc != ESMC_NULL_POINTER) *rc = ESMF_SUCCESS;

    if (this == ESMC_NULL_POINTER) {
      ESMC_LogDefault.MsgFoundError(ESMC_RC_PTR_NULL,
         "; 'this' pointer is NULL.", ESMC_CONTEXT, rc);
      return(false);
    }

    if (direction == ESMF_DIRECTION_FORWARD) {

      if (!stopTimeEnabled) return(false);

      // check if stopTime has been reached or crossed

      // positive stopTime direction ?
      if (stopTime > startTime) {
        return(currTime >= stopTime);
  
      // or negative stopTime direction ?
      } else if (stopTime < startTime) {
        return(currTime <= stopTime);

      // or no stopTime direction ? (stopTime == startTime)
      } else return(currTime == stopTime);

    } else { // ESMF_DIRECTION_REVERSE

      // check if startTime has been reached or crossed

      // positive stopTime direction ?
      if (stopTime > startTime) {
        return(currTime <= startTime);
  
      // or negative stopTime direction ?
      } else if (stopTime < startTime) {
        return(currTime >= startTime);

      // or no stopTime direction ? (stopTime == startTime)
      } else return(currTime == startTime);

    }

 } // end Clock::isDone

//-------------------------------------------------------------------------
//BOP
// !IROUTINE:  Clock::isReverse - test if clock is in reverse mode
//
// !INTERFACE:
      bool Clock::isReverse(
//
// !RETURN VALUE:
//    bool is reverse mode or not
//
// !ARGUMENTS:
      int  *rc) const {        // out - error return code
//
// !DESCRIPTION:
//    Checks if {\tt ESMC\_Clock}'s direction is {\tt ESMF\_DIRECTION\_REVERSE}.
//
//EOP
// !REQUIREMENTS:

 #undef  ESMC_METHOD
 #define ESMC_METHOD "ESMCI::Clock::isReverse()"

    if (rc != ESMC_NULL_POINTER) *rc = ESMF_SUCCESS;

    if (this == ESMC_NULL_POINTER) {
      ESMC_LogDefault.MsgFoundError(ESMC_RC_PTR_NULL,
         "; 'this' pointer is NULL.", ESMC_CONTEXT, rc);
      return(false);
    }

    return(direction == ESMF_DIRECTION_REVERSE);

 } // end Clock::isReverse

//-------------------------------------------------------------------------
//BOP
// !IROUTINE:  Clock::getNextTime - calculates a Clock's next time 
//
// !INTERFACE:
      int Clock::getNextTime(
//
// !RETURN VALUE:
//    int error return code
//
// !ARGUMENTS:
      Time         *nextTime,       // out
      TimeInterval *timeStep) {     // in

// !DESCRIPTION:
//      Calculates what the next time of the {\tt ESMF\_Clock} will be, based
//      on the clock's current timestep or an optionally passed-in timestep.

//
//EOP
// !REQUIREMENTS:  

 #undef  ESMC_METHOD
 #define ESMC_METHOD "ESMCI::Clock::getNextTime()"

    int rc = ESMF_SUCCESS;

    if (this == ESMC_NULL_POINTER) {
      ESMC_LogDefault.MsgFoundError(ESMC_RC_PTR_NULL,
         "; 'this' pointer is NULL.", ESMC_CONTEXT, &rc);
      return(rc);
    }

    // Get tmp time step to use 
    TimeInterval tmpTimeStep;
    if (timeStep != ESMC_NULL_POINTER) {
      // use passed-in timeStep if specified
      tmpTimeStep=*timeStep;
    } else {
      // otherwise use clock's own timestep
      tmpTimeStep=this->timeStep;
    }

    // Save currTime, so we don't change it
    Time tmpCurrTime=currTime;

    // Calculate nextTime taking repeat into account
    if (repeat) {

      // Repeat isn't supported yet with a negative time step or one that's 0
      // The code below will have to be re-thought to support either. 
      if (tmpTimeStep <= (TimeInterval)0) {
        ESMC_LogDefault.MsgFoundError(ESMF_RC_INTNRL_INCONS,
         "repeating clocks currently do not support negative or 0 time steps.", ESMC_CONTEXT, &rc);
        return(rc);
      }
        
      // Time at which we repeat
      Time repeatTime=startTime+repeatDuration;
      
      // At first use whole time step
      TimeInterval leftoverTimeStep = tmpTimeStep;
      
      // Loop while we still have time step left
      while (tmpCurrTime+leftoverTimeStep >= repeatTime) {
        
        // Take off part to get to repeatTime
        leftoverTimeStep = (tmpCurrTime+leftoverTimeStep)-repeatTime;
        
        // Move tmpCurrTime back to startTime
        tmpCurrTime=startTime;
        
        // Because we went back to startTime, advance repeatCount
        repeatCount++;                      
      }
      
      // Add remaining part of time step to tmpCurrTime to get nextTime
      *nextTime= tmpCurrTime + leftoverTimeStep;
      
    } else {
      // If not repeating, then nextTime is just tmpCurrTime + timeStep
      *nextTime= tmpCurrTime + tmpTimeStep;
    }

    // Return success
    return(ESMF_SUCCESS);

 } // end Clock::getNextTime

//-------------------------------------------------------------------------
//BOP
// !IROUTINE:  Clock::getAlarm - get alarm from clock's alarm list
//
// !INTERFACE:
      int Clock::getAlarm(
//
// !RETURN VALUE:
//    int error return code
//
// !ARGUMENTS:
      int          alarmnameLen,   // in  - the length of the alarm name
      char        *alarmname,      // in  - the alarm "name" to get
      Alarm **alarm) {   // out - the alarm named "name"
//
// !DESCRIPTION:
//     Retrieves the clock's alarm named "alarmname" from the alarm list
//
//EOP
// !REQUIREMENTS:  TMG x.x

 #undef  ESMC_METHOD
 #define ESMC_METHOD "ESMCI::Clock::getAlarm()"

    int rc = ESMF_SUCCESS;

    if (this == ESMC_NULL_POINTER) {
      ESMC_LogDefault.MsgFoundError(ESMC_RC_PTR_NULL,
         "; 'this' pointer is NULL.", ESMC_CONTEXT, &rc);
      return(rc);
    }

    if (alarmnameLen >= ESMF_MAXSTR) {
      char logMsg[2*ESMF_MAXSTR];
      sprintf(logMsg, "For alarmname %s, length >= ESMF_MAXSTR, "
                      "truncated.", alarmname);
      ESMC_LogDefault.Write(logMsg, ESMC_LOGMSG_WARN,ESMC_CONTEXT);
      // TODO: return ESMF_WARNING when defined
    }

    // TODO: use inherited methods from ESMC_Base
    char alarmName[2*ESMF_MAXSTR];
    strncpy(alarmName, alarmname, alarmnameLen);
    alarmName[alarmnameLen] = '\0';  // null terminate

    // linear search for alarm name
    for(int i=0; i<alarmCount; i++) {
      if (strcmp(alarmName, alarmList[i]->name) == 0) {
        // found, return alarm
        *alarm = alarmList[i];
        return(ESMF_SUCCESS);
      }
    }

    // not found, return null ...
    *alarm = ESMC_NULL_POINTER;
    return(ESMF_FAILURE);

 } // end Clock::getAlarm

//-------------------------------------------------------------------------
//BOP
// !IROUTINE:  Clock::getAlarmList - Get a list of alarms from a clock
//
// !INTERFACE:
      int Clock::getAlarmList(
//
// !RETURN VALUE:
//    int error return code
//
// !ARGUMENTS:
      ESMC_AlarmList_Flag alarmlistflag,         // in - list flag to get
      char              *alarmList1stElementPtr, // out - array of alarms
      char              *alarmList2ndElementPtr, // in  - address of 2nd
                                                 //        element to calculate
                                                 //        F90 array element
                                                 //        size
      int                sizeofAlarmList,        // in  - size of given array
                                                 //       of alarms
      int               *alarmCount,             // out - number of alarms
      TimeInterval *timeStep) {                  // in  - optional time step to
                                                 //         use instead of the
                                                 //         clock's (only use
                                                 //         with alarm list flag
                                                 // ESMF_ALARMLIST_NEXTRINGING)
//
// !DESCRIPTION:
//    Gets an {\tt ESMF\_Clock}'s list of alarms.
//
//EOP
// !REQUIREMENTS:  TMG 4.3, 4.8

 #undef  ESMC_METHOD
 #define ESMC_METHOD "ESMCI::Clock::getAlarmList()"

    int rc = ESMF_SUCCESS;

    if (this == ESMC_NULL_POINTER) {
      ESMC_LogDefault.MsgFoundError(ESMC_RC_PTR_NULL,
         "; 'this' pointer is NULL.", ESMC_CONTEXT, &rc);
      return(rc);
    }

    if (alarmCount != ESMC_NULL_POINTER) *alarmCount = 0;

    // Calculate element size of F90 array of Alarm pointers since we
    // cannot depend on C++ element size to be the same as F90's across all
    // platforms.  It is assumed that all F90 platforms allocate arrays
    // contiguously and uniformly in memory, in either ascending or descending
    // address order.
    // TODO:  calculate once during ESMF_FrameworkInitialize() (runtime),
    //        since this is a platform constant. compile-time constant ?
    // see also Clock::advance().

    int f90ArrayElementSize = 0; 
    if (alarmList1stElementPtr != ESMC_NULL_POINTER &&
        alarmList2ndElementPtr != ESMC_NULL_POINTER) {
        f90ArrayElementSize = (int)(alarmList2ndElementPtr -
                                    alarmList1stElementPtr);
    }

    // traverse clock's alarm list (i) for alarms to return in
    //   requested list (j)
    for(int i=0, j=0; i < this->alarmCount; i++) {
      bool returnAlarm;

      // based on requested list flag, check if this (i'th) alarm is
      //   to be returned
      switch (alarmlistflag)
      {
        case ESMF_ALARMLIST_ALL:
          // return all alarms!
          returnAlarm = true;
          break;

        case ESMF_ALARMLIST_RINGING:
          // return alarm if it's ringing
          returnAlarm = (this->alarmList[i])->Alarm::isRinging(&rc);
          break;

        case ESMF_ALARMLIST_NEXTRINGING:
          // return alarm if it will ring upon the next clock time step
          returnAlarm = (this->alarmList[i])->Alarm::willRingNext(timeStep,&rc);
          break;

        case ESMF_ALARMLIST_PREVRINGING:
          // return alarm if it was ringing on the previous clock time step
          returnAlarm = (this->alarmList[i])->Alarm::wasPrevRinging(&rc);
          break;

        default :
          // unknown alarm list flag; return empty list
          char logMsg[2*ESMF_MAXSTR];
          sprintf(logMsg, "For clock %s, unknown alarm list flag %d.",
                  this->name, alarmlistflag);
          ESMC_LogDefault.Write(logMsg, ESMC_LOGMSG_WARN,ESMC_CONTEXT);
          return(ESMF_FAILURE);
      }

      // copy alarm pointers to be returned into given F90 array
      if (returnAlarm) {
        // count and report number of returned alarms
        if (alarmCount != ESMC_NULL_POINTER) (*alarmCount)++;

        if (alarmList1stElementPtr != ESMC_NULL_POINTER) {
          // copy if there's space in the given F90 array
          if (j < sizeofAlarmList) {
            // F90/C++ equivalent: AlarmList(j) = this->alarmList[i]
            //                 j = j + 1
            // calculate F90 array address for the j'th element ...
            char *f90ArrayElementJ;
            f90ArrayElementJ = alarmList1stElementPtr +
                                                (j++ * f90ArrayElementSize);
            // ... then copy it in!
            *((Alarm**)f90ArrayElementJ) = this->alarmList[i];
          } else {
            // list overflow!
            char logMsg[2*ESMF_MAXSTR];
            sprintf(logMsg, "For clock %s, "
                    "trying to return %dth requested alarm, but given "
                    "alarmList array can only hold %d.",
                    this->name, j+1, sizeofAlarmList);
            ESMC_LogDefault.Write(logMsg, ESMC_LOGMSG_WARN,ESMC_CONTEXT);
            rc = ESMF_FAILURE;
          }
        }
      }
    }
    return(rc);

 } // end Clock::getAlarmList

#if 0
//
// possible native C++ versions
//
//-------------------------------------------------------------------------
//BOP
// !IROUTINE:  Clock::getAlarmList - get a clock's alarm list
//
// !INTERFACE:
      int Clock::getAlarmList(
//
// !RETURN VALUE:
//    int error return code
//
// !ARGUMENTS:
      Alarm ***alarmList,            // out - alarm list
      int          *alarmCount) const {   // out - number of alarms in list
//
// !DESCRIPTION:
//     Get a clock's alarm list and number of alarms
//
//EOP
// !REQUIREMENTS:  TMG 4.3

    // validate inputs
    if (alarmList == ESMC_NULL_POINTER || alarmCount == ESMC_NULL_POINTER) {
      return(ESMF_FAILURE);
    }

    // copy the list of alarm pointers
    for(int i=0; i<this->alarmCount; i++) {
      (*alarmList)[i] = this->alarmList[i];  
    }

    // return number of alarms
    *alarmCount = this->alarmCount;

    return(ESMF_SUCCESS);

 } // end Clock::getAlarmList

//-------------------------------------------------------------------------
//BOP
// !IROUTINE:  Clock::getRingingAlarm - get ringing alarm from clock's alarm list
//
// !INTERFACE:
      int Clock::getRingingAlarm(
//
// !RETURN VALUE:
//    int error return code
//
// !ARGUMENTS:
      int          i,         // in  - the i'th alarm to get
      Alarm **alarm) {   // out - the i'th alarm
//
// !DESCRIPTION:
//     Retrieves the clock's i'th ringing alarm from the alarm list
//
//EOP
// !REQUIREMENTS:  TMG 4.1, 4.2

    // validate inputs
    if (i < 1 || i > alarmCount || alarm == ESMC_NULL_POINTER) {
      return(ESMF_FAILURE);
    }

    int rc;
    for (int j=0, r=0; j < alarmCount; j++) {
      if (alarmList[j]->Alarm::isRinging(&rc)) {
        if (++r == i) *alarm = alarmList[j];
        return(ESMF_SUCCESS);
      }
    }

    return(ESMF_FAILURE);

 } // end _Clock::getRingingAlarm

//-------------------------------------------------------------------------
//BOP
// !IROUTINE:  Clock::getAlarmList - get a clock's alarm list
//
// !INTERFACE:
      int Clock::getAlarmList(
//
// !RETURN VALUE:
//    int error return code
//
// !ARGUMENTS:
      Alarm **alarmList,            // out - alarm list
      int         *alarmCount) const {   // out - number of alarms in list
//
// !DESCRIPTION:
//     Get a clock's alarm list and number of alarms
//
//EOP
// !REQUIREMENTS:  TMG 4.3

    // validate inputs
    if (alarmList == ESMC_NULL_POINTER || alarmCount == ESMC_NULL_POINTER) {
      return(ESMF_FAILURE);
    }

    // copy the list of alarms
    for(int i=0; i<this->alarmCount; i++) {
      (*alarmList)[i] = *(this->alarmList[i]);  
    }

    // return number of alarms
    *alarmCount = this->alarmCount;

    return(ESMF_SUCCESS);

 } // end Clock::getAlarmList
#endif

//-------------------------------------------------------------------------
//BOP
// !IROUTINE:  Clock::syncToRealTime - synchronize a clock to the wall clock time
//
// !INTERFACE:
      int Clock::syncToRealTime(void) {
//
// !RETURN VALUE:
//    int error return code
//
// !ARGUMENTS:
//    none
//
// !DESCRIPTION:
//    Synchronize a clock to the wall clock time
//
//EOP
// !REQUIREMENTS:  TMG 3.4.5

 #undef  ESMC_METHOD
 #define ESMC_METHOD "ESMCI::Clock::syncToRealTime()"

    int rc = ESMF_SUCCESS;

    if (this == ESMC_NULL_POINTER) {
      ESMC_LogDefault.MsgFoundError(ESMC_RC_PTR_NULL,
         "; 'this' pointer is NULL.", ESMC_CONTEXT, &rc);
      return(rc);
    }

    // set current time to wall clock time
    // TODO:  ensure current time is within startTime and stopTime
    rc = currTime.Time::syncToRealTime();
    if (ESMC_LogDefault.MsgFoundError(rc, ESMCI_ERR_PASSTHRU, ESMC_CONTEXT,
      &rc))
      return(rc);
    return(Clock::validate());

 } // end Clock::syncToRealTime

//-------------------------------------------------------------------------
//BOP
// !IROUTINE:  Clock(=) - assignment operator
//
// !INTERFACE:
      Clock& Clock::operator=(
//
// !RETURN VALUE:
//    Clock& result
//
// !ARGUMENTS:
      const Clock &clock) {   // in - Clock to copy
//
// !DESCRIPTION:
//      Assign current object's (this) {\tt ESMC\_Clock} with given
//      {\tt ESMC\_Clock}.  
//EOP
// !REQUIREMENTS:  

    // check for self-assignment
    if (&clock != this) {

      // reallocate alarmList if not same size
      if (alarmListCapacity != clock.alarmListCapacity) {
        delete [] alarmList;
        try {
          alarmList = new ESMCI_AlarmPtr[clock.alarmListCapacity];
        }
        catch (...) {
          ESMC_LogDefault.AllocError(ESMC_CONTEXT,ESMC_NULL_POINTER);
          return(*this);  // TODO:  throw exception
        }
        alarmListCapacity = clock.alarmListCapacity;
      }
  
      // copy alarm list (array of pointers)
      //for(int i=0; i<clock.alarmCount; i++) {
      //  alarmList[i] = clock.alarmList[i];
      //}
      //alarmCount = clock.alarmCount;

      // don't copy alarm list values; an alarm can only be associated with
      // one clock
      alarmCount = 0;

      // copy all other members
      strcpy(name,           clock.name);
      timeStep             = clock.timeStep;
      startTime            = clock.startTime;
      stopTime             = clock.stopTime;
      refTime              = clock.refTime;
      currTime             = clock.currTime;
      prevTime             = clock.prevTime;
      repeat               = clock.repeat;
      repeatDuration       = clock.repeatDuration;
      repeatCount          = clock.repeatCount;
      advanceCount         = clock.advanceCount;
      direction            = clock.direction;
      userChangedDirection = clock.userChangedDirection;
      stopTimeEnabled      = clock.stopTimeEnabled;
      id                   = clock.id;

      
      // copy = true;   // TODO: Unique copy ? (id = ++count) (review operator==
                        //       and operator!=)  Must do same in assignment
                        //       overloaded method and interface from F90.
                        //       Also, inherit from ESMC_Base class.
                        //       See also copy constructor
    }

    return(*this);

}  // end Clock::operator=

//-------------------------------------------------------------------------
//BOP
// !IROUTINE:  Clock(==) - Clock equality comparison
// 
// !INTERFACE:
      bool Clock::operator==(
//   
// !RETURN VALUE:
//    bool result
//
// !ARGUMENTS:
      const Clock &clock) const {   // in - Clock to compare
//
// !DESCRIPTION:
//      Compare for equality the current object's (this) {\tt ESMC\_Clock} with
//      given {\tt ESMC\_Clock}, return result.  Comparison is based on IDs.
//   
//EOP
// !REQUIREMENTS:

 #undef  ESMC_METHOD
 #define ESMC_METHOD "ESMCI::Clock::operator==()"

    if (this == ESMC_NULL_POINTER) {
      ESMC_LogDefault.MsgFoundError(ESMC_RC_PTR_NULL,
         "; 'this' pointer is NULL.", ESMC_CONTEXT, ESMC_NULL_POINTER);
      return(false);
    }

    return(id == clock.id);

}  // end Clock::operator==

//-------------------------------------------------------------------------
//BOP
// !IROUTINE:  Clock(!=) - Clock inequality comparison
// 
// !INTERFACE:
      bool Clock::operator!=(
//   
// !RETURN VALUE:
//    bool result
//
// !ARGUMENTS:
      const Clock &clock) const {   // in - Clock to compare
//
// !DESCRIPTION:
//      Compare for inequality the current object's (this)
//      {\tt ESMC\_Clock} with given {\tt ESMC\_Clock}, return result.
//      Comparison is based on IDs.
//   
//EOP
// !REQUIREMENTS:

 #undef  ESMC_METHOD
 #define ESMC_METHOD "ESMCI::Clock::operator!=()"

    if (this == ESMC_NULL_POINTER) {
      ESMC_LogDefault.MsgFoundError(ESMC_RC_PTR_NULL,
         "; 'this' pointer is NULL.", ESMC_CONTEXT, ESMC_NULL_POINTER);
      return(false);
    }

    return(id != clock.id);

}  // end Clock::operator!=

//-------------------------------------------------------------------------
//BOP
// !IROUTINE:  ESMCI_ClockReadRestart - restore contents of a Clock
//
// !INTERFACE:
      Clock *ESMCI_ClockReadRestart(
//
// !RETURN VALUE:
//    pointer to newly allocated and restored Clock
//
// !ARGUMENTS:
      int          nameLen,  // in
      const char  *name,     // in
      int         *rc ) {    // out - return code

//
// !DESCRIPTION:
//      Restore information about an {\tt ESMC\_Clock}.
//      For persistence/checkpointing.
// 
//EOP
// !REQUIREMENTS:  SSSn.n, GGGn.n

 #undef  ESMC_METHOD
 #define ESMC_METHOD "ESMCI_ClockReadRestart()"

    // Initialize return code
    if (rc != ESMC_NULL_POINTER) *rc = ESMC_RC_NOT_IMPL;

    // TODO:  read clock state from name, then allocate/restore
    //        (share code with ESMCI_ClockCreate()).

    return(ESMC_NULL_POINTER);

 } // end ESMCI_ClockReadRestart

//-------------------------------------------------------------------------
//BOP
// !IROUTINE:  Clock::writeRestart - save contents of a Clock
//
// !INTERFACE:
      int Clock::writeRestart(void) const {
//
// !RETURN VALUE:
//    int error return code
//
// !ARGUMENTS:
//    none
//
// !DESCRIPTION:
//      Save information about an {\tt ESMC\_Clock}.
//      For persistence/checkpointing
//
//EOP
// !REQUIREMENTS:  SSSn.n, GGGn.n

 #undef  ESMC_METHOD
 #define ESMC_METHOD "ESMCI::Clock::writeRestart()"

    int rc = ESMF_SUCCESS;

    if (this == ESMC_NULL_POINTER) {
      ESMC_LogDefault.MsgFoundError(ESMC_RC_PTR_NULL,
         "; 'this' pointer is NULL.", ESMC_CONTEXT, &rc);
      return(rc);
    }

    // TODO:  save clock state using name.  Default to disk file.

    return(ESMF_SUCCESS);

 } // end Clock::writeRestart

//-------------------------------------------------------------------------
//BOP
// !IROUTINE:  Clock::validate - internal consistency check for a Clock
//
// !INTERFACE:
      int Clock::validate(
//
// !RETURN VALUE:
//    int error return code
//
// !ARGUMENTS:
      const char *options) const {    // in - validate options
//
// !DESCRIPTION:
//      Validates that a {\tt ESMC\_Clock} is internally consistent.
//      Returns error code if problems are found.  {\tt ESMC\_Base}
//      class method.
//
//EOP
// !REQUIREMENTS:  XXXn.n, YYYn.n

 #undef  ESMC_METHOD
 #define ESMC_METHOD "ESMCI::Clock::validate()"

    int rc = ESMF_SUCCESS;

    if (this == ESMC_NULL_POINTER) {
      ESMC_LogDefault.MsgFoundError(ESMC_RC_PTR_NULL,
         "; 'this' pointer is NULL.", ESMC_CONTEXT, &rc);
      return(rc);
    }

    // validate required individual properties
    if(ESMC_LogDefault.MsgFoundError(timeStep.TimeInterval::validate(),
        "timeStep.TimeInterval::validate() failed", ESMC_CONTEXT, &rc) ||
       ESMC_LogDefault.MsgFoundError(startTime.Time::validate(),
        "startTime.Time::validate() failed", ESMC_CONTEXT, &rc) ||
       ESMC_LogDefault.MsgFoundError(refTime.Time::validate(),
        "refTime.Time::validate() failed", ESMC_CONTEXT, &rc)   ||
       ESMC_LogDefault.MsgFoundError(currTime.Time::validate(),
        "currTime.Time::validate() failed", ESMC_CONTEXT, &rc)  ||
       ESMC_LogDefault.MsgFoundError(prevTime.Time::validate(),
        "prevTime.Time::validate() failed", ESMC_CONTEXT, &rc)) {
       return(rc);
    }

    if (direction != ESMF_DIRECTION_FORWARD && 
        direction != ESMF_DIRECTION_REVERSE) {
      char logMsg[2*ESMF_MAXSTR];
      sprintf(logMsg, "direction property %d is not ESMF_DIRECTION_FORWARD or "
              "ESMF_DIRECTION_REVERSE", direction);
      ESMC_LogDefault.Write(logMsg, ESMC_LOGMSG_WARN,ESMC_CONTEXT);
      return(ESMF_FAILURE);
    }

    // validate optional stopTime property if set
    if (stopTimeEnabled) {
      if(ESMC_LogDefault.MsgFoundError(stopTime.Time::validate(),
         "stopTime.Time::validate() failed", ESMC_CONTEXT, 
                                     &rc)) return(rc);

//  The following fixes bugs 801366, 801409, & 806784

      // startTime and stopTime calendars should generally be the same.
      //   (Conceptually could be different, if based on same zero-point).
      //   So only produce ESMC_LOGMSG_WARN,ESMC_CONTEXT if different.
      //   (TODO: check only if stopTime set)
      // TODO: use native C++ Get, not F90 entry point, when ready
      Calendar *startCal, *stopCal;
      int rc = startTime.Time::get((ESMC_I4 *)ESMC_NULL_POINTER, 
                          ESMC_NULL_POINTER, ESMC_NULL_POINTER,
                          ESMC_NULL_POINTER, ESMC_NULL_POINTER,
                          ESMC_NULL_POINTER, ESMC_NULL_POINTER,
                          ESMC_NULL_POINTER, ESMC_NULL_POINTER,
                          ESMC_NULL_POINTER, ESMC_NULL_POINTER,
                          ESMC_NULL_POINTER, ESMC_NULL_POINTER,
                          ESMC_NULL_POINTER, ESMC_NULL_POINTER,
                          ESMC_NULL_POINTER, ESMC_NULL_POINTER,
                          ESMC_NULL_POINTER, ESMC_NULL_POINTER,
                          ESMC_NULL_POINTER, ESMC_NULL_POINTER,
                          ESMC_NULL_POINTER, ESMC_NULL_POINTER,
                          ESMC_NULL_POINTER, &startCal);

      if(ESMC_LogDefault.MsgFoundError(rc,
         "startTime.Time::get(...startCal) failed.", 
          ESMC_CONTEXT, &rc)) {
        return(rc);   
      }

      rc = stopTime.Time::get((ESMC_I4 *)ESMC_NULL_POINTER, 
                          ESMC_NULL_POINTER, ESMC_NULL_POINTER,
                          ESMC_NULL_POINTER, ESMC_NULL_POINTER,
                          ESMC_NULL_POINTER, ESMC_NULL_POINTER,
                          ESMC_NULL_POINTER, ESMC_NULL_POINTER,
                          ESMC_NULL_POINTER, ESMC_NULL_POINTER,
                          ESMC_NULL_POINTER, ESMC_NULL_POINTER,
                          ESMC_NULL_POINTER, ESMC_NULL_POINTER,
                          ESMC_NULL_POINTER, ESMC_NULL_POINTER,
                          ESMC_NULL_POINTER, ESMC_NULL_POINTER,
                          ESMC_NULL_POINTER, ESMC_NULL_POINTER,
                          ESMC_NULL_POINTER, ESMC_NULL_POINTER,
                          ESMC_NULL_POINTER, &stopCal);

      if(ESMC_LogDefault.MsgFoundError(rc,
         "stopTime.Time::get(...stopCal) failed.", 
          ESMC_CONTEXT, &rc)) {
        return(rc);   
      }

      if (startCal == ESMC_NULL_POINTER || stopCal == ESMC_NULL_POINTER) {
        ESMC_LogDefault.Write("startCal or stopCal is NULL.",
                                      ESMC_LOGMSG_WARN,ESMC_CONTEXT);
        return(ESMF_FAILURE);
      }

      if (*startCal != *stopCal) {
        ESMC_LogDefault.Write("startCal not equal to stopCal.",
                                      ESMC_LOGMSG_WARN,ESMC_CONTEXT);
        return(ESMC_RC_OBJ_BAD); 
      }

      TimeInterval zeroTimeStep(0,0,1,0,0,0);

      // The following checks only produce ESMC_LOGMSG_WARN,ESMC_CONTEXT because
      // the user may want or need to do these things.

      // check if current time is out-of-range
      if (stopTime > startTime) {
        if (currTime < startTime || currTime > stopTime) {
          ESMC_LogDefault.Write("currTime out-of-range (startTime to "
                                        "stopTime).", ESMC_LOGMSG_WARN,ESMC_CONTEXT);
          return(ESMC_RC_VAL_OUTOFRANGE);
        }
        if (currTime == startTime && timeStep < zeroTimeStep) {
          ESMC_LogDefault.Write("timeStep negative for positive "
                                        "startTime to stopTime range).",
                                        ESMC_LOGMSG_WARN,ESMC_CONTEXT);
          return(ESMC_RC_VAL_OUTOFRANGE);
        }
      } else if (stopTime < startTime) {
        if (currTime > startTime || currTime < stopTime) {
          ESMC_LogDefault.Write("currTime out-of-range (startTime to "
                                        "stopTime).", ESMC_LOGMSG_WARN,ESMC_CONTEXT);
          return(ESMC_RC_VAL_OUTOFRANGE);
        }
        if (currTime == startTime && timeStep > zeroTimeStep) {
          ESMC_LogDefault.Write("timeStep positive for negative "
                                        "startTime to stopTime range).",
                                        ESMC_LOGMSG_WARN,ESMC_CONTEXT);
          return(ESMC_RC_VAL_OUTOFRANGE);
        }
      } else { // stopTime == startTime
        ESMC_LogDefault.Write("stopTime equals startTime.",
                                      ESMC_LOGMSG_WARN,ESMC_CONTEXT);
        return(ESMC_RC_VAL_WRONG);
      }

      // check for zero time step
      if(timeStep == zeroTimeStep) {
        ESMC_LogDefault.Write("timeStep equals zero.", ESMC_LOGMSG_WARN,ESMC_CONTEXT);
        return(ESMC_RC_VAL_WRONG);
      }

      // note:  don't check prevTime relative to currTime, as user could
      //        change direction with a variable time step.  Also, prevTime
      //        is exclusively maintained internally.

    } // endif stopTimeEnabled


    return(ESMF_SUCCESS);

 } // end Clock::validate

//-------------------------------------------------------------------------
//BOP
// !IROUTINE:  Clock::print - print contents of a Clock
//
// !INTERFACE:
      int Clock::print(
//
// !RETURN VALUE:
//    int error return code
//
// !ARGUMENTS:
      const char *options) const {    // in - print options
//
// !DESCRIPTION:
//      Prints a {\tt ESMC\_Clock}'s contents for testing/debugging
//
//EOP
// !REQUIREMENTS:  XXXn.n, YYYn.n

 #undef  ESMC_METHOD
 #define ESMC_METHOD "ESMCI::Clock::print()"

    int rc = ESMF_SUCCESS;

    if (this == ESMC_NULL_POINTER) {
      ESMC_LogDefault.MsgFoundError(ESMC_RC_PTR_NULL,
         "; 'this' pointer is NULL.", ESMC_CONTEXT, &rc);
      return(rc);
    }

    printf("Clock ----------------------------------\n");

    // print out individually selected components
    // TODO: enable multiple simultaneous options (token parsing)
    //       (currently mutually exclusive)
    if (options != ESMC_NULL_POINTER) {

      // make options case insensitive
      // TODO: put this into function to share
      char opts[2*ESMF_MAXSTR];
      int i;
      for(i=0; i<strlen(options) && i<ESMF_MAXSTR-1; i++) {
        opts[i] = tolower(options[i]);
      }
      opts[i] = '\0';

      if (strncmp(opts, "name", 4) == 0) {
        printf("name = %s\n", name);
      }
      else if (strncmp(opts, "timestep", 8) == 0) {
        printf("timeStep = \n");
        // TODO:  timeStep.TimeInterval::print(&opts(8)); ?
        if (strstr(opts, "string") != ESMC_NULL_POINTER) {
          timeStep.TimeInterval::print("string");
        } else {
          timeStep.TimeInterval::print();
        }
      }
      else if (strncmp(opts, "starttime", 9) == 0) {
        printf("startTime = \n");
        if (strstr(opts, "string") != ESMC_NULL_POINTER) {
          startTime.Time::print("string");
        } else {
          startTime.Time::print();
        }
      }
      else if (strncmp(opts, "stoptimeenabled", 15) == 0) {
        printf("stopTimeEnabled = %s\n", stopTimeEnabled ? "true" : "false");
      }
      else if (strncmp(opts, "stoptime", 8) == 0) {
        printf("stopTime = \n");
        if (strstr(opts, "string") != ESMC_NULL_POINTER) {
          stopTime.Time::print("string");
        } else {
          stopTime.Time::print();
        }
      }
      else if (strncmp(opts, "reftime", 7) == 0) {
        printf("refTime = \n");
        if (strstr(opts, "string") != ESMC_NULL_POINTER) {
          refTime.Time::print("string");
        } else {
          refTime.Time::print();
        }
      }
      else if (strncmp(opts, "currtime", 8) == 0) {
        printf("currTime = \n");
        if (strstr(opts, "string") != ESMC_NULL_POINTER) {
          currTime.Time::print("string");
        } else {
          currTime.Time::print();
        }
      }
      else if (strncmp(opts, "prevtime", 8) == 0) {
        printf("prevTime = \n");
        if (strstr(opts, "string") != ESMC_NULL_POINTER) {
          prevTime.Time::print("string");
        } else {
          prevTime.Time::print();
        }
      }
      else if (strncmp(opts, "advancecount", 12) == 0) {
        printf("advanceCount = %lld\n", advanceCount);
      }
      else if (strncmp(opts, "direction", 9) == 0) {
        printf("direction = %d\n", direction);
      }
      else if (strncmp(opts, "userchangeddirection", 20) == 0) {
        printf("direction = %d\n", direction);
      }
      else if (strncmp(opts, "alarmcount", 10) == 0) {
        printf("alarmCount = %d\n", alarmCount);
      }
      else if (strncmp(opts, "alarmlist", 9) == 0) {
        printf("alarmList = \n");
        for (int i=0; i<alarmCount; i++) {
          alarmList[i]->Alarm::print(&opts[9]);
        }
      }


    }

    if (options == ESMC_NULL_POINTER || strncmp(options, "string", 6) == 0) {

      // default:  print out all properties

      printf("name = %s\n", name);
      printf("timeStep = \n");  timeStep.TimeInterval::print(options);
      printf("startTime = \n"); startTime.Time::print(options);
      printf("stopTime = \n");  stopTime.Time::print(options);
      printf("stopTimeEnabled = %s\n", stopTimeEnabled ? "true" : "false");
      printf("refTime = \n");   refTime.Time::print(options);
      printf("currTime = \n");  currTime.Time::print(options);
      printf("prevTime = \n");  prevTime.Time::print(options);
      printf("advanceCount = %lld\n", advanceCount);
      printf("direction = %d\n", direction);
      printf("userChangedDirection = %s\n",
                                     userChangedDirection ? "true" : "false");
      printf("alarmCount = %d\n", alarmCount);
      printf("alarmList = \n");
      for (int i=0; i<alarmCount; i++) {
        alarmList[i]->Alarm::print(options);
      }
    }

    printf("end Clock ------------------------------\n\n");

    return(ESMF_SUCCESS);

 } // end Clock::print

//-------------------------------------------------------------------------
//BOP
// !IROUTINE:  Clock - native C++ constructor
//
// !INTERFACE:
      Clock::Clock(void) {
//
// !RETURN VALUE:
//    none
//
// !ARGUMENTS:
//    none
//
// !DESCRIPTION:
//      Initializes for either C++ or F90, since {\tt ESMC\_Clock} is a deep,
//      dynamically allocated class.
//
//EOP
// !REQUIREMENTS:  SSSn.n, GGGn.n

 #undef  ESMC_METHOD
 #define ESMC_METHOD "ESMCI::Clock() native constructor"

    // allocate the clock's alarm list (array of pointers)
    try {
      alarmList = new ESMCI_AlarmPtr[ESMF_ALARM_BLOCK_SIZE];
    }
    catch (...) {
      ESMC_LogDefault.AllocError(ESMC_CONTEXT,ESMC_NULL_POINTER);
      return;
    }
    alarmCount = 0;
    alarmListCapacity = ESMF_ALARM_BLOCK_SIZE;

    name[0] = '\0';
    advanceCount = 0;
    direction = ESMF_DIRECTION_FORWARD;
    userChangedDirection = false;
    stopTimeEnabled = false;
    id = ++count;  // TODO: inherit from ESMC_Base class
    repeat               = false;
    repeatDuration       = (TimeInterval)0;
    repeatCount          = 0;
    
    // copy = false;  // TODO: see notes in constructors and destructor below

 } // end Clock

//-------------------------------------------------------------------------
//BOP
// !IROUTINE:  Clock - native C++ copy constructor
//
// !INTERFACE:
      Clock::Clock(
//
// !RETURN VALUE:
//    none
//
// !ARGUMENTS:
      const Clock &clock) {  // in - clock to copy
//
// !DESCRIPTION:
//      Copies members of given clock.
//
//EOP
// !REQUIREMENTS:  SSSn.n, GGGn.n

 #undef  ESMC_METHOD
 #define ESMC_METHOD "ESMCI::Clock() copy constructor"

    // allocate the new clock's own alarm list (array of pointers)
    try {
      alarmList = new ESMCI_AlarmPtr[clock.alarmListCapacity];
    }
    catch (...) {
      ESMC_LogDefault.AllocError(ESMC_CONTEXT,ESMC_NULL_POINTER);
      return;
    }
    alarmListCapacity = clock.alarmListCapacity;

    // memberwise copy (invokes overloaded assignment operator=)
    *this = clock;

    // copy = true;   // TODO: Unique copy ? (id = ++count) (review operator==
                      //       and operator!=)  Must do same in assignment
                      //       overloaded method and interface from F90.
                      //       Also, inherit from ESMC_Base class.
                      //       See also overloaded assignment operator=

 } // end Clock

//-------------------------------------------------------------------------
//BOP
// !IROUTINE:  ~Clock - native C++ destructor
//
// !INTERFACE:
      Clock::~Clock(void) {
//
// !RETURN VALUE:
//    none
//
// !ARGUMENTS:
//    none
//
// !DESCRIPTION:
//      Calls standard ESMF deep or shallow methods for destruction
//
//EOP
// !REQUIREMENTS:  SSSn.n, GGGn.n

  delete [] alarmList;

  // TODO: Decrement static count for one less object; but don't decrement   //       for copies.  Must create and set a copy flag property to detect.
  //       Also must set copy flag in copy constructor and overloaded
  //       assignment method, and provide interface from F90.
  // if (!copy) count--;

 } // end ~Clock

//-------------------------------------------------------------------------
// Private methods
//-------------------------------------------------------------------------

//-------------------------------------------------------------------------
//BOP
// !IROUTINE:  Clock::addAlarm - add alarm to clock's alarm list
//
// !INTERFACE:
      int Clock::addAlarm(
//
// !RETURN VALUE:
//    int error return code
//
// !ARGUMENTS:
      Alarm *alarm) {   // in - alarm to add
//
// !DESCRIPTION:
//     Adds given alarm to a clock's alarm list. 
//     Used by {\tt ESMC\_AlarmCreate().}
//
//EOP
// !REQUIREMENTS:  TMG 4.1, 4.2

 #undef  ESMC_METHOD
 #define ESMC_METHOD "ESMCI::Clock::addAlarm()"

    int rc = ESMF_SUCCESS;

    // validate inputs

    if (this == ESMC_NULL_POINTER) {
      ESMC_LogDefault.MsgFoundError(ESMC_RC_PTR_NULL,
         "; 'this' pointer is NULL.", ESMC_CONTEXT, &rc);
      return(rc);
    }

    if (alarm == ESMC_NULL_POINTER) {
      char logMsg[2*ESMF_MAXSTR];
      sprintf(logMsg, "For clock %s, given alarm is NULL.", this->name);
      ESMC_LogDefault.Write(logMsg, ESMC_LOGMSG_WARN,ESMC_CONTEXT);
      return(ESMF_FAILURE);
    }

    // if alarm list full, re-allocate it
    if (alarmCount == alarmListCapacity) {
      char logMsg[2*ESMF_MAXSTR];
      sprintf(logMsg, "For clock %s, alarm list is full (%d alarms), "
              "re-allocating to hold %d alarms.",
                this->name, alarmListCapacity, 
                alarmListCapacity+ESMF_ALARM_BLOCK_SIZE);
      ESMC_LogDefault.Write(logMsg, ESMC_LOGMSG_INFO,ESMC_CONTEXT);

      // re-allocate clock's alarm list to next block size
      Alarm **tempList;
      try {
        tempList = new ESMCI_AlarmPtr[alarmListCapacity + ESMF_ALARM_BLOCK_SIZE];
      }
      catch (...) {
        ESMC_LogDefault.AllocError(ESMC_CONTEXT,&rc);
        return(rc);
      }

      // copy alarm list to re-allocated array
      for(int i=0; i<alarmCount; i++) {
        tempList[i] = alarmList[i];
      }

      // deallocate the old alarmList and reset to the new one
      delete [] alarmList;
      alarmList = tempList;
      alarmListCapacity += ESMF_ALARM_BLOCK_SIZE;
    }

    // append given alarm to list and count it
    alarmList[alarmCount++] = alarm;

    // check new alarm to see if it's time to ring
    alarm->Alarm::checkRingTime(&rc);

    return(rc);

 } // end Clock::addAlarm

//-------------------------------------------------------------------------
//BOP
// !IROUTINE:  Clock::removeAlarm - remove alarm from clock's alarm list
//
// !INTERFACE:
      int Clock::removeAlarm(
//
// !RETURN VALUE:
//    int error return code
//
// !ARGUMENTS:
      Alarm *alarm) {   // in - alarm to remove
//
// !DESCRIPTION:
//     Adds given alarm to a clock's alarm list. 
//     Used by {\tt ESMC\_AlarmCreate().}
//
//EOP
// !REQUIREMENTS:  TMG xx.x

 #undef  ESMC_METHOD
 #define ESMC_METHOD "ESMCI::Clock::removeAlarm()"

    int rc = ESMF_SUCCESS;

    // validate inputs

    if (this == ESMC_NULL_POINTER) {
      ESMC_LogDefault.MsgFoundError(ESMC_RC_PTR_NULL,
         "; 'this' pointer is NULL.", ESMC_CONTEXT, &rc);
      return(rc);
    }

    if (alarm == ESMC_NULL_POINTER) {
      char logMsg[2*ESMF_MAXSTR];
      sprintf(logMsg, "For clock %s, given alarm is NULL.", this->name);
      ESMC_LogDefault.Write(logMsg, ESMC_LOGMSG_WARN, ESMC_CONTEXT);
      return(ESMF_FAILURE);
    }

    // TODO: replace alarmList with C++ STL container
    // linear search for given alarm in list
    for(int i=0; i<alarmCount; i++) {
      if (alarmList[i] == alarm) {
        // remove alarm by left shifting remainder of list ...
        for(int j=i; j<alarmCount-1; j++) {
          alarmList[j] = alarmList[j+1];
        }
        // ... and nullifying end of list
        alarmList[alarmCount-1] = ESMC_NULL_POINTER; 
        alarmCount--;
        return(rc);
      }
    }

    // given alarm not found in list
    char logMsg[2*ESMF_MAXSTR];
    sprintf(logMsg, "For clock %s, given alarm is not in clock's alarmList.",
            this->name);
    ESMC_LogDefault.Write(logMsg, ESMC_LOGMSG_WARN, ESMC_CONTEXT);
    return(ESMF_FAILURE);

 } // end Clock::removeAlarm

}  // namespace ESMCI
