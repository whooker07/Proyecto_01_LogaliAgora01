CLASS zcl_wo_crud_test_agora01 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_wo_crud_test_agora01 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA: lv_message TYPE string,
          lv_valid   TYPE abap_bool.

    DATA(lo_instance) = NEW zcl_wo_crud_handler_agora01( ).

    " Llamar al método de instancia

    lo_instance->create_work_order( EXPORTING  iv_work_order_id = 2
                                      iv_customer_id  = '1'
                                      iv_technician_id = '1'
                                      iv_priority = 'A'
                                      iv_status = 'PE'
                                      iv_description = 'insertando wo prueba'
                                      iv_creation_date = '20250308'
                                      IMPORTING
                                      rv_valid = lv_valid
                                      rv_message = lv_message ).



out->write( | { lv_message } | ).

  ENDMETHOD.

ENDCLASS.
