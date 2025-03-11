CLASS zcl_wo_crud_test_agora01 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
    METHODS:
      test_create_work_order
        EXPORTING rv_valid   TYPE abap_bool
                  rv_message TYPE string,
      test_read_work_order
        EXPORTING rv_valid        TYPE abap_bool
                  rv_message      TYPE string
                  rv_ls_workorder TYPE ztwork_order,
      test_delete_work_order
        EXPORTING rv_valid   TYPE abap_bool
                  rv_message TYPE string,
      test_update_work_order
        EXPORTING rv_valid   TYPE abap_bool
                  rv_message TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_wo_crud_test_agora01 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA: lv_message TYPE string,
          lv_valid   TYPE abap_bool,
          lv_test    TYPE c.  "1-create, 2-read, 3-update, 4-delete

    DATA ls_workorder TYPE ztwork_order.

*  test crud
    lv_test = '3'.

    CASE lv_test.
      WHEN '1'.
        test_create_work_order(   IMPORTING
                                            rv_valid = lv_valid
                                            rv_message = lv_message ).

        out->write( | { lv_message }| ).


      WHEN '2'.
        test_read_work_order(   IMPORTING
                                            rv_valid = lv_valid
                                            rv_message = lv_message
                                            rv_ls_workorder = ls_workorder ).
        IF lv_valid = abap_false.
          out->write( | { lv_message } | ).
        ELSE.
          out->write(  ls_workorder ).
        ENDIF.

      WHEN '3'.
        test_update_work_order(   IMPORTING
                                            rv_valid = lv_valid
                                            rv_message = lv_message ).

        out->write( | { lv_message }| ).

      WHEN '4'.
        test_delete_work_order(   IMPORTING
                                            rv_valid = lv_valid
                                            rv_message = lv_message ).

        IF lv_valid = abap_false.
          out->write( | { lv_message }| ).
        ELSE.
          out->write( | work order  deleted correctly | ).
        ENDIF.





    ENDCASE.

  ENDMETHOD.

  METHOD test_create_work_order.


    DATA(lo_instance) = NEW zcl_wo_crud_handler_agora01( ).

    " Llamar al método de instancia

    lo_instance->create_work_order( EXPORTING  iv_work_order_id = 9
                                      iv_customer_id  = '1'
                                      iv_technician_id = '1'
                                      iv_priority = 'A'
                                      iv_status = 'PE'
                                      iv_description = 'insertando wo prueba'
                                      iv_creation_date = '20250308'
                                      IMPORTING
                                      rv_valid = rv_valid
                                      rv_message = rv_message ).




  ENDMETHOD.

  METHOD test_read_work_order.

    DATA(lo_instance) = NEW zcl_wo_crud_handler_agora01( ).

    " Llamar al método de instancia

    lo_instance->read_work_order( EXPORTING  iv_work_order_id = 9

                                      IMPORTING
                                      rv_valid = rv_valid
                                      rv_message = rv_message
                                      rv_ls_work_order = rv_ls_workorder ).



  ENDMETHOD.

  METHOD test_delete_work_order.
    DATA(lo_instance) = NEW zcl_wo_crud_handler_agora01( ).

    " Llamar al método de instancia

    lo_instance->delete_work_order( EXPORTING  iv_work_order_id = 4

                                      IMPORTING
                                      rv_valid = rv_valid
                                      rv_message = rv_message ).

  ENDMETHOD.

  METHOD test_update_work_order.
    DATA(lo_instance) = NEW zcl_wo_crud_handler_agora01( ).

    " Llamar al método de instancia

    lo_instance->update_work_order( EXPORTING  iv_work_order_id = 5
                                      iv_customer_id  = '1'
                                      iv_technician_id = '1'
                                      iv_priority = 'B'
                                      iv_status = 'PE'
                                      iv_description = '  ok modifcado wo prueba '
                                      iv_creation_date = '20250310'

                                      IMPORTING
                                      rv_valid = rv_valid
                                      rv_message = rv_message ).





  ENDMETHOD.

ENDCLASS.
