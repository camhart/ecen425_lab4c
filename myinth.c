#include "clib.h"
#include "yakk.h"

extern int KeyBuffer;

void resetHandler() {
       exit(0);
}

void keyHandler() {
    char key = (char) KeyBuffer;
    int c = 0;
    if(key == 'd') {
        printString("\nDELAY KEY PRESSED\n");
        while (c < 5000)
            c++;
        printString("\nDELAY COMPLETE\n");

    } else {
        printString("\nKEYPRESS (");
        printChar(key);
        printString(") IGNORED\n");
    }
}

void tickHandler() {
    YKTickNum++;
    printString("\nTICK ");
    printInt(YKTickNum);
    printNewLine();
}
