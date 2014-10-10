#define null 0


typedef enum {
	DELAYED, BLOCKED, RUNNING, READY
} State;

typedef struct {
	int count;
} YKSEM;

typedef struct {
	int something;
} YKQ;

typedef struct {
	int something;
} YKEVENT;

typedef struct TCB {
	unsigned short int context[3];//SS, SP, CS register will be saved here.
	State state;// an enumerated type. blocked, delayed, ready
	struct TCB * previous; //used when inserting and removing from queue (our queue will be a double linked list)
	struct TCB * next; // same as above
	unsigned delay; //How much time to delay
	unsigned char priority; //priority value of the current task
	void (* taskFunction)(void);
	unsigned char runCount;
} TCB;


void saveAndRestoreContext(void);
void saveAndFirstRestoreContext(void);
void restoreContext(void);
void YKInitialize(void);
void YKEnterMutex(void);
void YKExitMutex(void);
void YKIdleTask(void);
void YKNewTask(void (* task)(void), void *taskStack, unsigned char priority);
void YKRun(void);
void YKDelayTask(unsigned count);
void YKEnterISR(void);
void YKExitISR(void);
void YKScheduler(void);
void YKDispatcher(int);
YKSEM* YKSemCreate(int initialValue);
void YKSemPend(YKSEM *semaphore);
void YKSemPost(YKSEM *semaphore);
YKQ *YKQCreate(void **start, unsigned size);
void *YKQPend(YKQ *queue);
int YKQPost(YKQ *queue, void *msg);
YKEVENT *YKEventCreate(unsigned initialValue);
unsigned YKEventPend(YKEVENT *event, unsigned eventMask, int waitMode); 
void YKEventSet(YKEVENT *event, unsigned eventMask);
void YKEventReset(YKEVENT *event, unsigned eventMask);

#ifndef VAR
#define VAR 1
extern unsigned YKCtxSwCount; //Type: unsigned int This is an unsigned int that must be incremented each time a context switch occurs, defined as the dispatching of a task other than the task that ran most recently.

extern unsigned YKIdleCount; // Type: unsigned int This is an unsigned int that must be incremented by the idle task in its while(1) loop. If desired, the user code can use this value to determine CPU utilization. See the section on YKIdleTask, above, to see how to prevent overflow of YKIdleCount.

extern unsigned YKTickNum; //Type: unsigned int This is an unsigned int that must be incremented each time the kernel's tick handler runs.
#endif
