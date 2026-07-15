       IDENTIFICATION DIVISION.
       PROGRAM-ID. CMPNCMP.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-TS5FTARF-NAME         PIC X(08) VALUE 'TS5FTARF'.
       01  WS-TS5FTAR1-NAME.
           05 WS-TS5FTAR1-NAME-PFX  PIC X(04) VALUE 'TS5F'.
           05 WS-TS5FTAR1-NAME-TSKID PIC X(04) VALUE SPACES.
       01  WS-EIBTASKN              PIC X(07) VALUE '0001234'.
       01  WS-STATUS                PIC S9(9) COMP VALUE 0.

       PROCEDURE DIVISION.
       0-MAIN.
      *    Noncompliant: WS-STATUS is not tested before the MOVE
           EXEC CICS DELETEQ TS
                QNAME(WS-TS5FTARF-NAME)
                RESP(WS-STATUS)
           END-EXEC.
           MOVE WS-EIBTASKN (4:4) TO WS-TS5FTAR1-NAME-TSKID.

      *    Compliant: WS-STATUS is tested before the MOVE
           EXEC CICS DELETEQ TS
                QNAME(WS-TS5FTARF-NAME)
                RESP(WS-STATUS)
           END-EXEC.
           IF WS-STATUS = DFHRESP(NORMAL)
               MOVE WS-EIBTASKN (4:4) TO WS-TS5FTAR1-NAME-TSKID
           ELSE
               DISPLAY 'DELETEQ FAILED WITH RESP: ' WS-STATUS
           END-IF.

           GOBACK.

       END PROGRAM CMPNCMP.
