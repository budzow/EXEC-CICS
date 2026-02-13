       IDENTIFICATION DIVISION.
       PROGRAM-ID. EXECRESP.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-QUEUE-NAME            PIC X(08) VALUE 'MYQUEUE '.
       01  WS-QUEUE-DATA            PIC X(20) VALUE 'SAMPLE DATA'.
       01  WS-QUEUE-LEN             PIC S9(4) COMP VALUE 20.
       01  WS-STATUS                PIC S9(9) COMP VALUE 0.

       PROCEDURE DIVISION.
       0-MAIN.
      *    Example 1: RESP - response code checked
           EXEC CICS WRITEQ TS
                QUEUE(WS-QUEUE-NAME)
                FROM(WS-QUEUE-DATA)
                LENGTH(WS-QUEUE-LEN)
                RESP(WS-STATUS)
           END-EXEC
           IF WS-STATUS = DFHRESP(NORMAL)
               DISPLAY 'WRITEQ COMPLETED SUCCESSFULLY'
           ELSE
               DISPLAY 'WRITEQ FAILED WITH RESP: ' WS-STATUS
           END-IF

      *    Example 2: NOHANDLE - EIBRESP checked
           EXEC CICS READQ TS
                QUEUE(WS-QUEUE-NAME)
                INTO(WS-QUEUE-DATA)
                LENGTH(WS-QUEUE-LEN)
                NOHANDLE
           END-EXEC
           IF EIBRESP = DFHRESP(NORMAL)
               DISPLAY 'READQ COMPLETED SUCCESSFULLY'
           ELSE
               DISPLAY 'READQ FAILED WITH EIBRESP: ' EIBRESP
           END-IF

           GOBACK.

       END PROGRAM EXECRESP.
