CLASS zcl_00_stat_prior DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_00_stat_prior IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    delete from ztstatus_inf.
    modify ztstatus_inf from table @( value #( ( client = '100'
                                    status_code = 'PE'
                                    status_description = 'Pending' )
                                    ( client = '100'
                                    status_code = 'CO'
                                    status_description = 'Completed' )
                                     ) ).

*****  priority
    delete from ztpriority_inf.
    modify ztpriority_inf from table @( value #( ( client = '100'
                                    priority_code = 'A'
                                    priority_description = 'High' )
                                    ( client = '100'
                                   priority_code = 'B'
                                    priority_description = 'Low' )
                                     ) ).

  ENDMETHOD.

ENDCLASS.
