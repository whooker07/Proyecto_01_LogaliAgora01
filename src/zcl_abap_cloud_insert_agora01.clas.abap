CLASS zcl_abap_cloud_insert_agora01 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_abap_cloud_insert_agora01 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA ls_status TYPE ztstatus_inf.
    DATA ls_priority TYPE ztpriority_inf.
    DATA ls_customer TYPE ztcustomer_inf.
      DATA ls_technician TYPE zttechnician_inf.

*    ls_status = VALUE #( status_code = 'PO'
*                         status_description = 'Pending' ).

*    ls_status = VALUE #( status_code = 'CO'
*                         status_description = 'Completed' ).
*    INSERT  ztstatus_inf FROM @ls_status.

*    ls_priority = VALUE #( priority_code = 'A'
*                         priority_description = 'High' ).

*    ls_priority = VALUE #( priority_code = 'B'
*                         priority_description = 'Low' ).
*    INSERT  ztpriority_inf FROM @ls_priority.

*    ls_customer = VALUE #( customer_id = '1'
*                         name = 'Pablo'
*                         address = 'cr 85 2 34'
*                         phone = '345-3344' ).
*    INSERT  ztcustomer_inf FROM @ls_customer.

    ls_technician = VALUE #( technician_id = '1'
                         name = 'Carlos'
                         speciality = 'programmer' ).
    INSERT  zttechnician_inf FROM @ls_technician.

    IF sy-subrc = 0.
      out->write( ' record inserted correctly' ).
    ELSE.
    ENDIF.




  ENDMETHOD.

ENDCLASS.
