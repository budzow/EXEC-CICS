       IDENTIFICATION DIVISION.
       PROGRAM-ID. EXECTHRE.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-QUEUE-NAME            PIC X(08) VALUE 'MYQUEUE '.
       01  WS-QUEUE-DATA            PIC X(20) VALUE 'SAMPLE DATA'.
       01  WS-QUEUE-LEN             PIC S9(4) COMP VALUE 20.
       01  WS-ITEM-NUM              PIC S9(4) COMP VALUE 1.       
       01  WS-STATUS                PIC S9(9) COMP VALUE 0.
       01  WSC-STR-FINAL            PIC X(30) VALUE 'FINAL PROCESSING'.

       PROCEDURE DIVISION.
       0-MAIN.


           EXEC CICS READQ TS
                QUEUE(WS-QUEUE-NAME)
                INTO(WS-QUEUE-DATA)
                LENGTH(WS-QUEUE-LEN)
                ITEM(WS-ITEM-NUM)
                RESP(WS-STATUS)
           END-EXEC

           DISPLAY WSC-STR-FINAL. *> Secondary location would point here
                                       *> but in this case it is quite obvious


           EXEC CICS WRITEQ TS
                QUEUE(WS-QUEUE-NAME)
                FROM(WS-QUEUE-DATA)
                LENGTH(WS-QUEUE-LEN)
                RESP(WS-STATUS)
           END-EXEC
           PERFORM FIRST-PARAGRAPH


           GOBACK.

       FIRST-PARAGRAPH.
           PERFORM SECOND-PARAGRAPH.

       SECOND-PARAGRAPH.
           PERFORM THIRD-PARAGRAPH.

       THIRD-PARAGRAPH.
           DISPLAY WSC-STR-FINAL.  *> Secondary location would point here without 
                                       *> showing the 'intermediate' paragraphs
                                       *> which could be a bit confusing

       END PROGRAM EXECTHRE. 
